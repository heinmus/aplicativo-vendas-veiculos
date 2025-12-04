import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../features/about_screen.dart';
import '../features/details_screen.dart';
import '../features/favorites_screen.dart';
import '../features/home_screen.dart';
import '../features/login_screen.dart';
import '../features/register_screen.dart'; 
import 'auth_service.dart';
import 'veiculo_model.dart';

class AppRouter {
  final AuthService authService;

  AppRouter(this.authService);

  late final GoRouter router = GoRouter(
    initialLocation: '/', // A rota inicial é verificada pelo redirect
    refreshListenable: authService,
    routes: <RouteBase>[
      GoRoute(
        path: '/',
        builder: (context, state) => const HomeScreen(),
        routes: <RouteBase>[
           GoRoute(
            path: 'details',
            builder: (context, state) {
              final vehicle = state.extra as Vehicle;
              return DetailsScreen(vehicle: vehicle);
            },
          ),
        ],
      ),
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginScreen(),
      ),
       GoRoute(
        path: '/register',
        builder: (context, state) => const RegisterScreen(),
      ),
      GoRoute(
        path: '/favorites',
        builder: (context, state) => const FavoritesScreen(),
      ),
      GoRoute(
        path: '/about',
        builder: (context, state) => const AboutScreen(),
      ),
    ],
    redirect: (BuildContext context, GoRouterState state) {
      final isLoggedIn = authService.isLoggedIn;
      final isLoggingIn = state.matchedLocation == '/login' || state.matchedLocation == '/register';

      // Se não estiver logado e tentando acessar algo que não seja login/cadastro, redirecione para o login.
      if (!isLoggedIn && !isLoggingIn) {
        return '/login';
      }

      // Se já estiver logado e tentando acessar a tela de login/cadastro, redirecione para a home.
      if (isLoggedIn && isLoggingIn) {
        return '/';
      }

      // Em todos os outros casos, não faça nada.
      return null;
    },
  );
}
