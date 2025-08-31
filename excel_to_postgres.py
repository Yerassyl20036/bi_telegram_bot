import os
import sys
import pandas as pd
import psycopg2
from psycopg2 import sql
from psycopg2.extras import RealDictCursor
from dotenv import load_dotenv
from datetime import datetime
import logging

# Setup logging
logging.basicConfig(
    level=logging.INFO,
    format='%(asctime)s - %(levelname)s - %(message)s',
    handlers=[
        logging.FileHandler('excel_import.log'),
        logging.StreamHandler(sys.stdout)
    ]
)
logger = logging.getLogger(__name__)

# Load environment variables
load_dotenv()

# Database configuration
DATABASE_HOST = os.getenv("DATABASE_HOST", "localhost")
DATABASE_PORT = int(os.getenv("DATABASE_PORT", "5432"))
DATABASE_NAME = os.getenv("DATABASE_NAME", "power_bi_bot")
DATABASE_USER = os.getenv("DATABASE_USER", "bot_user")
DATABASE_PASSWORD = os.getenv("DATABASE_PASSWORD", "bot_password")

# Excel file path
EXCEL_FILE_PATH = "Data_DM (3).xlsx"

# Column mapping from Russian (Excel) to English (Database)
# This mapping will need to be adjusted based on actual Excel column names
COLUMN_MAPPINGS = {
    'P1': {
        'ID': 'id',
        'Мектеп': 'edu_school',
        'Дата': 'edu_date',
        'Время обхода': 'edu_time',
        'Роль': 'edu_role',
        'Тип проблемы  жалоба': 'edu_problem',
        'Описание жалоба': 'edu_describtion',
        'Принятые меры_дисциплина': 'edu_action',
        'Статус_дисциплина': 'edu_status',
        'Фото/ссылка_дисциплина': 'edu_photo',
        'Источник данных': 'edu_data_from',
        'Примечание (сюда входит пояснение про сломанный инвентарь)': 'edu_add_inf',
        'контакты по обратной связи_дисциплина': 'edu_contact'
    },
    'P2': {
        'ID': 'id',
        'Мектеп': 'edu_school',
        'Дата': 'edu_date',
        'Время обхода': 'edu_time',
        'Роль': 'edu_role',
        'Сфера идеи': 'edu_sphere',
        'Ожидаемый результат': 'edu_result',
        'Описание идеи': 'edu_describtion',
        'Автор идеи': 'edu_author',
        'Принятые меры_безопасность': 'edu_action',
        'Статус_безопасность': 'edu_status',
        'Фото/ссылка_безопасность': 'edu_photo',
        'Источник данных': 'edu_data_from',
        'Примечание (сюда входит пояснение про сломанный инвентарь)': 'edu_add_inf',
        'контакты по обратной связи_безопасность': 'edu_contact'
    },
    'P3': {
        'ID': 'id',
        'Мектеп': 'edu_school',
        'Дата': 'edu_date',
        'Время обхода': 'edu_time',
        '🙂\xa0Эмоциялық жағдай / Эмоциональное состояние': 'edu_emotional_state',
        '🤝\xa0Қақтығыстар және қарым-қатынастар / Конфликты и взаимоотношения': 'edu_conflicts_relations',
        '🚫\xa0Буллинг / кибербуллинг': 'edu_bullying_cyberbullying',
        '📖\xa0Оқудағы мәселелер / Проблемы в обучении': 'edu_learning_problems',
        '⚠️\xa0Дағдарыстық жағдайлар / Кризисные ситуации': 'edu_crisis_situations',
        '💬\xa0Профилактикалық әңгіме / консультация / Профилактическая беседа / консультация': 'edu_preventive_consultation',
        '📌\xa0Басқа / Прочее': 'edu_other',
        'Барлығы_психолог': 'edu_total_psychologist',
        'Фото/ссылка_безопасность': 'edu_photo',
        'Источник данных': 'edu_data_from',
        'Примечание (сюда входит пояснение про сломанный инвентарь)': 'edu_add_inf',
        'контакты по обратной связи_безопасность': 'edu_contact'
    },
    'Q1': {
        'ID': 'id',
        'Мектеп': 'edu_school',
        'Дата': 'edu_date',
        'Время обхода': 'edu_time',
        'Роль': 'edu_role',
        'Тип проблемы_расписание': 'edu_problem',
        'Сынып_расписание': 'edu_grate',
        'Литер расписание': 'edu_litter',
        'Предмет_расписание': 'edu_subject',
        'Дата_расписание': 'edu_problem_date',
        'Принятые меры_расписание': 'edu_action',
        'Статус_расписание': 'edu_status',
        'Фото/ссылка_расписание': 'edu_photo',
        'Источник данных': 'edu_data_from',
        'Примечание (сюда входит пояснение про сломанный инвентарь)': 'edu_add_inf',
        'контакты по обратной связи_расписание': 'edu_contact'
    },
    'Q2': {
        'ID': 'id',
        'Мектеп': 'edu_school',
        'Дата': 'edu_date',
        'Время обхода': 'edu_time',
        'Роль': 'edu_role',
        'Тип проблемы предмет': 'edu_problem',
        'Предмет_предмет': 'edu_subject',
        'Сынып предмет': 'edu_grate',
        'Литер предмет': 'edu_litter',
        'Принятые меры_предмет': 'edu_action',
        'Статус_предмет': 'edu_status',
        'Фото/ссылка_предмет': 'edu_photo',
        'Источник данных': 'edu_data_from',
        'Примечание (сюда входит пояснение про сломанный инвентарь)': 'edu_add_inf',
        'контакты по обратной связи_предмет': 'edu_contact'
    },
    'Q3': {
        'ID': 'id',
        'Мектеп': 'edu_school',
        'Дата': 'edu_date',
        'Время обхода': 'edu_time',
        'Роль': 'edu_role',
        'Тип проблемы дисциплина': 'edu_problem',
        'ФИО учащихся_дисциплина': 'edu_full_name',
        'Сынып дисциплина': 'edu_grate',
        'Литер дисциплина': 'edu_litter',
        'Принятые меры_дисциплина': 'edu_action',
        'Статус_дисциплина': 'edu_status',
        'Фото/ссылка_дисциплина': 'edu_photo',
        'Источник данных': 'edu_data_from',
        'Примечание (сюда входит пояснение про сломанный инвентарь)': 'edu_add_inf',
        'контакты по обратной связи_дисциплина': 'edu_contact'
    },
    'Q4': {
        'ID': 'id',
        'Мектеп': 'edu_school',
        'Дата': 'edu_date',
        'Время обхода': 'edu_time',
        'Роль': 'edu_role',
        'Номер кабинета': 'edu_problem',  # Mapping room number to problem field
        'Тип сбоя': None,  # Skip this - no good mapping
        'Принятые меры_безопасность': 'edu_action',
        'Статус_безопасность': 'edu_status',
        'Фото/ссылка_безопасность': 'edu_photo',
        'Источник данных': 'edu_data_from',
        'Примечание (сюда входит пояснение про сломанный инвентарь)': 'edu_add_inf',
        'контакты по обратной связи_безопасность': 'edu_contact'
    },
    'Q5': {
        'ID': 'id',
        'Мектеп': 'edu_school',
        'Дата': 'edu_date',
        'Время обхода': 'edu_time',
        '👥 Барлығы / Всего учителей': 'edu_total_teachers',
        '🤒 Ауырғанына байланысты / По болезни': 'edu_illness',
        '✈️ Іссапар / Командировка': 'edu_business_trip',
        '🏠 Жеке себептер / Личные причины': 'edu_personal_reasons',
        '🎓 Біліктілікті арттыру / Повышение квалификации': 'edu_professional_development',
        '📌 Басқа / Прочее': 'edu_other',
        'Фото/ссылка_безопасность': 'edu_photo',
        'Источник данных': 'edu_data_from',
        'Примечание (сюда входит пояснение про сломанный инвентарь)': 'edu_add_inf',
        'контакты по обратной связи_безопасность': 'edu_contact'
    },
    'S1': {
        'ID': 'id',
        'Мектеп': 'edu_school',
        'Дата': 'edu_date',
        'Время обхода': 'edu_time',
        'роль': 'edu_role',
        'Осмотрено кабинетов': 'edu_class_num',
        'Этаж': 'edu_floor',
        'Кабинет': 'edu_classroom',
        'Отклонение': 'edu_problem',
        'Состояние кабинета': 'edu_condition',
        'Действия': 'edu_action',
        'Статус': 'edu_status',
        'Фото/ссылка': 'edu_photo',
        'Источник данных': 'edu_data_from',
        'Примечание (сюда входит пояснение про сломанный инвентарь)': 'edu_add_inf',
        'Кері байланыс': 'edu_contact'
    },
    'S2': {
        'ID': 'id',
        'Мектеп': 'edu_school',
        'Дата': 'edu_date',
        'Время обхода': 'edu_time',
        'Роль': 'edu_role',
        'Осмотрено локаций': 'edu_loc_num',
        'Локация_ЧШ': 'edu_location',
        'Этаж_ЧШ': 'edu_floor',
        'Место_ЧШ': 'edu_place',
        'Тип проблемы_ЧШ': 'edu_problem',
        'Состояние_ЧШ': 'edu_condition',
        'Принятые меры_ЧШ': 'edu_action',
        'Статус_ЧШ': 'edu_status',
        'Фото/ссылка_ЧШ': 'edu_photo',
        'Источник данных_ЧШ': 'edu_data_from',
        'Примечание (сюда входит пояснение про сломанный инвентарь)': 'edu_add_inf',
        'контакты по обратной связи_ЧШ': 'edu_contact'
    },
    'S3': {
        'ID': 'id',
        'Мектеп': 'edu_school',
        'Дата': 'edu_date',
        'Время обхода': 'edu_time',
        'Роль': 'edu_role',
        'Осмотрено локаций': 'edu_loc_num',
        'Локация_ТР': 'edu_location',
        'Этаж_ТР': 'edu_floor',
        'Место_ТР': 'edu_place',
        'Тип проблемы_ТР': 'edu_problem',
        'Состояние_ТР': 'edu_condition',
        'Принятые меры_ТР': 'edu_action',
        'Статус_ТР': 'edu_status',
        'Фото/ссылка_ТР': 'edu_photo',
        'Источник данных_ТР': 'edu_data_from',
        'Примечание (сюда входит пояснение про сломанный инвентарь)': 'edu_add_inf',
        'контакты по обратной связи_ТР': 'edu_contact'
    },
    'S4': {
        'ID': 'id',
        'Мектеп': 'edu_school',
        'Дата': 'edu_date',
        'Время обхода': 'edu_time',
        'роль': 'edu_role',
        'Тип проблемы': 'edu_problem',
        'Категория риска': 'edu_condition',
        'Принятые меры': 'edu_action',
        'Статус': 'edu_status',
        'Фото/ссылка': 'edu_photo',
        'Источник данных': 'edu_data_from',
        'Примечание (сюда входит пояснение про сломанный инвентарь)': 'edu_add_inf',
        'контакты по обратной связи': 'edu_contact'
    },
    'S5': {
        'ID': 'id',
        'Мектеп': 'edu_school',
        'Дата': 'edu_date',
        'Время обхода': 'edu_time',
        'Роль': 'edu_role',
        'Инцидент': 'edu_incident',
        'Описание инцидент': 'edu_describtion',
        'Принятые меры_инцидент': 'edu_action',
        'Статус_инцидент': 'edu_status',
        'Фото/ссылка_инцидент': 'edu_photo',
        'Источник данных': 'edu_data_from',
        'Примечание (сюда входит пояснение про сломанный инвентарь)': 'edu_add_inf',
        'контакты по обратной связи_инцидент': 'edu_contact'
    },
    'S6': {
        'ID': 'id',
        'Мектеп': 'edu_school',
        'Дата': 'edu_date',
        'Время обхода': 'edu_time',
        'Роль': 'edu_role',
        'Охрана': 'edu_security',
        'Принятые меры_охрана': 'edu_action',
        'Статус_охрана': 'edu_status',
        'Фото/ссылка_охрана': 'edu_photo',
        'Источник данных': 'edu_data_from',
        'Примечание (сюда входит пояснение про сломанный инвентарь)': 'edu_add_inf',
        'контакты по обратной связи_охрана': 'edu_contact'
    },
    'S7': {
        'ID': 'id',
        'Мектеп': 'edu_school',
        'Дата': 'edu_date',
        'Время обхода': 'edu_time',
        'Роль': 'edu_role',
        'Безопасность': 'edu_problem',
        'Принятые меры_безопасность': 'edu_action',
        'Статус_безопасность': 'edu_status',
        'Фото/ссылка_безопасность': 'edu_photo',
        'Источник данных': 'edu_data_from',
        'Примечание (сюда входит пояснение про сломанный инвентарь)': 'edu_add_inf',
        'контакты по обратной связи_безопасность': 'edu_contact'
    },
    'S8': {
        'ID': 'id',
        'Мектеп': 'edu_school',
        'Дата': 'edu_date',
        'Время обхода': 'edu_time',
        '🍽 Ас қорыту жүйесі / ЖКТ (пищеварительная система)': 'edu_digestive_system',
        'Тұмау / ОРВИ и простудные заболевания': 'edu_cold_flu',
        '🤕 Жарақаттар / Травмы': 'edu_injuries',
        '🌸 Аллергиялық реакциялар / Аллергические реакции': 'edu_allergic_reactions',
        '🧠 Неврологиялық және жалпы жағдай / Неврологические и общее самочувствие': 'edu_neurological_general',
        '♻️ Созылмалы аурулардың асқынуы / Обострение хронических заболеваний': 'edu_chronic_diseases',
        '📌 Басқа / Прочее': 'edu_other',
        'Барлығы_медицина': 'edu_total_medical',
        'Фото/ссылка_безопасность': 'edu_photo',
        'Источник данных': 'edu_data_from',
        'Примечание (сюда входит пояснение про сломанный инвентарь)': 'edu_add_inf',
        'контакты по обратной связи_безопасность': 'edu_contact'
    }
}

