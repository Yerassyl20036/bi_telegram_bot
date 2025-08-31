import os
import json
import asyncio
import hashlib
import uuid
import aiofiles
from datetime import datetime, timezone, timedelta
from aiogram import Bot, Dispatcher, Router, types
from aiogram.filters import Command
from aiogram.fsm.context import FSMContext
from aiogram.fsm.state import State, StatesGroup
from aiogram.types import ReplyKeyboardMarkup, KeyboardButton, ReplyKeyboardRemove
import psycopg2
from psycopg2 import sql
from dotenv import load_dotenv

# Load environment variables
load_dotenv()

TOKEN = os.getenv("TELEGRAM_BOT_TOKEN")
DATABASE_URL = os.getenv("DATABASE_URL")
DATABASE_HOST = os.getenv("DATABASE_HOST", "localhost")
DATABASE_PORT = int(os.getenv("DATABASE_PORT", "5432"))
DATABASE_NAME = os.getenv("DATABASE_NAME", "power_bi_bot")
DATABASE_USER = os.getenv("DATABASE_USER", "bot_user")
DATABASE_PASSWORD = os.getenv("DATABASE_PASSWORD", "bot_password")
PREFIX = os.getenv("TABLE_PREFIX", "edu_")

# Photo configuration
PHOTO_DIR = os.getenv("PHOTO_DIR", "/tmp/photos")
PHOTO_URL_BASE = os.getenv("PHOTO_URL_BASE", "http://localhost:8080/photos")
MAX_PHOTO_SIZE = int(os.getenv("MAX_PHOTO_SIZE", str(10 * 1024 * 1024)))  # 10MB


# ==========================
# SETTINGS
# ==========================
if not TOKEN:
    raise RuntimeError("TELEGRAM_BOT_TOKEN env var is required")

if not DATABASE_URL:
    raise RuntimeError("DATABASE_URL env var is required")

# Default table mapping for different survey blocks
DEFAULT_TABLE_MAP = {
    # Safety/Cleanliness/Tech/Health S1..S8
    "S1": "s1",
    "S2": "s2", 
    "S3": "s3",
    "S4": "s4",
    "S5": "s5",
    "S6": "s6",
    "S7": "s7",
    "S8": "s8",
    # Study/Quality Q1..Q5
    "Q1": "q1",
    "Q2": "q2",
    "Q3": "q3",
    "Q4": "q4",
    "Q5": "q5",
    # People P1..P3
    "P1": "p1",
    "P2": "p2",
    "P3": "p3",
}

TABLE_MAP = DEFAULT_TABLE_MAP

bot = Bot(token=TOKEN)
dp = Dispatcher()
router = Router()
dp.include_router(router)

# ==========================
# Database helpers
# ==========================
def get_db_connection():
    """Create a database connection."""
    try:
        conn = psycopg2.connect(DATABASE_URL)
        return conn
    except psycopg2.Error as e:
        print(f"Database connection error: {e}")
        raise


def test_db_connection():
    """Test database connection and log result."""
    try:
        conn = get_db_connection()
        cursor = conn.cursor()
        cursor.execute("SELECT 1;")
        result = cursor.fetchone()
        cursor.close()
        conn.close()
        print("✅ Database connection successful!")
        return True
    except Exception as e:
        print(f"❌ Database connection failed: {e}")
        return False


def postgres_create(table_name: str, payload: dict) -> int:
    """Insert data into PostgreSQL table and return the ID."""
    conn = get_db_connection()
    cursor = conn.cursor()
    
    try:
        # Build the INSERT query dynamically
        columns = list(payload.keys())
        values = list(payload.values())
        
        # Create the SQL query
        insert_query = sql.SQL(
            "INSERT INTO dbo.{table} ({columns}) VALUES ({values}) RETURNING id"
        ).format(
            table=sql.Identifier(table_name),
            columns=sql.SQL(', ').join(map(sql.Identifier, columns)),
            values=sql.SQL(', ').join(sql.Placeholder() * len(values))
        )
        
        # Execute the query
        cursor.execute(insert_query, values)
        record_id = cursor.fetchone()[0]
        
        # Commit the transaction
        conn.commit()
        
        print(f"✅ Record saved to {table_name} with ID: {record_id}")
        return record_id
        
    except psycopg2.Error as e:
        conn.rollback()
        raise RuntimeError(f"Database insert failed: {e}")
    finally:
        cursor.close()
        conn.close()

# ==========================
# Column name helper
# ==========================
def dv(header: str) -> str:
    """Derive Dataverse logical name from a human header using PREFIX."""
    snake = []
    for ch in header:
        if ch.isalnum():
            snake.append(ch.lower())
        elif ch in [" ", "-", "/"] or ch == "\n":
            snake.append("_")
        else:
            snake.append(ch.lower())
    s = "".join(snake)
    while "__" in s:
        s = s.replace("__", "_")
    return f"{PREFIX}{s.strip('_')}"

# ==========================
# Keyboards
# ==========================
def kb(options, row_size=3) -> ReplyKeyboardMarkup:
    rows = [options[i:i+row_size] for i in range(0, len(options), row_size)]
    keyboard = [[KeyboardButton(text=opt) for opt in row] for row in rows]
    return ReplyKeyboardMarkup(keyboard=keyboard, resize_keyboard=True)

def schools_keyboard():
    schools = [
        "Binom school им. А. Байтұрсынұлы",
        "Binom School им. А. Бөкейхана",
        "Binom school им. А. Кекилбаева",
        "Binom school им. Қ. Сәтбаева",
        "Binom School им. Қадыр Мырза Әлі",
        "Binom school им. Ы. Алтынсарина",
        "Binom school Школа-лицей им. Аль-Фараби",
        "Binom Школа-лицей им. Динмухаммеда Кунаева",
        "Binom school Авангард",
        "Riviera International School",
        "FARABI SCHOOL SHYMKENT",
        "FARABI SCHOOL ATYRAU",
    ]
    return kb(schools, row_size=1)

def roles_keyboard():
    roles = [
        "👨‍👩‍👦 Ата-ана / Родитель",
        "🧑‍🎓 Оқушы / Ученик",
        "👨‍🏫 Қызметкер / Сотрудник",
    ]
    return kb(roles, row_size=1)

def topics_keyboard():
    topics = [
        "🧽 Тазалық / Чистота (кластар, ортақ орындар, температура)",
        "🍽 Асхана / Питание",
        "🔔 Оқу процесі / Учебный процесс",
        "👨‍👩‍👦 Ұсыныстар мен шағымдар / Предложения и жалобы",
        "⚠ Қауіпсіздік / Безопасность",
        "💡 Жаңа идеялар / Новые инициативы",
        "🖥 Техникалық ақау / Технические сбои",
        "🏥 Денсаулық / Здоровье",
        "🧑‍🏫 Мұғалімдердің қолжетімділігі / Доступность учителей",
        "🧠 Психологиялық қолдау / Психологическая поддержка",
    ]
    return kb(topics, row_size=1)

