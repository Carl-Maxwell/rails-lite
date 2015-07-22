CREATE TABLE cats (name varchar(255), id INTEGER NOT NULL, PRIMARY KEY(id));

CREATE TABLE statuses (text varchar(255), id INTEGER NOT NULL, cat_id INTEGER NOT NULL, PRIMARY KEY(id));


INSERT INTO cats
	(id, name)
VALUES
	(1, "Curie"), (2, "Markov");


INSERT INTO statuses
	(id, cat_id, text)
VALUES
  ( 1, 1, "Curie loves string!" ),
  ( 2, 2, "Markov is mighty!"   ),
  ( 3, 1, "Curie is cool!"      );
