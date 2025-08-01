use ExamSystem

-- Training Manager.

-- sp_AddTrainingManager @Username, @Password, @FullName, @Email
[TrainingManager].[sp_AddTrainingManager] 'manager1', '112233', 'Abdo Mahdy', 'abdo@email'


-- sp_AddBranch @BranchName
[TrainingManager].[sp_AddBranch] 'Zagazig'
go
[TrainingManager].[sp_AddBranch] 'Cairo'
go
[TrainingManager].[sp_AddBranch] 'Mansura'

-- sp_AddIntake @IntakeName , @BranchID 
[TrainingManager].[sp_AddIntake] 'Jun 2025', 1
go
[TrainingManager].[sp_AddIntake] 'Jul 2025', 1
go
[TrainingManager].[sp_AddIntake] 'Aug 2025', 1

-- sp_AddTrack @TrackName, @IntakeID, @ManagerID
[TrainingManager].[sp_AddTrack] '.NET', 1, 1
go
[TrainingManager].[sp_AddTrack] 'AI', 2, 1
go
[TrainingManager].[sp_AddTrack] 'Flutter', 3, 1


-- sp_AddInstructor @Username, @Password, @FullName, @Email, @Specialization, @TrackID
[TrainingManager].[sp_AddInstructor] 'ins1', '11233', 'Ahmed Ali','ins1@email','AI',1
go
[TrainingManager].[sp_AddInstructor] 'ins2', '11233', 'Tarek Emad','ins2@email','AI',2
go
[TrainingManager].[sp_AddInstructor] 'ins3', '11233', 'Mohamed Hani','in31@email','AI',3

-- sp_AddStudent @Username, @Password, @FullName, @Email, @TrackID, @IntakeID, @BranchID
[TrainingManager].[sp_AddStudent] 'stu1', '112233', 'Mohamed Naser', 'stu1@email', 2, 2, 1
go
[TrainingManager].[sp_AddStudent] 'stu2', '112233', 'Ali Ibrahim', 'stu2@email', 1, 1, 1
go
[TrainingManager].[sp_AddStudent] 'stu3', '112233', 'Adel Mohamed', 'stu3@email', 3, 3, 1
go
[TrainingManager].[sp_AddStudent] 'stu4', '112233', 'Ahmed Samir', 'stu4@email', 1, 1, 1
go
[TrainingManager].[sp_AddStudent] 'stu5', '112233', 'Aahmed Mohamed', 'stu5@email', 2, 2, 1

-- sp_AddCourse @CrsName, @Description, @MaxDegree, @MinDegree
[TrainingManager].[sp_AddCourse] 'C#', ' ', 100, 50
go
[TrainingManager].[sp_AddCourse] 'Dart', ' ', 100, 50
go
[TrainingManager].[sp_AddCourse] 'Python', ' ', 100, 50
go
[TrainingManager].[sp_AddCourse] 'SQL', ' ', 100, 50

-- sp_AssignInstructorToCourse  @InsID,  @CourseID, @Year, @Class
[TrainingManager].[sp_AssignInstructorToCourse] 2, 1, '2025', 'Class 1'
go
[TrainingManager].[sp_AssignInstructorToCourse] 3, 2, '2025', 'Class 2'
go
[TrainingManager].[sp_AssignInstructorToCourse] 4, 3, '2025', 'Class 3'
go
[TrainingManager].[sp_AssignInstructorToCourse] 2, 4, '2025', 'Class 1'

----------------------------------------------------------------------------

-- Instructor.

-- sp_AddQuestion @QuestionType, @QuestionText, @CorrectAnswer, @CourseID
[Instructor].[sp_AddQuestion] 'MCQ', 'MCQ1', 'Correct1', 1
go
[Instructor].[sp_AddQuestion] 'MCQ', 'MCQ2', 'Correct2', 1
go
[Instructor].[sp_AddQuestion] 'MCQ', 'MCQ3', 'Correct3', 1
go
[Instructor].[sp_AddQuestion] 'MCQ', 'MCQ4', 'Correct4', 1
go
[Instructor].[sp_AddQuestion] 'T/F', 'T/F1', 'True', 1
go
[Instructor].[sp_AddQuestion] 'T/F', 'T/F2', 'False', 1
go
[Instructor].[sp_AddQuestion] 'T/F', 'T/F3', 'False', 1

