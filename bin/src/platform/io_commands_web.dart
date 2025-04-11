import 'file_system_interface.dart';

class IoCommandsWeb implements FileSystemInterface {
  @override
  Future<void> createDirectory(String path) async {
    throw UnimplementedError('Directory creation not supported in web');
  }

  @override
  void writeFile(String path, String content) async {
    throw UnimplementedError('File writing not supported in web');
  }

  @override
  bool existsFile(String path) {
    return false;
  }

  @override
  bool existsDir(String path) {
    return false;
  }

  @override
  String getCurrentPath() {
    return '/';
  }

  @override
  void exitProgram() {
    throw UnimplementedError('File writing not supported in web');
  }

  @override
  void logARo(String message) {
    throw UnimplementedError('File writing not supported in web');
  }
}
