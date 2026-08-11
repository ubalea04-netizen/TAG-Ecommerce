import 'package:flutter/material.dart';

import 'screens/admin_panel_screen.dart';
import 'screens/auction_screen.dart';
import 'screens/customer_home_screen.dart';
import 'screens/home_screen.dart';
import 'screens/seller_panel_screen.dart';

class AppRouter {
  static const String home = '/';
  static const String sellerPanel = '/seller';
  static const String customerHome = '/customer';
  static const String auction = '/auction';
  static const String adminPanel = '/admin';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case home:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case sellerPanel:
        return MaterialPageRoute(builder: (_) => const SellerPanelScreen());
      case customerHome:
        return MaterialPageRoute(builder: (_) => const CustomerHomeScreen());
      case auction:
        return MaterialPageRoute(builder: (_) => const AuctionScreen());
      case adminPanel:
        return MaterialPageRoute(builder: (_) => const AdminPanelScreen());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            appBar: AppBar(title: const Text('Page not found')),
            body: const Center(child: Text('No route defined for this page.')),
          ),
        );
    }
  }
}
