import 'package:flutter/material.dart';

// menu lateral do aplicativo
class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blueAccent,
            ),
            child: Text(
              'MyApp Veículos',
              style: TextStyle(
                color: Colors.white,
                fontSize: 23, 
                fontWeight: FontWeight.w600,
              ),
            ),
          ),

          // item do menu catalogo e inico
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Catálogo (Início)'),
            onTap: () {
              Navigator.pop(context); 
              Navigator.pushNamedAndRemoveUntil(
                  context, '/', (route) => false); 
            },
          ),

          // item do menu da tela sobre o app e os membros
          ListTile(
            leading: const Icon(Icons.group),
            title: const Text('Sobre o App e Grupo'),
            onTap: () {
              Navigator.pop(context); // fecha o drawer
              Navigator.pushNamed(context, '/about'); // abre a tela sobre
            },
          ),
        ],
      ),
    );
  }
}
