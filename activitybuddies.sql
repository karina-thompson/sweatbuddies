CREATE DATABASE activitybuddies;

\c activitybuddies

CREATE TABLE users (
  id SERIAL4 PRIMARY KEY,
  email VARCHAR(50) NOT NULL,
  password_digest VARCHAR(400),
  user_name VARCHAR(200),
  location VARCHAR(200),
  greeting VARCHAR(500),
  UNIQUE (email)
);

CREATE TABLE interests (
  id SERIAL4 PRIMARY KEY,
  name VARCHAR(100)
);

CREATE TABLE interests_users (
  user_id INTEGER,
  interest_id INTEGER,
  UNIQUE (user_id, interest_id)
);

INSERT into interests (name) VALUES ('Running/Jogging');
INSERT into interests (name) VALUES ('Walking/Hiking'); 
INSERT into interests (name) VALUES ('Gym based exercise');
INSERT into interests (name) VALUES ('Team Sports');
INSERT into interests (name) VALUES ('Cycling');
INSERT into interests (name) VALUES ('Water based activities');
INSERT into interests (name) VALUES ('Dancing');
INSERT into interests (name) VALUES ('Yoga');
INSERT into interests (name) VALUES ('Snow sports');
INSERT into interests (name) VALUES ('Fitness classes');






