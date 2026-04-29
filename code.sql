-- Специализации
CREATE TABLE Specialization (
    specialization_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE
);

-- Производители
CREATE TABLE Proizvoditel (
    proizvoditel_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE,
    country VARCHAR(100)
);

-- Пациенты
CREATE TABLE Patient (
    patient_id SERIAL PRIMARY KEY,
    full_name VARCHAR(150) NOT NULL,
    date_of_birth DATE,
    gender CHAR(1),
    phone VARCHAR(20),
    email VARCHAR(100),
    address TEXT
);

-- Врачи
CREATE TABLE Doctor (
    doctor_id SERIAL PRIMARY KEY,
    full_name VARCHAR(150) NOT NULL,
    specialization_id INT NOT NULL,
    phone VARCHAR(20),
    email VARCHAR(100),
    cabinet_number VARCHAR(10),
    FOREIGN KEY (specialization_id) REFERENCES Specialization(specialization_id)
);

-- Приёмы
CREATE TABLE Visit (
    visit_id SERIAL PRIMARY KEY,
    patient_id INT NOT NULL,
    doctor_id INT NOT NULL,
    visit_datetime TIMESTAMP NOT NULL,
    status VARCHAR(20) NOT NULL DEFAULT 'запланирован',
    FOREIGN KEY (patient_id) REFERENCES Patient(patient_id),
    FOREIGN KEY (doctor_id) REFERENCES Doctor(doctor_id)
);

-- Диагнозы
CREATE TABLE Diagnosis (
    diagnosis_id SERIAL PRIMARY KEY,
    visit_id INT NOT NULL UNIQUE,
    description TEXT NOT NULL,
    diagnosis_date DATE NOT NULL,
    FOREIGN KEY (visit_id) REFERENCES Visit(visit_id)
);

-- Лекарства
CREATE TABLE Medication (
    medication_id SERIAL PRIMARY KEY,
    name VARCHAR(150) NOT NULL,
    proizvoditel_id INT NOT NULL,
    price DECIMAL(10, 2),
    instructions TEXT,
    FOREIGN KEY (proizvoditel_id) REFERENCES Proizvoditel(proizvoditel_id)
);
вот весь мой проект сделай под него и чтобы я просто скопировал и вставил в реадми
-- Назначения
CREATE TABLE Prescription (
    prescription_id SERIAL PRIMARY KEY,
    visit_id INT NOT NULL,
    medication_id INT NOT NULL,
    dosage VARCHAR(100),
    FOREIGN KEY (visit_id) REFERENCES Visit(visit_id),
    FOREIGN KEY (medication_id) REFERENCES Medication(medication_id)
);
INSERT INTO Specialization (name) VALUES
('Терапевт'),
('Кардиолог'),
('Окулист'),
('Невролог'),
('Хирург');

INSERT INTO Proizvoditel (name, country) VALUES
('Pfizer', 'США'),
('Bayer', 'Германия'),
('Novartis', 'Швейцария'),
('Sanofi', 'Франция'),
('Фармстандарт', 'Россия'),
('KRKA', 'Словения'),
('Teva', 'Израиль');

INSERT INTO Patient (full_name, date_of_birth, gender, phone, email, address) VALUES
('Иванов Иван Иванович', '1985-03-12', 'M', '+79001234561', 'ivanov@example.com', 'г. Москва, ул. Ленина, д. 10, кв. 5'),
('Петрова Анна Сергеевна', '1992-07-25', 'F', '+79001234562', 'petrova_a@example.com', 'г. Санкт-Петербург, Невский пр., д. 45'),
('Сидоров Дмитрий Викторович', '1978-11-30', 'M', '+79001234563', 'sidorov.d@example.com', 'г. Новосибирск, ул. Гоголя, д. 22'),
('Козлова Елена Павловна', '2000-01-15', 'F', '+79001234564', 'kozlova.e@example.com', 'г. Екатеринбург, пр. Космонавтов, д. 88'),
('Смирнов Алексей Юрьевич', '1989-09-08', 'M', '+79001234565', 'smirnov_a@example.com', 'г. Казань, ул. Баумана, д. 12');

INSERT INTO Doctor (full_name, specialization_id, phone, email, cabinet_number) VALUES
('Морозова Ольга Николаевна', 1, '+79009876541', 'morozova@clinic.ru', '101'),
('Волков Сергей Петрович', 2, '+79009876542', 'volkov@clinic.ru', '205'),
('Лебедева Мария Андреевна', 3, '+79009876543', 'lebedeva@clinic.ru', '112'),
('Громов Игорь Валерьевич', 4, '+79009876544', 'gromov@clinic.ru', '304'),
('Федоров Артём Дмитриевич', 5, '+79009876545', 'fedorov@clinic.ru', '401');

