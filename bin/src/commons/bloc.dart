import 'creations.dart';
import '../platform/io_commands.dart';

/// Create directorys structures for bloc without files
void presentationBloc({
  required CommandsIO ioCommands,
  required String rootDir,
}) {
  createDirectory(
    ioCommands: ioCommands,
    rootDir: rootDir,
    dir: '/lib/app/presentation/blocs/login',
  );
}

/// Create files for bloc
Future<void> createFilesBlocs({
  required CommandsIO ioCommands,
  required String rootDir,
  required bool isEmpty,
}) async {
  await createFile(
    ioCommands: ioCommands,
    rootDir: rootDir,
    pathFile: '/lib/app/presentation/blocs/login/login_bloc.dart',
    content: isEmpty ? '' : loginBloc,
  );

  await createFile(
    ioCommands: ioCommands,
    rootDir: rootDir,
    pathFile: '/lib/app/presentation/blocs/login/login_event.dart',
    content: isEmpty ? '' : loginEvent,
  );
  await createFile(
    ioCommands: ioCommands,
    rootDir: rootDir,
    pathFile: '/lib/app/presentation/blocs/login/login_state.dart',
    content: isEmpty ? '' : loginState,
  );

  await createFile(
    ioCommands: ioCommands,
    rootDir: rootDir,
    pathFile: '/lib/app/presentation/pages/login/login_page.dart',
    content: isEmpty ? '' : loginPageBloc,
  );

  if (!isEmpty) {
    await createFile(
      ioCommands: ioCommands,
      rootDir: rootDir,
      pathFile: '/lib/main.dart',
      content: mainBloc,
      replaceContent: true,
    );
  }
}

/// Create login bloc file
const String loginBloc = '''
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginState.initial()) {
    on<LoginEmailChanged>((event, emit) {
      emit(state.copyWith(email: event.email));
    });

    on<LoginPasswordChanged>((event, emit) {
      emit(state.copyWith(password: event.password));
    });

    on<LoginSubmitted>(
      (event, emit) async {
        emit(state.copyWith(
            isLoading: true, errorMessage: null, isSuccess: false));

        // Simulación de verificación de login
        await Future.delayed(const Duration(seconds: 1));

        if (state.email == 'demo@arosistemas.com' &&
            state.password == '123456') {
          emit(
            state.copyWith(
              isLoading: false,
              isSuccess: true,
            ),
          );
        } else {
          emit(
            state.copyWith(
              isLoading: false,
              errorMessage: 'Correo o contraseña inválidos',
            ),
          );
        }
      },
    );
  }
}
''';

/// Create login eventes file
const String loginEvent = '''
part of 'login_bloc.dart';

@immutable
abstract class LoginEvent extends Equatable {
  const LoginEvent();
}

class LoginEmailChanged extends LoginEvent {
  final String email;

  const LoginEmailChanged(this.email);

  @override
  List<Object> get props => [email];
}

class LoginPasswordChanged extends LoginEvent {
  final String password;

  const LoginPasswordChanged(this.password);

  @override
  List<Object> get props => [password];
}

class LoginSubmitted extends LoginEvent {
  const LoginSubmitted();

  @override
  List<Object> get props => [];
}
''';

/// Create login state file
const String loginState = '''
part of 'login_bloc.dart';

class LoginState extends Equatable {
  final String email;
  final String password;
  final bool isLoading;
  final String? errorMessage;
  final bool isSuccess;

  const LoginState({
    required this.email,
    required this.password,
    this.isLoading = false,
    this.errorMessage,
    this.isSuccess = false,
  });

  factory LoginState.initial() => const LoginState(
        email: '',
        password: '',
      );

  LoginState copyWith({
    String? email,
    String? password,
    bool? isLoading,
    String? errorMessage,
    bool? isSuccess,
  }) =>
      LoginState(
        email: email ?? this.email,
        password: password ?? this.password,
        isLoading: isLoading ?? this.isLoading,
        errorMessage: errorMessage,
        isSuccess: isSuccess ?? false,
      );

  @override
  List<Object?> get props => [
        email,
        password,
        isLoading,
        errorMessage,
        isSuccess,
      ];
}
''';

/// Create main page file
const String mainBloc = '''
import 'package:flutter/material.dart';

import 'app/presentation/pages/login/login_page.dart';

void main() {
  runApp(const MyApp());
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
      home: LoginPage(),
    );
  }
}
''';

/// Create login page file
const String loginPageBloc = '''
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../home/home_page.dart';
import '../../blocs/login/login_bloc.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginBloc(),
      child: BlocListener<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state.errorMessage != null) {
            _showErrorSnackBar(state.errorMessage!);
          }
          if (state.isSuccess) {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => const HomePage(),
              ),
            );
          }
        },
        child: Scaffold(
          appBar: AppBar(title: const Text('Login with BLoC')),
          body: BlocBuilder<LoginBloc, LoginState>(
            builder: (context, state) {
              return Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextFormField(
                            onChanged: (value) {
                              context.read<LoginBloc>().add(
                                    LoginEmailChanged(value),
                                  );
                            },
                            decoration: const InputDecoration(
                              labelText: 'Email',
                              border: OutlineInputBorder(),
                              hintText: 'demo@arosistemas.com',
                            ),
                            keyboardType: TextInputType.emailAddress,
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
                            onChanged: (value) {
                              context.read<LoginBloc>().add(
                                    LoginPasswordChanged(value),
                                  );
                            },
                            decoration: const InputDecoration(
                              labelText: 'Contraseña',
                              border: OutlineInputBorder(),
                              hintText: '123456',
                            ),
                            obscureText: true,
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
                            onPressed: state.isLoading
                                ? null
                                : () {
                                    if (_formKey.currentState!.validate()) {
                                      context
                                          .read<LoginBloc>()
                                          .add(const LoginSubmitted());
                                    }
                                  },
                            child: state.isLoading
                                ? const CircularProgressIndicator()
                                : const Text('Iniciar Sesión'),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
''';
