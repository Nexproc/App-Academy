DROP TABLE IF EXISTS users;

CREATE TABLE users (
  id INTEGER PRIMARY KEY NOT NULL,
  fname VARCHAR(255),
  lname VARCHAR(255)
);

DROP TABLE IF EXISTS questions;

CREATE TABLE questions (
  id INTEGER PRIMARY KEY NOT NULL,
  title VARCHAR(255),
  body TEXT,
  author INTEGER NOT NULL REFERENCES users(id)
);

DROP TABLE IF EXISTS question_follows;

CREATE TABLE question_follows (
  id INTEGER NOT NULL PRIMARY KEY,
  question_id INTEGER NOT NULL REFERENCES questions(id),
  user_id INTEGER NOT NULL REFERENCES user(id)
);

DROP TABLE IF EXISTS replies;

CREATE TABLE replies (
  id INTEGER PRIMARY KEY NOT NULL,
  question_id INTEGER NOT NULL REFERENCES questions(id),
  user_id INTEGER NOT NULL REFERENCES users(id),
  parent_id INTEGER REFERENCES replies(id),
  body TEXT NOT NULL
);

DROP TABLE IF EXISTS question_likes;

CREATE TABLE question_likes (
  id INTEGER NOT NULL PRIMARY KEY,
  question_id INTEGER NOT NULL REFERENCES questions(id),
  user_id INTEGER NOT NULL REFERENCES user(id)
);

INSERT INTO users (id, fname, lname)
VALUES
  (2, 'Nick', 'Tit'),
  (1, 'Matt', 'Piercy');

INSERT INTO questions(id, title, body, author)
VALUES
  (1, 'Unsure', "I'm not really sure what to type. I think I'm unsure. Maybe?", 2 ),
  (2, 'Question!', "I have one!?", 1);

INSERT INTO question_follows (id, question_id, user_id)
VALUES
  (1, 1, 1), (2, 2, 2);

INSERT INTO question_likes (id, question_id, user_id)
VALUES
  (1, 1, 1), (2, 1, 2), (3, 2, 2);

INSERT INTO replies (id, question_id, user_id, parent_id, body)
VALUES
  (1, 1, 2, NULL, "I am unsure as well. We need assured!"),
  (2, 1, 2, 1, "Who posted this reply?"),
  (3, 2, 1, NULL, "I have one too, probably.");
