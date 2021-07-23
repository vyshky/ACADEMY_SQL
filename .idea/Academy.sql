drop table curators , departments ,
    faculties , groups ,
    groupscurators , groupslectures ,
    lectures , subjects , teachers;

CREATE TABLE curators
(
    id      int primary key auto_increment,
    name    nvarchar(8000) NOT NULL CHECK (name != ''),
    surname nvarchar(8000) NOT NULL CHECK (surname != '')
);

CREATE TABLE faculties
(
    id        int primary key auto_increment,
    financing real          NOT NULL DEFAULT 0 CHECK (financing > 0),
    name      nvarchar(100) NOT NULL unique CHECK (name != '')
);

CREATE TABLE subjects
(
    id   int primary key auto_increment,
    name nvarchar(100) NOT NULL UNIQUE CHECK (name != '')
);

CREATE TABLE teachers
(
    id      int primary key auto_increment,
    name    nvarchar(8000) NOT NULL CHECK (name != ''),
    surname nvarchar(8000) NOT NULL CHECK (surname != ''),
    salary  real           NOT NULL CHECK (salary > 0)
);

CREATE TABLE departments
(
    id        int primary key auto_increment,
    financing real         NOT NULL DEFAULT 0 CHECK (financing > 0),
    name      varchar(100) not null unique check (name != ''),
    facultyid int          NOT NULL,
    FOREIGN KEY (facultyid) REFERENCES faculties (id) ON DELETE CASCADE
);

CREATE TABLE groups
(
    id           int primary key auto_increment,
    name         nvarchar(10) NOT NULL unique CHECK (name != ''),
    year         int          NOT NULL CHECK (year >= 1 AND year <= 5),
    departmentid int          NOT NULL,
    FOREIGN KEY (departmentid) REFERENCES departments (id) ON DELETE CASCADE
);

CREATE TABLE groupscurators
(
    id        int primary key auto_increment,
    curatorid int NOT NULL,
    FOREIGN KEY (curatorid) REFERENCES curators (id) ON DELETE CASCADE,
    groupid   int NOT NULL,
    FOREIGN KEY (groupid) REFERENCES groups (id) ON DELETE CASCADE
);

CREATE TABLE lectures
(
    id          int primary key auto_increment,
    lectureroom nvarchar(8000) NOT NULL CHECK (lectureroom != ''),
    subjectid   int            NOT NULL,
    FOREIGN KEY (subjectid) REFERENCES subjects (id) ON DELETE CASCADE,
    teacherid   int            NOT NULL,
    FOREIGN KEY (teacherid) REFERENCES teachers (id) ON DELETE CASCADE
);

CREATE TABLE groupslectures
(
    id        int primary key auto_increment,
    groupid   int NOT NULL,
    FOREIGN KEY (groupid) REFERENCES groups (id) ON DELETE CASCADE,
    lectureid int NOT NULL,
    FOREIGN KEY (lectureid) REFERENCES lectures (id) ON DELETE CASCADE
);

INSERT INTO teachers
VALUES (NULL, 'Denis', 'Vladimirovich', 100.5),
       (NULL, 'Vlad', 'Ojmegov', 89.5),
       (NULL, 'Slava', 'Ojmegov', 120.5),
       (NULL, 'Alexandr', 'Dedykhin', 150.5),
       (NULL, 'Egor', 'Ojegin', 61.5),
       (NULL, 'Lev', 'Ignatyev', 120.8),
       (NULL, 'Islam', 'Magomedov', 119.5),
       (NULL, 'Rystam', 'Minmuhametov', 126.5),
       (NULL, 'Vitaliy', 'Gainylin', 69.5),
       (NULL, 'Igor', 'Haluev', 55.5),
       (NULL, 'Raf', 'Batirov', 80.5);

INSERT INTO curators
VALUES (NULL, 'Lev', 'Ignatyev'),
       (NULL, 'Islam', 'Magomedov'),
       (NULL, 'Rystam', 'Minmuhametov'),
       (NULL, 'Vitaliy', 'Gainylin'),
       (NULL, 'Igor', 'Haluev'),
       (NULL, 'Raf', 'Batirov');


INSERT INTO faculties
VALUES (NULL, 12000, 'Исторический факультет'),
       (NULL, 13000, 'Филологический факультет'),
       (NULL, 10000, 'Факультет удмуртской филологии'),
       (NULL, 20000, 'Факультет физической культуры и спорта'),
       (NULL, 15000, 'Факультет социологии и философии'),
       (NULL, 9000, 'Факультет журналистики'),
       (NULL, 12000, 'Факультет профессионального иностранного языка'),
       (NULL, 8000, 'Институт искусств и дизайна');


INSERT INTO groups(name, year, departmentid)
VALUES ('ИФ', 1, 26),
       ('ФФ', 3, 27),
       ('ФУФ', 1, 28),
       ('ФФКС', 5, 29),
       ('ФСФ', 2, 30),
       ('ФЖ', 4, 31),
       ('ФПИЯ', 5, 32),
       ('ИИД', 1, 33);


-- копирование из faculties в departments
INSERT INTO departments(financing, name, facultyid)
SELECT financing, name, id
FROM faculties;


-- Создание group
-- ///// Примеры....
SELECT CONVERT(RAND() * 200, NCHAR);
SELECT CONCAT('Tom ', RAND() * 200, ' Smith');
SELECT LOCATE('.', 'P45.2323', 2);
SELECT SUBSTRING_INDEX('P45.2323', '.', 1);
SELECT SUBSTRING_INDEX(CONCAT('Р', RAND() * 200), '.', 1);
SELECT SUBSTRING_INDEX((RAND() * 4) + 1, '.', 1);
-- Создание group
INSERT INTO groups (name, year, departmentid)
SELECT SUBSTRING_INDEX(CONCAT('Р', RAND() * 200), '.', 1), SUBSTRING_INDEX((RAND() * 4) + 1, '.', 1), id
FROM departments;

