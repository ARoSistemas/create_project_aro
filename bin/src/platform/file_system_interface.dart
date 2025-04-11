/// An abstract class defining an interface for file system operations.
///
/// This abstract class specifies the contract for file system interactions,
/// including directory creation, file writing, existence checks, and path retrieval.
abstract class FileSystemInterface {
  /// Creates a directory at the specified path
  void createDirectory(String path);

  /// Writes content to a file at the specified path
  void writeFile(String path, String content);

  /// Checks if a file exists at the specified path
  bool existsFile(String path);

  /// Checks if a  directory exists at the specified path
  bool existsDir(String path);

  /// Retrieves the current working directory path
  String getCurrentPath();

  /// Writes a message to the standard output.
  void logARo(String message);

  /// Exits the program
  void exitProgram();
}
