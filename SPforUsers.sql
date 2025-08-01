

----------------------USERS
use ExamSystem

--sp_CreateUser  Ì‰‘∆ Õ”«» ·√Ì ‰Ê⁄ (Admin / Manager / Instructor / Student)

CREATE or alter  PROC sp_CreateUser
    @Username NVARCHAR(255),
    @Password NVARCHAR(255),
    @Role NVARCHAR(255),
    @UserID BIGINT OUTPUT
AS
BEGIN
    -- «· Õﬁﬁ „‰ ÊÃÊœ ÌÊ“— »‰›” «·«”„
    IF EXISTS (SELECT 1 FROM vw_Users WHERE Username = @Username)
    BEGIN
        RAISERROR('Username already exists.', 16, 1)
        RETURN
    END

    -- ≈÷«›… «·„” Œœ„
    INSERT INTO vw_Users (Username, Password, Role)
    VALUES (@Username, @Password, @Role)

    -- Ã·» «·‹ UserID «·ÃœÌœ
    SET @UserID = SCOPE_IDENTITY()
END

------------Admin/ manger


--sp_AddBranch  ≈÷«›… ›—⁄

CREATE PROCEDURE sp_AddBranch
    @BranchName NVARCHAR(255)
AS
BEGIN
	IF EXISTS (SELECT 1 FROM vw_Branches WHERE BranchName = @BranchName)
    BEGIN
        RAISERROR('Branch already exists.', 16, 1)
        RETURN
    END

    INSERT INTO vw_Branches (BranchName)
    VALUES (@BranchName)
END

sp_AddBranch 'Cairo'
--sp_AddTrack  ≈÷«›… „”«— + —»ÿÂ »›—⁄

  CREATE  PROCEDURE sp_AddTrack
    @TrackName NVARCHAR(255),
    @IntakeID BIGINT,
    @ManagerID BIGINT
AS
BEGIN
	IF EXISTS (SELECT 1 FROM vw_Tracks WHERE TrackName = @TrackName)
    BEGIN
        RAISERROR('Track already exists.', 16, 1)
        RETURN
    END

    INSERT INTO vw_Tracks (TrackName, IntakeID, ManagerID)
    VALUES (@TrackName, @IntakeID, @ManagerID)
END

sp_AddTrack 'React', 1, 2

--sp_AddIntake  ≈÷«›… œ›⁄…

CREATE PROCEDURE sp_AddIntake
    @IntakeName NVARCHAR(255),
    @BranchID BIGINT
AS
BEGIN
	IF EXISTS (SELECT 1 FROM vw_Intakes WHERE IntakeName = @IntakeName)
    BEGIN
        RAISERROR('Intake already exists.', 16, 1)
        RETURN
    END

    INSERT INTO vw_Intakes (IntakeName, BranchID)
    VALUES (@IntakeName, @BranchID)
END

sp_AddIntake 'June 2025', 1

--sp_AddTrainingManager  ≈÷«›… „œÌ—  œ—Ì»

CREATE or alter PROCEDURE sp_AddTrainingManager
    @Username NVARCHAR(255),
    @Password NVARCHAR(255),
    @FullName NVARCHAR(255),
    @Email NVARCHAR(255)
AS
BEGIN
    DECLARE @UserID BIGINT;

    EXEC sp_CreateUser @Username, @Password, 'Manager', @UserID OUTPUT;

    INSERT INTO vw_TrainingManagers (ManagerID, FullName, Email)
    VALUES (@UserID, @FullName, @Email);
END

sp_AddTrainingManager 'manager2', '112233', 'Abdo Mahdy', 'abdo@email'
select * from TrainingManagers


--sp_AddInstructor  ≈÷«›… „œ—”

CREATE OR ALTER PROCEDURE sp_AddInstructor
    @Username NVARCHAR(255),
    @Password NVARCHAR(255),
    @FullName NVARCHAR(255),
    @Email NVARCHAR(255),
    @Specialization NVARCHAR(255),
    @TrackID BIGINT
AS
BEGIN
    DECLARE @UserID BIGINT

    -- ≈‰‘«¡ ÌÊ“—
    EXEC sp_CreateUser @Username, @Password, 'Instructor', @UserID OUTPUT

    -- ≈÷«›… «·„œ—”
    INSERT INTO vw_Instructors (InsID, FullName, Email, Specialization, TrackID)
    VALUES (@UserID, @FullName, @Email, @Specialization, @TrackID)
