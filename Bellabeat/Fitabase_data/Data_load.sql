-- ============================================================================
-- 1. PRÉPARATION DE L'ENVIRONNEMENT ET CONNEXION
-- ============================================================================

-- Crée la base de données si elle n'existe pas encore
CREATE DATABASE IF NOT EXISTS bellabeat_db;

-- CONNEXION : Indique à SQL d'utiliser cette base de données pour la suite
USE bellabeat_db;

-- ============================================================================
-- 1. CRÉATION DES TABLES
-- ============================================================================

CREATE TABLE IF NOT EXISTS daily_activity (
    Id BIGINT,
    ActivityDate VARCHAR(50),
    TotalSteps INT,
    TotalDistance DOUBLE,
    TrackerDistance DOUBLE,
    LoggedActivitiesDistance DOUBLE,
    VeryActiveDistance DOUBLE,
    ModeratelyActiveDistance DOUBLE,
    LightActiveDistance DOUBLE,
    SedentaryActiveDistance DOUBLE,
    VeryActiveMinutes INT,
    FairlyActiveMinutes INT,
    LightlyActiveMinutes INT,
    SedentaryMinutes INT,
    Calories INT
);

CREATE TABLE IF NOT EXISTS daily_calories (
    Id BIGINT,
    ActivityDay VARCHAR(50),
    Calories INT
);

CREATE TABLE IF NOT EXISTS daily_steps (
    Id BIGINT,
    ActivityDay VARCHAR(50),
    StepTotal INT
);

CREATE TABLE IF NOT EXISTS daily_intensities (
    Id BIGINT,
    ActivityDay VARCHAR(50),
    SedentaryMinutes INT,
    LightlyActiveMinutes INT,
    FairlyActiveMinutes INT,
    VeryActiveMinutes INT,
    SedentaryActiveDistance DOUBLE,
    LightActiveDistance DOUBLE,
    ModeratelyActiveDistance DOUBLE,
    VeryActiveDistance DOUBLE
);

CREATE TABLE IF NOT EXISTS hourly_calories (
    Id BIGINT,
    ActivityHour VARCHAR(50),
    Calories INT
);

CREATE TABLE IF NOT EXISTS hourly_steps (
    Id BIGINT,
    ActivityHour VARCHAR(50),
    StepTotal INT
);

CREATE TABLE IF NOT EXISTS hourly_intensities (
    Id BIGINT,
    ActivityHour VARCHAR(50),
    TotalIntensity INT,
    AverageIntensity DOUBLE
);

CREATE TABLE IF NOT EXISTS minute_calories (
    Id BIGINT,
    ActivityMinute VARCHAR(50),
    Calories DOUBLE
);

CREATE TABLE IF NOT EXISTS minute_steps (
    Id BIGINT,
    ActivityMinute VARCHAR(50),
    Steps INT
);

CREATE TABLE IF NOT EXISTS minute_intensities (
    Id BIGINT,
    ActivityMinute VARCHAR(50),
    Intensity INT
);

CREATE TABLE IF NOT EXISTS minute_mets (
    Id BIGINT,
    ActivityMinute VARCHAR(50),
    METs INT
);

CREATE TABLE IF NOT EXISTS minute_sleep (
    Id BIGINT,
    date VARCHAR(50),
    value INT,
    logId BIGINT
);

CREATE TABLE IF NOT EXISTS heartrate_seconds (
    Id BIGINT,
    Time VARCHAR(50),
    Value INT
);

CREATE TABLE IF NOT EXISTS sleep_day (
    Id BIGINT,
    SleepDay VARCHAR(50),
    TotalSleepRecords INT,
    TotalMinutesAsleep INT,
    TotalTimeInBed INT
);

CREATE TABLE IF NOT EXISTS weight_log_info (
    Id BIGINT,
    Date VARCHAR(50),
    WeightKg DOUBLE,
    WeightPounds DOUBLE,
    Fat INT,
    BMI DOUBLE,
    IsFromCoef VARCHAR(10),
    LogId BIGINT
);


-- ============================================================================
-- 2. IMPORTATION DES DONNÉES (LOAD DATA)
-- ============================================================================

