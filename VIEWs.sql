-- View 1: Users
use ExamSystem
go
CREATE OR ALTER VIEW vw_Users With Encryption AS
SELECT * FROM Users;
go
-- View 2: Students
CREATE OR ALTER VIEW vw_Students With Encryption AS
SELECT * FROM Students;
go
-- View 3: Instructors
CREATE OR ALTER VIEW vw_Instructors With Encryption AS
SELECT * FROM Instructors;
go
-- View 4: Training Managers
CREATE OR ALTER VIEW vw_TrainingManagers With Encryption AS
SELECT * FROM TrainingManagers;
go
-- View 5: Branches
CREATE OR ALTER VIEW vw_Branches With Encryption AS
SELECT * FROM Branches;
go
-- View 6: Intakes
CREATE OR ALTER VIEW vw_Intakes With Encryption AS
SELECT * FROM Intakes;
go
-- View 7: Tracks
CREATE OR ALTER VIEW vw_Tracks With Encryption AS
SELECT * FROM Tracks;
go
-- View 8: Courses
CREATE OR ALTER VIEW vw_Courses With Encryption AS
SELECT * FROM Courses;
go
-- View 9: Instructor-Course Relation
CREATE OR ALTER VIEW vw_Ins_Course With Encryption AS
SELECT * FROM Ins_Course;
go
-- View 10: Exams
CREATE OR ALTER VIEW vw_Exams With Encryption AS
SELECT * FROM Exams;
go
-- View 11: Student Exams
CREATE OR ALTER VIEW vw_StExams With Encryption AS
SELECT * FROM StExams;
go
-- View 12: Questions
CREATE OR ALTER VIEW vw_Questions With Encryption AS
SELECT * FROM Questions;
go
-- View 13: Exam Questions (relation)
CREATE OR ALTER VIEW vw_ExamQuestions With Encryption AS
SELECT * FROM ExamQuestions;
go
-- View 14: Question Choices
CREATE OR ALTER VIEW vw_QuestionChoices With Encryption AS
SELECT * FROM QuestionChoices;
go
create or alter view vw_StudentAnswers With Encryption as
select * from StudentAnswers