END
sp_AddInstructor 'ins3', '11233', 'Ahmed Ali',' ',' ',2
select * from Instructors
select * from Users

--sp_AddStudent  ≈÷«›… ÿ«·» + —»ÿÂ »‹ Intake / Branch / Track

CREATE OR ALTER PROCEDURE sp_AddStudent
    @Username NVARCHAR(255),
    @Password NVARCHAR(255),
    @FullName NVARCHAR(255),
    @Email NVARCHAR(255),
    @TrackID BIGINT,
    @IntakeID BIGINT,
    @BranchID BIGINT
AS
BEGIN
    DECLARE @UserID BIGINT

    -- ≈‰‘«¡ ÌÊ“—
    EXEC sp_CreateUser @Username, @Password, 'Student', @UserID OUTPUT

    -- ≈÷«›… «·ÿ«·»
    INSERT INTO vw_Students (FullName, Email, TrackID, IntakeID, BranchID, StudentID)
    VALUES (@FullName, @Email, @TrackID, @IntakeID, @BranchID, @UserID)
END
   
sp_AddStudent 'stu2', '11233', 'Ali Ali',' ', 2, 1, 1
select * from Students

--sp_AddCourse ≈÷«›… ﬂÊ—”

CREATE OR ALTER PROCEDURE sp_AddCourse
	@CrsName NVARCHAR(255),
	@Description NVARCHAR(255),
	@MaxDegree INT,
	@MinDegree INT
AS
BEGIN
	IF EXISTS (SELECT 1 FROM vw_Courses WHERE CrsName = @CrsName)
    BEGIN
        RAISERROR('Course already exists.', 16, 1)
        RETURN
    END

    INSERT INTO vw_Courses (CrsName, Description, MaxDegree, MinDegree)
    VALUES (@CrsName, @Description, @MaxDegree, @MinDegree)
END

sp_AddCourse 'CSS', '', 100, 60
select * from Courses

--sp_AssignInstructorToCourse  —»ÿ „œ—” »ﬂÊ—” ›Ì ”‰… „Õœœ…

CREATE OR ALTER PROCEDURE sp_AssignInstructorToCourse
    @InsID BIGINT,
    @CourseID BIGINT,
    @Year DATE,
    @Class NVARCHAR(255)
AS
BEGIN
    INSERT INTO vw_Ins_Course (InsID, CourseID, Year, Class)
    VALUES (@InsID, @CourseID, @Year, @Class)
END

sp_AssignInstructorToCourse 6, 1, '2025', null
select * from Ins_Course

-------------------------------------------------------------------------------------------------
«---------------------------------------------------------- Instructor




--sp_AddQuestion  ≈÷«›… ”ƒ«· ··„Œ“‰ (Question Pool)

CREATE OR ALTER PROCEDURE sp_AddQuestion
    @QuestionType NVARCHAR(255),
    @QuestionText NVARCHAR(255),
    @CorrectAnswer NVARCHAR(255),
    @CourseID BIGINT
AS
BEGIN
	
	if exists (select 1 from vw_Questions where QuestionText = @QuestionText)
	begin
		raiserror('Question is already exist.',16,1)
		return
	end

    INSERT INTO vw_Questions (QuestionType, QuestionText, CorrectAnswer, CourseID)
    VALUES (@QuestionType, @QuestionText, @CorrectAnswer, @CourseID)
END

sp_AddQuestion 'T/F', 'Test question5', 'False', 3
select * from Questions

create or alter procedure sp_AddQuestionChoices
	@QuestionID bigint,
	@ChoiceText varchar(255)
as
begin
	
	if exists (select 1 from vw_QuestionChoices where ChoiceText = @ChoiceText)
	begin
		raiserror('This answer is already exist for that question.',16,1)
		return
	end

	insert into vw_QuestionChoices(QuestionID, ChoiceText)
	values(@QuestionID, @ChoiceText)
end

sp_AddQuestionChoices 2, 'test answer2'
sp_AddQuestionChoices 1, 'test answer'

select * from QuestionChoices

--sp_GetQuestionsByTypeOrCourse  ·«” ⁄—«÷ «·√”∆·… Õ”» «·ﬂÊ—” √Ê «·‰Ê⁄

CREATE OR ALTER PROCEDURE sp_GetQuestionsByTypeOrCourse
    @QuestionType NVARCHAR(255) = NULL,
    @CourseID BIGINT = NULL
