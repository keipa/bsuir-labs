# BSUIR Labs — AI Agent Instructions

> This file helps AI coding agents understand the repository and be immediately productive.

## What is this repo?

University lab assignments for **BSUIR** (Software Engineering program), spanning **12 semesters**.  
Structure: `NNcem/Subject_Name/labNN/` — see [README.md](README.md) for full table of contents.

## Key conventions

- **Semesters** are `NNcem/` folders (01–12)
- **Courses** use `PascalCase_With_Underscores` (e.g., `System_Programming`)
- **Labs** are `labNN/` (lowercase, zero-padded from 06cem onward)
- Early semesters (01–04) have inconsistent naming — don't assume a pattern
- Late semesters (11–12) use short abbreviations: `ml/`, `iad/`, `sap/`, `bt/`

## Languages by semester

| Semesters | Primary Languages |
|-----------|-------------------|
| 01–02 | Pascal / Delphi |
| 03 | MATLAB, C# |
| 04 | C++, C#, Java, MATLAB, Assembly (TASM) |
| 05 | C++, C#, SQL, MATLAB, Assembly |
| 06 | Python, C++, JavaScript, Bash, SQL |
| 07 | MATLAB, Python, C#/WPF |
| 09–10 | C#/.NET, Python |
| 11–12 | Python, Jupyter Notebooks, C#/.NET |

## Build & run quick-reference

| Context | Command / Tool |
|---------|---------------|
| C#/WPF / ASP.NET | `dotnet build` / `dotnet run` in folder with `.csproj` or `.sln` |
| C++ (MSVC) | Open `.sln` in Visual Studio, or `msbuild Labs.sln` |
| C++ (CMake) | `cmake -B build && cmake --build build` where `CMakeLists.txt` exists |
| Python | `python script.py` — check `requirements*.txt` if present |
| Jupyter | Open `.ipynb` files in VS Code or JupyterLab |
| MATLAB/Octave | Run `.m` files in MATLAB or `octave script.m` |
| Gradle / Android | `./gradlew build` where `gradlew` exists |

## Important notes

- **Reports** (`.docx`, `.pdf`) co-located with source code — these are lab report submissions, not part of the build
- **Group numbers** `453504` / `858641` appear in report filenames — this is student identification
- **No centralized build system** — each lab is independent; build/run per folder
- **No tests directory** — testing labs exist in `07cem/Testing_And_Verification_Of_Programs` (manual test plans)
- **Russian-language** documentation is common alongside English code/folder names