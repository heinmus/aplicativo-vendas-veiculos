import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../core/theme_provider.dart';
import '../core/vehicle_provider.dart';
import '../shared/card_item.dart';
import '../shared/custom_drawer.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final vehicles = Provider.of<VehicleProvider>(context).vehicles;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Catálogo de Veículos'),
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
      drawer: const CustomDrawer(),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: vehicles.length,
        itemBuilder: (context, index) {
          return CardItem(vehicle: vehicles[index]);
        },
      ),
    );
  }
}