def floors_keyboard():
    return kb(["1","2","3","4","5"], row_size=5)

def class_numbers_keyboard():
    return kb([str(i) for i in range(1, 12)], row_size=6)

async def save_photo(bot: Bot, photo: types.PhotoSize) -> str:
    """Save photo to local storage and return URL"""
    try:
        # Create photo directory if it doesn't exist
        os.makedirs(PHOTO_DIR, exist_ok=True)
        print(f"📁 Photo directory: {PHOTO_DIR}")
        
        # Generate unique filename
        file_info = await bot.get_file(photo.file_id)
        print(f"📄 File info: {file_info.file_path}")
        
        file_extension = file_info.file_path.split('.')[-1] if '.' in file_info.file_path else 'jpg'
        unique_id = str(uuid.uuid4())
        filename = f"{unique_id}.{file_extension}"
        local_path = os.path.join(PHOTO_DIR, filename)
        print(f"💾 Saving to: {local_path}")
        
        # Download the photo directly to file path
        await bot.download_file(file_info.file_path, local_path)
        
        print(f"✅ Photo saved successfully: {filename}")
        
        # Return the URL
        photo_url = f"{PHOTO_URL_BASE}/{filename}"
        print(f"🌐 Photo URL: {photo_url}")
        return photo_url
        
    except Exception as e:
        print(f"❌ Error saving photo: {e}")
        import traceback
        traceback.print_exc()
        return ""

def liter_keyboard():
    letters = ["А","Ә","Б","В","Г","Ғ","Д","Е","Ё","Ж","З","И","Й","К","Қ","Л","М","Н","Ң","О","Ө","П","Р","С","Т","У","Ұ","Ү","Ф","Х","Һ","Ц","Ч","Ш","Щ","Ъ","Ы","І","Ь","Э","Ю","Я"]
    return kb(letters, row_size=8)

# ==========================
# FSM states
# ==========================
class Survey(StatesGroup):
    school = State()
    role = State()
    topic = State()

    # Cleanliness
    clean_branch = State()
    clean_floor = State()
    clean_classroom = State()
    clean_specific_place = State()
    clean_problem_choice = State()
    clean_problem_text = State()
    clean_condition_3 = State()

    # Temperature
    temp_location = State()
    temp_floor = State()
    temp_specific_place = State()
    temp_condition_choice = State()

    # Food
    food_problem = State()

    # Study process
    study_class_number = State()
    study_liter = State()
    study_topic = State()
    schedule_problem = State()
    schedule_subject = State()
    schedule_date = State()
    subject = State()
    subject_problem = State()
    discipline_problem = State()
    discipline_student_name = State()

    # Complaints
    complaint_area = State()
    complaint_text = State()

    # Ideas
    idea_area = State()
    idea_effect = State()
    idea_description = State()
    idea_author = State()

    # Tech
    tech_issue = State()
    tech_room = State()

    # Safety
    security_category = State()
    security_incident_type = State()
    security_incident_desc = State()
    security_guard_issue = State()
    security_hazard_issue = State()

    # Health (S8)
    health_text = State()

    # Teachers availability (Q5)
    q5_total = State()
    q5_illnes = State()
    q5_flight = State()
    q5_individual = State()
    q5_cvalification = State()
    q5_other = State()

    # Psych support (P3)
    p3_category = State()
    p3_additional = State()

    # Other
    other_input = State()

    # Final
    extra_info = State()
    photo = State()
    need_callback = State()
    contact_info = State()

# ==========================
# Flow start
# ==========================

@router.message(Command("start"))
async def start(message: types.Message, state: FSMContext):
    await state.clear()
    await message.answer(
        # "👋 Сәлеметсіз бе! / Привет!",
        "📚 Сіз қай мектептенсіз? / Из какой вы школы?",
        reply_markup=schools_keyboard(),
    )
    await state.set_state(Survey.school)

@router.message(Survey.school)
async def got_school(message: types.Message, state: FSMContext):
    await state.update_data(school=message.text)
    await message.answer("👤 Рөліңізді таңдаңыз / Выберите вашу роль:", reply_markup=roles_keyboard())
    await state.set_state(Survey.role)

@router.message(Survey.role)
async def got_role(message: types.Message, state: FSMContext):
    await state.update_data(role=message.text)
    await message.answer("📝 Тақырыпты таңдаңыз / Выберите тему:", reply_markup=topics_keyboard())
    await state.set_state(Survey.topic)

# ==========================
# Branching by topic
# ==========================
@router.message(Survey.topic)
async def process_topic(message: types.Message, state: FSMContext):
    topic = message.text
    await state.update_data(topic=topic)

    if topic.startswith("🧽"):
        branches = [
            "🧹 Сынып тазалығы / Чистота классов",
            "🏢 Ортақ орындар тазалығы / Чистота мест общего пользования",
            "🌡 Температуралық режим / Температурный режим",
        ]
        await message.answer("🧽 Тазалық бойынша бағыт / Направление по чистоте:", reply_markup=kb(branches, row_size=1))
        await state.set_state(Survey.clean_branch)
        return

    if topic.startswith("🍽"):
        await message.answer("4️⃣ Мәселеңізді таңдаңыз / Укажите проблему (Питание):", reply_markup=kb(FOOD_OPTIONS, row_size=1))
        await state.set_state(Survey.food_problem)
        return

    if topic.startswith("🔔"):
        await message.answer("🏫 Қай сынып? / Какой класс?", reply_markup=class_numbers_keyboard())
        await state.set_state(Survey.study_class_number)
        return

    if topic.startswith("👨‍👩‍👦"):
        await message.answer("✍ Сала / Сфера:", reply_markup=kb(COMPLAINT_AREAS, row_size=1))
        await state.set_state(Survey.complaint_area)
        return

    if topic.startswith("⚠"):
        await message.answer("4️⃣ Қауіпсіздік мәселесі:", reply_markup=kb(SECURITY_CATEGORIES, row_size=1))
        await state.set_state(Survey.security_category)
        return

    if topic.startswith("💡"):
        await message.answer("4️⃣ Идея саласы:", reply_markup=kb(IDEA_AREAS, row_size=1))
        await state.set_state(Survey.idea_area)
        return

    if topic.startswith("🖥"):
        await message.answer("Не істемей тұр? / Что не работает?", reply_markup=kb(TECH_OPTIONS, row_size=1))
        await state.set_state(Survey.tech_issue)
        return

    if topic.startswith("🏥"):
        await message.answer("📝 Денсаулық мәселесін қысқаша сипаттаңыз / Опишите кратко проблему со здоровьем — «Введите ответ»:", reply_markup=ReplyKeyboardRemove())
        await state.set_state(Survey.health_text)
        return

    if topic.startswith("🧑‍🏫"):
        await message.answer("👥 Барлығы қанша мұғалім? / Сколько всего учителей? — число:", reply_markup=ReplyKeyboardRemove())
        await state.set_state(Survey.q5_total)
        return

    if topic.startswith("🧠"):
        await message.answer("🧭 Бағытты таңдаңыз / Выберите направление:", reply_markup=kb(["Emotion","Conflict","Bulling","Teaching","Crisis","Consultation","Other"], row_size=2))
        await state.set_state(Survey.p3_category)
        return

    await message.answer("Тізімнен таңдаңыз / Выберите из списка.")

