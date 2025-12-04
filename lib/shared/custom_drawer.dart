
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../core/auth_service.dart';
import '../core/theme_provider.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final authService = context.watch<AuthService>();
    final themeProvider = context.watch<ThemeProvider>();

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(authService.username ?? 'Visitante'),
            accountEmail: Text(authService.isLoggedIn ? 'online' : 'offline'),
            currentAccountPicture: const CircleAvatar(
              child: Icon(Icons.person),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Início'),
            onTap: () => context.go('/'),
          ),
          ListTile(
            leading: const Icon(Icons.favorite),
            title: const Text('Favoritos'),
            onTap: () => context.go('/favorites'),
          ),
          ListTile(
            leading: const Icon(Icons.info),
            title: const Text('Sobre'),
            onTap: () => context.go('/about'),
          ),
          const Divider(),
          ListTile(
            leading: Icon(themeProvider.themeMode == ThemeMode.dark ? Icons.dark_mode : Icons.light_mode),
            onTap: () {
              themeProvider.toggleTheme();
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Sair'),
            onTap: () {
              authService.logout();
              // A navegação será tratada pelo redirect do go_router
            },
          ),
        ],
      ),
    );
  }
}
