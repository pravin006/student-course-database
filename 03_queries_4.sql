--(iv)
CREATE VIEW ACCU_SCORES AS
SELECT a.courseCode, s.studentId, SUM(s.score * a.weight) as totalScore
FROM ASSIGNMENT a JOIN SUBMISSION s ON a.courseCode = s.courseCode AND a.assignmentNumber = s.assignmentNumber
GROUP BY a.courseCode,s.studentId

CREATE VIEW TOTAL_COURSE_PERC AS
SELECT courseCode, SUM(weight) AS totalPerc
FROM ASSIGNMENT
GROUP BY courseCode

SELECT a.courseCode,CAST(ROUND(ISNULL(a.totalScore,0),1)/t.totalPerc as DECIMAL(10,1)) AS accumulated_score, a.studentId
FROM ACCU_SCORES a JOIN TOTAL_COURSE_PERC t ON a.courseCode = t.courseCode
ORDER BY a.courseCode Asc, a.totalScore desc, a.studentId Asc


--without view
SELECT a.courseCode, 
       CAST(ROUND(ISNULL(SUM(s.score * a.weight), 0), 1) / SUM(a.weight) AS DECIMAL(10,1)) AS accumulated_score, 
       s.studentId
FROM ASSIGNMENT a 
JOIN SUBMISSION s ON a.courseCode = s.courseCode AND a.assignmentNumber = s.assignmentNumber
GROUP BY a.courseCode, s.studentId
ORDER BY a.courseCode ASC, accumulated_score DESC, s.studentId ASC;