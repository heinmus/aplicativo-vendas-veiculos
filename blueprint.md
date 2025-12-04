# Blueprint do Projeto: MyApp Veículos

## Visão Geral

Este documento descreve a arquitetura e as funcionalidades da aplicação `MyApp Veículos`. O objetivo é criar uma aplicação robusta, escalável e de fácil manutenção, seguindo as melhores práticas de desenvolvimento Flutter.

## Arquitetura

O projeto adota uma arquitetura baseada em `Providers` para gerenciamento de estado e `go_router` para navegação.

### Gerenciamento de Estado

Utilizamos o `provider` para gerenciar o estado da aplicação de forma centralizada. O `MultiProvider` é inicializado no topo da árvore de widgets, acima do `MaterialApp.router`, garantindo que todos os serviços estejam disponíveis em qualquer parte da aplicação.

Os seguintes providers estão configurados:
- **ChangeNotifierProvider<AuthService>**: Gerencia o estado de autenticação do usuário.
- **ChangeNotifierProvider<ThemeProvider>**: Controla o tema da aplicação (claro/escuro).
- **ChangeNotifierProvider<VehicleProvider>**: Fornece a lista de veículos.
- **ChangeNotifierProxyProvider<AuthService, FavoritesProvider>**: Gerencia os veículos favoritados pelo usuário, reagindo a mudanças no estado de autenticação.

### Navegação

A navegação é gerenciada pelo `go_router`, permitindo uma navegação declarativa e baseada em URLs. As rotas são definidas no arquivo `lib/core/app_router.dart`.

## Funcionalidades

- **Autenticação de Usuário**: O usuário pode fazer login para acessar a aplicação. O estado de login é persistido entre as sessões.
- **Catálogo de Veículos**: A tela inicial exibe um catálogo de veículos.
- **Sistema de Favoritos**: O usuário pode favoritar e desfavoritar veículos. Os favoritos são salvos por usuário e persistem entre as sessões.
- **Troca de Tema**: O usuário pode alternar entre os temas claro e escuro através de um botão no menu lateral.
- **Navegação Intuitiva**: Um menu lateral permite a navegação entre as principais telas da aplicação.
- **Página de Favoritos**: Uma página dedicada exibe a lista de veículos favoritados pelo usuário.
- **Página Sobre**: Uma página com informações sobre o aplicativo.

## Estrutura de Arquivos

```
/lib
|-- /core
|   |-- app_router.dart
|   |-- auth_service.dart
|   |-- favorites_provider.dart
|   |-- storage_service.dart
|   |-- theme_provider.dart
|   |-- vehicle_provider.dart
|   |-- veiculo_model.dart
|-- /features
|   |-- about_screen.dart
|   |-- details_screen.dart
|   |-- favorites_screen.dart
|   |-- home_screen.dart
|   |-- login_screen.dart
|   |-- register_screen.dart
|-- /shared
|   |-- card_item.dart
|   |-- custom_drawer.dart
|-- main.dart
```

## Plano de Melhorias Futuras

- **Integração com Firebase**: Utilizar o Firebase Authentication para um sistema de login mais robusto e o Firestore para armazenar os dados dos veículos e favoritos.
- **Testes Unitários e de Widgets**: Adicionar testes para garantir a qualidade e a estabilidade do código.
- **Melhorias na UI/UX**: Refinar o design das telas, adicionar animações e melhorar a experiência do usuário.
- **Internacionalização**: Adicionar suporte para múltiplos idiomas.
