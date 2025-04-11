import 'package:flutter_test/flutter_test.dart';

import '../bin/create.dart';

void main() {
  group('Create Utility Tests', () {
    test('validateFlags should return valid flags only', () {
      final List<String> testFlags = ['--b', '--x', '--r', '--d', '--b', '--p'];
      final Set<String> result = validateFlags(testFlags);
      expect(result, {'--b', '--r', '--d', '--p'});
    });

    test('validateFlags should handle empty input', () {
      final List<String> emptyFlags = [];
      final Set<String> result = validateFlags(emptyFlags);
      expect(result, isEmpty);
    });

    test('getStateManager should return correct manager', () {
      expect(getStateManager({'--b'}), equals('bloc'));
      expect(getStateManager({'--p'}), equals('provider'));
      expect(getStateManager({'--r'}), equals('riverpod'));
      expect(getStateManager({'--d'}), equals('bloc')); // Default case
    });

    test('getFileType should return correct type', () {
      expect(getFileType({'--d'}), equals('demo'));
      expect(getFileType({'--e'}), equals('empty'));
      expect(getFileType({'--b'}), equals('')); // Invalid flag
      expect(getFileType({}), equals('')); // Empty set
    });

    test('getStateManager should default to bloc', () {
      expect(getStateManager({}), equals('bloc'));
      expect(getStateManager({'--x'}), equals('bloc'));
    });

    test('validateFlags should filter out invalid flags', () {
      final List<String> invalidFlags = ['--x', '--y', '--z'];
      final Set<String> result = validateFlags(invalidFlags);
      expect(result, isEmpty);
    });
  });
}
