import 'package:flutter_test/flutter_test.dart';
import 'package:ogzawesomenotificationmanager/ogzawesomenotificationmanager.dart';

void main() {
  group('NotificationService Tests', () {
    test('should initialize notification service', () {
      // Basic test to ensure the service can be imported
      expect(NotificationService.getHandler, isA<Map<String, BaseNotificationHandler>>());
    });
  });
}
