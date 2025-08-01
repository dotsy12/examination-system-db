-- Admin

-- Manager

ALTER SCHEMA TrainingManager TRANSFER Admin.sp_AddTrainingManager;
ALTER SCHEMA TrainingManager TRANSFER dbo.sp_AddBranch;
ALTER SCHEMA TrainingManager TRANSFER dbo.sp_AddIntake;
ALTER SCHEMA TrainingManager TRANSFER dbo.sp_AddCourse;
ALTER SCHEMA TrainingManager TRANSFER dbo.sp_AddTrack;
ALTER SCHEMA TrainingManager TRANSFER dbo.sp_AddInstructor;
ALTER SCHEMA TrainingManager TRANSFER dbo.sp_AssignInstructorToCourse;
ALTER SCHEMA TrainingManager TRANSFER dbo.sp_AddStudent;

-- Instructor
ALTER SCHEMA Instructor TRANSFER dbo.sp_AddQuestion;
ALTER SCHEMA Instructor TRANSFER dbo.sp_GetQuestionsByTypeOrCourse;
ALTER SCHEMA Instructor TRANSFER dbo.sp_CreateExam;
ALTER SCHEMA Instructor TRANSFER dbo.sp_AddQuestionToExam;
ALTER SCHEMA Instructor TRANSFER dbo.sp_AssignExamToStudents;
ALTER SCHEMA Instructor TRANSFER dbo.sp_GetExamDetails;
ALTER SCHEMA Instructor TRANSFER dbo.sp_GetExamQuestions;
ALTER SCHEMA Instructor TRANSFER dbo.sp_AddQuestionChoices;
-- Student
ALTER SCHEMA Student TRANSFER dbo.sp_SubmitAnswer;
ALTER SCHEMA Student TRANSFER dbo.sp_GetStudentResults;

-- Create Login for the server
CREATE LOGIN user_student WITH PASSWORD = 'P@ssw0rd1';
CREATE LOGIN user_instructor WITH PASSWORD = 'P@ssw0rd2';
CREATE LOGIN user_manager WITH PASSWORD = 'P@ssw0rd3';
CREATE LOGIN user_admin WITH PASSWORD = 'P@ssw0rd4';

-- Create database users
CREATE USER user_student FOR LOGIN user_student;
CREATE USER user_instructor FOR LOGIN user_instructor;
CREATE USER user_manager FOR LOGIN user_manager;
CREATE USER user_admin FOR LOGIN user_admin;


-- Grant EXECUTE permission on each role's own schema
GRANT EXECUTE ON SCHEMA::Student TO user_student;
GRANT EXECUTE ON SCHEMA::Instructor TO user_instructor;
GRANT EXECUTE ON SCHEMA::TrainingManager TO user_manager;
GRANT EXECUTE ON SCHEMA::Admin TO user_admin;

-- Explicitly DENY access to other schemas (optional but safer)
-- Student
DENY EXECUTE ON SCHEMA::Instructor TO user_student;
DENY EXECUTE ON SCHEMA::TrainingManager TO user_student;
DENY EXECUTE ON SCHEMA::Admin TO user_student;

-- Instructor
DENY EXECUTE ON SCHEMA::Student TO user_instructor;
DENY EXECUTE ON SCHEMA::TrainingManager TO user_instructor;
DENY EXECUTE ON SCHEMA::Admin TO user_instructor;

-- Manager
DENY EXECUTE ON SCHEMA::Student TO user_manager;
DENY EXECUTE ON SCHEMA::Instructor TO user_manager;
DENY EXECUTE ON SCHEMA::Admin TO user_manager;