LOAD DATA LOCAL INFILE 'C:/Mes projets/Etudes de cas formation Data Analyst/Bellabeat/Fitabase_data/dailyActivity_merged.csv'
INTO TABLE daily_activity FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\r\n' IGNORE 1 ROWS;

LOAD DATA LOCAL INFILE 'C:/Mes projets/Etudes de cas formation Data Analyst/Bellabeat/Fitabase_data/dailyCalories_merged.csv'
INTO TABLE daily_calories FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\r\n' IGNORE 1 ROWS;

LOAD DATA LOCAL INFILE 'C:/Mes projets/Etudes de cas formation Data Analyst/Bellabeat/Fitabase_data/dailySteps_merged.csv'
INTO TABLE daily_steps FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\r\n' IGNORE 1 ROWS;

LOAD DATA LOCAL INFILE 'C:/Mes projets/Etudes de cas formation Data Analyst/Bellabeat/Fitabase_data/dailyIntensities_merged.csv'
INTO TABLE daily_intensities FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\r\n' IGNORE 1 ROWS;

LOAD DATA LOCAL INFILE 'C:/Mes projets/Etudes de cas formation Data Analyst/Bellabeat/Fitabase_data/hourlyCalories_merged.csv'
INTO TABLE hourly_calories FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\r\n' IGNORE 1 ROWS;

LOAD DATA LOCAL INFILE 'C:/Mes projets/Etudes de cas formation Data Analyst/Bellabeat/Fitabase_data/hourlySteps_merged.csv'
INTO TABLE hourly_steps FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\r\n' IGNORE 1 ROWS;

LOAD DATA LOCAL INFILE 'C:/Mes projets/Etudes de cas formation Data Analyst/Bellabeat/Fitabase_data/hourlyIntensities_merged.csv'
INTO TABLE hourly_intensities FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\r\n' IGNORE 1 ROWS;

LOAD DATA LOCAL INFILE 'C:/Mes projets/Etudes de cas formation Data Analyst/Bellabeat/Fitabase_data/minuteCaloriesNarrow_merged.csv'
INTO TABLE minute_calories FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\r\n' IGNORE 1 ROWS;

LOAD DATA LOCAL INFILE 'C:/Mes projets/Etudes de cas formation Data Analyst/Bellabeat/Fitabase_data/minuteStepsNarrow_merged.csv'
INTO TABLE minute_steps FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\r\n' IGNORE 1 ROWS;

LOAD DATA LOCAL INFILE 'C:/Mes projets/Etudes de cas formation Data Analyst/Bellabeat/Fitabase_data/minuteIntensitiesNarrow_merged.csv'
INTO TABLE minute_intensities FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\r\n' IGNORE 1 ROWS;

LOAD DATA LOCAL INFILE 'C:/Mes projets/Etudes de cas formation Data Analyst/Bellabeat/Fitabase_data/minuteMETsNarrow_merged.csv'
INTO TABLE minute_mets FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\r\n' IGNORE 1 ROWS;

LOAD DATA LOCAL INFILE 'C:/Mes projets/Etudes de cas formation Data Analyst/Bellabeat/Fitabase_data/minuteSleep_merged.csv'
INTO TABLE minute_sleep FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\r\n' IGNORE 1 ROWS;

LOAD DATA LOCAL INFILE 'C:/Mes projets/Etudes de cas formation Data Analyst/Bellabeat/Fitabase_data/heartrate_seconds_merged.csv'
INTO TABLE heartrate_seconds FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\r\n' IGNORE 1 ROWS;

LOAD DATA LOCAL INFILE 'C:/Mes projets/Etudes de cas formation Data Analyst/Bellabeat/Fitabase_data/sleepDay_merged.csv'
INTO TABLE sleep_day FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\r\n' IGNORE 1 ROWS;

LOAD DATA LOCAL INFILE 'C:/Mes projets/Etudes de cas formation Data Analyst/Bellabeat/Fitabase_data/weightLogInfo_merged.csv'
INTO TABLE weight_log_info FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\r\n' IGNORE 1 ROWS;