# -------------- CLEANLINESS --------------
CLASS_CLEAN_PROBLEMS = [
    "🪑 Сынған жиһаз / Сломанная мебель",
    "🪟 Терезе жабылмайды / Не закрывается окно",
    "🧼 Еден лас / Грязный пол",
    "🗑 Қоқыс шығарылмаған / Мусор не вынесен",
    "Другое / Басқа",
]

COMMON_PLACE_PROBLEMS = [
    "Лас / Грязь – еден, қабырға, иіс / пол, стены, запах",
    "Сынған жиһаз / Сломанная мебель – үстел, орындық / столы, стулья",
    "Жабдықтың ақауы / Неисправное оборудование – шам, техника / освещение, техника",
    "Су ағуы / Утечка воды – кран, құбыр / краны, трубы",
    "Қауіпсіздік бұзушылығы / Нарушение безопасности – сырғанақ еден, сымдар / скользкий пол, провода",
    "Қоқыс шығарылмаған / Мусор не вынесен – қоқыс жәшігі толы / переполненные урны",
    "Другое / Басқа",
]

CONDITION_3 = ["Нашар / Плохое", "Орташа / Среднее", "Жақсы / Хорошее"]

@router.message(Survey.clean_branch)
async def clean_branch(message: types.Message, state: FSMContext):
    choice = message.text
    await state.update_data(clean_branch=choice)

    if choice.startswith("🧹") or choice.startswith("🏢"):
        await message.answer("🏢 Қай қабат? / Какой этаж?", reply_markup=floors_keyboard())
        await state.set_state(Survey.clean_floor)
        return
    if choice.startswith("🌡"):
        await message.answer("📍 Қай жерде? / Где именно?", reply_markup=kb(TEMP_LOCATIONS, row_size=1))
        await state.set_state(Survey.temp_location)
        return
    await message.answer("Тізімнен таңдаңыз / Выберите из списка.")

@router.message(Survey.clean_floor)
async def clean_floor(message: types.Message, state: FSMContext):
    await state.update_data(clean_floor=message.text)
    data = await state.get_data()
    branch = data.get("clean_branch", "")
    if branch.startswith("🧹"):
        await message.answer("🏫 Қай кабинет? / Какой кабинет? — «Введите ответ»", reply_markup=ReplyKeyboardRemove())
        await state.set_state(Survey.clean_classroom)
    else:
        await message.answer("7️⃣ Нақты орынды жазыңыз / Уточните место — «Введите ответ»", reply_markup=ReplyKeyboardRemove())
        await state.set_state(Survey.clean_specific_place)

@router.message(Survey.clean_classroom)
async def clean_classroom(message: types.Message, state: FSMContext):
    await state.update_data(clean_classroom=message.text)
    await message.answer("🔎 Мәселеңізді таңдаңыз / Укажите проблему:", reply_markup=kb(CLASS_CLEAN_PROBLEMS, row_size=1))
    await state.set_state(Survey.clean_problem_choice)

@router.message(Survey.clean_specific_place)
async def clean_specific_place(message: types.Message, state: FSMContext):
    await state.update_data(clean_specific_place=message.text)
    await message.answer("🔎 Мәселені таңдаңыз / Укажите проблему:", reply_markup=kb(COMMON_PLACE_PROBLEMS, row_size=1))
    await state.set_state(Survey.clean_problem_choice)

@router.message(Survey.clean_problem_choice)
async def clean_problem_choice(message: types.Message, state: FSMContext):
    txt = message.text
    if "Другое" in txt or "Басқа" in txt:
        await state.update_data(other_target="clean_problem_text", other_next="clean_condition_3")
        await message.answer("✍ Мәселені жазыңыз / Опишите проблему:", reply_markup=ReplyKeyboardRemove())
        await state.set_state(Survey.other_input)
        return
    await state.update_data(clean_problem_text=txt)
    await message.answer("🧼 Жағдайын бағалаңыз / Оцените состояние:", reply_markup=kb(CONDITION_3, row_size=1))
    await state.set_state(Survey.clean_condition_3)

@router.message(Survey.clean_condition_3)
async def clean_condition_3(message: types.Message, state: FSMContext):
    await state.update_data(clean_condition_3=message.text)
    await begin_final_questions(message, state)

# ---------- Temperature subset ----------
TEMP_LOCATIONS = [
    "Кабинет","Дәліз / Коридор","Баспалдақ / Лестница","Фойе (холл) / Холл",
    "Асхана аймағы / Зона столовой","Спортзал / Спортзал","Әжетхана / Санузел","Другое / Басқа",
]
TEMP_COND = ["Ыстық / Жарко","Суық / Холодно","Другое / Басқа"]

@router.message(Survey.temp_location)
async def temp_location(message: types.Message, state: FSMContext):
    txt = message.text
    if "Другое" in txt or "Басқа" in txt:
        await state.update_data(other_target="temp_location", other_next="temp_floor")
        await message.answer("✍ Өз нұсқаңызды жазыңыз / Напишите свой вариант места:", reply_markup=ReplyKeyboardRemove())
        await state.set_state(Survey.other_input)
        return
    await state.update_data(temp_location=txt)
    await message.answer("🏢 Қай қабат? / Какой этаж?", reply_markup=floors_keyboard())
    await state.set_state(Survey.temp_floor)

@router.message(Survey.temp_floor)
async def temp_floor(message: types.Message, state: FSMContext):
    await state.update_data(clean_floor=message.text)
    await message.answer("7️⃣ Нақты орынды жазыңыз / Уточните место — «Введите ответ»", reply_markup=ReplyKeyboardRemove())
    await state.set_state(Survey.temp_specific_place)