def get_database_connection():
    """Establish connection to PostgreSQL database."""
    try:
        connection = psycopg2.connect(
            host=DATABASE_HOST,
            port=DATABASE_PORT,
            database=DATABASE_NAME,
            user=DATABASE_USER,
            password=DATABASE_PASSWORD
        )
        return connection
    except Exception as e:
        logger.error(f"Error connecting to database: {e}")
        raise

def test_database_connection():
    """Test database connection and show basic info."""
    try:
        conn = get_database_connection()
        cursor = conn.cursor(cursor_factory=RealDictCursor)
        
        # Test connection
        cursor.execute("SELECT version();")
        version = cursor.fetchone()
        if version:
            logger.info(f"PostgreSQL version: {version['version']}")
        else:
            logger.info("Connected to PostgreSQL database")
        
        # Check if tables exist
        cursor.execute("""
            SELECT table_name 
            FROM information_schema.tables 
            WHERE table_schema = 'dbo' 
            AND table_name IN ('p1', 'p2', 'p3', 'q1', 'q2', 'q3', 'q4', 'q5', 's1', 's2', 's3', 's4', 's5', 's6', 's7', 's8')
            ORDER BY table_name;
        """)
        
        tables = cursor.fetchall()
        table_names = [table['table_name'] for table in tables]
        logger.info(f"Found tables: {table_names}")
        
        cursor.close()
        conn.close()
        
        return True, table_names
    except Exception as e:
        logger.error(f"Database connection test failed: {e}")
        return False, []

