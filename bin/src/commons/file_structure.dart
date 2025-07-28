import 'creations.dart';
import '../platform/io_commands.dart';

/// Create directorys empty structures
void createStructureEmpty({
  required CommandsIO ioCommands,
  required String rootDir,
}) {
  ioCommands.logARo('''

  🗂️   Creating Clean Architecture base structure:
  
  ''');

  createDirectory(
    ioCommands: ioCommands,
    rootDir: rootDir,
    dir: '/lib/core/errors',
  );
  createDirectory(
    ioCommands: ioCommands,
    rootDir: rootDir,
    dir: '/lib/core/network',
  );
  createDirectory(
    ioCommands: ioCommands,
    rootDir: rootDir,
    dir: '/lib/core/utils',
  );
  createDirectory(
    ioCommands: ioCommands,
    rootDir: rootDir,
    dir: '/lib/core/widgets',
  );

  createDirectory(
    ioCommands: ioCommands,
    rootDir: rootDir,
    dir: '/lib/app/injection',
  );
  createDirectory(
    ioCommands: ioCommands,
    rootDir: rootDir,
    dir: '/lib/app/config/constans',
  );
  createDirectory(
    ioCommands: ioCommands,
    rootDir: rootDir,
    dir: '/lib/app/config/router',
  );
  createDirectory(
    ioCommands: ioCommands,
    rootDir: rootDir,
    dir: '/lib/app/config/styles',
  );
  createDirectory(
    ioCommands: ioCommands,
    rootDir: rootDir,
    dir: '/lib/app/config/themes',
  );
  createDirectory(
    ioCommands: ioCommands,
    rootDir: rootDir,
    dir: '/lib/app/data/repositories',
  );
  createDirectory(
    ioCommands: ioCommands,
    rootDir: rootDir,
    dir: '/lib/app/data/datasources/local',
  );
  createDirectory(
    ioCommands: ioCommands,
    rootDir: rootDir,
    dir: '/lib/app/data/datasources/remote',
  );
  createDirectory(
    ioCommands: ioCommands,
    rootDir: rootDir,
    dir: '/lib/app/domain/entities/models',
  );
  createDirectory(
    ioCommands: ioCommands,
    rootDir: rootDir,
    dir: '/lib/app/domain/entities/dtos',
  );
  createDirectory(
    ioCommands: ioCommands,
    rootDir: rootDir,
    dir: '/lib/app/domain/repositories',
  );
  createDirectory(
    ioCommands: ioCommands,
    rootDir: rootDir,
    dir: '/lib/app/domain/usecases',
  );
  createDirectory(
    ioCommands: ioCommands,
    rootDir: rootDir,
    dir: '/lib/app/presentation/pages/login',
  );
  createDirectory(
    ioCommands: ioCommands,
    rootDir: rootDir,
    dir: '/lib/app/presentation/pages/home',
  );
  createDirectory(
    ioCommands: ioCommands,
    rootDir: rootDir,
    dir: '/lib/app/presentation/widgets/login',
  );
  createDirectory(
    ioCommands: ioCommands,
    rootDir: rootDir,
    dir: '/lib/app/utils/helpers',
  );
  createDirectory(
    ioCommands: ioCommands,
    rootDir: rootDir,
    dir: '/lib/app/utils/widgets',
  );
}