AS
BEGIN
    SELECT *
    FROM vw_Questions
    WHERE 
        (@QuestionType IS NULL OR QuestionType = @QuestionType)
        AND (@CourseID IS NULL OR CourseID = @CourseID)
END

sp_GetQuestionsByTypeOrCourse 'MCQ', 2

-- 5. ≈‰‘«¡ «„ Õ«‰

--sp_CreateExam  ≈‰‘«¡ «„ Õ«‰ Ê—»ÿÂ »ﬂÊ—” Ê≈‰” —ﬂ Ê—

CREATE OR ALTER PROCEDURE sp_CreateExam
    @Type NVARCHAR(255),
    @AllowOptions NVARCHAR(255),
	@Date date,
    @StTime TIME,
    @EndTime TIME,
    @TotaleTime TIME,
    @TotalDegree INT,
    @InsID BIGINT,
    @CourseID BIGINT
    --@ExamID BIGINT OUTPUT
AS
BEGIN

	IF @Date < GETDATE()
    BEGIN
        RAISERROR('Start date cannot be earlier than the current date.', 16, 1)
        RETURN
    END

    INSERT INTO vw_Exams (Type, AllowOptions, ExamDate, StTime, EndTime, TotaleTime, TotalDegree, InsID, CourseID)
    VALUES (@Type, @AllowOptions, @Date, @StTime, @EndTime, @TotaleTime, @TotalDegree, @InsID, @CourseID)

    --SET @ExamID = SCOPE_IDENTITY()
END

sp_CreateExam 'Exam', null, '2025-7-30', '05:00:00', '07:30:00', '02:30:00',
	80, 6, 3
select * from Exams


--sp_AddQuestionToExam  —»ÿ «·√”∆·… »«·«„ Õ«‰ Ê ÕœÌœ «·œ—Ã… ·ﬂ· ”ƒ«·  ÊÃ⁄· «·«‰” —ﬂ Ê— Ì÷Ì› «”«·Â „‰ »‰ﬂ «·«”«·Â ›ﬁÿ

CREATE OR ALTER PROCEDURE sp_AddQuestionToExam
    @ExamID BIGINT,
    @QuestionID BIGINT,
    @Degree INT
AS
BEGIN
    -- «· Õﬁﬁ „‰ ÊÃÊœ «·”ƒ«· ›Ì »‰ﬂ «·√”∆·…
    IF NOT EXISTS (SELECT 1 FROM vw_Questions WHERE QuestionID = @QuestionID)
    BEGIN
        RAISERROR('This question does not exist in the question pool.', 16, 1)
        RETURN
    END

	IF NOT EXISTS (SELECT 1 FROM vw_ExamQuestions WHERE ExamID = @ExamID)
    BEGIN

        IF ((select @Degree) > (select TotalDegree from vw_Exams where ExamID = @ExamID))
		BEGIN
			RAISERROR('The Exam degree has exceed the max degree.', 16, 1)
			RETURN
		END

		-- ≈÷«›… «·”ƒ«· ··«„ Õ«‰
		INSERT INTO vw_ExamQuestions (ExamID, QuestionID, Degree)
		VALUES (@ExamID, @QuestionID, @Degree)
		return
    END

	IF EXISTS (SELECT sum(Degree)+@Degree FROM vw_ExamQuestions where ExamID = @ExamID having sum(Degree)+@Degree  > (select TotalDegree from vw_Exams where ExamID = @ExamID))
    BEGIN
        RAISERROR('The Exam degree has exceed the max degree.', 16, 1)
        RETURN
    END

    -- ≈÷«›… «·”ƒ«· ··«„ Õ«‰
    INSERT INTO vw_ExamQuestions (ExamID, QuestionID, Degree)
    VALUES (@ExamID, @QuestionID, @Degree)
END

sp_AddQuestionToExam 1,6,4
select * from ExamQuestions

--sp_AssignExamToStudents   ÕœÌœ «·ÿ·«» «·„”„ÊÕ ·Â„ »√œ«¡ «·«„ Õ«‰ Ê ÊﬁÌ  «·œŒÊ·

CREATE OR ALTER PROCEDURE sp_AssignExamToStudents
    @ExamID BIGINT,
    @StudentID BIGINT
AS
BEGIN
    INSERT INTO vw_StExams (StudentID, ExamID)
    VALUES (@StudentID, @ExamID)
END

sp_AssignExamToStudents 1, 8
select * from StExams

