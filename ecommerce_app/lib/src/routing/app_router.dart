import 'package:ecommerce_app/src/features/account/account_screen.dart';
import 'package:ecommerce_app/src/features/checkout/checkout_screen.dart';
import 'package:ecommerce_app/src/features/leave_review_page/leave_review_screen.dart';
import 'package:ecommerce_app/src/features/not_found/not_found_screen.dart';
import 'package:ecommerce_app/src/features/orders_list/orders_list_screen.dart';
import 'package:ecommerce_app/src/features/product_page/product_screen.dart';
import 'package:ecommerce_app/src/features/shopping_cart/shopping_cart_screen.dart';
import 'package:ecommerce_app/src/features/sign_in/email_password_sign_in_screen.dart';
import 'package:ecommerce_app/src/features/sign_in/email_password_sign_in_state.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../features/products_list/products_list_screen.dart';

enum AppRoute {
  home,
  product,
  leavereview,
  cart,
  checkout,
  orders,
  account,
  signin,
}

final goRouter = GoRouter(
  debugLogDiagnostics: true,
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      name: AppRoute.home.name,
      builder: (context, state) => const ProductsListScreen(),
      routes: [
        GoRoute(
            path: 'product/:id',
            name: AppRoute.product.name,
            builder: (context, state) {
              final productId = state.pathParameters['id']!;
              return ProductScreen(productId: productId);
            },
            routes: [
              GoRoute(
                  path: 'review',
                  name: AppRoute.leavereview.name,
                  pageBuilder: (context, state) {
                    final productId = state.pathParameters['id']!;
                    return MaterialPage(
                      key: state.pageKey,
                      child: LeaveReviewScreen(productId: productId),
                      fullscreenDialog: true,
                    );
                  }),
            ]),
        GoRoute(
            path: 'cart',
            name: AppRoute.cart.name,
            pageBuilder: (context, state) => MaterialPage(
                  key: state.pageKey,
                  child: const ShoppingCartScreen(),
                  fullscreenDialog: true,
                ),
            routes: [
              GoRoute(
                path: 'checkout',
                name: AppRoute.checkout.name,
                pageBuilder: (context, state) => MaterialPage(
                  key: state.pageKey,
                  child: const CheckoutScreen(),
                  fullscreenDialog: true,
                ),
              ),
            ]),
        GoRoute(
          path: 'orders',
          name: AppRoute.orders.name,
          pageBuilder: (context, state) => MaterialPage(
            key: state.pageKey,
            child: const OrdersListScreen(),
            fullscreenDialog: true,
          ),
        ),
        GoRoute(
          path: 'account',
          name: AppRoute.account.name,
          pageBuilder: (context, state) => MaterialPage(
            key: state.pageKey,
            child: const AccountScreen(),
            fullscreenDialog: true,
          ),
        ),
        GoRoute(
          path: 'signin',
          name: AppRoute.signin.name,
          pageBuilder: (context, state) => MaterialPage(
            key: state.pageKey,
            child: const EmailPasswordSignInScreen(
              formType: EmailPasswordSignInFormType.signIn,
            ),
            fullscreenDialog: true,
          ),
        ),
      ],
    ),
  ],
  errorBuilder: (context, state) => const NotFoundScreen(),
);
