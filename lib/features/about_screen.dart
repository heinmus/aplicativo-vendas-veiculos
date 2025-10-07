import 'package:flutter/material.dart';
import 'package:myapp/core/data.dart';
import 'package:myapp/shared/card_item.dart';

//tela dos membros do grupo
class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sobre o App e o Grupo'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(18), 
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              infoApp['appNome'] ?? 'Aplicativo de veículos',
              style: const TextStyle(
                fontSize: 27,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'Versão: ${infoApp['versao'] ?? '1.0'}',
              style: TextStyle(
                fontSize: 15.5,
                color: Colors.grey.shade700,
              ),
            ),

            const Divider(height: 25),

            const Text(
              'Integrantes do Grupo:',
              style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),

            // Grid com as informaçoes do membros da equipe 
            GridView.builder(
              itemCount: infoMembros.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                childAspectRatio: 0.95,
              ),
              itemBuilder: (context, i) {
                final membro = infoMembros[i];
                return CardItem(
                  title: membro['nome'] ?? 'Sem nome',
                  subtitle: membro['funcao'] ?? 'Função não informada',
                  icon: Icons.person,
                  backgroundColor: Colors.grey.shade200,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
