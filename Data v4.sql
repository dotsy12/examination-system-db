CREATE DATABASE ExamSystem;
GO
USE ExamSystem;
GO

-- جدول المستخدمين
CREATE TABLE Users (
    UserID BIGINT PRIMARY KEY IDENTITY(1,1),
    Username NVARCHAR(255) NOT NULL,
    Password NVARCHAR(255) NOT NULL,
    Role NVARCHAR(255) NOT NULL
);

-- الطلاب
CREATE TABLE Students (
    StudentID BIGINT PRIMARY KEY ,
    FullName NVARCHAR(255) NOT NULL,
    Email NVARCHAR(255),
    TrackID BIGINT NOT NULL,
    IntakeID BIGINT NOT NULL,
    BranchID BIGINT NOT NULL
);

-- المدرسين
CREATE TABLE Instructors (
    InsID BIGINT PRIMARY KEY ,
    FullName NVARCHAR(255) NOT NULL,
    Email NVARCHAR(255),
    Specialization NVARCHAR(255),
    TrackID BIGINT NOT NULL
);

-- مدير التدريب
CREATE TABLE TrainingManagers (
    ManagerID BIGINT PRIMARY KEY,
	FullName NVARCHAR(255) NOT NULL,
    Email NVARCHAR(255)
);

-- الفروع
CREATE TABLE Branches (
    BranchID BIGINT PRIMARY KEY IDENTITY(1,1),
    BranchName NVARCHAR(255) NOT NULL
);

-- الدفعات
CREATE TABLE Intakes (
    IntakeID BIGINT PRIMARY KEY IDENTITY(1,1),
    IntakeName NVARCHAR(255) NOT NULL,
    BranchID BIGINT NOT NULL
);

-- المسارات
CREATE TABLE Tracks (
    TrackID BIGINT PRIMARY KEY IDENTITY(1,1),
    ManagerID BIGINT NOT NULL,
    TrackName NVARCHAR(255) NOT NULL,
    IntakeID BIGINT NOT NULL
);

-- الكورسات
CREATE TABLE Courses (
    CourseID BIGINT PRIMARY KEY IDENTITY(1,1),
    CrsName NVARCHAR(255) NOT NULL,
    Description NVARCHAR(255),
    MaxDegree INT NOT NULL,
    MinDegree INT NOT NULL
);

-- العلاقة بين المدرس والكورس
CREATE TABLE Ins_Course (
    InsID BIGINT NOT NULL,
    CourseID BIGINT NOT NULL,
    Year DATE,
    Class NVARCHAR(255)
);

-- الامتحانات
CREATE TABLE Exams (
    ExamID BIGINT PRIMARY KEY IDENTITY(1,1),
    Type NVARCHAR(255) NOT NULL,
    AllowOptions NVARCHAR(255),
    StTime TIME NOT NULL,
    EndTime TIME NOT NULL,
    TotaleTime TIME NOT NULL,
    TotalDegree INT NOT NULL,
    InsID BIGINT NOT NULL,
    CourseID BIGINT NOT NULL
);

-- جدول امتحانات الطلبة
CREATE TABLE StExams (
    StudentID BIGINT NOT NULL,
    ExamID BIGINT NOT NULL,
);

-- الأسئلة
CREATE TABLE Questions (
    QuestionID BIGINT PRIMARY KEY IDENTITY(1,1),
    QuestionType NVARCHAR(255) NOT NULL,
    QuestionText NVARCHAR(255) NOT NULL,
    CorrectAnswer NVARCHAR(255) NOT NULL
);

-- علاقة الامتحان بالأسئلة
CREATE TABLE ExamQuestions (
    ExamID BIGINT NOT NULL,
    QuestionID BIGINT NOT NULL,
    Degree INT NOT NULL
);

-- ===================== العلاقات =====================
ALTER TABLE Students
ADD FOREIGN KEY (TrackID) REFERENCES Tracks(TrackID),
    FOREIGN KEY (IntakeID) REFERENCES Intakes(IntakeID),
    FOREIGN KEY (BranchID) REFERENCES Branches(BranchID);

