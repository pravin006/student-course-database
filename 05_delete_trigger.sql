--DELETE TRIGGER
CREATE TRIGGER UPDATE_ASSIGNMENTNUM_AFTER
ON ASSIGNMENT AFTER DELETE
AS
BEGIN
	DECLARE @Deleted_assignment AS INT,
			@CourseCode AS CHAR(5)

	SELECT @CourseCode = courseCode,
		   @Deleted_assignment = assignmentNumber
	FROM deleted

	UPDATE ASSIGNMENT SET assignmentNumber = assignmentNumber - 1
	WHERE courseCode = @CourseCode AND assignmentNumber > @Deleted_assignment
END