def read_excel_file(file_path):
    """Read Excel file and return dictionary of DataFrames for each sheet."""
    try:
        if not os.path.exists(file_path):
            raise FileNotFoundError(f"Excel file not found: {file_path}")
        
        # Read all sheets
        excel_data = pd.read_excel(file_path, sheet_name=None, engine='openpyxl')
        
        # Filter only the sheets we need
        target_sheets = ['P1', 'P2', 'P3', 'Q1', 'Q2', 'Q3', 'Q4', 'Q5', 'S1', 'S2', 'S3', 'S4', 'S5', 'S6', 'S7', 'S8']
        filtered_data = {}
        
        for sheet_name in target_sheets:
            if sheet_name in excel_data:
                df = excel_data[sheet_name]
                if not df.empty:
                    filtered_data[sheet_name] = df
                    logger.info(f"Sheet {sheet_name}: {len(df)} rows, {len(df.columns)} columns")
                else:
                    logger.warning(f"Sheet {sheet_name} is empty")
            else:
                logger.warning(f"Sheet {sheet_name} not found in Excel file")
        
        return filtered_data
    except Exception as e:
        logger.error(f"Error reading Excel file: {e}")
        raise

def map_columns(df, sheet_name):
    """Map Russian column names to English database column names."""
    if sheet_name not in COLUMN_MAPPINGS:
        logger.warning(f"No column mapping found for sheet {sheet_name}")
        return df
    
    mapping = COLUMN_MAPPINGS[sheet_name]
    
    # Create a mapping dictionary for actual columns that exist in the DataFrame
    actual_mapping = {}
    for russian_col, english_col in mapping.items():
        if english_col is None:  # Skip columns that have no database equivalent
            continue
        if russian_col in df.columns:
            actual_mapping[russian_col] = english_col
        else:
            # Try to find similar column names (case insensitive, strip whitespace)
            for col in df.columns:
                if str(col).strip().lower() == russian_col.lower():
                    actual_mapping[col] = english_col
                    break
    
    # Debug: Print column mapping details for P3
    if sheet_name == 'P3':
        logger.info(f"P3 Debug - Excel columns: {list(df.columns)}")
        logger.info(f"P3 Debug - Mapping attempted: {list(mapping.keys())}")
        logger.info(f"P3 Debug - Successful mappings: {actual_mapping}")
        
        # Check specific emoji columns
        emoji_cols = [col for col in df.columns if any(emoji in str(col) for emoji in ['🙂', '🤝', '🚫', '📖', '⚠️', '💬', '📌'])]
        logger.info(f"P3 Debug - Emoji columns found: {emoji_cols}")
        
        for col in emoji_cols:
            if col in df.columns:
                logger.info(f"P3 Debug - Column '{col}' sample data: {df[col].head(3).tolist()}")
    
    # Rename columns
    df_mapped = df.rename(columns=actual_mapping)
    
    # Add default values for missing columns
    if 'edu_data_from' not in df_mapped.columns:
        df_mapped['edu_data_from'] = 'Excel Import'
    
    logger.info(f"Sheet {sheet_name}: Mapped {len(actual_mapping)} columns")
    logger.debug(f"Column mapping for {sheet_name}: {actual_mapping}")
    
    return df_mapped

