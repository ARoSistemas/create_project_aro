import 'dart:io';
import 'dart:developer';

void main(List<String> arguments) async {
  log('Ejemplo de uso del paquete create_project_aro');

  // Ruta actual del proyecto
  final currentPath = Directory.current.path;
  log('Directorio actual: $currentPath');

  // Ejecución real del package
  log('Ejecutando el package con las siguientes banderas:');
  log('--b (BLoC), --d (Demo)');

  try {
    ProcessResult result = await Process.run(
      'dart',
      [
        'run',
        'create_project_aro:create',
        '--b',
        '--d',
      ],
      runInShell: true,
    );

    // Mostrar salida del package
    log('Salida del package:');
    log(result.stdout);

    // Mostrar errores si los hay
    if (result.stderr.isNotEmpty) {
      log('Errores del package:');
      log(result.stderr);
    }
  } catch (e) {
    log('Error al ejecutar el package: $e');
  }

  log('Ejecución del package finalizada.');
}
