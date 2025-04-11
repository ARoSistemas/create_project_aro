import 'file_system_interface.dart';
import 'io_commands.dart';
import 'io_commands_web.dart';

/// A factory class for creating file system implementations.
///
/// This class provides a static method to create an instance of a file system
/// implementation based on the runtime environment (web or IO).
///
/// **Logic**:
/// - If running in a web environment, returns an instance of `WebFileSystem`.
/// - If running in an IO environment, returns an instance of `IOFileSystem`.
///
class FileSystemFactory {
  static FileSystemInterface create() {
    if (identical(0, 0.0)) {
      return IoCommandsWeb();
    }
    return CommandsIO();
  }
}
