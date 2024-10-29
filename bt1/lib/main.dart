import 'package:flutter/material.dart';
import 'ui/screens/authScreens/login_screen.dart'; 
import './ui/screens/introductionScreens/intro_screen.dart'; 

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'App Manager',
      initialRoute: '/',
      routes: {
        '/': (context) => MemberIntroduction(),
        '/login': (context) => LoginPage(),
        '/managerDashboard': (context) => const Scaffold(body: Center(child: Text('Manager Dashboard'))),
      },
    );
  }
}
