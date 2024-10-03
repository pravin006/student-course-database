SELECT program, count(studentId) AS numberOfStudents
from STUDENT
GROUP BY program
ORDER BY count(studentId) Desc;
