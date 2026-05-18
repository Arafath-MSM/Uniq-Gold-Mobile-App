import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../features/cart/presentation/pages/cart_page.dart';
import '../features/catalog/presentation/pages/catalog_page.dart';
import '../features/home/presentation/pages/home_page.dart';
import '../features/product/presentation/pages/product_details_page.dart';
import '../features/profile/presentation/pages/profile_page.dart';
import '../features/splash/presentation/pages/splash_page.dart';
import '../shared/widgets/app_bottom_nav_bar.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/',
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      name: 'splash',
      builder: (BuildContext context, GoRouterState state) {
        return const SplashPage();
      },
    ),
    ShellRoute(
      builder: (BuildContext context, GoRouterState state, Widget child) {
        return AppBottomNavScaffold(child: child);
      },
      routes: <RouteBase>[
        GoRoute(
          path: '/home',
          name: 'home',
          builder: (BuildContext context, GoRouterState state) {
            return const HomePage();
          },
        ),
        GoRoute(
          path: '/catalog',
          name: 'catalog',
          builder: (BuildContext context, GoRouterState state) {
            return const CatalogPage();
          },
        ),
        GoRoute(
          path: '/cart',
          name: 'cart',
          builder: (BuildContext context, GoRouterState state) {
            return const CartPage();
          },
        ),
        GoRoute(
          path: '/profile',
          name: 'profile',
          builder: (BuildContext context, GoRouterState state) {
            return const ProfilePage();
          },
        ),
      ],
    ),
    GoRoute(
      path: '/product/:id',
      name: 'product',
      builder: (BuildContext context, GoRouterState state) {
        final String productId = state.pathParameters['id'] ?? '';
        return ProductDetailsPage(productId: productId);
      },
    ),
  ],
);