@router.message(Survey.temp_specific_place)
async def temp_specific_place(message: types.Message, state: FSMContext):
    await state.update_data(clean_specific_place=message.text)
    await message.answer("🌡 Температура: сізге суық па, әлде ыстық па? / Вам холодно или жарко?", reply_markup=kb(TEMP_COND, row_size=1))
    await state.set_state(Survey.temp_condition_choice)

@router.message(Survey.temp_condition_choice)
async def temp_condition_choice(message: types.Message, state: FSMContext):
    txt = message.text
    if "Другое" in txt or "Басқа" in txt:
        await state.update_data(other_target="temp_condition_choice", other_next=None)
        await message.answer("✍ Өз нұсқаңызды жазыңыз / Напишите свой вариант:", reply_markup=ReplyKeyboardRemove())
        await state.set_state(Survey.other_input)
        return
    await state.update_data(temp_condition_choice=txt)
    await begin_final_questions(message, state)

# ---------- Food ----------
FOOD_OPTIONS = [
    "Асхана қызметін бағалау / Оценка работы столовой",
    "Ыстық тамақтың болмауы / Отсутствие горячего питания",
    "Салқын тағамдар / Блюда холодные",
    "Кезек > 10 минут / Очереди > 10 мин",
    "Тәтті сусындардың (газдалған) сатылуы / Продажа сладких (газированных) напитков",
    "Тамақтанудың бірсарындығы / Однообразие питания",
    "Тамақ үлестірудің әлсіз ұйымдастырылуы / Слабая организация раздачи",
    "Санитарлық нормалардың бұзылуы / Нарушение санитарных норм",
    "Уақыт жетіспеуі / Не хватает времени",
    "Бағаның жоғары болуы / Завышенные цены",
    "Другое / Басқа",
]

@router.message(Survey.food_problem)
async def food_problem(message: types.Message, state: FSMContext):
    txt = message.text
    if "Другое" in txt or "Басқа" in txt:
        await state.update_data(other_target="food_problem", other_next=None)
        await message.answer("✍ Өз нұсқаңызды жазыңыз / Напишите свой вариант:", reply_markup=ReplyKeyboardRemove())
        await state.set_state(Survey.other_input)
        return
    await state.update_data(food_problem=txt)
    await begin_final_questions(message, state)

# ---------- Study process ----------
STUDY_TOPICS = [
    "📅 Сабақ кестесі және срывы / Расписание и срывы уроков",
    "📚 Пәндер / Учебные предметы",
    "👩‍🏫 Мектептегі тәртіп / Дисциплина в школе",
]
SCHEDULE_PROBLEMS = [
    "❌ Сабақ өткізілмеді / Урок не состоялся",
    "⏳ Сабақ толық өткізілмеді / Урок состоялся частично",
    "🗓 Кестеде қате / Ошибка в расписании",
    "🔁 Кабинеттер алыс / Длинные переходы между кабинетами",
    "⏱ Үзілістер қолайсыз / Перемены слишком короткие или длинные",
    "➕ Кестеде пәндері қиындығы ескерілмеген / Не учтена сложность предметов",
    "Другое / Басқа",
]
SCHEDULE_NEEDS_SUBJECT_DATE_MARKERS = ["өткізілмеді","не состоялся","толық","частично","қате","ошибка"]
SUBJECTS = [
    "Қазақ тілі","Орыс тілі","Ағылшын тілі","Математика","Физика","Химия","Биология","География","Тарих","Дене шынықтыру","Другое / Басқа",
]
SUBJECT_PROBLEMS = [
    "📊 Бағалау әдісі / Система оценивания",
    "🏠 Үй жұмысы тым көп / Слишком много домашнего задания",
    "🤔 Мұғалімнің түсіндіруі қиын / Сложно понять объяснение учителя",
    "➕ Мұғалім тарапынан дөрекілік / Грубость со стороны учителя",
    "Другое / Басқа",
]

@router.message(Survey.study_class_number)
async def study_class_number(message: types.Message, state: FSMContext):
    await state.update_data(study_class_number=message.text)
    await message.answer("🔤 Литер / Литера:", reply_markup=liter_keyboard())
    await state.set_state(Survey.study_liter)

@router.message(Survey.study_liter)
async def study_liter(message: types.Message, state: FSMContext):
    await state.update_data(study_liter=message.text)
    await message.answer("📘 Тақырып / Тема:", reply_markup=kb(STUDY_TOPICS, row_size=1))
    await state.set_state(Survey.study_topic)

@router.message(Survey.study_topic)
async def study_topic(message: types.Message, state: FSMContext):
    txt = message.text
    await state.update_data(study_topic=txt)
    low = txt.lower()
    if "распис" in low or "кесте" in low or "срыв" in low:
        await message.answer("🗓 Мәселені таңдаңыз / Проблема (Расписание):", reply_markup=kb(SCHEDULE_PROBLEMS, row_size=1))
        await state.set_state(Survey.schedule_problem)
        return
    if "пән" in low or "предмет" in low:
        await message.answer("📚 Пән / Предмет:", reply_markup=kb(SUBJECTS, row_size=2))
        await state.set_state(Survey.subject)
        return
    await message.answer("🧭 Мәселені таңдаңыз / Проблема (Дисциплина):", reply_markup=kb(DISCIPLINE_PROBLEMS, row_size=1))
    await state.set_state(Survey.discipline_problem)

@router.message(Survey.schedule_problem)
async def schedule_problem(message: types.Message, state: FSMContext):
    txt = message.text
    await state.update_data(schedule_problem=txt)
    need_subj_date = any(m in txt.lower() for m in SCHEDULE_NEEDS_SUBJECT_DATE_MARKERS)
    if "Другое" in txt or "Басқа" in txt:
        await begin_final_questions(message, state)
        return
    if need_subj_date:
        await message.answer("📚 Пән / Предмет:", reply_markup=kb(SUBJECTS, row_size=2))
        await state.set_state(Survey.schedule_subject)
    else:
        await begin_final_questions(message, state)

@router.message(Survey.schedule_subject)
async def schedule_subject(message: types.Message, state: FSMContext):
    txt = message.text
    if "Другое" in txt or "Басқа" in txt:
        await state.update_data(other_target="schedule_subject", other_next="schedule_date")
        await message.answer("✍ Пән атауын жазыңыз / Напишите предмет:", reply_markup=ReplyKeyboardRemove())
        await state.set_state(Survey.other_input)
        return
    await state.update_data(schedule_subject=txt)
    await message.answer("📅 Дата — «Введите ответ» (напр.: 2025-09-01):", reply_markup=ReplyKeyboardRemove())
    await state.set_state(Survey.schedule_date)

