import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../core/favorites_provider.dart';
import '../core/theme_provider.dart';
import '../core/veiculo_model.dart';

class DetailsScreen extends StatelessWidget {
  final Vehicle vehicle;
  const DetailsScreen({super.key, required this.vehicle});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(vehicle.model),
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
          Consumer<FavoritesProvider>(
            builder: (context, favoritesProvider, child) {
              final isFavorite = favoritesProvider.isFavorite(vehicle);
              return IconButton(
                icon: Icon(
                  isFavorite ? Icons.favorite : Icons.favorite_border,
                  color: isFavorite ? Colors.red : null,
                ),
                onPressed: () {
                  favoritesProvider.toggleFavorite(vehicle);
                },
                tooltip: isFavorite ? 'Remover dos Favoritos' : 'Adicionar aos Favoritos',
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Hero(
              tag: vehicle.id,
              child: Image.asset(
                vehicle.imageUrl!,
                width: double.infinity,
                fit: BoxFit.cover,
                height: 250,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              vehicle.model,
              style: Theme.of(context).textTheme.headlineLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              'Preço: R\$ ${vehicle.price.toStringAsFixed(2)}',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(color: Theme.of(context).colorScheme.primary),
            ),
            const SizedBox(height: 24),
            Text(
              'Descrição',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
            const Divider(height: 16),
            Text(
              'Um excelente carro.',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
             const SizedBox(height: 24),
             Text(
              'Detalhes Adicionais',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
            const Divider(height: 16),
            ListTile(
              leading: Icon(Icons.calendar_today, color: Theme.of(context).colorScheme.secondary),
              title: const Text('Ano'),
              subtitle: Text(vehicle.year.toString()),
            ),
          ],
        ),
      ),
    );
  }
}
