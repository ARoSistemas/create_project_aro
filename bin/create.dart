import 'src/commons/bloc.dart';
import 'src/commons/provider.dart';
import 'src/commons/riverpod.dart';
import 'src/commons/creations.dart';
import 'src/commons/file_structure.dart';

import 'src/platform/io_commands.dart';

/// The main entry point of the application.
///
/// This function handles command-line flags, determines the state manager and file type to use,
/// creates the project structure, and applies the necessary configurations.
Future<void> main(List<String> flags) async {
  /// CommandsIO instance
  final CommandsIO ioCommands = CommandsIO();

  /// Flag cleaning and validation
  Set<String> flagsOk = validateFlags(flags);

  /// Get the current path
  final String rootDir = ioCommands.getCurrentPath();

  /// Determine the state manager to create
  final String stateManager = getStateManager(flagsOk);

  /// Determine the type of file to create: Demo or Empty
  final String fileType = getFileType(flagsOk);

  /// Create structure by default BLoC
  createStructureEmpty(rootDir: rootDir, ioCommands: ioCommands);

  /// apply configuration
  await createProject(
    ioCommands: ioCommands,
    rootDir: rootDir,
    stateManager: stateManager,
    fileType: fileType,
  );

  /// Message finish
  ioCommands.logARo('''

    ___    ____           _____ _      __
   /   |  / __ \\____     / ___/(_)____/ /____  ____ ___  ____ ______        _________  ____ ___
  / /| | / /_/ / __ \\    \\__ \\/ / ___/ __/ _ \\/ __ `__ \\/ __ `/ ___/       / ___/ __ \\/ __ `__ \\
 / ___ |/ _, _/ /_/ /   ___/ / (__  ) /_/  __/ / / / / / /_/ (__  )  _    / /__/ /_/ / / / / / /
/_/  |_/_/ |_|\\____/   /____/_/____/\\__/\\___/_/ /_/ /_/\\__,_/____/  (_)   \\___/\\____/_/ /_/ /_/

      The folder structure was created successfully.

      📂 Project path: $rootDir
      ⚙️  State manager: ${stateManager.toUpperCase()}
      📄 File type: ${fileType.toUpperCase()}

      The necessary files for the selected state manager have been created.

    ''');

  if (fileType == 'demo') {
    switch (stateManager) {
      case 'bloc':
        ioCommands.logARo('''
      ⚙️  Remember to install the necessary dependencies for BLoC state manager:
              
          It is recommended to execute the following commands:
          
          flutter pub add flutter_bloc
          flutter pub add equatable
          flutter pub add meta

        ''');
        break;
      case 'provider':
        ioCommands.logARo('''
     ⚙️  Remember to install the necessary dependencies for PROVIDER state manager:
              
         It is recommended to execute the following commands:
          
          flutter pub add provider
          
        ''');
        break;
      case 'riverpod':
        ioCommands.logARo('''
     ⚙️  Remember to install the necessary dependencies for RIVERPOD state manager:
            
        It is recommended to execute the following commands:
          
          flurtter pub add flutter_riverpod
          flutter pub add riverpod_annotation
          flutter pub add riverpod_generator

          flutter pub add build_runner --dev
          flutter pub add riverpod_generator --dev
          

        And to generate the providers code, run the following command:
        
          flutter pub run build_runner build 

        ''');
        break;

      default:
    }
  }

  ioCommands.exitProgram();
}

/// Validates and filters a list of command-line flags.
///
/// This function takes a list of flags, removes duplicates, and returns a set
/// containing only the valid flags.
Set<String> validateFlags(List<String> flags) {
  final uniqueFlags = flags.toSet();
  const validFlags = {'--b', '--p', '--r', '--e', '--d'};
  return uniqueFlags.intersection(validFlags);
}

/// Determines the state manager based on the provided flags.
///
/// This function checks a set of flags for state management options and returns
/// the corresponding state manager name. If no valid flag is found, it defaults to 'bloc'.
///
/// **Parameters**:
/// - `flags` (Set`<String>`): A set of command-line flags.
///
/// **Flags and State Managers**:
/// - '--b': Returns 'bloc' for Bloc state management.
/// - '--p': Returns 'provider' for Provider state management.
/// - '--r': Returns 'riverpod' for Riverpod state management.
///
/// **Returns**:
/// - `String`: The name of the selected state manager ('bloc', 'provider', or 'riverpod').
///             Defaults to 'bloc' if no valid flag is found.
String getStateManager(Set<String> flags) {
  if (flags.contains('--b')) return 'bloc';
  if (flags.contains('--p')) return 'provider';
  if (flags.contains('--r')) return 'riverpod';
  return 'bloc';
}

/// Determines the file type to create based on the provided flags.
///
/// This function checks a set of flags for file type options and returns
/// the corresponding file type name. If no valid flag is found, it returns an empty string.
///
/// **Parameters**:
/// - `flags` (Set`<String>`): A set of command-line flags.
///
/// **Flags and File Types**:
/// - '--d': Returns 'demo' for creating a demo project.
/// - '--e': Returns 'empty' for creating an empty project.
///
/// **Returns**:
/// - `String`: The name of the selected file type ('demo' or 'empty').
///             Returns an empty string if no valid flag is found.
String getFileType(Set<String> flags) {
  if (flags.contains('--d')) return 'demo';
  if (flags.contains('--e')) return 'empty';
  return '';
}

