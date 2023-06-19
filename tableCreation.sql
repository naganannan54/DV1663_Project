CREATE TABLE Users(
username VARCHAR(50) NOT NULL,
country VARCHAR(50) NOT NULL,
league VARCHAR(50) NOT NULL,
joindate DATE NOT NULL,
PRIMARY KEY (username)
);

CREATE TABLE Stages(
stagename VARCHAR(50) NOT NULL,
startdate DATE NOT NULL,
enddate DATE NOT NULL,
descending BOOL NOT NULL,
PRIMARY KEY (stagename)
);

CREATE TABLE Motherboards(
motherboardname VARCHAR(50) NOT NULL,
manufacturer VARCHAR(50),
chipset VARCHAR(50),
model VARCHAR(50),
PRIMARY KEY (motherboardname)
);

CREATE TABLE Submissions(
score FLOAT NOT NULL,
username VARCHAR(50) NOT NULL,
stagename VARCHAR(50) NOT NULL,
submissionDate DATE NOT NULL,
motherboardname VARCHAR(50),
memoryFrequency FLOAT,
points INT,
PRIMARY KEY (username, stagename),
FOREIGN KEY (username) REFERENCES Users(username),
FOREIGN KEY (stagename) REFERENCES Stages(stagename),
FOREIGN KEY (motherboardname) REFERENCES Motherboards(motherboardname)
);

CALL UpdatePoints('Memory Frequency', 1);
CALL UpdatePoints('Cinebench R15', 1);
CALL UpdatePoints('SuperPi 32M', 0);
CALL UpdatePoints('Y-Cruncher 2.5B', 0);
