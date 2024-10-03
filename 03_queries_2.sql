--ii)

CREATE VIEW STUDENT_SUMBISSIONS AS
	SELECT stu.studentId, stu.program, sub.assignmentNumber, sub.datesubmitted, sub.courseCode
	FROM STUDENT stu JOIN SUBMISSION sub ON stu.studentId = sub.studentId
--FROM VIEW--
SELECT studentId, program
FROM STUDENT_SUMBISSIONS
WHERE assignmentNumber = 3 AND courseCode = 'BS100' AND program IN ('Accountancy', 'Business Administration', 'Finance') AND datesubmitted IS NULL


---without view
SELECT stu.studentId, stu.program
FROM STUDENT stu 
JOIN SUBMISSION sub ON stu.studentId = sub.studentId
WHERE sub.assignmentNumber = 3 
	AND sub.courseCode = 'BS100' 
	AND stu.program IN ('Accountancy', 'Business Administration', 'Finance') 
	AND sub.datesubmitted IS NULL;