@router.message(Survey.schedule_date)
async def schedule_date(message: types.Message, state: FSMContext):
    await state.update_data(schedule_date=message.text)
    await begin_final_questions(message, state)

@router.message(Survey.subject)
async def subject(message: types.Message, state: FSMContext):
    txt = message.text
    if "Другое" in txt or "Басқа" in txt:
        await state.update_data(other_target="subject", other_next="subject_problem")
        await message.answer("✍ Пән атауын жазыңыз / Напишите предмет:", reply_markup=ReplyKeyboardRemove())
        await state.set_state(Survey.other_input)
        return
    await state.update_data(subject=txt)
    await message.answer("🧩 Проблема (Пәндер):", reply_markup=kb(SUBJECT_PROBLEMS, row_size=1))
    await state.set_state(Survey.subject_problem)

@router.message(Survey.subject_problem)
async def subject_problem(message: types.Message, state: FSMContext):
    txt = message.text
    if "Другое" in txt or "Басқа" in txt:
        await state.update_data(other_target="subject_problem", other_next=None)
        await message.answer("✍ Өз нұсқаңызды жазыңыз / Напишите свой вариант:", reply_markup=ReplyKeyboardRemove())
        await state.set_state(Survey.other_input)
        return
    await state.update_data(subject_problem=txt)
    await begin_final_questions(message, state)

# ---------- Security ----------
SECURITY_CATEGORIES = [
    "🚨 Жағдай / Инцидент",
    "👮 Қауіпсіздік қызметі / Служба безопасности",
    "⚠️ Қауіп / Опасность",
]

# ---------- Discipline ----------
DISCIPLINE_PROBLEMS = [
    "⏱ Сабақтан >10 мин кешігу / Отсутствие на уроке более 10 минут",
    "🔊 Шу, назар аудармау, тәртіп бұзу / Шум, отвлечение, нарушение порядка",
    "🙅‍♂ Тапсырманы орындаудан бас тарту, дөрекі мінез-құлық / Отказ выполнять задания, дерзкое поведение",
    "🤼‍♂ Сыныптасымен жанжал / Конфликт с одноклассником",
    "👨‍🏫 Мұғаліммен жанжал / Конфликт с учителем",
    "📱 Телефон немесе құрылғыны сабақта пайдалану / Использование телефона или гаджета",
    "🧢 Мектеп формасын сақтамау / Несоблюдение школьной формы",
    "🚬 Тыйым салынған заттарды пайдалану / Запрещённые предметы",
    "🪧 Сабақ кезінде рұқсатсыз кету / Самовольный уход с урока",
    "📲 Буллинг / Кибербуллинг",
    "🪑 Мүлікті бүлдіру / Порча имущества",
    "Другое / Басқа",
]

@router.message(Survey.discipline_problem)
async def discipline_problem(message: types.Message, state: FSMContext):
    txt = message.text
    if "Другое" in txt or "Басқа" in txt:
        await state.update_data(other_target="discipline_problem", other_next="discipline_student_name")
        await message.answer("📝 Сипаттаңыз / Опишите:", reply_markup=ReplyKeyboardRemove())
        await state.set_state(Survey.other_input)
        return
    await state.update_data(discipline_problem=txt)
    await message.answer("🧑‍🎓 Оқушы(лар) ФИО — «Введите ответ»:", reply_markup=ReplyKeyboardRemove())
    await state.set_state(Survey.discipline_student_name)

@router.message(Survey.discipline_student_name)
async def discipline_student_name(message: types.Message, state: FSMContext):
    await state.update_data(discipline_student_name=message.text)
    await begin_final_questions(message, state)

# ---------- Complaints & Ideas ----------
COMPLAINT_AREAS = [
    "🍽 Тамақ сапасы / Качество питания","🍴 Тамақтануды ұйымдастыру / Организация питания","📚 Оқу процесі / Учебный процесс",
    "👨‍🏫 Мұғалімдердің жұмысы / Работа учителей","🧑‍🏫 Сынып жетекшісі / Классный руководитель","🔄 Коммуникация және ақпарат / Коммуникации и информирование",
    "⚠ Қауіпсіздік / Безопасность","🧹 Ғимараттардың тазалығы / Чистота помещений","🎭 Кружки және үйірмелер / Кружковая работа",
    "🏫 Сыныптан тыс іс-шаралар / Внеклассная работа","📖 Ғылыми-әдістемелік жұмыс / Научно-методическая работа","Другое / Басқа",
]

@router.message(Survey.complaint_area)
async def complaint_area(message: types.Message, state: FSMContext):
    txt = message.text
    if "Другое" in txt or "Басқа" in txt:
        await state.update_data(other_target="complaint_area", other_next="complaint_text")
        await message.answer("✍ Өз нұсқаңызды жазыңыз / Напишите свой вариант:", reply_markup=ReplyKeyboardRemove())
        await state.set_state(Survey.other_input)
        return
    await state.update_data(complaint_area=txt)
    await message.answer("5️⃣ Ұсынысты/шағымды сипаттаңыз — «Введите ответ»:", reply_markup=ReplyKeyboardRemove())
    await state.set_state(Survey.complaint_text)

@router.message(Survey.complaint_text)
async def complaint_text(message: types.Message, state: FSMContext):
    await state.update_data(complaint_text=message.text)
    await begin_final_questions(message, state)

IDEA_AREAS = [
    "⚙ Процесті оңтайландыру / Оптимизация процесса","🪑 Жұмыс орнын жақсарту / Улучшение рабочего места","💧 Ресурстарды үнемдеу / Экономия ресурсов",
    "📚 Оқыту сапасын арттыру / Улучшение качества обучения","💻 Цифрландыру / Цифровизация","🛡 Қауіпсіздікті арттыру / Улучшение безопасности","Другое / Басқа",
]

@router.message(Survey.idea_area)
async def idea_area(message: types.Message, state: FSMContext):
    txt = message.text
    if "Другое" in txt or "Басқа" in txt:
        await state.update_data(other_target="idea_area", other_next="idea_effect")
        await message.answer("✍ Өз нұсқаңызды жазыңыз / Напишите свой вариант:", reply_markup=ReplyKeyboardRemove())
        await state.set_state(Survey.other_input)
        return
    await state.update_data(idea_area=txt)
    await message.answer("5️⃣ ✨ Күтілетін эффект / Ожидаемый эффект — «Введите ответ»:")
    await state.set_state(Survey.idea_effect)

@router.message(Survey.idea_effect)
async def idea_effect(message: types.Message, state: FSMContext):
    await state.update_data(idea_effect=message.text)
    await message.answer("6️⃣ 📝 Қысқаша сипаттама / Краткое описание — «Введите ответ»:")
    await state.set_state(Survey.idea_description)

