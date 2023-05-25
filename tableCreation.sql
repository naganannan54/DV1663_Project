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
PRIMARY KEY (stagename)
);

CREATE TABLE Submissions(
score FLOAT NOT NULL,
user VARCHAR(50) NOT NULL,
stage VARCHAR(50) NOT NULL,
submissionDate DATE NOT NULL,
motherboard VARCHAR(50),
memoryFrequency FLOAT,
PRIMARY KEY (score, user),
FOREIGN KEY (user) REFERENCES Users(username),
FOREIGN KEY (stage) REFERENCES Stages(stagename)
);