def clean_data(df):
    """Clean and prepare data for database insertion."""
    import datetime
    
    # Make a copy to avoid modifying the original
    df = df.copy()
    
    # Convert datetime columns
    for col in df.columns:
        if 'date' in col.lower():
            if df[col].dtype == 'object' or 'datetime' in str(df[col].dtype):
                # Check if values are already date objects
                sample_non_null = df[col].dropna()
                if len(sample_non_null) > 0 and isinstance(sample_non_null.iloc[0], datetime.date):
                    # Already date objects, just replace NaN with None
                    df[col] = df[col].where(pd.notnull(df[col]), None)
                else:
                    df[col] = pd.to_datetime(df[col], errors='coerce').dt.date
                    # Replace NaT with None
                    df[col] = df[col].where(pd.notnull(df[col]), None)
        elif 'time' in col.lower() and col != 'created_at':
            # Check if values are already time objects
            sample_non_null = df[col].dropna()
            if len(sample_non_null) > 0:
                first_val = sample_non_null.iloc[0]
                if isinstance(first_val, datetime.time):  # Already a time object
                    # Just replace NaT/NaN with None
                    df[col] = df[col].where(pd.notnull(df[col]), None)
                else:
                    # Convert to time
                    if df[col].dtype == 'object' or 'datetime' in str(df[col].dtype):
                        df[col] = pd.to_datetime(df[col], errors='coerce').dt.time
                        # Replace NaT with None
                        df[col] = df[col].where(pd.notnull(df[col]), None)
    
    # Replace all remaining NaN/NaT values with None
    df = df.where(pd.notnull(df), None)
    
    return df

