import 'package:flutter/material.dart';

import 'app_theme.dart';
import 'pages/login_page.dart';

void main() {
  runApp(const PiggyParkGolfApp());
}

class PiggyParkGolfApp extends StatelessWidget {
  const PiggyParkGolfApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GIGI Sports',
      debugShowCheckedModeBanner: false,
      theme: buildAppTheme(),
      home: const LoginPage(),
    );
  }
}
