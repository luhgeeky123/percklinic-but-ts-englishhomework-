# percklinic
[License: MIT]

[PostgreSQL]

Educational relational database for modeling a medical clinic operations. Normalized 3NF schema with 8 tables, real data samples, and analytical queries.

##📑Table of Contents

- [About](#about)
- [Installation](#installation)
- [Usage](#usage)
- [Database Structure](#database-structure)
- [Analytical Queries](#analytical-queries)
- [Data Samples](#data-samples)
- [ER Diagram](#er-diagram)
- [Contributing](#contributing)
- [License](#license)

## 📋 About

This project is a fully functional clinic database featuring:
- ✅ Normalized schema in Third Normal Form (3NF)
- ✅ 8 related tables with foreign keys
- ✅ Realistic test data (patients, doctors, medications, visits)
- ✅ Three analytical queries for clinic management
- ✅ ER diagram of the database structure

## 🔧 Installation

### Requirements
- PostgreSQL 12+ (or compatible DBMS)
- pgAdmin, DBeaver, or psql for database management

### Quick Start

```bash
# 1. Clone the repository
git clone <your-repository>
cd clinic-database

# 2. Create database
psql -U postgres -c "CREATE DATABASE clinic_db;"

# 3. Execute SQL scripts
psql -U postgres -d clinic_db -f create_tables.sql
psql -U postgres -d clinic_db -f insert_data.sql

# Or via pgAdmin/DBeaver:
# - Open SQL Editor
# - Copy contents of create_tables.sql and execute
# - Then execute insert_data.sql
```
### 📖 Usage
Connect to Database

-- Connect to database
\c clinic_db;

-- List all tables
\dt

-- Describe table structure
\d Patient
### Basic Queries
```sql
-- All patients
SELECT * FROM Patient;

-- Doctors with their specializations
SELECT d.full_name, s.name as specialization
FROM Doctor d
JOIN Specialization s ON d.specialization_id = s.specialization_id;

-- Completed visits
SELECT * FROM Visit WHERE status = 'completed';

-- Medications by specific manufacturer
SELECT m.name, m.price, p.name as manufacturer
FROM Medication m
JOIN Proizvoditel p ON m.proizvoditel_id = p.proizvoditel_id
WHERE p.name = 'Pfizer';
```
### 🏗️ Database Structure
#### Tables
Specialization — medical specializations reference

specialization_id (PK)

name — specialization name

Proizvoditel — medication manufacturers

proizvoditel_id (PK)

name — company name

country — country of origin

Patient — patients

patient_id (PK)

full_name, date_of_birth, gender

phone, email, address

Doctor — doctors

doctor_id (PK)

full_name, specialization_id (FK)

phone, email, cabinet_number

Visit — patient visits

visit_id (PK)

patient_id (FK), doctor_id (FK)

visit_datetime, status

Diagnosis — medical diagnoses

diagnosis_id (PK)

visit_id (FK, UNIQUE)

description, diagnosis_date

Medication — medications

medication_id (PK)

name, proizvoditel_id (FK)

price, instructions

Prescription — prescriptions


prescription_id (PK)
visit_id (FK), medication_id (FK)

dosage

### 📊 Analytical Queries
1. Doctor with Most Visits Last Month
```sql
SELECT 
    d.full_name AS doctor_name,
    COUNT(v.visit_id) AS visit_count
FROM Doctor d
JOIN Visit v ON d.doctor_id = v.doctor_id
WHERE v.visit_datetime >= NOW() - INTERVAL '1 month'
GROUP BY d.doctor_id, d.full_name
ORDER BY visit_count DESC
LIMIT 1;
```
Result(sql):

 doctor_name          | visit_count
 
----------------------+-------------

 Morozova O.N.        |     2
 
2. Top 5 Most Prescribed Medications
   
```sql
SELECT 
    m.name AS medication_name,
    COUNT(p.prescription_id) AS prescription_count
FROM Medication m
JOIN Prescription p ON m.medication_id = p.medication_id
GROUP BY m.medication_id, m.name
ORDER BY prescription_count DESC
LIMIT 5;
```
Result(sql):

 medication_name  | prescription_count
 
------------------+--------------------

 Paracetamol      |         4
 
 
 Amoxicillin      |         2
 
 Nurofen          |         2
 
 Aspirin Cardio   |         2
 
 Visine           |         1

3. Patients with Diagnoses and Doctors (JSON)
```json
SELECT
    p.full_name AS patient_name,
    json_agg(
        jsonb_build_object(
            'diagnose', diag.description,
            'doctor', d.full_name
        )
    ) AS diagnoses
FROM Patient p 
JOIN Visit v ON p.patient_id = v.patient_id
JOIN Diagnosis diag ON v.visit_id = diag.visit_id
JOIN Doctor d ON v.doctor_id = d.doctor_id
GROUP BY p.patient_id, p.full_name
ORDER BY p.full_name;
```
 Result(json):
 
[

  {
  
    "patient_name": "Ivanov Ivan Ivanovich",
    "diagnoses": [
      {"diagnose": "Acute bronchitis", "doctor": "Morozova Olga Nikolaevna"}
    ]
  },
  
  {
  
    "patient_name": "Petrova Anna Sergeevna",
    "diagnoses": [
      {"diagnose": "Moderate myopia", "doctor": "Lebedeva Maria Andreevna"}
    ]
    
  }
  
]
### 💡 Data Samples

#### Patients (5 records)

Ivanov Ivan Ivanovich (born 1985)

Petrova Anna Sergeevna (born 1992)

Sidorov Dmitry Viktorovich (born 1978)

Kozlova Elena Pavlovna (born 2000)

Smirnov Alexey Yurievich (born 1989)

#### Doctors (5 specialists)

Morozova Olga Nikolaevna — Therapist (Room 101)

Volkov Sergey Petrovich — Cardiologist (Room 205)

Lebedeva Maria Andreevna — Ophthalmologist (Room 112)

Gromov Igor Valerievich — Neurologist (Room 304)

Fedorov Artem Dmitrievich — Surgeon (Room 401)
#### Medications (7 drugs)

Amoxicillin (Pfizer) — 120.50 ₽

Aspirin Cardio (Bayer) — 85.00 ₽

Visine (Novartis) — 210.75 ₽

Nurofen (Sanofi) — 95.30 ₽

Amlodipine (Farmstandart) — 65.90 ₽

Paracetamol (KRKA) — 40.00 ₽

Citramon (Teva) — 35.20 ₽

### 🗂️ER Diagram
<img width="1171" height="793" alt="image" src="https://github.com/user-attachments/assets/dd2db19c-e815-4ecf-9e69-53eaab87c0c4" />
ER diagram shows all tables, primary and foreign keys, and relationships between entities.

#### Table Relationships:

Doctor → Specialization: Many-to-One (N:1)

Visit → Patient: Many-to-One (N:1)

Visit → Doctor: Many-to-One (N:1)

Diagnosis → Visit: One-to-One (1:1)

Medication → Proizvoditel: Many-to-One (N:1)

Prescription → Visit: Many-to-One (N:1)

Prescription → Medication: Many-to-One (N:1)

### 🤝 Contributing
Contributions are welcome!

#### How to Contribute:

Fork the repository

Create your feature branch (git checkout -b feature/AmazingFeature)

Commit your changes (git commit -m 'Add some AmazingFeature')

Push to the branch (git push origin feature/AmazingFeature)

Open a Pull Request

#### Possible Improvements:

Add stored procedures for frequently used queries

Create indexes for performance optimization

Add triggers for automatic data updates

Expand test data (100+ patients)

Add views (VIEW) for reporting

Implement change audit system

#### 📄 License
This project is distributed under the MIT License

### 📁 Project Structure
clinic-database/

├── README.md

├── LICENSE

├── create_tables.sql      # SQL script for table creation

├── insert_data.sql        # SQL script for data insertion

├── analytical_queries.sql # Analytical queries

├── images/

│   └── clinic_er_diagram.png  # ER diagram

└── clinic_er_diagram.drawio   # Diagram source (draw.io)

### 📞 Contact

For questions and suggestions: [ndonttextme@noanswer.ru]

Project Status: ✅ Completed

Version: 1.0.0

Last Updated: December 2026

DBMS: PostgreSQL 12+

Normalization: 3NF