def insert_data_to_table(conn, table_name, df):
    """Insert DataFrame data into specified table."""
    if df.empty:
        logger.info(f"No data to insert for table {table_name}")
        return 0
    
    try:
        cursor = conn.cursor()
        
        # Get table columns from database
        cursor.execute(sql.SQL("""
            SELECT column_name 
            FROM information_schema.columns 
            WHERE table_schema = 'dbo' 
            AND table_name = %s 
            AND column_name != 'id' 
            AND column_name != 'created_at'
            ORDER BY ordinal_position;
        """), [table_name])
        
        db_columns = [row[0] for row in cursor.fetchall()]
        
        # Filter DataFrame columns to match database columns
        available_columns = [col for col in db_columns if col in df.columns]
        
        if not available_columns:
            logger.warning(f"No matching columns found for table {table_name}")
            return 0
        
        # Prepare data for insertion
        df_filtered = df[available_columns].copy()
        df_filtered = clean_data(df_filtered)
        
        # Additional cleaning for problematic values
        for col in df_filtered.columns:
            try:
                if df_filtered[col].dtype == 'object':
                    # Replace any string representations of NaT or NaN
                    df_filtered[col] = df_filtered[col].replace(['NaT', 'NaN', 'nat', 'nan'], None)
            except Exception as e:
                logger.debug(f"Could not process column {col}: {e}")
                continue
        
        logger.debug(f"Data types for {table_name}: {df_filtered.dtypes.to_dict()}")
        logger.debug(f"Sample data for {table_name}: {df_filtered.head(2).to_dict()}")
        
        # Create INSERT query
        columns_sql = sql.SQL(', ').join(sql.Identifier(col) for col in available_columns)
        placeholders = sql.SQL(', ').join(sql.Placeholder() * len(available_columns))
        
        insert_query = sql.SQL("""
            INSERT INTO dbo.{table} ({columns}) 
            VALUES ({placeholders})
        """).format(
            table=sql.Identifier(table_name),
            columns=columns_sql,
            placeholders=placeholders
        )
        
        # Convert DataFrame to list of tuples, ensuring no pandas objects
        data_tuples = []
        for _, row in df_filtered.iterrows():
            row_tuple = []
            for value in row:
                if pd.isna(value) or str(value) in ['NaT', 'NaN', 'nat', 'nan']:
                    row_tuple.append(None)
                else:
                    # Truncate text that's too long for database fields
                    if isinstance(value, str) and len(value) > 500:
                        logger.warning(f"Truncating long text in {table_name}: {value[:50]}...")
                        value = value[:500]
                    row_tuple.append(value)
            data_tuples.append(tuple(row_tuple))
        
        # Execute batch insert
        cursor.executemany(insert_query, data_tuples)
        rows_inserted = cursor.rowcount
        
        conn.commit()
        cursor.close()
        
        logger.info(f"Successfully inserted {rows_inserted} rows into table {table_name}")
        return rows_inserted
        
    except Exception as e:
        logger.error(f"Error inserting data into table {table_name}: {e}")
        conn.rollback()
        raise