--sp_GetExamDetails  Ì⁄—÷  ›«’Ì· «·«„ Õ«‰ («·ﬂÊ—”° «·Êﬁ ° «·√”∆·…...)

CREATE OR ALTER PROCEDURE sp_GetExamDetails
    @ExamID BIGINT
AS
BEGIN
    SELECT 
        e.ExamID,
        c.CrsName AS CourseName,
		e.ExamDate,
        e.StTime,
        e.EndTime,
        e.TotalDegree,
        COUNT(eq.QuestionID) AS NumberOfQuestions
    FROM vw_Exams e
    JOIN vw_Courses c ON e.CourseID = c.CourseID
    LEFT JOIN vw_ExamQuestions eq ON e.ExamID = eq.ExamID
    WHERE e.ExamID = @ExamID
    GROUP BY e.ExamID, c.CrsName, e.ExamDate, e.StTime, e.EndTime, e.TotalDegree;
END

sp_GetExamDetails 2

--sp_GetExamQuestions  Ì⁄—÷ «·√”∆·… «·„— »ÿ… »«„ Õ«‰ „⁄Ì‰

CREATE OR ALTER PROCEDURE sp_GetExamQuestions
    @ExamID BIGINT
AS
BEGIN
    SELECT 
        q.QuestionID,
        q.QuestionType,
        q.QuestionText,
        eq.Degree
    FROM vw_ExamQuestions eq
    JOIN vw_Questions q ON eq.QuestionID = q.QuestionID
    WHERE eq.ExamID = @ExamID;
END

sp_GetExamQuestions 2

----------------------------------------------------------------------------------------------
-------------------Student--------------------------------

--sp_GetAvailableExams  «·«„ Õ«‰«  «·„ «Õ… Õ«·Ì« ··ÿ«·» 

--CREATE OR ALTER PROCEDURE sp_GetAvailableExams
--    @StudentID BIGINT
--AS
--BEGIN
--    SELECT 
--        e.ExamID,
--        c.CrsName,
--        e.StTime,
--        e.EndTime,
--        e.TotalDegree
--    FROM Exams e
--    JOIN Courses c ON e.CourseID = c.CourseID
--    WHERE GETDATE() BETWEEN CAST(e.StTime AS DATETIME) AND CAST(e.EndTime AS DATETIME)
--    AND e.ExamID NOT IN (
--        SELECT ExamID FROM StExams WHERE StudentID = @StudentID
--    );
--END


--«· Õﬁﬁ „‰ ﬂ· «·‘—Êÿ «·„ÿ·Ê»… ⁄‰œ ≈œŒ«· ≈Ã«»…
--1- ⁄«Ê“Ì‰ «·ÿ«·» ÌœŒ·  «·«„ Õ«‰ ›Ì «·Êﬁ   Ê«· «—ÌŒ «·„ÕœœÌ‰
--2-⁄«Ê“Ì‰ «·ÿ«·» „Ìﬂ »‘ id „‘  „ÊÃÊœ Êﬁ  «œ«¡  «·«„ Õ«‰
--3- ⁄«Ê“Ì‰ ⁄‰œ «œ«¡  «·«„ Õ«‰ «·”ƒ«·  «·–Ì  Ì —ﬂ ÌﬂÊ‰ » null
--4- ⁄«ÊÌ“‰ ›Ì  «·«”«·Â «·true ,false  „ÌœŒ·‘  «Ã«»«  €Ì— true or false
--5-„‘  ⁄«Ê“Ì‰ ›Ì «·«”«·Â «· mcq  ÌŒ «— »—Â «·«Ã«»«  «·„ÊÃÊœÂ 
--6- ‰Œ·Ì «·ÿ«·» „Ì»⁄‰‘  «·«„ Õ«‰ »⁄œ «‰ Â«¡  «·Êﬁ  

CREATE OR ALTER PROCEDURE sp_SubmitAnswer
    @StudentID BIGINT,
    @ExamID BIGINT,
    @QuestionID BIGINT,
    @AnswerText NVARCHAR(255)
