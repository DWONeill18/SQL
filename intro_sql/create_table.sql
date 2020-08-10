CREATE TABLE friends (
id INTEGER,
name TEXT,
birthday DATE
);

INSERT INTO friends (id, name, birthday)
VALUES (1, 'Jane Doe', '30/05/1990');

INSERT INTO friends (id, name, birthday)
VALUES (2, 'Chess Paul', '06/10/1988');
INSERT INTO friends (id, name, birthday)
VALUES (3, 'School Ryan', '14/09/1990');

UPDATE friends
SET name = 'Jane Smith'
WHERE id = 1;

ALTER TABLE friends
ADD COLUMN email TEXT;

UPDATE friends
SET email = 'jane@codeacademy.com'
WHERE id = 1;
UPDATE friends
SET email = 'paul@codeacademy.com'
WHERE id = 2;
UPDATE friends
SET email = 'ryan@codeacademy.com'
WHERE id = 3;

DELETE FROM friends
WHERE name IS 'Jane Smith';

SELECT * FROM friends;