@router.message(Survey.idea_description)
async def idea_description(message: types.Message, state: FSMContext):
    await state.update_data(idea_description=message.text)
    await message.answer("7️⃣ 👤 Автор (аты-жөні және рөлі) / Автор (имя и роль) — «Введите ответ»:")
    await state.set_state(Survey.idea_author)

@router.message(Survey.idea_author)
async def idea_author(message: types.Message, state: FSMContext):
    await state.update_data(idea_author=message.text)
    await begin_final_questions(message, state)

# ---------- Security ----------
@router.message(Survey.security_category)
async def security_category(message: types.Message, state: FSMContext):
    txt = message.text
    await state.update_data(security_category=txt)
    
    if txt.startswith("🚨"):  # Incident
        await message.answer("Жағдай түрі / Тип инцидента:", reply_markup=kb([
            "Жарақат / Травма",
            "Төбелес / Драка", 
            "Ұрлық / Кража",
            "Вандализм / Вандализм",
            "Другое / Басқа"
        ], row_size=1))
        await state.set_state(Survey.security_incident_type)
        return
    elif txt.startswith("👮"):  # Security service
        await message.answer("Қауіпсіздік қызметі мәселесі / Проблема службы безопасности:", reply_markup=kb([
            "Қызметкердің болмауы / Отсутствие сотрудника",
            "Кеш келу / Опоздание",
            "Міндеттерді орындамау / Невыполнение обязанностей", 
            "Другое / Басқа"
        ], row_size=1))
        await state.set_state(Survey.security_guard_issue)
        return
    else:  # Hazard
        await message.answer("Қауіп түрі / Тип опасности:", reply_markup=kb([
            "Сынған жабдық / Сломанное оборудование",
            "Сырғанақ еден / Скользкий пол",
            "Электр қаупі / Электроопасность",
            "Пожар қаупі / Пожароопасность",
            "Другое / Басқа"
        ], row_size=1))
        await state.set_state(Survey.security_hazard_issue)
        return

@router.message(Survey.security_incident_type)
async def security_incident_type(message: types.Message, state: FSMContext):
    txt = message.text
    if "Другое" in txt or "Басқа" in txt:
        await state.update_data(other_target="security_incident_type", other_next="security_incident_desc")
        await message.answer("✍ Өз нұсқаңызды жазыңыз / Напишите свой вариант:", reply_markup=ReplyKeyboardRemove())
        await state.set_state(Survey.other_input)
        return
    await state.update_data(security_incident_type=txt)
    await message.answer("📝 Жағдайды сипаттаңыз / Опишите инцидент:", reply_markup=ReplyKeyboardRemove())
    await state.set_state(Survey.security_incident_desc)

@router.message(Survey.security_incident_desc)
async def security_incident_desc(message: types.Message, state: FSMContext):
    await state.update_data(security_incident_desc=message.text)
    await begin_final_questions(message, state)

@router.message(Survey.security_guard_issue)
async def security_guard_issue(message: types.Message, state: FSMContext):
    txt = message.text
    if "Другое" in txt or "Басқа" in txt:
        await state.update_data(other_target="security_guard_issue", other_next=None)
        await message.answer("✍ Өз нұсқаңызды жазыңыз / Напишите свой вариант:", reply_markup=ReplyKeyboardRemove())
        await state.set_state(Survey.other_input)
        return
    await state.update_data(security_guard_issue=txt)
    await begin_final_questions(message, state)

@router.message(Survey.security_hazard_issue)
async def security_hazard_issue(message: types.Message, state: FSMContext):
    txt = message.text
    if "Другое" in txt or "Басқа" in txt:
        await state.update_data(other_target="security_hazard_issue", other_next=None)
        await message.answer("✍ Өз нұсқаңызды жазыңыз / Напишите свой вариант:", reply_markup=ReplyKeyboardRemove())
        await state.set_state(Survey.other_input)
        return
    await state.update_data(security_hazard_issue=txt)
    await begin_final_questions(message, state)

# ---------- Tech ----------
TECH_OPTIONS = [
    "🌐 Интернет / Wi-Fi","🖥 Компьютер / Ноутбук","📽 Проектор / Интерактивті панель / Проектор / Интерактивная панель",
    "🖨 Принтер / Көшірме құрылғысы / Принтер / Копир","🧩 Платформа немесе БҚ (eKundelik, LMS, Teams және т.б.) / Платформа или ПО (eKundelik, LMS и др.)",
    "⚡ Электр қуаты / Электропитание","Другое / Басқа",
]

@router.message(Survey.tech_issue)
async def tech_issue(message: types.Message, state: FSMContext):
    txt = message.text
    if "Другое" in txt or "Басқа" in txt:
        await state.update_data(other_target="tech_issue", other_next="tech_room")
        await message.answer("✍ Өз нұсқаңызды жазыңыз / Напишите свой вариант:", reply_markup=ReplyKeyboardRemove())
        await state.set_state(Survey.other_input)
        return
    await state.update_data(tech_issue=txt)
    await message.answer("5️⃣ Кабинет номері / Номер кабинета — «Введите ответ»:", reply_markup=ReplyKeyboardRemove())
    await state.set_state(Survey.tech_room)

@router.message(Survey.tech_room)
async def tech_room(message: types.Message, state: FSMContext):
    await state.update_data(tech_room=message.text)
    await begin_final_questions(message, state)

# ---------- Health (S8) ----------
@router.message(Survey.health_text)
async def health_text(message: types.Message, state: FSMContext):
    # Free text; stored to 'Other' for S8
    await state.update_data(health_text=message.text)
    await begin_final_questions(message, state)

# ---------- Teachers availability (Q5) ----------
@router.message(Survey.q5_total)
async def q5_total(message: types.Message, state: FSMContext):
    await state.update_data(q5_total=message.text)
    await message.answer("🤒 Ауру / Болеют — число:")
    await state.set_state(Survey.q5_illnes)

@router.message(Survey.q5_illnes)
async def q5_illnes(message: types.Message, state: FSMContext):
    await state.update_data(q5_illnes=message.text)
    await message.answer("🛫 Іссапар / Командировка — число:")
    await state.set_state(Survey.q5_flight)

@router.message(Survey.q5_flight)
async def q5_flight(message: types.Message, state: FSMContext):
    await state.update_data(q5_flight=message.text)
    await message.answer("👤 Жеке себептер / Индивидуальные причины — число:")
    await state.set_state(Survey.q5_individual)

@router.message(Survey.q5_individual)
async def q5_individual(message: types.Message, state: FSMContext):
    await state.update_data(q5_individual=message.text)
    await message.answer("🎓 Біліктілікті арттыру / Повышение квалификации — число:")
    await state.set_state(Survey.q5_cvalification)