def main():
    """Main function to execute the Excel to PostgreSQL import."""
    logger.info("Starting Excel to PostgreSQL import process")
    
    # Test database connection
    logger.info("Testing database connection...")
    connection_ok, existing_tables = test_database_connection()
    
    if not connection_ok:
        logger.error("Database connection failed. Exiting.")
        sys.exit(1)
    
    # Read Excel file
    logger.info(f"Reading Excel file: {EXCEL_FILE_PATH}")
    try:
        excel_data = read_excel_file(EXCEL_FILE_PATH)
    except Exception as e:
        logger.error(f"Failed to read Excel file: {e}")
        sys.exit(1)
    
    if not excel_data:
        logger.error("No valid sheets found in Excel file")
        sys.exit(1)
    
    # Process each sheet
    total_inserted = 0
    conn = get_database_connection()
    
    try:
        for sheet_name, df in excel_data.items():
            table_name = sheet_name.lower()
            
            if table_name not in existing_tables:
                logger.warning(f"Table {table_name} does not exist in database. Skipping sheet {sheet_name}")
                continue
            
            logger.info(f"Processing sheet {sheet_name} -> table {table_name}")
            
            # Map columns from Russian to English
            df_mapped = map_columns(df, sheet_name)
            
            # Insert data
            rows_inserted = insert_data_to_table(conn, table_name, df_mapped)
            total_inserted += rows_inserted
        
        logger.info(f"Import completed successfully. Total rows inserted: {total_inserted}")
        
    except Exception as e:
        logger.error(f"Error during import process: {e}")
        raise
    finally:
        conn.close()

if __name__ == "__main__":
    main()
