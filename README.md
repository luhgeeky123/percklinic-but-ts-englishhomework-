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
