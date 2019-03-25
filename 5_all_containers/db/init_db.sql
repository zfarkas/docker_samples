USE zip2000_app;

CREATE TABLE messages (
  id int(11) NOT NULL AUTO_INCREMENT,
  text varchar(64) DEFAULT NULL,
  ts timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (id)
);
