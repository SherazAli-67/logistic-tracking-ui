import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:logistic_tracking_ui/presentation/screens/home_screen.dart';
import 'package:logistic_tracking_ui/presentation/screens/welcome_screen.dart';
import 'package:logistic_tracking_ui/providers/home_provider.dart';
import 'package:provider/provider.dart';

import '../presentation/screens/main_menu_page.dart';

GoRouter router = GoRouter(
  initialLocation: NamedRoutes.home.routeName,
  routes: [
    GoRoute(path: NamedRoutes.welcome.routeName, builder: (_, state) => const WelcomeScreen(),),
    StatefulShellRoute.indexedStack(
      branches: [
        StatefulShellBranch(routes: [
          GoRoute(path: NamedRoutes.cart.routeName, builder: (_, state) => Center(child: Text("Cart"),)),
        ]),
        StatefulShellBranch(routes: [
          GoRoute(path: NamedRoutes.search.routeName, builder: (_, state) => Center(child: Text("Search"),)),
        ]),
        StatefulShellBranch(routes: [
          GoRoute(path: NamedRoutes.home.routeName, builder: (_, state) => ChangeNotifierProvider(create: (_)=> HomeProvider(), child:  HomeScreen(),)),
        ]),
        StatefulShellBranch(routes: [
          GoRoute(path: NamedRoutes.cart.routeName, builder: (_, state) => Center(child: Text("Cart"),)),
        ]),
        StatefulShellBranch(routes: [
          GoRoute(path: NamedRoutes.notification.routeName, builder: (_, state) => Center(child: Text("Notifications"),)),
        ]),
      ],
      builder: (ctx, state, navigationShell) => MainMenuPage(navigationShell: navigationShell),
    ),
    GoRoute(
      path: NamedRoutes.order.routeName,
      builder: (_, state) => Scaffold(
        body: Center(child: Text('Order #${state.pathParameters['orderId'] ?? ''}'),),
      ),
    ),
  ],
);

enum NamedRoutes {
  welcome('/welcome'),
  cart('/cart'),
  search('/search'),
  home('/home'),
  calendar('/calendar'),
  notification('/notifications'),
  order('/order/:orderId');

  final String routeName;
  const NamedRoutes(this.routeName);

  String pathFor(String orderId) => '/order/$orderId';
}
