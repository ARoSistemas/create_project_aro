import 'creations.dart';
import '../platform/io_commands.dart';

/// Create directorys structures for GetX
void presentationGetX({
  required CommandsIO ioCommands,
  required String rootDir,
}) {
  createDirectory(
    ioCommands: ioCommands,
    rootDir: rootDir,
    dir: '/lib/app/presentation/controllers/login',
  );
  createDirectory(
    ioCommands: ioCommands,
    rootDir: rootDir,
    dir: '/lib/app/presentation/bindings',
  );
}

/// Create files for GetX
Future<void> createFilesGetX({
  required CommandsIO ioCommands,
  required String rootDir,
  required bool isEmpty,
}) async {
  await createFile(
    ioCommands: ioCommands,
    rootDir: rootDir,
    pathFile: '/lib/app/presentation/controllers/login/login_controller.dart',
    content: isEmpty ? '' : loginController,
  );

  await createFile(
    ioCommands: ioCommands,
    rootDir: rootDir,
    pathFile: '/lib/app/presentation/bindings/login_binding.dart',
    content: isEmpty ? '' : loginBinding,
  );

  await createFile(
    ioCommands: ioCommands,
    rootDir: rootDir,
    pathFile: '/lib/app/presentation/pages/login/login_page.dart',
    content: isEmpty ? '' : loginPageGetX,
  );

  if (!isEmpty) {
    await createFile(
      ioCommands: ioCommands,
      rootDir: rootDir,
      pathFile: '/lib/main.dart',
      content: mainGetX,
      replaceContent: true,
    );
  }
}

/// Create login controller file for GetX
const String loginController = '''
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class LoginController extends GetxController {
  // Observable variables
  final RxString email = ''.obs;
  final RxString password = ''.obs;
  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;
  final RxBool isSuccess = false.obs;

  /// Updates email value
  void updateEmail(String value) {
    email.value = value;
    // Clear error message when user types
    if (errorMessage.value.isNotEmpty) {
      errorMessage.value = '';
    }
  }

  /// Updates password value
  void updatePassword(String value) {
    password.value = value;
    // Clear error message when user types
    if (errorMessage.value.isNotEmpty) {
      errorMessage.value = '';
    }
  }

  /// Performs login validation and navigation
  Future<void> login() async {
    // Reset states
    isLoading.value = true;
    errorMessage.value = '';
    isSuccess.value = false;

    try {
      // Simulate API call delay
      await Future.delayed(const Duration(seconds: 1));

      // Simple validation
      if (email.value == 'demo@arosistemas.com' && password.value == '123456') {
        isSuccess.value = true;
        
        // Navigate to home page
        Get.offNamed('/home');
        
        // Show success message
        Get.snackbar(
          'Éxito',
          'Bienvenido a la aplicación',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.green[50],
        );
      } else {
        errorMessage.value = 'Correo o contraseña inválidos';
        
        // Show error message
        Get.snackbar(
          'Error',
          'Credenciales incorrectas',
          snackPosition: SnackPosition.TOP,
        );
      }
    } catch (e) {
      errorMessage.value = 'Error inesperado: \${e.toString()}';
    } finally {
      isLoading.value = false;
    }
  }

  /// Validates email format
  bool get isEmailValid {
    return GetUtils.isEmail(email.value);
  }

  /// Validates password length
  bool get isPasswordValid {
    return password.value.length >= 6;
  }

  /// Checks if form is valid for submission
  bool get canSubmit {
    return isEmailValid && isPasswordValid && !isLoading.value;
  }

  /// Clears all form data
  void clearForm() {
    email.value = '';
    password.value = '';
    errorMessage.value = '';
    isSuccess.value = false;
  }
}
''';

/// Create login binding file for GetX
const String loginBinding = '''
import 'package:get/get.dart';
import '../controllers/login/login_controller.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoginController>(() => LoginController());
  }
}
''';

/// Create login page file for GetX
const String loginPageGetX = '''
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/login/login_controller.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
        centerTitle: true,
      ),
      body: GetBuilder<LoginController>(
        builder: (controller) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Logo or title
                const Icon(
                  Icons.lock_outline,
                  size: 80,
                  color: Colors.blue,
                ),
                const SizedBox(height: 32),
                
                // Email field
                TextField(
                  onChanged: controller.updateEmail,
                  decoration: InputDecoration(
                    labelText: 'Correo electrónico',
                    hintText: 'demo@arosistemas.com',
                    prefixIcon: const Icon(Icons.email),
                    border: const OutlineInputBorder(),
                    errorText: controller.email.isNotEmpty && !controller.isEmailValid
                        ? 'Ingresa un correo válido'
                        : null,
                  ),
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 16),
                
                // Password field
                TextField(
                  onChanged: controller.updatePassword,
                  decoration: InputDecoration(
                    labelText: 'Contraseña',
                    hintText: '123456',
                    prefixIcon: const Icon(Icons.lock),
                    border: const OutlineInputBorder(),
                    errorText: controller.password.isNotEmpty && !controller.isPasswordValid
                        ? 'La contraseña debe tener al menos 6 caracteres'
                        : null,
                  ),
                  obscureText: true,
                ),
                const SizedBox(height: 24),
                
                // Error message
                Obx(() => controller.errorMessage.isNotEmpty
                    ? Container(
                        padding: const EdgeInsets.all(8),
                        margin: const EdgeInsets.only(bottom: 16),
                        decoration: BoxDecoration(
                          color: Colors.red.shade100,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.red.shade300),
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.error, color: Colors.red),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                controller.errorMessage.value,
                                style: const TextStyle(color: Colors.red),
                              ),
                            ),
                          ],
                        ),
                      )
                    : const SizedBox.shrink()),
                
                // Login button
                Obx(() => SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: controller.canSubmit ? controller.login : null,
                    child: controller.isLoading.value
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                            ),
                          )
                        : const Text('Iniciar Sesión'),
                  ),
                )),
                const SizedBox(height: 16),
              ],
            ),
          );
        },
      ),
    );
  }
}
''';

/// Create main.dart file for GetX
const String mainGetX = '''
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'app/presentation/pages/login/login_page.dart';
import 'app/presentation/pages/home/home_page.dart';
import 'app/presentation/bindings/login_binding.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter GetX Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      initialRoute: '/login',
      getPages: [
        GetPage(
          name: '/login',
          page: () => const LoginPage(),
          binding: LoginBinding(),
        ),
        GetPage(
          name: '/home',
          page: () => const HomePage(),
        ),
      ],
      debugShowCheckedModeBanner: false,
    );
  }
}
''';