@router.message(Survey.q5_cvalification)
async def q5_cvalification(message: types.Message, state: FSMContext):
    await state.update_data(q5_cvalification=message.text)
    await message.answer("➕ Басқа / Другое — число:")
    await state.set_state(Survey.q5_other)

@router.message(Survey.q5_other)
async def q5_other(message: types.Message, state: FSMContext):
    await state.update_data(q5_other=message.text)
    await begin_final_questions(message, state)

# ---------- Psych support (P3) ----------
@router.message(Survey.p3_category)
async def p3_category(message: types.Message, state: FSMContext):
    await state.update_data(p3_category=message.text)
    await message.answer("📝 Қысқаша сипаттама / Краткое описание — «Введите ответ»:")
    await state.set_state(Survey.p3_additional)

@router.message(Survey.p3_additional)
async def p3_additional(message: types.Message, state: FSMContext):
    await state.update_data(p3_additional=message.text)
    await begin_final_questions(message, state)

# ---------- Universal "Other" ----------
@router.message(Survey.other_input)
async def other_input(message: types.Message, state: FSMContext):
    data = await state.get_data()
    target = data.get("other_target")
    next_state = data.get("other_next")
    if target:
        await state.update_data({target: message.text})
    await state.update_data(other_target=None, other_next=None)
    if next_state:
        await state.set_state(getattr(Survey, next_state))
    else:
        await begin_final_questions(message, state)

# ---------- Final questions & Save ----------
async def begin_final_questions(message: types.Message, state: FSMContext):
    await message.answer(
        "6️⃣ Қосымша ақпарат / Дополнительная информация",
        reply_markup=ReplyKeyboardRemove(),
    )
    await state.set_state(Survey.extra_info)

@router.message(Survey.extra_info)
async def extra_info(message: types.Message, state: FSMContext):
    await state.update_data(extra_info=message.text)
    await message.answer(
        "6️⃣ Суретті жүктеу / Загрузить фото (міндетті емес / необязательно)\n\n"
        "Мәселенің суретін жіберіңіз немесе «Жоқ» деп жазыңыз\n"
        "Отправьте фото проблемы или напишите «Нет»",
        reply_markup=kb(["Жоқ / Нет"], row_size=1),
    )
    await state.set_state(Survey.photo)

@router.message(Survey.photo)
async def handle_photo(message: types.Message, state: FSMContext, bot: Bot):
    photo_url = ""
    
    if message.photo:
        # Get the largest photo size
        largest_photo = message.photo[-1]
        
        # Check file size
        if largest_photo.file_size and largest_photo.file_size > MAX_PHOTO_SIZE:
            await message.answer(
                "❌ Сурет тым үлкен! Максимум 10MB / Фото слишком большое! Максимум 10MB"
            )
            return
            
        # Save photo and get URL
        photo_url = await save_photo(bot, largest_photo)
        if photo_url:
            await message.answer(f"✅ Сурет сақталды / Фото сохранено: {photo_url}")
        else:
            await message.answer("❌ Суретті сақтауда қате / Ошибка при сохранении фото")
    elif message.text and (message.text.startswith("Жоқ") or message.text.startswith("Нет")):
        photo_url = ""
        await message.answer("✅ Сурет жоқ / Без фото")
    else:
        await message.answer(
            "Сурет жіберіңіз немесе «Жоқ» деп жазыңыз / Отправьте фото или напишите «Нет»"
        )
        return
    
    await state.update_data(photo_url=photo_url)
    await message.answer(
        "7️⃣ Кері байланыс қажет пе? / Нужна ли обратная связь?",
        reply_markup=kb(["Иә / Да", "Жоқ / Нет"], row_size=2),
    )
    await state.set_state(Survey.need_callback)

@router.message(Survey.need_callback)
async def need_callback(message: types.Message, state: FSMContext):
    ans = message.text
    await state.update_data(want_callback=ans)
    if ans.startswith("Иә") or ans.startswith("Да"):
        await message.answer(
            "8️⃣ Байланыс мәліметтерін қалдырыңыз / Оставьте контакты (e-mail/телефон) — «Введите ответ»:",
            reply_markup=ReplyKeyboardRemove(),
        )
        await state.set_state(Survey.contact_info)
    else:
        await state.update_data(contact_info="")
        await finish_and_save(message, state)

@router.message(Survey.contact_info)
async def contact_info(message: types.Message, state: FSMContext):
    await state.update_data(contact_info=message.text)
    await finish_and_save(message, state)

ALMATY = timezone(timedelta(hours=5))  # Asia/Almaty UTC+05

def now_parts():
    now_local = datetime.now(ALMATY)
    return now_local.date().isoformat(), now_local.strftime("%H:%M")

def choose_block(data: dict) -> str:
    topic = (data.get("topic") or "").strip()
    # Cleanliness / Temperature
    if topic.startswith("🧽"):
        branch = (data.get("clean_branch") or "").strip()
        if branch.startswith("🧹"):  # Class cleanliness
            return "S1"
        if branch.startswith("🏢"):  # Common places
            return "S2"
        if branch.startswith("🌡"):  # Temperature
            return "S3"
    # Food → Q4
    if topic.startswith("🍽"):
        return "Q4"
    # Study → Q1/Q2/Q3
    if topic.startswith("🔔"):
        st = (data.get("study_topic") or "").lower()
        if "распис" in st or "кесте" in st or "срыв" in st:
            return "Q1"
        if "пән" in st or "предмет" in st:
            return "Q2"
        return "Q3"  # discipline default
    # Complaints → P1
    if topic.startswith("👨‍👩‍👦"):
        return "P1"
    # Safety → S5/S6/S4
    if topic.startswith("⚠"):
        cat = (data.get("security_category") or "").strip()
        if cat.startswith("🚨"):
            return "S5"
        if cat.startswith("👮"):
            return "S6"
        return "S4"
    # Ideas → P2
    if topic.startswith("💡"):
        return "P2"
    # Tech → S7
    if topic.startswith("🖥"):
        return "S7"
    # Health → S8
    if topic.startswith("🏥"):
        return "S8"
    # Teachers availability → Q5
    if topic.startswith("🧑‍🏫"):
        return "Q5"
    # Psych support → P3
    if topic.startswith("🧠"):
        return "P3"
    # Fallback
    return "P1"

