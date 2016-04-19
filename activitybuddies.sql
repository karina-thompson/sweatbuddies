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


CREATE TABLE interest_users (
  id SERIAL4 PRIMARY KEY,
  user_id INTEGER,
  interest_id INTEGER,
  UNIQUE (user_id, interest_id)
);

CREATE TABLE interests_users (
  user_id INTEGER,
  interest_id INTEGER,
  UNIQUE (user_id, interest_id)
);

-- CREATE TABLE activities (
--   id SERIAL4 PRIMARY KEY,
--   name VARCHAR(200),
--   location VARCHAR(200),
--   cost MONEY,
--   day VARCHAR(10),
--   date DATE
-- );


