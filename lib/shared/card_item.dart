import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../core/favorites_provider.dart';
import '../core/veiculo_model.dart';

class CardItem extends StatelessWidget {
  final Vehicle vehicle;

  const CardItem({super.key, required this.vehicle});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return GestureDetector(
      onTap: () => context.go('/details', extra: vehicle),
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 10),
        elevation: 5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        clipBehavior: Clip.antiAlias, // Garante que a imagem respeite as bordas arredondadas
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Hero(
              tag: vehicle.id, // Tag para a animação da imagem
              child: Image.asset(
                vehicle.imageUrl!,
                height: 200,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    vehicle.model,
                    style: textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'R\$ ${vehicle.price.toStringAsFixed(2)}',
                    style: textTheme.titleMedium?.copyWith(
                      color: colorScheme.primary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Um excelente carro.',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
            const Divider(height: 1),
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Consumer<FavoritesProvider>(
                  builder: (context, favoritesProvider, child) {
                    final isFavorite = favoritesProvider.isFavorite(vehicle);
                    return Align(
                      alignment: Alignment.centerRight,
                      child: IconButton(
                        icon: Icon(
                          isFavorite ? Icons.favorite : Icons.favorite_border,
                          color: isFavorite ? Colors.red.shade400 : colorScheme.onSurface, 
                        ),
                        iconSize: 30,
                        tooltip: isFavorite ? 'Remover dos Favoritos' : 'Adicionar aos Favoritos',
                        onPressed: () {
                          favoritesProvider.toggleFavorite(vehicle);

                          ScaffoldMessenger.of(context)
                            ..hideCurrentSnackBar()
                            ..showSnackBar(
                              SnackBar(
                                content: Text(
                                  isFavorite 
                                  ? '${vehicle.model} removido dos favoritos.' 
                                  : '${vehicle.model} adicionado aos favoritos.'
                                ),
                                duration: const Duration(seconds: 2),
                              ),
                            );
                        },
                      ),
                    );
                  },
                ),
            )
          ],),
      ),
    );
  }
}
