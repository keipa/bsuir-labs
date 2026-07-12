# BSUIR Labs Repository

A comprehensive collection of university lab assignments for **BSUIR** (Belarusian State University of Informatics and Radioelectronics), Software Engineering program. Spans **12 semesters** (6 years) covering foundational programming through machine learning.

## Table of Contents

- [Repository Structure](#repository-structure)
- [Semester Overview](#semester-overview)
  - [Semester 01 — Algorithmization & Programming Basics](#semester-01)
  - [Semester 02 — Algorithmization & Programming / Olympiad / Python](#semester-02)
  - [Semester 03 — Mathematical Analysis / C#](#semester-03)
  - [Semester 04 — Algorithms, Architecture, OOP, Numerical Analysis](#semester-04)
  - [Semester 05 — Architecture, Databases, Software Design, System Programming](#semester-05)
  - [Semester 06 — Security, Databases, Networking, OS, Translation Methods](#semester-06)
  - [Semester 07 — Cryptography, Modeling, System Analysis, Testing](#semester-07)
  - [Semester 09 — Management, Data Processing, Networks](#semester-09)
  - [Semester 10 — Software Product Management, OOP](#semester-10)
  - [Semester 11 — Data Analysis, Machine Learning](#semester-11)
  - [Semester 12 — Bachelor Thesis, Machine Learning](#semester-12)
- [Technologies](#technologies)
- [Naming Conventions](#naming-conventions)
- [Related Documentation](#related-documentation)

---

## Repository Structure

```
bsuir-labs/
├── 01cem/          ← Semester 1
│   └── Algorithmization_and_Programming_Basics/
├── 02cem/          ← Semester 2
│   ├── Algorithmization_and_Programming_Basics/
│   ├── Olympiad_Programming/
│   └── ...
├── ...
├── 12cem/          ← Semester 12
│   ├── bt/         ← Bachelor Thesis
│   └── ml/         ← Machine Learning (part 2)
├── AGENTS.md       ← AI agent instructions
└── README.md       ← This file
```

Each `XXcem/` folder represents a semester. Inside, courses use **PascalCase with underscores** (e.g., `System_Programming`). Labs are typically numbered (`lab01/`, `lab02/`).

---

## Semester Overview

### Semester 01

**Course:** Algorithmization and Programming Basics

- Pascal / Delphi 7 introductory programming
- Console applications, basic algorithms

### Semester 02

**Courses:**
- Algorithmization & Programming Basics (continued)
- Olympiad Programming (ACM-style)
- Python
- C# (introductory)

### Semester 03

**Courses:**
- Mathematical Analysis — MATLAB/Octave numerical exercises
- Programming (C)
- Programming Software Tools (C#)

### Semester 04

**Courses:**
- Algorithms and Data Structure — C++, C#
- Architecture of Computer Systems — x86 Assembly (TASM), HTML/CSS
- Object-Oriented Programming — Java (mobile apps), Python (Pygame)
- Numerical Analysis — MATLAB (Gauss, Newton, Zeidel methods)
- Programming Software Tools — C#, Python
- Theory of Probability and Mathematical Statistics

### Semester 05

**Courses:**
- Architecture of Computer Systems — TASM assembly, MMX/SSE
- Data Models and Database Management Systems — SQL, .NET
- Numerical Analysis — MATLAB (continued)
- Software Design — Android (Gradle), WPF applications
- System Programming — Win32 C++ with Visual Studio

### Semester 06

**Courses:**
- Content Protection Methods — RC5 cipher implementation
- Data Models and Database Management Systems — SQL projects
- Internet Technology and Distributed Data Processing — TCP client/server (Python), JavaScript
- Operation Systems and Environments — Shell scripting, system security
- Optimisation and Manage Methods
- Translation Methods — Lexer/parser (Python + PLY library)

### Semester 07

**Courses:**
- Content Protection Methods — DES, WPF applications, WebAPI
- Mathematical Modeling — MATLAB (wave equations, heat transfer, Dirichlet)
- System Analysis and Operations Research — Simplex method, transport problem
- Testing and Verification of Programs — Test planning, bug reporting

### Semester 09

**Courses:**
- English
- Management and Marketing of Software Products
- Models and Methods for Processing and Analyzing Large Data
- Modern Means of Designing Information Systems
- Network Technologies of Data Processing — Python TCP/socket
- Technology Platform for Managing Large Data

### Semester 10

**Courses:**
- English
- MMPOR (Management and Marketing)
- PTOOP (Software Product Technologies) — C#/.NET

### Semester 11

**Courses:**
- IAD (Data Analysis and Processing) — Jupyter notebooks
- ML (Machine Learning, part 1) — NumPy, Pandas, Matplotlib
- SAP (Software Application Platforms) — Python + SQLite

### Semester 12

**Courses:**
- BT (Bachelor Thesis)
- ML (Machine Learning, part 2) — Jupyter notebooks, ML API (C# ASP.NET)

---

## Technologies

| Category | Languages & Tools |
|----------|-------------------|
| **Foundational** | Pascal, Delphi 7 |
| **Systems** | C, C++, x86 Assembly (TASM), Win32 API |
| **Enterprise** | C#, .NET (WPF, ASP.NET, Console), Visual Studio |
| **Android** | Java, Gradle |
| **Data Science** | Python, Jupyter, NumPy, Pandas, Matplotlib |
| **Web** | JavaScript, HTML, CSS |
| **Scripting** | Bash/Shell |
| **Math** | MATLAB/Octave |
| **Database** | SQL (SQLite, MS SQL) |
| **Build Tools** | CMake, Make, MSBuild, Gradle |

**Curriculum progression:** Pascal → C/C++ → C#/Java → Python/ML → Full-stack & Data Science

---

## Naming Conventions

| Element | Convention | Example |
|---------|-----------|---------|
| Semesters | `NNcem/` (zero-padded) | `06cem/` |
| Courses | `PascalCase_With_Underscores` | `Translation_Methods/` |
| Labs | `labNN/` (zero-padded, lowercase) | `lab01/`, `lab02/` |
| Late-semester shortcuts | lowercase abbreviations | `ml/`, `iad/`, `bt/` |

> **Note:** Early semesters (01–04) have less consistent naming. Later semesters (06+) follow cleaner conventions.

---

## Related Documentation

- [`06cem/Translation_Methods/lab02/README.md`](06cem/Translation_Methods/lab02/README.md) — MT labs
- [`06cem/Content_Protection_Methods/lab01-03/docs/README.md`](06cem/Content_Protection_Methods/lab01-03/docs/README.md) — RC5 cipher details
- [`07cem/System_Analysis_And_Operations_Research/lab05/readme.md`](07cem/System_Analysis_And_Operations_Research/lab05/readme.md) — Transport problem algorithm notes