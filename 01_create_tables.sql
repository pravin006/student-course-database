USE Q3
GO

CREATE TABLE COURSE (
	courseCode 			Char(5) 			NOT NULL,
	courseName			Varchar(50)		    NOT NULL,

	CONSTRAINT 	courseCodePK			PRIMARY KEY(courseCode),
	CONSTRAINT 	courseNameAK1			UNIQUE(courseName),
	CONSTRAINT 	ValidCourseCode 	CHECK
					(courseCode LIKE '[A-Z][A-Z][0-9][0-9][0-9]'),
	);

CREATE TABLE ASSIGNMENT (
	courseCode 			Char(5) 		NOT NULL,
	assignmentNumber 	Int 			NOT NULL,
	[weight]			Int		        NOT NULL,
	dueDate 			Date		    NULL,

	CONSTRAINT 	assignmentTablePK	    PRIMARY KEY(courseCode, assignmentNumber),
	CONSTRAINT 	courseCodeFK		FOREIGN KEY(courseCode)
						REFERENCES COURSE(courseCode)
 							ON UPDATE CASCADE
							ON DELETE CASCADE,

	CONSTRAINT 	weightCheck 	CHECK
					([weight] > 0),
	--CONSTRAINT  dueDateCheck    CHECK
					--(DATEDIFF(DAY,CONVERT (DATE, GETDATE()),dueDate) >= 7) 


	);


CREATE TABLE STUDENT (
	studentId 			Int 			NOT NULL IDENTITY(1000000,1),
	program			    Varchar(50)		NOT NULL,

	CONSTRAINT 	studentIdPK			PRIMARY KEY(studentId),
	CONSTRAINT 	programValues	CHECK 
					(program IN ('Accountancy', 'Finance', 'Information and Communication Technology',
					 'Business Administration')),
	);

CREATE TABLE SUBMISSION (
	studentId 			Int 		NOT NULL,
	courseCode 			Char(5) 	NOT NULL,
	assignmentNumber 	Int 		NOT NULL,
	datesubmitted		Date	NULL DEFAULT CONVERT(DATE, GETDATE()),
	score 			    Decimal(5,2)		NULL,

	CONSTRAINT 	submissionTablePK	    PRIMARY KEY(studentId, courseCode, assignmentNumber),
	CONSTRAINT 	studentIdFK		    FOREIGN KEY(studentId)
						REFERENCES STUDENT(studentId)
 							ON UPDATE NO ACTION
							ON DELETE CASCADE,
	CONSTRAINT 	assignmentTableFK		    FOREIGN KEY(courseCode, assignmentNumber)
						REFERENCES ASSIGNMENT(courseCode, assignmentNumber)
 							ON UPDATE NO ACTION
							ON DELETE NO ACTION,
	);


Create TABLE COURSE_STUDENTS (
	courseCode			Char(5)			NOT NULL,
	studentId			Int				NOT NULL,

	constraint	courseStudentsTablePK	PRIMARY KEY(courseCode,studentId),
	constraint	courseStudentsTableFK1		FOREIGN KEY(courseCode)
						REFERENCES COURSE(courseCode)
							ON UPDATE NO ACTION
							ON DELETE NO ACTION,
	constraint	courseStudentsTableFK2		FOREIGN KEY(studentId)
						REFERENCES STUDENT(studentId)
							ON UPDATE NO ACTION
							ON DELETE NO ACTION,
);
