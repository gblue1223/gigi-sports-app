import 'package:flutter/material.dart';

import 'pages/booking_page.dart';
import 'pages/home_page.dart';
import 'pages/profile_page.dart';
import 'pages/qr_scanner_page.dart';

class MainShell extends StatefulWidget {
  const MainShell({super.key});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    final pages = [
      const HomePage(),
      const ProfilePage(),
      const BookingPage(),
      const QrScannerPage(),
    ];

    return Scaffold(
      body: pages[index],
      bottomNavigationBar: DecoratedBox(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
          boxShadow: [
            BoxShadow(
                color: Color(0x1414140A),
                blurRadius: 28,
                offset: Offset(0, -8)),
          ],
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
          child: NavigationBar(
            selectedIndex: index,
            onDestinationSelected: (value) => setState(() => index = value),
            destinations: const [
              NavigationDestination(
                icon: Icon(Icons.home_outlined),
                selectedIcon: Icon(Icons.home_rounded),
                label: '홈',
              ),
              NavigationDestination(
                icon: Icon(Icons.person_outline_rounded),
                selectedIcon: Icon(Icons.person_rounded),
                label: '프로필',
              ),
              NavigationDestination(
                icon: Icon(Icons.calendar_month_outlined),
                selectedIcon: Icon(Icons.calendar_month_rounded),
                label: '예약',
              ),
              NavigationDestination(
                icon: Icon(Icons.qr_code_scanner_rounded),
                selectedIcon: Icon(Icons.qr_code_2_rounded),
                label: 'QR',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
