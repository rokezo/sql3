IF NOT EXISTS (SELECT 1 FROM sys.databases WHERE name = 'AcademyDB')
BEGIN
    CREATE DATABASE AcademyDB;
END
GO

USE AcademyDB;


CREATE TABLE Teachers (
    Id INT PRIMARY KEY
);

CREATE TABLE Assistants (
    Id INT PRIMARY KEY,
    TeacherId INT NOT NULL,
    FOREIGN KEY (TeacherId) REFERENCES Teachers(Id)
);


CREATE TABLE Curators (
    Id INT PRIMARY KEY,
    TeacherId INT NOT NULL,
    FOREIGN KEY (TeacherId) REFERENCES Teachers(Id)
);

CREATE TABLE Deans (
    Id INT PRIMARY KEY,
    TeacherId INT NOT NULL,
    FOREIGN KEY (TeacherId) REFERENCES Teachers(Id)
);

CREATE TABLE Faculties (
    Id INT PRIMARY KEY,
    Building INT NOT NULL CHECK (Building BETWEEN 1 AND 5),
    Name NVARCHAR(100) NOT NULL UNIQUE,
    DeanId INT NOT NULL,
    FOREIGN KEY (DeanId) REFERENCES Deans(Id)
);

CREATE TABLE Heads (
    Id INT PRIMARY KEY,
    TeacherId INT NOT NULL,
    FOREIGN KEY (TeacherId) REFERENCES Teachers(Id)
);

CREATE TABLE Departments (
    Id INT PRIMARY KEY,
    Building INT NOT NULL CHECK (Building BETWEEN 1 AND 5),
    Name NVARCHAR(100) NOT NULL UNIQUE,
    FacultyId INT NOT NULL,
    HeadId INT NOT NULL,
    FOREIGN KEY (FacultyId) REFERENCES Faculties(Id),
    FOREIGN KEY (HeadId) REFERENCES Heads(Id)
);



CREATE TABLE Groups (
    Id INT PRIMARY KEY,
    Name NVARCHAR(10) NOT NULL UNIQUE,
    Year INT NOT NULL CHECK (Year BETWEEN 1 AND 5),
    DepartmentId INT NOT NULL,
    FOREIGN KEY (DepartmentId) REFERENCES Departments(Id)
);

CREATE TABLE GroupsCurators (
    Id INT PRIMARY KEY,
    CuratorId INT NOT NULL,
    GroupId INT NOT NULL,
    FOREIGN KEY (CuratorId) REFERENCES Curators(Id),
    FOREIGN KEY (GroupId) REFERENCES Groups(Id)
);

CREATE TABLE Subjects (
    Id INT PRIMARY KEY,
    Name NVARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE Lectures (
    Id INT PRIMARY KEY,
    SubjectId INT NOT NULL,
    TeacherId INT NOT NULL,
    FOREIGN KEY (SubjectId) REFERENCES Subjects(Id),
    FOREIGN KEY (TeacherId) REFERENCES Teachers(Id)
);


CREATE TABLE GroupsLectures (
    Id INT PRIMARY KEY,
    GroupId INT NOT NULL,
    LectureId INT NOT NULL,
    FOREIGN KEY (GroupId) REFERENCES Groups(Id),
    FOREIGN KEY (LectureId) REFERENCES Lectures(Id)
);


CREATE TABLE LectureRooms (
    Id INT PRIMARY KEY,
    Building INT NOT NULL CHECK (Building BETWEEN 1 AND 5),
    Name NVARCHAR(10) NOT NULL UNIQUE
);


CREATE TABLE Schedules (
    Id INT PRIMARY KEY,
    Class INT NOT NULL CHECK (Class BETWEEN 1 AND 8),
    DayOfWeek INT NOT NULL CHECK (DayOfWeek BETWEEN 1 AND 7),
    Week INT NOT NULL CHECK (Week BETWEEN 1 AND 52),
    LectureId INT NOT NULL,
    LectureRoomId INT NOT NULL,
    FOREIGN KEY (LectureId) REFERENCES Lectures(Id),
    FOREIGN KEY (LectureRoomId) REFERENCES LectureRooms(Id)
);

