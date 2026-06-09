-- f --

-- 1. Création et sélection de la base de données
CREATE DATABASE IF NOT EXISTS fitbit_bellabeat_db;
USE fitbit_bellabeat_db;

-- =========================================================================
-- 2. CRÉATION DES TABLES
-- =========================================================================

CREATE TABLE users (
    id BIGINT NOT NULL,
    CONSTRAINT PK_users PRIMARY KEY (id)
);

CREATE TABLE daily_activity (
    id BIGINT NOT NULL,
    ActivityDate VARCHAR(50) NOT NULL,
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
    Calories INT,
    CONSTRAINT PK_daily_activity PRIMARY KEY (id, ActivityDate),
    CONSTRAINT FK_daily_activity_users FOREIGN KEY (id) REFERENCES users(id) ON DELETE NO ACTION ON UPDATE NO ACTION
);

CREATE TABLE daily_calories (
    id BIGINT NOT NULL,
    ActivityDay VARCHAR(50) NOT NULL,
    Calories INT,
    CONSTRAINT PK_daily_calories PRIMARY KEY (id, ActivityDay),
    CONSTRAINT FK_daily_calories_users FOREIGN KEY (id) REFERENCES users(id) ON DELETE NO ACTION ON UPDATE NO ACTION
);

CREATE TABLE daily_steps (
    id BIGINT NOT NULL,
    ActivityDay VARCHAR(50) NOT NULL,
    StepTotal INT,
    CONSTRAINT PK_daily_steps PRIMARY KEY (id, ActivityDay),
    CONSTRAINT FK_daily_steps_users FOREIGN KEY (id) REFERENCES users(id) ON DELETE NO ACTION ON UPDATE NO ACTION
);

CREATE TABLE daily_intensities (
    id BIGINT NOT NULL,
    ActivityDay VARCHAR(50) NOT NULL,
    SedentaryMinutes INT,
    LightlyActiveMinutes INT,
    FairlyActiveMinutes INT,
    VeryActiveMinutes INT,
    SedentaryActiveDistance DOUBLE,
    LightActiveDistance DOUBLE,
    ModeratelyActiveDistance DOUBLE,
    VeryActiveDistance DOUBLE,
    CONSTRAINT PK_daily_intensities PRIMARY KEY (id, ActivityDay),
    CONSTRAINT FK_daily_intensities_users FOREIGN KEY (id) REFERENCES users(id) ON DELETE NO ACTION ON UPDATE NO ACTION
);

CREATE TABLE sleepy_day (
    id BIGINT NOT NULL,
    SleepDay VARCHAR(50) NOT NULL,
    TotalSleepRecords INT,
    TotalMinutesAsleep INT,
    TotalTimeInBed INT,
    CONSTRAINT PK_sleepy_day PRIMARY KEY (id, SleepDay),
    CONSTRAINT FK_sleepy_day_users FOREIGN KEY (id) REFERENCES users(id) ON DELETE NO ACTION ON UPDATE NO ACTION
);

CREATE TABLE weight_log_info (
    id BIGINT NOT NULL,
    LogId BIGINT NOT NULL,
    Date VARCHAR(50),
    WeightKg DOUBLE,
    WeightPounds DOUBLE,
    Fat DOUBLE,
    BMI DOUBLE,
    IsFromCoef VARCHAR(10),
    CONSTRAINT PK_weight_log_info PRIMARY KEY (id, LogId),
    CONSTRAINT FK_weight_log_info_users FOREIGN KEY (id) REFERENCES users(id) ON DELETE NO ACTION ON UPDATE NO ACTION
);

CREATE TABLE hourly_calories (
    id BIGINT NOT NULL,
    ActivityHour VARCHAR(50) NOT NULL,
    Calories INT,
    CONSTRAINT PK_hourly_calories PRIMARY KEY (id, ActivityHour),
    CONSTRAINT FK_hourly_calories_users FOREIGN KEY (id) REFERENCES users(id) ON DELETE NO ACTION ON UPDATE NO ACTION
);

CREATE TABLE hourly_steps (
    id BIGINT NOT NULL,
    ActivityHour VARCHAR(50) NOT NULL,
    StepTotal INT,
    CONSTRAINT PK_hourly_steps PRIMARY KEY (id, ActivityHour),
    CONSTRAINT FK_hourly_steps_users FOREIGN KEY (id) REFERENCES users(id) ON DELETE NO ACTION ON UPDATE NO ACTION
);

