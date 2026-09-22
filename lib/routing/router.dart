import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:logistic_tracking_ui/core/app_data.dart';
import 'package:logistic_tracking_ui/presentation/screens/home_screen.dart';
import 'package:logistic_tracking_ui/presentation/screens/order_details_screen.dart';
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
          GoRoute(path: NamedRoutes.calendar.routeName, builder: (_, state) => Center(child: Text("Calendar"),)),
        ]),
        StatefulShellBranch(routes: [
          GoRoute(path: NamedRoutes.notification.routeName, builder: (_, state) => Center(child: Text("Notifications"),)),
        ]),
      ],
      builder: (ctx, state, navigationShell) => MainMenuPage(navigationShell: navigationShell),
    ),
    GoRoute(
      path: NamedRoutes.order.routeName,
      pageBuilder: (_, state) => CustomTransitionPage(
        key: state.pageKey,
        child: OrderDetailsScreen(
          orderId: state.pathParameters['orderId'] ?? AppData.sampleOrder.orderId,
        ),
        transitionDuration: const Duration(milliseconds: 350),
        reverseTransitionDuration: const Duration(milliseconds: 280),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          final curved = CurvedAnimation(parent: animation, curve: Curves.easeOutCubic,);
          return FadeTransition(
            opacity: curved,
            child: SlideTransition(
              position: Tween<Offset>(begin: Offset(0, 0.08), end: Offset.zero).animate(curved),
              child: child,
            ),
          );
        },
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
