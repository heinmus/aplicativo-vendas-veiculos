
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:myapp/core/auth_service.dart';
import 'package:myapp/core/theme_provider.dart';
import 'package:myapp/main.dart';
import 'package:myapp/core/favorites_provider.dart';
import 'package:myapp/core/vehicle_provider.dart';
import 'package:myapp/features/login_screen.dart';
import 'package:provider/provider.dart';

import 'widget_test.mocks.dart';

@GenerateMocks([AuthService])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late MockAuthService mockAuthService;

  setUp(() {
    mockAuthService = MockAuthService();
    // Required for the RefreshListenable to not throw an exception
    when(mockAuthService.addListener(any)).thenAnswer((_) {});
  });

  testWidgets('Renders LoginScreen when not authenticated', (WidgetTester tester) async {
    // Arrange
    when(mockAuthService.isLoggedIn).thenReturn(false);
    when(mockAuthService.username).thenReturn(null);

    // Build the app and trigger a frame.
    // We need to provide all the necessary providers that the app uses.
    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider<AuthService>.value(value: mockAuthService),
          ChangeNotifierProvider(create: (context) => ThemeProvider()),
          ChangeNotifierProvider(create: (context) => VehicleProvider(mockAuthService)),
          ChangeNotifierProxyProvider<AuthService, FavoritesProvider>(
            create: (context) => FavoritesProvider(null),
            update: (context, auth, _) => FavoritesProvider(auth),
          ),
        ],
        child: MyApp(authService: mockAuthService),
      ),
    );

    // Let the router handle the initial navigation
    await tester.pumpAndSettle();

    // Verify that the LoginScreen is present.
    expect(find.byType(LoginScreen), findsOneWidget);
  });
}