AS
BEGIN
    -- 1. «· Õﬁﬁ „‰ √‰ «·ÿ«·» „ÊÃÊœ
    IF NOT EXISTS (SELECT 1 FROM vw_Students WHERE StudentID = @StudentID)
    BEGIN
        RAISERROR('Student does not exist.', 16, 1)
        RETURN
    END

    -- 2. «· Õﬁﬁ „‰ √‰ «·«„ Õ«‰ „— »ÿ »«·ÿ«·»
    IF NOT EXISTS (SELECT 1 FROM vw_StExams WHERE StudentID = @StudentID AND ExamID = @ExamID)
    BEGIN
        RAISERROR('Student is not assigned to this exam.', 16, 1)
        RETURN
    END

    -- 3. «· Õﬁﬁ „‰ «·Êﬁ  Ê«· «—ÌŒ
    DECLARE @ExamDate DATE, @StTime TIME, @EndTime TIME
    SELECT @ExamDate = ExamDate, @StTime = StTime, @EndTime = EndTime
    FROM vw_Exams WHERE ExamID = @ExamID

    IF @ExamDate != CAST(GETDATE() AS DATE)
    BEGIN
        RAISERROR('You cannot submit answers outside the exam date.', 16, 1)
        RETURN
    END

    IF CONVERT(TIME, GETDATE()) NOT BETWEEN @StTime AND @EndTime
    BEGIN
        RAISERROR('You cannot submit answers outside the exam time.', 16, 1)
        RETURN
    END

    -- 4. «· Õﬁﬁ ≈‰ «·ÿ«·» „Ã«Ê»‘ ﬁ»· ﬂœÂ
    IF EXISTS (
        SELECT 1 FROM vw_StudentAnswers
        WHERE StudentID = @StudentID AND ExamID = @ExamID AND QuestionID = @QuestionID
    )
    BEGIN
        RAISERROR('You have already answered this question.', 16, 1)
        RETURN
    END

    -- 5. «· Õﬁﬁ „‰ ‰Ê⁄ «·”ƒ«·
    DECLARE @QuestionType NVARCHAR(255), @CorrectAnswer NVARCHAR(255)
    SELECT @QuestionType = QuestionType, @CorrectAnswer = CorrectAnswer
    FROM vw_Questions WHERE QuestionID = @QuestionID

    IF @QuestionType = 'T/F' AND @AnswerText NOT IN ('True', 'False')
    BEGIN
        RAISERROR('Answer must be True or False.', 16, 1)
        RETURN
    END

    IF @QuestionType = 'MCQ' AND NOT EXISTS (
        SELECT 1 FROM vw_QuestionChoices WHERE QuestionID = @QuestionID AND ChoiceText = @AnswerText
    )
    BEGIN
        RAISERROR('Answer must be one of the provided choices.', 16, 1)
        RETURN
    END

    -- 6. «·Õ’Ê· ⁄·Ï œ—Ã… «·”ƒ«·
    DECLARE @QuestionDegree INT;
    SELECT @QuestionDegree = Degree
    FROM vw_ExamQuestions
    WHERE ExamID = @ExamID AND QuestionID = @QuestionID;

    -- 7. Â· «·≈Ã«»… ’ÕÌÕ…ø
    DECLARE @IsCorrect BIT = CASE WHEN @AnswerText = @CorrectAnswer THEN 1 ELSE 0 END;
    DECLARE @FinalDegree INT = CASE WHEN @IsCorrect = 1 THEN @QuestionDegree ELSE 0 END;

    -- 8. Õ›Ÿ «·≈Ã«»…
    INSERT INTO vw_StudentAnswers(StudentID, ExamID, QuestionID, Degree, IsCorrect, AnswerText)
    VALUES (@StudentID, @ExamID, @QuestionID, @FinalDegree, @IsCorrect, NULLIF(@AnswerText, ''))
END

sp_SubmitAnswer 7, 1, 2,'test answer2'
select * from vw_StudentAnswers

update  vw_Exams set ExamDate = '2025-7-27', StTime = '14:00:00', EndTime = '23:59:59'

--sp_GetStudentResults  ÌÃÌ» œ—Ã«  «·ÿ«·» ›Ì ﬂ· «„ Õ«‰« Â

CREATE OR ALTER PROCEDURE sp_GetStudentResults
    @StudentID BIGINT
AS
BEGIN
    SELECT 
        e.ExamID,
        c.CrsName AS CourseName,
        e.TotalDegree AS ExamMaxDegree,
        sum(sa.Degree) AS StudentDegree
    FROM vw_StudentAnswers sa
    JOIN vw_Exams e ON sa.ExamID = e.ExamID
    JOIN vw_Courses c ON e.CourseID = c.CourseID
    WHERE sa.StudentID = @StudentID
	GROUP BY e.ExamID, c.CrsName, e.TotalDegree
END

[Student].[sp_GetStudentResults] 7
