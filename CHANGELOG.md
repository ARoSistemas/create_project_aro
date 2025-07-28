# Changelog

#### [0.0.9] - 2025-07-27
- Fix: Spelling corrections in MDs 

#### [0.0.8] - 2025-07-27
- Fix: Fixed example.md for interactive mode

#### [0.0.7] - 2025-07-27
- Fix: Interactive Mode. Now with DART only

#### [0.0.6] - 2025-07-27
- update: Update Flutter 3.32.6 Dart 3.8.0
- update: Update Dart 3.8.0
- Add: Interactive Mode

#### [0.0.5] - 2025-04-11
- add: Repository github.

#### [0.0.4] - 2025-04-11
- Fix: Se reorganizan los archivos del package.
- Fix: WASM compatibility
- Fix: Angle brackets will be interpreted as HTML.

#### [0.0.3] - 2025-04-10
- Fix: The correct command ends with :create (create_project_aro:create)
- Fix: static analysis

#### [0.0.2] - 2025-04-10
- Fix: Dart file conventions
- Fix: Short description 
- add: An example

#### [0.0.1] - 2025-04-10

### Added ✨

- Flutter project structure generator with different state managers
- Support for the following state managers:
  - BLoC (--b)
  - Provider (--p)
  - Riverpod (--r)
- File generation options:
  - Empty (--e): Generates empty files
  - Demo (--d): Generates example code files
- Automatic base folder structure creation
- Flag validation system
- Specific structure creation for each state manager
- Confirmation messages with ASCII art
- Directory and project path handling


<details><summary>Features 🚀</summary>

- Automatic folder structure for presentation layer
- Integration with multiple state managers
- Flexible flag system for customized generation
- Support for demo and empty files

</details>

<details>
<summary>Technical ⚙️</summary>

- Asynchronous implementation for file handling
- Modular system for different state managers
- Flag validation using set intersection
- Directory handling using dart:io

</details>