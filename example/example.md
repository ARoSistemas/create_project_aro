

# 🚀 Example: How to use create_project_aro


## 🧑‍💻 Interactive Mode

You can use the interactive mode simply by running:

```sh
dart run create_project_aro:create
```

If you don't provide any flags, you will be prompted in the terminal to select:
- The state manager (BLoC, Provider, Riverpod)
- The type of generation (Functional demo or Empty folders)

---

This example demonstrates how to use the `create_project_aro` package to generate a professional Flutter project structure with clean architecture and optional login demo.

## ⚙️ Prerequisites

- ♣️ Dart SDK >= 3.0.0
- 💙 Flutter >= 3.10.0

## 🛠️ Basic Usage (Flags Mode)
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

Generate the default folder structure using **BLoC**:

```sh
dart run create_project_aro:create --b
```

Generate the structure for **Provider**:

```sh
dart run create_project_aro:create --p
```

Generate the structure for **Riverpod**:

```sh
dart run create_project_aro:create --r
```

## 🔐 Generate Structure with Login Demo

Add a functional login demo using your preferred state manager:

**🟦 BLoC:**
```sh
dart run create_project_aro:create --b --d
```

**🟩 Provider:**
```sh
dart run create_project_aro:create --p --d
```

**🟪 Riverpod:**
```sh
dart run create_project_aro:create --r --d
```

## 📄 Generate Structure with Empty Base Files

Create the structure with empty base files for each state manager:

**🟦 BLoC:**
```sh
dart run create_project_aro:create --b --e
```

**🟩 Provider:**
```sh
dart run create_project_aro:create --p --e
```

**🟪 Riverpod:**
```sh
dart run create_project_aro:create --r --e
```

## 📦 Recommended Dependencies

Depending on the state manager you choose, add the following dependencies to your `pubspec.yaml`:

### 🟦 For BLoC
- 📦 flutter_bloc: ^9.0.0
- 📦 equatable: ^2.0.5
- 📦 meta: ^1.15.0

### 🟩 For Provider
- 📦 provider: ^6.1.1

### 🟪 For Riverpod
- 📦 flutter_riverpod: ^2.4.5
- 📦 riverpod_annotation: ^2.3.0

**Dev dependencies:**
- 🛠️ riverpod_generator: ^2.3.5
- 🛠️ build_runner: ^2.4.6

To generate files for Riverpod:
```sh
flutter pub run build_runner build
```

## 🔑 Login Demo Details

- 📝 Basic field validation (email and password)
- 📧 Correct email: `demo@arosistemas.com`
- 🔒 Correct password: `123456`
- ✅ On successful login, redirects to a `HomePage` screen
- 🏠 Home screen displays centered text: `HomePage`

---
ℹ️ For more information, see the [README.md](../README.md).


Visit my website [https://www.arosistemas.com](https://www.arosistemas.com).