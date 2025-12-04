
import 'package:flutter_test/flutter_test.dart';
import 'package:myapp/core/auth_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late AuthService authService;

  group('AuthService', () {
    test('deve estar deslogado inicialmente', () async {
      // Arrange
      SharedPreferences.setMockInitialValues({});
      authService = AuthService();
      // Wait for _loadUser to finish
      await Future.delayed(Duration.zero);

      // Assert
      expect(authService.isLoggedIn, isFalse);
      expect(authService.username, isNull);
    });

    test('deve registrar e logar com sucesso', () async {
      // Arrange
      SharedPreferences.setMockInitialValues({});
      authService = AuthService();
      await Future.delayed(Duration.zero);

      // Act: Register
      await authService.register('testuser', 'password123');

      // Act: Login
      final result = await authService.login('testuser', 'password123');

      // Assert
      expect(result['success'], isTrue);
      expect(authService.isLoggedIn, isTrue);
      expect(authService.username, 'testuser');
    });

    test('não deve logar com credenciais incorretas', () async {
      // Arrange
      SharedPreferences.setMockInitialValues(
          {'username': 'testuser', 'password': 'password123'});
      authService = AuthService();
      await Future.delayed(Duration.zero);

      // Act
      final result = await authService.login('testuser', 'wrongpassword');

      // Assert
      expect(result['success'], isFalse);
      expect(authService.isLoggedIn, isFalse);
    });

    test('deve fazer logout com sucesso', () async {
      // Arrange
      SharedPreferences.setMockInitialValues({
        'username': 'testuser',
        'password': 'password123',
        'isLoggedIn': true, // Start as logged in
      });
      authService = AuthService();
      await Future.delayed(Duration.zero); // wait for _loadUser

      // Pre-condition check
      expect(authService.isLoggedIn, isTrue);

      // Act
      await authService.logout();

      // Assert
      expect(authService.isLoggedIn, isFalse);
      expect(authService.username, isNull);
    });
  });
}