/// Creates the project structure and applies configurations based on the
/// provided state manager and file type.
///
/// This function creates the necessary directory structure for the presentation
/// layer and generates files based on the selected state manager and file type.
///
/// **Parameters**:
/// - `rp` (String): The root path of the project.
/// - `stateManager` (String): The selected state manager ('bloc', 'provider', or 'riverpod').
/// - `fileType` (String): The type of file to create ('demo' or 'empty').
Future<void> createProject({
  required CommandsIO ioCommands,
  required String rootDir,
  required String stateManager,
  required String fileType,
}) async {
  /// create directory structure for presentation layer
  switch (stateManager) {
    case 'bloc':
      presentationBloc(rootDir: rootDir, ioCommands: ioCommands);
      break;
    case 'provider':
      presentationProvider(rootDir: rootDir, ioCommands: ioCommands);
      break;
    case 'riverpod':
      presentationRiverpod(rootDir: rootDir, ioCommands: ioCommands);
      break;
  }

  /// Apply file types
  if (fileType.isNotEmpty) {
    /// Create empty files
    if (fileType == 'empty') {
      await createEmptyFile(
        ioCommands: ioCommands,
        rootDir: rootDir,
      );
    } else if (fileType == 'demo') {
      /// if type of file is demo, create main.dart
      await createFile(
        ioCommands: ioCommands,
        rootDir: rootDir,
        pathFile: '/lib/app/presentation/pages/home/home_page.dart',
        content: homePage,
        replaceContent: true,
      );
      // Experimental yet...
      // add pacakages according to the state manager
      // await addPackages(stateManager);
    }

    if (stateManager.isNotEmpty) {
      ioCommands.logARo('''

        ⚙️  Creating structure for state manager: ${stateManager.toUpperCase()} 
            and creating files in ${fileType.toUpperCase()} format for the presentation layer

        ''');

      switch (stateManager) {
        case 'bloc':
          await createFilesBlocs(
            ioCommands: ioCommands,
            rootDir: rootDir,
            isEmpty: fileType == 'empty',
          );
          break;
        case 'provider':
          await createFilesProviders(
            ioCommands: ioCommands,
            rootDir: rootDir,
            isEmpty: fileType == 'empty',
          );
          break;
        case 'riverpod':
          await createFilesRiverpods(
            ioCommands: ioCommands,
            rootDir: rootDir,
            isEmpty: fileType == 'empty',
          );
          break;
      }
    }
  }
}

/// Experimental yert...
/// *************************************************************************
/// Adds required packages and dev dependencies based on the selected state manager.
///
/// This function installs the necessary Flutter packages and dev dependencies
/// for the specified state manager using `flutter pub add` and generates code
/// if the state manager is Riverpod.
// Future<void> addPackages(String stateManager) async {
//   Map<String, List<String>> packagesByManager = {
//     'bloc': ['flutter_bloc:^9.0.0', 'equatable:^2.0.5', 'meta:^1.15.0'],
//     'provider': ['provider:^6.1.1'],
//     'riverpod': ['flutter_riverpod:^2.4.5', 'riverpod_annotation:^2.3.0']
//   };

//   Map<String, List<String>> devPackagesByManager = {
//     'riverpod': ['riverpod_generator:^2.3.5', 'build_runner:^2.4.6']
//   };

//   List<String> packages = packagesByManager[stateManager] ?? [];
//   List<String> devPackages = devPackagesByManager[stateManager] ?? [];

//   for (String package in packages) {
//     try {
//       logARo('''
//           ⚙️  Instalando $package...
//         ''');
//       ProcessResult result = await Process.run(
//         'flutter',
//         ['pub', 'add', package],
//         runInShell: true,
//       );

//       if (result.exitCode == 0) {
//         logARo('''
//           ✅ $package install successfully
//         ''');
//       } else {
//         logARo('''
//           ❌ Error installing $package: ${result.stderr}
//         ''');
//       }
//     } catch (e) {
//       logARo('''
//         ❌ Error executing command: $e
//       ''');
//     }
//   }

//   for (String devPackage in devPackages) {
//     try {
//       logARo('''
//         ⚙️  Installing dev dependency $devPackage...
//       ''');
//       ProcessResult result = await Process.run(
//         'flutter',
//         ['pub', 'add', '--dev', devPackage],
//         runInShell: true,
//       );

//       if (result.exitCode == 0) {
//         logARo('''
//           ✅ $devPackage install successfully
//         ''');
//       } else {
//         logARo('''
//           ❌ Error installing $devPackage: ${result.stderr}
//         ''');
//       }
//     } catch (e) {
//       logARo('''
//         ❌ Error executing command: $e
//       ''');
//     }
//   }

//   try {
//     if (stateManager == 'riverpod') {
//       ProcessResult genCode = await Process.run(
//         'flutter',
//         [
//           'pub',
//           'run',
//           'build_runner',
//           'build',
//         ],
//         runInShell: true,
//       );

//       if (genCode.exitCode == 0) {
//         logARo('''
//           ✅ Generation of code completed
//         ''');
//       } else {
//         logARo('''
//           ❌ Error to generate code: ${genCode.stderr}
//         ''');
//       }
//     }
//   } catch (e) {
//     logARo('''
//       ❌ Error executing commano: $e
//     ''');
//   }
// }

const String homePage = '''import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: const Center(
        child: Text(
          'HomePage',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
''';
