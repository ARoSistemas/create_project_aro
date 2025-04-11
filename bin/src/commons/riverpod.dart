import 'creations.dart';
import '../platform/io_commands.dart';

/// Create directorys structures for Riverpod
void presentationRiverpod({
  required CommandsIO ioCommands,
  required String rootDir,
}) {
  createDirectory(
    ioCommands: ioCommands,
    rootDir: rootDir,
    dir: '/lib/app/presentation/controllers/login',
  );
}

/// Create files for Riverpod
Future<void> createFilesRiverpods({
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
    pathFile: '/lib/app/presentation/pages/login/login_page.dart',
    content: isEmpty ? '' : loginPageRiverpod,
  );

  if (!isEmpty) {
    await createFile(
      ioCommands: ioCommands,
      rootDir: rootDir,
      pathFile: '/lib/main.dart',
      content: mainRiverpod,
      replaceContent: true,
    );
  }
}

/// Create controller for  Riverpod
const String loginController = '''
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'login_controller.g.dart';

@riverpod
class LoginController extends _\$LoginController {
  @override
  LoginState build() => const LoginState();

  void updateEmail(String value) {
    state = state.copyWith(email: value.trim());
  }

  void updatePassword(String value) {
    state = state.copyWith(password: value);
  }

  Future<void> login() async {
    state = state.copyWith(isLoading: true, errorMessage: null);

    try {
      await Future.delayed(const Duration(milliseconds: 500));

      if (state.email == 'demo@arosistemas.com' && state.password == '123456') {
        state = state.copyWith(isSuccess: true, isLoading: false);
      } else {
        state = state.copyWith(
          errorMessage: 'Credenciales incorrectas',
          isLoading: false,
        );
      }
    } catch (e) {
      state = state.copyWith(
        errorMessage: 'Error inesperado: \${e.toString()}',
        isLoading: false,
      );
    }
  }
}

class LoginState {
  final bool isLoading;
  final String? errorMessage;
  final bool isSuccess;
  final String email;
  final String password;

  const LoginState({
    this.isLoading = false,
    this.errorMessage,
    this.isSuccess = false,
    this.email = '',
    this.password = '',
  });

  LoginState copyWith({
    bool? isLoading,
    String? errorMessage,
    bool? isSuccess,
    String? email,
    String? password,
  }) {
    return LoginState(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
      isSuccess: isSuccess ?? this.isSuccess,
      email: email ?? this.email,
      password: password ?? this.password,
    );
  }
}
''';

/// Create login page for Riverpod
const String loginPageRiverpod = '''
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../home/home_page.dart';
import '../../controllers/login/login_controller.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.red,
      ),
    );
  }

  void _goHomePage() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (_) => const HomePage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final loginState = ref.watch(loginControllerProvider);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (loginState.isSuccess) _goHomePage();

      if (loginState.errorMessage != null &&
          !loginState.isSuccess &&
          !loginState.isLoading) {
        _showErrorSnackBar(loginState.errorMessage!);
      }
    });

    return Scaffold(
      appBar: AppBar(title: const Text('Login with Riverpod')),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Email',
                      border: OutlineInputBorder(),
                      hintText: 'demo@arosistemas.com',
                    ),
                    keyboardType: TextInputType.emailAddress,
                    onChanged: (value) => ref
                        .read(loginControllerProvider.notifier)
                        .updateEmail(value),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor ingrese su email';
                      }
                      if (!RegExp(r'^[\\w-.]+@([\\w-]+\\.)+[\\w-]{2,4}\$')
                          .hasMatch(value)) {
                        return 'Por favor ingrese un email válido';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Contraseña',
                      border: OutlineInputBorder(),
                      hintText: '123456',
                    ),
                    obscureText: true,
                    onChanged: (value) => ref
                        .read(loginControllerProvider.notifier)
                        .updatePassword(value),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor ingrese su contraseña';
                      }
                      if (value.length < 6) {
                        return 'La contraseña debe tener al menos 6 caracteres';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: loginState.isLoading
                        ? null
                        : () async {
                            if (_formKey.currentState!.validate()) {
                              await ref
                                  .read(loginControllerProvider.notifier)
                                  .login();
                            }
                          },
                    child: loginState.isLoading
                        ? const CircularProgressIndicator()
                        : const Text('Iniciar Sesión'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
 ''';

/// Create main file for Riverpod
const String mainRiverpod = '''
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app/presentation/pages/login/login_page.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const LoginPage(),
    );
  }
}
 ''';