INSERT INTO Visit (patient_id, doctor_id, visit_datetime, status) VALUES
(1, 1, '2025-12-15 10:00:00', 'завершён'),
(2, 3, '2025-12-16 14:30:00', 'завершён'),
(3, 2, '2025-12-17 09:15:00', 'запланирован'),
(4, 1, '2025-12-18 16:00:00', 'запланирован'),
(5, 4, '2025-12-14 11:45:00', 'завершён'),
(1, 2, '2025-12-20 13:00:00', 'запланирован'),
(2, 5, '2025-12-19 15:20:00', 'отменён');
INSERT INTO Diagnosis (visit_id, description, diagnosis_date) VALUES
(1, 'Острый бронхит', '2025-12-15'),
(2, 'Миопия средней степени', '2025-12-16'),
(5, 'Мигрень', '2025-12-14'),
(4, 'Артериальная гипертензия 1 ст.', '2025-12-18');  --  если статус "запланирован", обычно диагноза ещё нет, но допустимо для примера

INSERT INTO Medication (name, proizvoditel_id, price, instructions) VALUES
('Амоксициллин', 1, 120.50, 'Принимать по 1 таблетке 3 раза в день после еды в течение 7 дней.'),
('Аспирин Кардио', 2, 85.00, 'Принимать по 1 таблетке в день утром натощак.'),
('Визин', 3, 210.75, 'Закапывать по 1–2 капли в каждый глаз при покраснении.'),
('Нурофен', 4, 95.30, 'Принимать по 1 таблетке до еды при боли или температуре.'),
('Амлодипин', 5, 65.90, 'Принимать по 1 таблетке утром для контроля давления.'),
('Парацетамол', 6, 40.00, 'Принимать по 1–2 таблетки при температуре выше 38.5°C.'),
('Цитрамон', 7, 35.20, 'Принимать по 1 таблетке при головной боли.');
-- Назначения (рецепты)
INSERT INTO Prescription (visit_id, medication_id, dosage) VALUES
-- Визит 1: Иванов И.И. → бронхит
(1, 1, 'По 1 таблетке 3 раза в день в течение 7 дней'),  -- Амоксициллин (ID=1)
(1, 4, 'По 1 таблетке при температуре выше 38°C'),      -- Нурофен (ID=4)


(2, 3, 'По 1–2 капли в каждый глаз 2 раза в день'),     -- Визин (ID=3)


(4, 5, 'По 1 таблетке утром ежедневно'),                -- Амлодипин (ID=5)
(4, 2, 'По 1 таблетке на ночь'),                        -- Аспирин Кардио (ID=2)


(5, 7, 'По 1 таблетке при приступе головной боли'),     -- Цитрамон (ID=7)
(5, 6, 'По 2 таблетки при сильной боли, не чаще 3 раз в день'), -- Парацетамол (ID=6)


(1, 6, 'По 1 таблетке 4 раза в день при лихорадке'),    -- Парацетамол (ещё раз)
(4, 6, 'По 1–2 таблетки при температуре'),              -- Парацетамол (ещё раз)
(5, 4, 'По 1 таблетке до еды при боли'),                -- Нурофен (ещё раз)
(2, 6, 'По 1 таблетке при головной боли'),              -- Парацетамол (ещё раз)
(1, 2, 'По 1 таблетке утром натощак'),                  -- Аспирин Кардио (ещё раз)
(5, 1, 'По 1 капсуле 2 раза в день в течение 5 дней');  -- Амоксициллин (ещё раз)

SELECT 
    d.full_name AS doctor_name,
    COUNT(v.visit_id) AS visit_count
FROM Doctor d
JOIN Visit v ON d.doctor_id = v.doctor_id
WHERE v.visit_datetime >= NOW() - INTERVAL '1 month'
GROUP BY d.doctor_id, d.full_name
ORDER BY visit_count DESC
LIMIT 1;

SELECT 
    m.name AS medication_name,
    COUNT(p.prescription_id) AS prescription_count
FROM Medication m
JOIN Prescription p ON m.medication_id = p.medication_id
GROUP BY m.medication_id, m.name
ORDER BY prescription_count DESC
LIMIT 5;


SELECT
p.full_name AS patient_name,
json_agg(
    jsonb_build_object(
        'diagnose',diag.description,
        'doctor',d.full_name
    )
) AS diagnoses
FROM Patient p 
JOIN Visit v ON p.patient_id=v.patient_id
JOIN Diagnosis diag ON v.visit_id=diag.visit_id
JOIN Doctor d ON v.doctor_id=d.doctor_id
GROUP BY p.patient_id,p.full_name
ORDER BY p.full_name;
-- build это джейсон объект который собираект объект из стрчоек типа
-- а agg создает типо массив