ALTER TABLE Instructors
ADD FOREIGN KEY (TrackID) REFERENCES Tracks(TrackID);

ALTER TABLE Intakes
ADD FOREIGN KEY (BranchID) REFERENCES Branches(BranchID);

ALTER TABLE Tracks
ADD FOREIGN KEY (ManagerID) REFERENCES TrainingManagers(ManagerID),
    FOREIGN KEY (IntakeID) REFERENCES Intakes(IntakeID);

ALTER TABLE Ins_Course
ADD FOREIGN KEY (InsID) REFERENCES Instructors(InsID),
    FOREIGN KEY (CourseID) REFERENCES Courses(CourseID);

ALTER TABLE Exams
ADD FOREIGN KEY (InsID) REFERENCES Instructors(InsID),
    FOREIGN KEY (CourseID) REFERENCES Courses(CourseID);

ALTER TABLE StExams
ADD FOREIGN KEY (StudentID) REFERENCES Students(StudentID),
    FOREIGN KEY (ExamID) REFERENCES Exams(ExamID);

ALTER TABLE ExamQuestions
ADD FOREIGN KEY (ExamID) REFERENCES Exams(ExamID),
    FOREIGN KEY (QuestionID) REFERENCES Questions(QuestionID);


ALTER TABLE Students
ADD CONSTRAINT FK_Students_Users FOREIGN KEY (StudentID) REFERENCES Users(UserID);

ALTER TABLE Instructors
ADD CONSTRAINT FK_Instructors_Users FOREIGN KEY (InsID) REFERENCES Users(UserID);

ALTER TABLE TrainingManagers
ADD CONSTRAINT FK_Managers_Users FOREIGN KEY (ManagerID) REFERENCES Users(UserID);



 -- احنا هنا كنا تايهين ونسينا نربط  الاساله  بالكورسات
 ALTER TABLE Questions ADD CourseID BIGINT;
ALTER TABLE Questions ADD CONSTRAINT FK_Questions_Courses FOREIGN KEY (CourseID) REFERENCES Courses(CourseID);
alter table exams add ExamDate date not null



----------------------------------------دا الجديد يوم الخميس 7/24
-- كمان نضيف علاقة FOREIGN KEY
--وده مهم علشان حتى لو حد استخدم SQL مباشر، قاعدة البيانات نفسها تمنعه.
--sp_AddQuestionToExam 
--ALTER TABLE ExamQuestions
--ADD CONSTRAINT FK_ExamQuestions_Questions
--FOREIGN KEY (QuestionID) REFERENCES Questions(QuestionID);

--1️⃣ جدول الاختيارات لأسئلة MCQ
--الجدول دا هيوفر علينا في  موضوع الاختيارات علي الاساله 
CREATE TABLE QuestionChoices (
    ChoiceID BIGINT PRIMARY KEY IDENTITY(1,1),
    QuestionID BIGINT NOT NULL,
    ChoiceText NVARCHAR(255) NOT NULL,
    FOREIGN KEY (QuestionID) REFERENCES Questions(QuestionID)
);

-- جدول لتخزين اجابة الطالب لكل سؤال بكل امتحاناته

CREATE TABLE StudentAnswers (
    StudentID BIGINT NOT NULL,
    ExamID BIGINT NOT NULL,
    QuestionID BIGINT NOT NULL,
    AnswerText NVARCHAR(255) NULL,
    Degree INT NOT NULL,
    IsCorrect BIT NOT NULL,
    PRIMARY KEY (StudentID, ExamID, QuestionID),
    FOREIGN KEY (StudentID, ExamID) REFERENCES StExams(StudentID, ExamID),
    FOREIGN KEY (QuestionID) REFERENCES Questions(QuestionID)
);


-- 1. تعديل جدول StExams ليحتوي على QuestionID
--الكود الحالي في INSERT بيحاول يحط قيمة لـ QuestionID، لكن من الديزاين القديم جدول StExams ما كانش فيه العمود ده.

--ALTER TABLE StExams
--ADD QuestionID BIGINT;

--ALTER TABLE StExams
--ADD CONSTRAINT FK_StExams_Questions FOREIGN KEY (QuestionID) REFERENCES Questions(QuestionID);
