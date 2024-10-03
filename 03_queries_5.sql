--(v)
----COUNT THE NUMBER OF LATE SUBMISSION PER STUDENT AND GET THE STUDENT ID WITH MORE THAN 1---
----STUDENT IDs PASSED INTO QUERY AS SUBQUERY----
SELECT *
FROM STUDENT
WHERE studentId IN (
SELECT sub.studentId
FROM ASSIGNMENT a JOIN SUBMISSION sub ON a.courseCode = sub.courseCode AND a.assignmentNumber = sub.assignmentNumber
WHERE sub.dateSubmitted > a.dueDate
GROUP BY sub.studentId
HAVING COUNT(sub.studentId) > 1)
