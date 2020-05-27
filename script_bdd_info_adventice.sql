DROP TABLE IS_DESTROYED_BY;
DROP TABLE DESTRUCTION_METHOD;
DROP TABLE CULTURE;
DROP TABLE ADVENTICE;

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
    name VARCHAR(100),
    description_infloweb VARCHAR(300),
    description_euralis VARCHAR(300),
    PRIMARY KEY (id)
);

CREATE TABLE IS_DESTROYED_BY (
    id_culture INT,
    id_adventice INT,
    id_destruction_method INT,
    comment VARCHAR(300),
    FOREIGN KEY (id_adventice) REFERENCES ADVENTICE(id),
    FOREIGN KEY (id_culture) REFERENCES CULTURE(id),
    FOREIGN KEY (id_destruction_method) REFERENCES DESTRUCTION_METHOD(id),
    PRIMARY KEY (id_adventice,id_culture,id_destruction_method)
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

INSERT INTO DESTRUCTION_METHOD (id,type,name,description_infloweb) VALUES (1,"M","binage","En agriculture et jardinage, le binage consiste à ameublir la couche superficielle du sol autour des plantes cultivées.");
INSERT INTO DESTRUCTION_METHOD (id,type,name,description_infloweb) VALUES (2,"B","rotation","La rotation culturale est en agriculture la suite de cultures échelonnées au fil des années sur une même parcelle. C'est un élément important de la gestion de la fertilité des sols et des bioagresseurs et donc un atout pour l'augmentation des rendements");
INSERT INTO DESTRUCTION_METHOD (id,type,name,description_infloweb) VALUES (3,"C","antigraminée foliaire","Les antigraminées foliaires (base pinoxaden clodinafop et fenoxaprop) sont les meilleures solutions disponibles.");
INSERT INTO DESTRUCTION_METHOD (id,type,name,description_infloweb) VALUES (4,"C","sulfonylurées","Les sulfonylurées (mésosulfuron iodosulfuron pyroxsulam) sont efficaces mais d 'un niveau inférieur comparé à l'antigraminée foliaire. Attention au développement de populations résistantes.");
INSERT INTO DESTRUCTION_METHOD (id,type,name,description_infloweb) VALUES (5,"C","cycloxydime","???");
INSERT INTO DESTRUCTION_METHOD (id,type,name,description_infloweb) VALUES (6,"B","destockage","Pratiquez le déstockage jusqu'en fin d'hiver par plusieurs déchaumages superficiels après la moisson d'une culture envahie, avant de mettre en place une culture de printemps.");
INSERT INTO DESTRUCTION_METHOD (id,type,name,description_infloweb) VALUES (7,"C","fluroxypyr","???");
INSERT INTO DESTRUCTION_METHOD (id,type,name,description_infloweb) VALUES (8,"C","clopyralid","???");

INSERT INTO IS_DESTROYED_BY (id_culture,id_adventice,id_destruction_method) VALUES (4,1,2);
INSERT INTO IS_DESTROYED_BY (id_culture,id_adventice,id_destruction_method) VALUES (3,1,3);
INSERT INTO IS_DESTROYED_BY (id_culture,id_adventice,id_destruction_method) VALUES (3,1,4);
INSERT INTO IS_DESTROYED_BY (id_culture,id_adventice,id_destruction_method) VALUES (5,1,6);
INSERT INTO IS_DESTROYED_BY (id_culture,id_adventice,id_destruction_method) VALUES (3,2,7);
INSERT INTO IS_DESTROYED_BY (id_culture,id_adventice,id_destruction_method) VALUES (3,2,8);
INSERT INTO IS_DESTROYED_BY (id_culture,id_adventice,id_destruction_method,comment) VALUES (4,1,2,"En post-levée : sulfonylurée à large spectre");
INSERT INTO IS_DESTROYED_BY (id_culture,id_adventice,id_destruction_method,comment) VALUES (1,1,5,"Avec maïs tolérants (Duo-System).");
INSERT INTO IS_DESTROYED_BY (id_culture,id_adventice,id_destruction_method,comment) VALUES (6,1,3,"Antigraminée foliaire de post-levée");
INSERT INTO IS_DESTROYED_BY (id_culture,id_adventice,id_destruction_method,comment) VALUES (1,1,1,"En curatif  pour ce genre d'adventice  le binage est nécessaire.");