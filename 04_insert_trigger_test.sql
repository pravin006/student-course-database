---INSERT NEW ASSIGNNMENT WITHOUT assignmentNumber GIVEN AT 10%----
---Able to insert---
INSERT INTO ASSIGNMENT 
		(courseCode, weight, dueDate)
		VALUES('BS105',10,'2023-04-15')
SELECT * FROM ASSIGNMENT


--- TRY TO INSERT AGAIN WITH TOTAL WEIGHT ALREADY AT 100---
---Not able to Insert---
INSERT INTO ASSIGNMENT 
		(courseCode, weight, dueDate)
		VALUES('BS105',10,'2023-04-15')
SELECT * FROM ASSIGNMENT
