--C) Insert
CREATE TRIGGER CHECK_ASSIGNMENT_WEIGHT_ADD_NUM
ON ASSIGNMENT INSTEAD OF INSERT
AS
BEGIN
	
	DECLARE @Latest_assignment AS INT,
			@TotalAssignmentWeight as INT,
			@CourseCode as CHAR(5),
			@AssignmentNumIns AS INT,
			@WeightIns AS INT,
			@DueDateIns AS DATE,
			@New_Assignment_Num AS INT

	SELECT @CourseCode = courseCode,
		   @AssignmentNumIns = assignmentNumber,
		   @WeightIns =weight,
		   @DueDateIns = dueDate
	FROM inserted

	---GET LATEST ASSIGNMENT NUMBER---
	--Assuming that there are no missing numbers in between, the latest number is used
	SELECT @Latest_assignment = MAX(assignmentNumber)
	FROM ASSIGNMENT
	WHERE courseCode = @CourseCode;

	---GET CURRENT TOTAL WEIGHT---
	SELECT @TotalAssignmentWeight = SUM(weight)
	FROM ASSIGNMENT
	WHERE courseCode = @CourseCode;

	IF (@TotalAssignmentWeight + @WeightIns > 100)
		BEGIN
			RAISERROR('UNABLE TO ADD NEW ASSIGNMENT. TOTAL WEIGHTAGE WILL BE ABOVE 100%', 16, 1)
		END
	ELSE
		BEGIN
			IF (@AssignmentNumIns IS NULL)
				SET @AssignmentNumIns = @Latest_assignment + 1
			INSERT INTO ASSIGNMENT 
			VALUES(@CourseCode,@AssignmentNumIns,@WeightIns,@DueDateIns)
		END
END
