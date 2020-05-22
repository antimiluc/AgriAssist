CREATE TABLE ADVENTICE (
    id INT NOT NULL AUTO_INCREMENT,
    name VARCHAR(50),
    PRIMARY KEY (id)
);

CREATE TABLE CULTURE (
    id INT NOT NULL AUTO_INCREMENT,
    name VARCHAR(50),
    PRIMARY KEY (id)
);

CREATE TABLE DESTRUCTION_METHOD (
    id INT NOT NULL AUTO_INCREMENT,
    type VARCHAR(1),
    name VARCHAR(50),
    description VARCHAR(300),
    PRIMARY KEY (id)
);

CREATE TABLE IS_DESTROYED_BY (
    id_adventice INT,
    id_culture INT,
    id_destruction_method INT,
    FOREIGN KEY (id_adventice) REFERENCES ADVENTICE(id),
    FOREIGN KEY (id_culture) REFERENCES CULTURE(id),
    FOREIGN KEY (id_destruction_method) REFERENCES DESTRUCTION_METHOD(id),
    PRIMARY KEY (id_adventice,id_culture)
);

INSERT INTO CULTURE (name) VALUES ("mais");
INSERT INTO CULTURE (name) VALUES ("ble dur");
INSERT INTO CULTURE (name) VALUES ("ble tendre");
INSERT INTO CULTURE (name) VALUES ("orge");
INSERT INTO CULTURE (name) VALUES ("soja");
INSERT INTO CULTURE (name) VALUES ("tournesol");

INSERT INTO ADVENTICE (name) VALUES ("folle avoine");
INSERT INTO ADVENTICE (name) VALUES ("liseron des haies");
INSERT INTO ADVENTICE (name) VALUES ("lampourde a gros fruits");
INSERT INTO ADVENTICE (name) VALUES ("datura stramoine");