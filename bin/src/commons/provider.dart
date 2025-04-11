import 'creations.dart';
import '../platform/io_commands.dart';

/// Create directorys structures for Provider
void presentationProvider({
  required CommandsIO ioCommands,
  required String rootDir,
}) {
  createDirectory(
    ioCommands: ioCommands,
    rootDir: rootDir,
    dir: '/lib/app/presentation/providers/login',
  );
}

/// Create files for Provider
Future<void> createFilesProviders({
  required CommandsIO ioCommands,
  required String rootDir,
  required bool isEmpty,
}) async {
  await createFile(
    ioCommands: ioCommands,
    rootDir: rootDir,
    pathFile: '/lib/app/presentation/providers/login/login_provider.dart',
    content: isEmpty ? '' : loginProvider,
  );

  await createFile(
    ioCommands: ioCommands,
    rootDir: rootDir,
    pathFile: '/lib/app/presentation/pages/login/login_page.dart',
    content: isEmpty ? '' : loginPageProvider,
  );

  if (!isEmpty) {
    await createFile(
      ioCommands: ioCommands,
      rootDir: rootDir,
      pathFile: '/lib/main.dart',
      content: mainProvider,
      replaceContent: true,
    );
  }
}

/// Create login provider file
const String loginProvider = '''
import 'package:flutter/material.dart' show ChangeNotifier;

class LoginProvider extends ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  String _errorMessage = '';
  String get errorMessage => _errorMessage;
  set errorMessage(String value) {
    _errorMessage = value;
    notifyListeners();
  }

  bool _isSuccess = false;
  bool get isSuccess => _isSuccess;
  set isSuccess(bool value) {
    _isSuccess = value;
    notifyListeners();
  }

  String _email = '';
  String get email => _email;
  set email(String value) {
    _email = value;
    notifyListeners();
  }

  String _password = '';
  String get password => _password;
  set password(String value) {
    _password = value;
    notifyListeners();
  }

  Future<void> login() async {
    _isLoading = true;
    _isSuccess = false;
    _errorMessage = '';

    notifyListeners();

    try {
      // Simulamos un delay para mostrar el loading
      await Future.delayed(const Duration(milliseconds: 500));

      if (_email == 'demo@arosistemas.com' && _password == '123456') {
        _isSuccess = true;
      } else {
        _errorMessage = 'Email o contraseña incorrectos';
      }
    } catch (e) {
      _errorMessage = 'Error inesperado: \${e.toString()}';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
''';

/// Create login page file for provider
const String loginPageProvider = '''
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../home/home_page.dart';
import '../../providers/login/login_provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  void goHomePage() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (_) => const HomePage(),
      ),
    );
  }

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.red,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final LoginProvider loginProvider = Provider.of<LoginProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Login with Provider')),
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
                    onChanged: (value) => loginProvider.email = value.trim(),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        loginProvider.errorMessage =
                            'Por favor ingrese su email';
                        return loginProvider.errorMessage;
                      }
                      if (!RegExp(r'^[\\w-.]+@([\\w-]+\\.)+[\\w-]{2,4}\$')
                          .hasMatch(value)) {
                        loginProvider.errorMessage =
                            'Por favor ingrese un email válido';
                        return loginProvider.errorMessage;
                      }

                      loginProvider.errorMessage = '';
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Contraseña',
                      hintText: '123456',
                      border: OutlineInputBorder(),
                    ),
                    obscureText: true,
                    onChanged: (value) => loginProvider.password = value.trim(),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        loginProvider.errorMessage =
                            'Por favor ingrese su contraseña';
                        return loginProvider.errorMessage;
                      }
                      if (value.length < 6) {
                        loginProvider.errorMessage =
                            'La contraseña debe tener al menos 6 caracteres';
                        return loginProvider.errorMessage;
                      }

                      loginProvider.errorMessage = '';
                      return null;
                    },
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: loginProvider.isLoading
                        ? null
                        : () {
                            _formKey.currentState!.validate();

                            if (loginProvider.errorMessage.isEmpty) {
                              loginProvider.login().then(
                                (_) {
                                  if (loginProvider.isSuccess) {
                                    goHomePage();
                                  } else {
                                    _showErrorSnackBar(
                                      loginProvider.errorMessage,
                                    );
                                  }
                                },
                              );
                            } else {
                              _showErrorSnackBar(
                                loginProvider.errorMessage,
                              );
                            }
                          },
                    child: loginProvider.isLoading
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

/// Create main file for provider
const String mainProvider = '''
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'app/presentation/pages/login/login_page.dart';
import 'app/presentation/providers/login/login_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LoginProvider()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const LoginPage(),
      ),
    );
  }
}
''';
