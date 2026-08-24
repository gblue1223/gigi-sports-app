import 'package:flutter/material.dart';

import 'app_theme.dart';
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
    const pages = [
      HomePage(),
      ProfilePage(),
      BookingPage(),
      QrScannerPage(),
    ];

    return Scaffold(
      body: IndexedStack(index: index, children: pages),
      bottomNavigationBar: LayoutBuilder(
        builder: (context, constraints) {
          final isWide = constraints.maxWidth >= 760;
          final radius = BorderRadius.circular(isWide ? 22 : 20);

          return ColoredBox(
            color: AppColors.surface,
            child: SafeArea(
              top: false,
              child: Padding(
                padding: EdgeInsets.fromLTRB(
                    isWide ? 16 : 0, 6, isWide ? 16 : 0, isWide ? 10 : 0),
                child: Center(
                  heightFactor: 1,
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                        maxWidth: isWide ? 520 : double.infinity),
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: radius,
                        border: Border.all(color: AppColors.line),
                        boxShadow: const [
                          BoxShadow(
                              color: Color(0x1214140A),
                              blurRadius: 22,
                              offset: Offset(0, -5)),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: radius,
                        child: NavigationBar(
                          selectedIndex: index,
                          onDestinationSelected: (value) =>
                              setState(() => index = value),
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
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
