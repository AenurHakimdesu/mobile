import 'package:flutter/material.dart';
import 'splash_screen.dart';
import 'login_screen.dart';
import 'dashboard_screen.dart';
import 'payment_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Blangkis UMKM',
      initialRoute: '/',
      routes: {
        '/': (context) => SplashScreen(),
        '/login': (context) => LoginScreen(),
        '/dashboard': (context) => DashboardScreen(),
        '/payment': (context) =>
            PaymentScreen(total: 0), // Example, pass actual total
      },
    );
  }
}
