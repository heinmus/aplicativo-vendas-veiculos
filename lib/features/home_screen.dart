import 'package:flutter/material.dart';
import 'package:myapp/core/data.dart';
import 'package:myapp/shared/custom_drawer.dart';
import 'package:myapp/shared/card_item.dart';

// Widget que monta o grid com os veículos
class _BuildVeiculosGrid extends StatelessWidget {
  const _BuildVeiculosGrid();

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(10),
      itemCount: listaVeiculos.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, 
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 0.8, 
      ),
      itemBuilder: (context, index) {
        final carro = listaVeiculos[index];

        return CardItem(
          title: '${carro.marca} ${carro.modelo}',
          subtitle: 'R\$ ${carro.preco.toStringAsFixed(2)}',
          detail: 'Ano: ${carro.ano}',
          backgroundColor: carro.corCard,
          imageUrl: carro.imagemUrl,
          icon: Icons.directions_car,
          onTap: () {
            // quando clica no card no caso o protudo do catalogo vai para a tela de detalhes
            Navigator.pushNamed(context, '/details', arguments: carro);
          },
        );
      },
    );
  }
}

// Tela principal do aplicativo
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _abaSelecionada = 0; //faz o controle de qual aba esta sendo selecionada

  // lista que contem os conteudos das abas
  static final List<Widget> _conteudos = [
    const _BuildVeiculosGrid(),
    const Center(
      child: Text(
        'Aba de Busca (em desenvolvimento)',
        style: TextStyle(fontSize: 22),
      ),
    ),
  ];

  // muda de aba 
  void _mudarAba(int index) {
    setState(() {
      _abaSelecionada = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Catálogo de Veículos'),
        backgroundColor: Colors.blue[900],
      ),
      drawer: const CustomDrawer(),
      body: _conteudos[_abaSelecionada],
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.directions_car),
            label: 'Catálogo',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Buscar',
          ),
        ],
        currentIndex: _abaSelecionada,
        selectedItemColor: Colors.blue[900],
        onTap: _mudarAba,
      ),
    );
  }
}
