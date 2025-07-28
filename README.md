# 🛠️ Create Project ARo

This package generates a professional directory structure for Flutter projects with a focus on **clean architecture** and allows you to include a basic login example using the state manager of your choice (**BLoC**, **Provider**, or **Riverpod**).

## ✨ Features

- 📁 Generates folder structure following clean architecture.
- 🧱 Allows including empty base files.
- 🔐 Includes login example with simple validation and navigation to Home.

## 🧩 Generated Structure by default BLoC

```dart
  📁lib
   │
   ├────📁app
   │     │
   │     ├───📁config
   │     │    ├──📁constans
   │     │    ├──📁router
   │     │    ├──📁styles
   │     │    └──📁themes
   │     │
   │     ├───📁data
   │     │    ├──📁datasources
   │     │    │   ├──📁local
   │     │    │   ├──📁remote
   │     │    └──📁repositories
   │     │
   │     ├───📁domain
   │     │    ├──📁entities
   │     │    │   ├──📁dtos
   │     │    │   └──📁models
   │     │    ├──📁repositories
   │     │    └──📁usecases
   │     │
   │     ├───📁injection
   │     │
   │     ├───📁presentation
   │     │    ├──📁blocs
   │     │    │   ├──📁login
   │     │    │   └──📁signup
   │     │    ├──📁pages
   │     │    │   ├──📁login
   │     │    │   └──📁signup
   │     │    └──📁widgets
   │     │        ├──📁login
   │     │        └──📁signup
   │     │
   │     └───📁utils
   │          ├──📁helpers
   │          └──📁widgets
   │  
   └────📁core
         ├───📁errors
         ├───📁network
         ├───📁utils
         └───📁widgets
```
for Provider
```dart
   ...
   │     ├───📁presentation
   │     │    ├──📁providers
   │     │    │   ├──📁login
   │     │    │   └──📁signup
   ...
```

for Riverpod
```dart
   ...
   │     ├───📁presentation
   │     │    ├──📁controllers
   │     │    │   ├──📁login
   │     │    │   └──📁signup
   ...
```


## 🧑‍💻 Interactive Mode

You can use the interactive mode simply by running:

```sh
dart run create_project_aro:create
```

If you don't provide any flags, you will be prompted to select:
- The state manager (BLoC, Provider, Riverpod)
- The type of generation (Functional demo or Empty folders)

---

## 🧩 AVAILABLE COMMANDS


| Command                             | Description                                                  |
| ---------------------------------   | ------------------------------------------------------------ |
| `dart run create_project_aro:create`           | Start interactive mode         |
| `dart run create_project_aro:create --p`       | Creates empty folder structure for **Provider**.              |
| `dart run create_project_aro:create --r`       | Creates empty folder structure for **Riverpod**.              |
| `dart run create_project_aro:create --b --d`   | Creates Structure + functional login demo using **BLoC**.     |
| `dart run create_project_aro:create --p --d`   | Creates Structure + functional login demo using **Provider**. |
| `dart run create_project_aro:create --r --d`   | Creates Structure + functional login demo using **Riverpod**. |
| `dart run create_project_aro:create --b --e`   | Creates Structure + empty files using **BLoC**.               |
| `dart run create_project_aro:create --p --e`   | Creates Structure + empty files using **Provider**.           |
| `dart run create_project_aro:create --r --e`   | Creates Structure + empty files using **Riverpod**.           |


## 📦 Install as a dev dependency

It is recommended to add `create_project_aro` as a dev dependency:

```sh
dart pub add --dev create_project_aro
```

And in your `pubspec.yaml`:

```yaml
dev_dependencies:
  create_project_aro: ^0.0.5
```

---

## 🧩About dependencies

Dependencies for demos are at your discretion. The following are recommended according to the chosen state manager.

For BLoC it's recommended to install:

- **flutter_bloc: ^9.0.0**
- **equatable: ^2.0.5**
- **meta: ^1.15.0**
--------------------------
For Provider it's recommended to install:
- **provider: ^6.1.1** 
--------------------------
For Riverpod it's recommended to install:
- **flutter_riverpod: ^2.4.5**
- **riverpod_annotation: ^2.3.0**

  Development dependencies:
  - **riverpod_generator: ^2.3.5**
  - **build_runner: ^2.4.6**

    To create files:
    ```dart
    flutter pub run build_runner build
    ```
--------------------------

## ✅ LOGIN EXAMPLE DETAILS

- Basic field validation (email and password)
- Correct email: "demo@arosistemas.com"
- Correct Password: "123456"
- If login is successful, redirects to a screen called HomePage
- Home screen only shows centered text: "HomePage"

## 🔧 Requirements

- Dart SDK >= 3.0.0
- Flutter >= 3.10.0

## 🧙 AUTHOR

Andres Rodriguez.
Passionate about professional, scalable, and maintainable development.

This package aims to be a solid foundation for any type of Flutter project, allowing you to freely choose the most convenient state manager.

## 📄 LICENSE

MIT License