CREATE TABLE hourly_intensities (
    id BIGINT NOT NULL,
    ActivityHour VARCHAR(50) NOT NULL,
    TotalIntensity INT,
    AverageIntensity DOUBLE,
    CONSTRAINT PK_hourly_intensities PRIMARY KEY (id, ActivityHour),
    CONSTRAINT FK_hourly_intensities_users FOREIGN KEY (id) REFERENCES users(id) ON DELETE NO ACTION ON UPDATE NO ACTION
);

CREATE TABLE minute_calories (
    id BIGINT NOT NULL,
    ActivityMinute VARCHAR(50) NOT NULL,
    Calories DOUBLE,
    CONSTRAINT PK_minute_calories PRIMARY KEY (id, ActivityMinute),
    CONSTRAINT FK_minute_calories_users FOREIGN KEY (id) REFERENCES users(id) ON DELETE NO ACTION ON UPDATE NO ACTION
);

CREATE TABLE minute_steps (
    id BIGINT NOT NULL,
    ActivityMinute VARCHAR(50) NOT NULL,
    Steps INT,
    CONSTRAINT PK_minute_steps PRIMARY KEY (id, ActivityMinute),
    CONSTRAINT FK_minute_steps_users FOREIGN KEY (id) REFERENCES users(id) ON DELETE NO ACTION ON UPDATE NO ACTION
);

CREATE TABLE minute_intensities (
    id BIGINT NOT NULL,
    ActivityMinute VARCHAR(50) NOT NULL,
    Intensity INT,
    CONSTRAINT PK_minute_intensities PRIMARY KEY (id, ActivityMinute),
    CONSTRAINT FK_minute_intensities_users FOREIGN KEY (id) REFERENCES users(id) ON DELETE NO ACTION ON UPDATE NO ACTION
);

CREATE TABLE minute_mets (
    id BIGINT NOT NULL,
    ActivityMinute VARCHAR(50) NOT NULL,
    METs INT,
    CONSTRAINT PK_minute_mets PRIMARY KEY (id, ActivityMinute),
    CONSTRAINT FK_minute_mets_users FOREIGN KEY (id) REFERENCES users(id) ON DELETE NO ACTION ON UPDATE NO ACTION
);

CREATE TABLE minute_sleep (
    id BIGINT NOT NULL,
    date VARCHAR(50) NOT NULL,
    value VARCHAR(50),
    logId BIGINT,
    CONSTRAINT PK_minute_sleep PRIMARY KEY (id, date),
    CONSTRAINT FK_minute_sleep_users FOREIGN KEY (id) REFERENCES users(id) ON DELETE NO ACTION ON UPDATE NO ACTION
);

CREATE TABLE heartrate_seconds (
    id BIGINT NOT NULL,
    Time VARCHAR(50) NOT NULL,
    Value INT,
    CONSTRAINT PK_heartrate_seconds PRIMARY KEY (id, Time),
    CONSTRAINT FK_heartrate_seconds_users FOREIGN KEY (id) REFERENCES users(id) ON DELETE NO ACTION ON UPDATE NO ACTION
);

-- ============================================================================
-- 3. IMPORTATION DES DONNÉES (LOAD DATA)
-- ============================================================================

-- ⚡ CRITIQUE : On désactive la vérification des clés étrangères pour l'import
SET FOREIGN_KEY_CHECKS = 0;

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

-- Correction du nom de la table : sleepy_day
LOAD DATA LOCAL INFILE 'C:/Mes projets/Etudes de cas formation Data Analyst/Bellabeat/Fitabase_data/sleepDay_merged.csv'
INTO TABLE sleepy_day FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\r\n' IGNORE 1 ROWS;

LOAD DATA LOCAL INFILE 'C:/Mes projets/Etudes de cas formation Data Analyst/Bellabeat/Fitabase_data/weightLogInfo_merged.csv'
INTO TABLE weight_log_info FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\r\n' IGNORE 1 ROWS;

-- ============================================================================
-- 4. ALIMENTATION AUTOMATIQUE DE LA TABLE USERS & RÉACTIVATION DES CLÉS
-- ============================================================================

-- On extrait tous les ID distincts de la table principale pour remplir 'users'
INSERT INTO users (id)
SELECT DISTINCT id FROM daily_activity;

-- CRITIQUE : On réactive la vérification des clés étrangères maintenant que 'users' est peuplée
SET FOREIGN_KEY_CHECKS = 1;