-- sp_AddQuestionChoices @QuestionID, @ChoiceText
[Instructor].[sp_AddQuestionChoices] 1, 'Correct1'
go
[Instructor].[sp_AddQuestionChoices] 1, 'wrong11'
go
[Instructor].[sp_AddQuestionChoices] 1, 'wrong12'
go
[Instructor].[sp_AddQuestionChoices] 2, 'Correct2'
go
[Instructor].[sp_AddQuestionChoices] 2, 'wrong21'
go
[Instructor].[sp_AddQuestionChoices] 2, 'wrong22'
go
[Instructor].[sp_AddQuestionChoices] 3, 'Correct3'
go
[Instructor].[sp_AddQuestionChoices] 3, 'wrong31'
go
[Instructor].[sp_AddQuestionChoices] 4, 'Correct4'
go
[Instructor].[sp_AddQuestionChoices] 4, 'wrong41'
go
[Instructor].[sp_AddQuestionChoices] 5, 'True'
go
[Instructor].[sp_AddQuestionChoices] 5, 'False'
go
[Instructor].[sp_AddQuestionChoices] 6, 'True'
go
[Instructor].[sp_AddQuestionChoices] 6, 'False'
go
[Instructor].[sp_AddQuestionChoices] 7, 'True'
go
[Instructor].[sp_AddQuestionChoices] 7, 'False'

-- sp_GetQuestionsByTypeOrCourse @QuestionType, @CourseID
[Instructor].[sp_GetQuestionsByTypeOrCourse] 'MCQ', 1
go
[Instructor].[sp_GetQuestionsByTypeOrCourse] 'T/F', 1

-- sp_CreateExam @Type, @AllowOptions, @Date, @StTime, @EndTime, @TotaleTime, @TotalDegree, @InsID, @CourseID
[Instructor].[sp_CreateExam] 'Exam', ' ', '2025-07-20', '21:00', '23:30', '02:30', 100, 2, 1 -- before today
[Instructor].[sp_CreateExam] 'Exam', ' ', '2025-07-31', '21:00', '23:30', '02:30', 100, 2, 1

-- sp_AddQuestionToExam @ExamID, @QuestionID, @Degree
[Instructor].[sp_AddQuestionToExam] 1, 1, 10
go
[Instructor].[sp_AddQuestionToExam] 1, 2, 10
go
[Instructor].[sp_AddQuestionToExam] 1, 3, 10
go
[Instructor].[sp_AddQuestionToExam] 1, 4, 10
go
[Instructor].[sp_AddQuestionToExam] 1, 5, 10
go
[Instructor].[sp_AddQuestionToExam] 1, 6, 10
go
[Instructor].[sp_AddQuestionToExam] 1, 7, 10

-- sp_AssignExamToStudents @ExamID, @StudentID
[Instructor].[sp_AssignExamToStudents] 1, 6

-- sp_GetExamDetails @ExamID
[Instructor].[sp_GetExamDetails] 1

-- sp_GetExamQuestions @ExamID
[Instructor].[sp_GetExamQuestions] 1

-----------------------------------------------------------------------

-- Student.

-- sp_SubmitAnswer @StudentID, @ExamID, @QuestionID, @AnswerText
[Student].[sp_SubmitAnswer] 6, 1, 1, 'Correct1'
go							
[Student].[sp_SubmitAnswer] 6, 1, 2, 'Correct2'
go							
[Student].[sp_SubmitAnswer] 6, 1, 3, 'wrong31' --wrong answer
go							
[Student].[sp_SubmitAnswer] 6, 1, 4, 'Correct4'
go							
[Student].[sp_SubmitAnswer] 6, 1, 5, 'True'
go							
[Student].[sp_SubmitAnswer] 6, 1, 6, 'False'
go							
[Student].[sp_SubmitAnswer] 6, 1, 7, 'True'  -- wrong answer



-- the date is still early need to change it.
update  vw_Exams set ExamDate = '2025-07-30' where ExamID = 1



--  sp_GetStudentResults @StudentID
[Student].[sp_GetStudentResults] 6        -- Must be 50