def build_payload(block: str, data: dict) -> dict:
    date_str, time_str = now_parts()
    # Common
    common = {
        dv("School"): str(data.get("school", "")),
        dv("Date"): date_str,
        dv("Time"): time_str,
        dv("Role"): str(data.get("role", "")),
        dv("Photo"): str(data.get("photo_url", "")),
        dv("Data_from"): "Telegram Bot",
        dv("Add_inf"): str(data.get("extra_info", "")),
        dv("Contact"): str(data.get("contact_info", "")),
    }
    payload = dict(common)

    if block == "S1":
        payload.update({
            dv("Class_num"): str(data.get("study_class_number", "")),
            dv("Floor"): str(data.get("clean_floor", "")),
            dv("Classroom"): str(data.get("clean_classroom", "")),
            dv("Problem"): str(data.get("clean_problem_text", "")),
            dv("Condition"): str(data.get("clean_condition_3", "")),
            dv("Action"): "",
            dv("Status"): "",
        })
    elif block == "S2":
        payload.update({
            dv("Loc_num"): str(data.get("clean_classroom", "")),
            dv("Floor"): str(data.get("clean_floor", "")),
            dv("Location"): "Common place",
            dv("Place"): str(data.get("clean_specific_place", "")),
            dv("Problem"): str(data.get("clean_problem_text", "")),
            dv("Condition"): str(data.get("clean_condition_3", "")),
            dv("Action"): "",
            dv("Status"): "",
        })
    elif block == "S3":
        payload.update({
            dv("Loc_num"): str(data.get("clean_classroom", "")),
            dv("Floor"): str(data.get("clean_floor", "")),
            dv("Location"): str(data.get("temp_location", "")),
            dv("Place"): str(data.get("clean_specific_place", "")),
            dv("Problem"): str(data.get("temp_condition_choice", "")),
            dv("Condition"): "",
            dv("Action"): "",
            dv("Status"): "",
        })
    elif block == "S4":  # hazards
        payload.update({
            dv("Problem"): str(data.get("security_hazard_issue", "")),
            dv("Condition"): "",
            dv("Action"): "",
            dv("Status"): "",
        })
    elif block == "S5":  # incident
        payload.update({
            dv("Incident"): str(data.get("security_incident_type", "")),
            dv("Describtion"): str(data.get("security_incident_desc", "")),
            dv("Action"): "",
            dv("Status"): "",
        })
    elif block == "S6":  # guard
        payload.update({
            dv("Security"): str(data.get("security_guard_issue", "")),
            dv("Action"): "",
            dv("Status"): "",
        })
    elif block == "S7":  # tech
        room = data.get("tech_room")
        prob = str(data.get("tech_issue", "")) + (f" | Кабинет: {room}" if room else "")
        payload.update({
            dv("Problem"): prob,
            dv("Action"): "",
            dv("Status"): "",
        })
    elif block == "S8":  # health
        payload.update({
            dv("Problem"): str(data.get("health_text", "")),
            dv("Action"): "",
            dv("Status"): "",
        })
    elif block == "Q1":  # schedule
        payload.update({
            dv("Problem"): str(data.get("schedule_problem", "")),
            dv("Grate"): str(data.get("study_class_number", "")),
            dv("Litter"): str(data.get("study_liter", "")),
            dv("Subject"): str(data.get("schedule_subject", "")),
            dv("Problem_date"): str(data.get("schedule_date", "")),
            dv("Action"): "",
            dv("Status"): "",
        })
    elif block == "Q2":  # subject issues
        payload.update({
            dv("Problem"): str(data.get("subject_problem", "")),
            dv("Grate"): str(data.get("study_class_number", "")),
            dv("Litter"): str(data.get("study_liter", "")),
            dv("Subject"): str(data.get("subject", "")),
            dv("Action"): "",
            dv("Status"): "",
        })
    elif block == "Q3":  # discipline
        payload.update({
            dv("Problem"): str(data.get("discipline_problem", "")),
            dv("Full_name"): str(data.get("discipline_student_name", "")),
            dv("Grate"): str(data.get("study_class_number", "")),
            dv("Litter"): str(data.get("study_liter", "")),
            dv("Action"): "",
            dv("Status"): "",
        })
    elif block == "Q4":  # food
        payload.update({
            dv("Problem"): str(data.get("food_problem", "")),
            dv("Action"): "",
            dv("Status"): "",
        })
    elif block == "Q5":  # teachers availability
        payload.update({
            dv("Total"): str(data.get("q5_total", "")),
            dv("Illness"): str(data.get("q5_illnes", "")),
            dv("Business_trip"): str(data.get("q5_flight", "")),
            dv("Individual"): str(data.get("q5_individual", "")),
            dv("Qualification"): str(data.get("q5_cvalification", "")),
            dv("Other"): str(data.get("q5_other", "")),
            dv("Action"): "",
            dv("Status"): "",
        })
    elif block == "P1":  # complaints
        payload.update({
            dv("Problem"): str(data.get("complaint_area", "")),
            dv("Describtion"): str(data.get("complaint_text", "")),
            dv("Action"): "",
            dv("Status"): "",
        })
    elif block == "P2":  # ideas
        payload.update({
            dv("Sphere"): str(data.get("idea_area", "")),
            dv("Result"): str(data.get("idea_effect", "")),
            dv("Describtion"): str(data.get("idea_description", "")),
            dv("Author"): str(data.get("idea_author", "")),
            dv("Action"): "",
            dv("Status"): "",
        })
    elif block == "P3":  # psych support
        payload.update({
            dv("Category"): str(data.get("p3_category", "")),
            dv("Describtion"): str(data.get("p3_additional", "")),
            dv("Action"): "",
            dv("Status"): "",
        })
    else:
        payload.update({
            dv("Problem"): str(data.get("topic", "")),
            dv("Describtion"): json.dumps(data, ensure_ascii=False),
        })

    return payload

async def finish_and_save(message: types.Message, state: FSMContext):
    data = await state.get_data()
    block = choose_block(data)
    try:
        table_name = TABLE_MAP.get(block)
        if not table_name:
            raise RuntimeError(f"No table mapped for block {block}")
        payload = build_payload(block, data)
        record_id = postgres_create(table_name, payload)
        await message.answer(
            "✅ Рақмет! Жауаптарыңыз дерекқорға сақталды. / Спасибо! Ответ сохранён в базе данных.\n"
            f"📦 Блок: {block} → Таблица: {table_name}\n"
            f"🆔 Запись ID: {record_id}",
            reply_markup=ReplyKeyboardRemove(),
        )
    except Exception as e:
        await message.answer(f"❌ Қате: {e}")
    await state.clear()

# ==========================
# RUN
# ==========================
async def main():
    # Test database connection at startup
    if not test_db_connection():
        print("❌ Failed to connect to database. Please check your database configuration.")
        return
    
    print("🚀 Starting Telegram bot...")
    await dp.start_polling(bot)

if __name__ == "__main__":
    asyncio.run(main())