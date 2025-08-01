<h1 align="center">🎓 Examination System Database Project</h1>

<p align="center">
  <img src="https://readme-typing-svg.demolab.com?font=Fira+Code&pause=1000&color=F7768E&width=435&lines=SQL+Server+Database+Design+%26+Development;Role-based+Access+with+Stored+Procedures;Secure+Exam+System+for+Institutions" alt="Typing SVG" />
</p>

<p align="center">
  <img src="https://capsule-render.vercel.app/api?type=waving&color=gradient&height=120&section=header"/>
</p>

---

## 🔍 Overview

> **Alhamdulillah**, we proudly completed this project as part of our .NET Fullstack training.  
> It's a well-structured SQL Server project for managing exams, instructors, students, and training operations in an educational environment.

The system provides role-based access, secure schema management, random/manual exam generation, answer validation (including regex for text), and stores final results.

---

## 🧩 System Requirements

- Instructor can generate exams from a question pool.
- Multiple question types:
  - ✅ Multiple Choice
  - 🚫 True/False
  - ✍️ Text (with Regex-based checking)
- Exam auto-evaluation (or manual grading for text).
- Course data (name, description, max/min degree).
- Each instructor teaches 1+ courses.
- Students assigned to branches, tracks, intakes.
- Login system for: Admin, Manager, Instructor, Student.
- Exam metadata (type, time, course, instructor).
- Assign students to exams & enforce time windows.
- Save answers & compute results.
- Inserted test data to verify full workflow.

---

## 💾 Tech Stack

- Microsoft SQL Server 2022
- T-SQL: Views, Stored Procedures, Triggers
- Role-Based Schemas (Admin, Instructor, Student, TrainingManager)
- SQL Logins & Permission Management

---

## 🧠 Team Members & Roles

| Name | Role | Contributions |
|------|------|----------------|
| **Ahmed Hany Ramadan** | DB Mapping & Logic | Mapped all tables, created views, wrote instructor-related stored procedures, and linked procedures to their respective schemas. |
| **Abdelsalam Mahdy** | Schema & Student Logic | Designed the ERD, created student & manager stored procedures, built database structure & schemas, and tested all data. |
| **Diaa Elsadeq** | Auth & Permissions | Developed login/auth system, managed permissions by role, and enforced schema-based access. |

---

## 📁 Project Structure

## 🚀 How to Run

1. Open `SQL Server Management Studio`.
2. Execute the scripts in the following order:
   - `create_schemas.sql`
   - `tables.sql`
   - `views.sql`
   - All stored procedures (organized by role).
   - `insert_test_data.sql`
3. Log in with different user roles to simulate real-life usage.
4. Enjoy a fully functional exam management system! 🧪

---

## 📸 Preview

> *(Add ERD or exam screenshots here if available)*  
> Example:
> ![ERD]([https://your-link-to-image.com](https://github.com/dotsy12/examination-system-db/blob/main/ERD.jpeg))

---

## 🙏 Special Thanks

> We'd like to express our deep gratitude to **Eng. Abdelrahman Shaaban Elwakil**  
> for his valuable supervision and guidance throughout the project journey.  
> His insights helped shape this system into a complete academic database solution. 🎓

---

## 📬 Let's Connect

<p align="center">
  <a href="mailto:ahmedhanyramadan01@gmail.com"><img src="https://img.shields.io/badge/Gmail-D14836?style=for-the-badge&logo=gmail&logoColor=white" /></a>
  <a href="https://linkedin.com/in/ahmed1hany"><img src="https://img.shields.io/badge/LinkedIn-blue?style=for-the-badge&logo=linkedin&logoColor=white" /></a>
  <a href="https://github.com/dotsy12"><img src="https://img.shields.io/badge/GitHub-100000?style=for-the-badge&logo=github&logoColor=white" /></a>
</p>

---

<p align="center">
  <img src="https://capsule-render.vercel.app/api?type=waving&color=gradient&height=120&section=footer"/>
</p>
