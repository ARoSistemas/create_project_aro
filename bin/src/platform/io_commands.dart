import 'dart:io';
import 'file_system_interface.dart';

/// An implementation of the `FileSystemInterface` for IO (Input/Output) environments.
///
/// This class provides file system operations for environments that support
/// standard file system access, such as desktop or mobile platforms.
///
/// **Implements**:
/// - `FileSystemInterface`
class CommandsIO implements FileSystemInterface {
  @override
  void createDirectory(String path) async {
    Directory(path).createSync(recursive: true);
    return;
  }

  @override
  void writeFile(String path, String content) async {
    File(path).writeAsStringSync(content);
  }

  @override
  bool existsFile(String path) {
    return File(path).existsSync();
  }

  @override
  bool existsDir(String path) {
    Directory directory = Directory(path);
    return directory.existsSync();
  }

  @override
  String getCurrentPath() {
    return Directory.current.path;
  }

  @override
  void logARo(String message) {
    stdout.writeln(message);
  }

  @override
  void exitProgram() {
    exit(0);
  }
}
