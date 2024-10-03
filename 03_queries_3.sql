--(iii)Using view
CREATE VIEW STUDENTS_IN_EACH_PROGRAM AS
SELECT program, count(studentId) AS noOfStudents
from STUDENT
GROUP BY program
--FROM--VIEW
SELECT program
FROM STUDENTS_IN_EACH_PROGRAM
WHERE noOfStudents = 
(SELECT MAX(noOfStudents)
FROM STUDENTS_IN_EACH_PROGRAM)


---without view
SELECT program
FROM (
    SELECT program, count(studentId) AS noOfStudents
    FROM STUDENT
    GROUP BY program
) AS program_counts
WHERE noOfStudents = (
    SELECT MAX(noOfStudents)
    FROM (
        SELECT program, count(studentId) AS noOfStudents
        FROM STUDENT
        GROUP BY program
    ) AS subquery
)

---join two different query
SELECT program
FROM (
    SELECT program, COUNT(studentId) AS noOfStudents
    FROM STUDENT
    GROUP BY program
) AS program_counts
JOIN (
    SELECT MAX(noOfStudents) AS maxStudents
    FROM (
        SELECT COUNT(studentId) AS noOfStudents
        FROM STUDENT
        GROUP BY program
    ) AS subquery
) AS max_counts
ON program_counts.noOfStudents = max_counts.maxStudents


