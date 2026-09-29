CREATE DATABASE vr_fitness;
USE vr_fitness;

-- user table (calling it member instead of user because sql gets confused with keywords sometimes lol)
CREATE TABLE member (
    member_id INT PRIMARY KEY,
    name VARCHAR(60) NOT NULL,
    email VARCHAR(100) NOT NULL,
    join_date DATE NOT NULL
);

-- trainers who make the routines
CREATE TABLE trainer (
    trainer_id INT PRIMARY KEY,
    name VARCHAR(60) NOT NULL,
    specialty VARCHAR(40) NOT NULL
);

-- main workouts available in VR
CREATE TABLE workout (
    workout_id INT PRIMARY KEY,
    trainer_id INT NOT NULL,  
    name VARCHAR(60) NOT NULL,
    level VARCHAR(20) NOT NULL,  -- beginner, intermediate, etc
    duration INT NOT NULL,       
    environment VARCHAR(60) NOT NULL,
    FOREIGN KEY (trainer_id) REFERENCES trainer(trainer_id)
);

-- individual exercises 
CREATE TABLE exercise (
    exercise_id INT PRIMARY KEY,
    name VARCHAR(60) NOT NULL,
    type VARCHAR(40) NOT NULL
);

-- bridging table for workouts and their steps/exercises
CREATE TABLE workout_exercise (
    workout_id INT NOT NULL,
    exercise_id INT NOT NULL,
    position INT NOT NULL,       -- order in the workout
    duration INT NOT NULL,
    PRIMARY KEY (workout_id, exercise_id),
    FOREIGN KEY (workout_id) REFERENCES workout(workout_id),
    FOREIGN KEY (exercise_id) REFERENCES exercise(exercise_id)
);

-- tracking actual gameplay/workout sessions completed by people
CREATE TABLE session (
    session_id INT PRIMARY KEY,
    member_id INT NOT NULL,
    workout_id INT NOT NULL,
    session_date DATETIME NOT NULL,
    duration INT NOT NULL,
    calories INT NOT NULL,
    score INT NOT NULL,          
    FOREIGN KEY (member_id) REFERENCES member(member_id),
    FOREIGN KEY (workout_id) REFERENCES workout(workout_id)
);

-- Dummy data for testing the local environment...
INSERT INTO member (member_id, name, email, join_date)
VALUES
(1, 'Alex Smith', 'alex@example.com', '2026-09-01'),
(2, 'Jordan Lee', 'jordan@example.com', '2026-09-03'),
(3, 'Taylor Brown', 'taylor@example.com', '2026-09-05'),
(4, 'Sam Davis', 'sam@example.com', '2026-09-08');

INSERT INTO trainer (trainer_id, name, specialty)
VALUES
(1, 'Chris Green', 'Boxing'),
(2, 'Morgan White', 'Cardio'),
(3, 'Jamie Clark', 'Strength');

INSERT INTO workout (workout_id, trainer_id, name, level, duration, environment)
VALUES
(1, 1, 'Boxing Basics', 'Beginner', 20, 'Virtual Gym'),
(2, 2, 'Beach Cardio', 'Intermediate', 30, 'Beach'),
(3, 3, 'Mountain Strength', 'Advanced', 25, 'Mountain'),
(4, 1, 'Quick Boxing', 'Beginner', 10, 'Virtual Gym');

INSERT INTO exercise (exercise_id, name, type)
VALUES
(1, 'Jabs', 'Boxing'),
(2, 'Uppercuts', 'Boxing'),
(3, 'Squats', 'Strength'),
(4, 'Side Steps', 'Cardio'),
(5, 'Lunges', 'Strength');

INSERT INTO workout_exercise (workout_id, exercise_id, position, duration)
VALUES
(1, 1, 1, 600),
(1, 2, 2, 600),
(2, 4, 1, 900),
(2, 3, 2, 900),
(3, 3, 1, 600),
(3, 5, 2, 900),
(4, 1, 1, 300),
(4, 2, 2, 300);

INSERT INTO session (session_id, member_id, workout_id, session_date, duration, calories, score)
VALUES
(1, 1, 1, '2026-09-10 18:00:00', 20, 160, 850),
(2, 2, 2, '2026-09-11 17:30:00', 30, 250, 920),
(3, 1, 1, '2026-09-12 18:00:00', 20, 175, 900),
(4, 3, 3, '2026-09-13 16:00:00', 25, 210, 780),
(5, 2, 1, '2026-09-14 17:00:00', 20, 165, 875),
(6, 1, 2, '2026-09-15 18:30:00', 30, 260, 950);

-- Just running some quick checks to make sure everything inserted properly
SELECT * FROM member;
SELECT * FROM trainer;
SELECT * FROM workout;
SELECT * FROM exercise;
SELECT * FROM workout_exercise;
SELECT * FROM session;

-- Let's check what user 1 has been up to
SELECT * FROM session
WHERE member_id = 1;
