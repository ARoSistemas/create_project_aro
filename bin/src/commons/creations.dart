import '../platform/io_commands.dart';

/// Creates a directory at the specified path if it does not already exist.
///
/// This function creates a directory at the given path, relative to the root path,
/// and logs whether the directory was created or already existed.
Future<void> createDirectory({
  required CommandsIO ioCommands,
  required String rootDir,
  required String dir,
}) async {
  final bool checkExistDir = ioCommands.existsDir('$rootDir/$dir');

  if (!checkExistDir) {
    ioCommands.createDirectory('$rootDir/$dir');
    ioCommands.logARo('👌 The directory created successfully :: $dir');
  } else {
    ioCommands.logARo('🚩 The directory already exists :: $dir');
  }
}

/// Creates a file at the specified path with the given content.
///
/// This function creates a file at the given path, relative to the root path,
/// and writes the provided content to it. Optionally, it can replace existing content.
Future<void> createFile({
  required CommandsIO ioCommands,
  required String rootDir,
  required String pathFile,
  required String content,
  bool replaceContent = false,
}) async {
  final bool checkExistFile = ioCommands.existsFile('$rootDir/$pathFile');

  if (!checkExistFile || replaceContent) {
    ioCommands.writeFile('$rootDir/$pathFile', content);
    ioCommands.logARo('👌 The file created successfully :: $pathFile');
  } else {
    ioCommands.logARo('🚩 The file already exists :: $pathFile');
  }
}
