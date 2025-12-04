import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../core/favorites_provider.dart';
import '../core/theme_provider.dart';
import '../shared/card_item.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Meus Favoritos'),
        actions: [
          Consumer<ThemeProvider>(
            builder: (context, themeProvider, child) {
              return IconButton(
                icon: Icon(themeProvider.themeMode == ThemeMode.dark
                    ? Icons.light_mode
                    : Icons.dark_mode),
                onPressed: () => themeProvider.toggleTheme(),
                tooltip: 'Alternar Tema',
              );
            },
          ),
        ],
      ),
      body: Consumer<FavoritesProvider>(
        builder: (context, favoritesProvider, child) {
          final favoriteItems = favoritesProvider.favorites;

          if (favoriteItems.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.favorite_border,
                    size: 80,
                    color: Theme.of(context).textTheme.bodySmall?.color,
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Sua lista de favoritos está vazia.',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Adicione carros aos seus favoritos na tela inicial.',
                    style: Theme.of(context).textTheme.bodyMedium,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16.0),
            itemCount: favoriteItems.length,
            itemBuilder: (context, index) {
              final vehicle = favoriteItems[index];
              return CardItem(vehicle: vehicle);
            },
          );
        },
      ),
    );
  }
}