/// Create empty files
Future<void> createEmptyFile({
  required CommandsIO ioCommands,
  required String rootDir,
}) async {
  ioCommands.logARo('''

  📄  Creating base empty files for Clean Architecture:
  
  ''');

  await createFile(
    ioCommands: ioCommands,
    rootDir: rootDir,
    pathFile: '/lib/core/errors/failures.dart',
    content: '',
  );
  await createFile(
    ioCommands: ioCommands,
    rootDir: rootDir,
    pathFile: '/lib/core/network/api_client.dart',
    content: '',
  );
  await createFile(
    ioCommands: ioCommands,
    rootDir: rootDir,
    pathFile: '/lib/core/network/exceptions.dart',
    content: '',
  );
  await createFile(
    ioCommands: ioCommands,
    rootDir: rootDir,
    pathFile: '/lib/core/network/network_info.dart',
    content: '',
  );
  await createFile(
    ioCommands: ioCommands,
    rootDir: rootDir,
    pathFile: '/lib/core/utils/results.dart',
    content: '',
  );
  await createFile(
    ioCommands: ioCommands,
    rootDir: rootDir,
    pathFile: '/lib/core/utils/input_converter.dart',
    content: '',
  );
  await createFile(
    ioCommands: ioCommands,
    rootDir: rootDir,
    pathFile: '/lib/core/utils/validators.dart',
    content: '',
  );
  await createFile(
    ioCommands: ioCommands,
    rootDir: rootDir,
    pathFile: '/lib/core/widgets/error_widget.dart',
    content: '',
  );
  await createFile(
    ioCommands: ioCommands,
    rootDir: rootDir,
    pathFile: '/lib/core/widgets/loading_widget.dart',
    content: '',
  );
  await createFile(
    ioCommands: ioCommands,
    rootDir: rootDir,
    pathFile: '/lib/app/config/constans/app_constans.dart',
    content: '',
  );
  await createFile(
    ioCommands: ioCommands,
    rootDir: rootDir,
    pathFile: '/lib/app/config/constans/app_env.dart',
    content: '',
  );
  await createFile(
    ioCommands: ioCommands,
    rootDir: rootDir,
    pathFile: '/lib/app/config/constans/app_keys.dart',
    content: '',
  );
  await createFile(
    ioCommands: ioCommands,
    rootDir: rootDir,
    pathFile: '/lib/app/config/constans/app_enums.dart',
    content: '',
  );
  await createFile(
    ioCommands: ioCommands,
    rootDir: rootDir,
    pathFile: '/lib/app/config/router/app_router.dart',
    content: '',
  );
  await createFile(
    ioCommands: ioCommands,
    rootDir: rootDir,
    pathFile: '/lib/app/config/styles/app_colors.dart',
    content: '',
  );
  await createFile(
    ioCommands: ioCommands,
    rootDir: rootDir,
    pathFile: '/lib/app/config/styles/app_styles.dart',
    content: '',
  );
  await createFile(
    ioCommands: ioCommands,
    rootDir: rootDir,
    pathFile: '/lib/app/config/themes/app_themes.dart',
    content: '',
  );
  await createFile(
    ioCommands: ioCommands,
    rootDir: rootDir,
    pathFile: '/lib/app/data/datasources/local/local_data_source.dart',
    content: '',
  );
  await createFile(
    ioCommands: ioCommands,
    rootDir: rootDir,
    pathFile: '/lib/app/data/datasources/remote/remote_data_source.dart',
    content: '',
  );
  await createFile(
    ioCommands: ioCommands,
    rootDir: rootDir,
    pathFile: '/lib/app/data/datasources/remote/api_client.dart',
    content: '',
  );
  await createFile(
    ioCommands: ioCommands,
    rootDir: rootDir,
    pathFile: '/lib/app/data/repositories/repository_impl.dart',
    content: '',
  );
  await createFile(
    ioCommands: ioCommands,
    rootDir: rootDir,
    pathFile: '/lib/app/domain/entities/dtos/user_api.dart',
    content: '',
  );
  await createFile(
    ioCommands: ioCommands,
    rootDir: rootDir,
    pathFile: '/lib/app/domain/entities/models/user.dart',
    content: '',
  );
  await createFile(
    ioCommands: ioCommands,
    rootDir: rootDir,
    pathFile: '/lib/app/domain/repositories/login_repository.dart',
    content: '',
  );
  await createFile(
    ioCommands: ioCommands,
    rootDir: rootDir,
    pathFile: '/lib/app/domain/usecases/login_usecase.dart',
    content: '',
  );
  await createFile(
    ioCommands: ioCommands,
    rootDir: rootDir,
    pathFile: '/lib/app/injection/injection.dart',
    content: '',
  );
  await createFile(
    ioCommands: ioCommands,
    rootDir: rootDir,
    pathFile: '/lib/app/presentation/pages/home/home_page.dart',
    content: '',
  );
  await createFile(
    ioCommands: ioCommands,
    rootDir: rootDir,
    pathFile: '/lib/app/presentation/widgets/login/email_input.dart',
    content: '',
  );
  await createFile(
    ioCommands: ioCommands,
    rootDir: rootDir,
    pathFile: '/lib/app/presentation/widgets/login/password_input.dart',
    content: '',
  );
  await createFile(
    ioCommands: ioCommands,
    rootDir: rootDir,
    pathFile: '/lib/app/utils/helpers/result.dart',
    content: '',
  );
  await createFile(
    ioCommands: ioCommands,
    rootDir: rootDir,
    pathFile: '/lib/app/utils/widgets/custom_button.dart',
    content: '',
  );
}
