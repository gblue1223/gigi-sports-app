import 'package:flutter/material.dart';

import '../app_theme.dart';
import '../main_shell.dart';
import '../widgets/common_widgets.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        bottom: false,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            Container(
              height: 360,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/brand/login_hero_clean.png'),
                  fit: BoxFit.cover,
                  alignment: Alignment.centerRight,
                ),
              ),
              child: Stack(
                clipBehavior: Clip.hardEdge,
                children: [
                  const Positioned.fill(
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          colors: [
                            Color(0xE60A120C),
                            Color(0xA60A120C),
                            Color(0x330A120C),
                          ],
                          stops: [0, 0.55, 1],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(24, 22, 24, 34),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const LogoHeader(onDark: true),
                        const Spacer(),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 7),
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: Colors.white.withValues(alpha: 0.3)),
                            borderRadius: BorderRadius.circular(999),
                          ),
                          child: const Text(
                            'ALL-IN-ONE PARK GOLF',
                            style: TextStyle(
                              fontSize: 10,
                              color: Colors.white,
                              fontWeight: FontWeight.w800,
                              letterSpacing: 1.4,
                            ),
                          ),
                        ),
                        const SizedBox(height: 18),
                        const Text(
                          '파크골프의 모든 순간을\n한곳에서 만나보세요',
                          style: TextStyle(
                            fontSize: 30,
                            height: 1.25,
                            fontWeight: FontWeight.w800,
                            letterSpacing: -1,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 12),
                        const Text(
                          '기록부터 예약, QR 체크인까지 더 간결하게.',
                          style: TextStyle(
                              fontSize: 14,
                              color: Color(0xFFC9C7BD),
                              height: 1.45),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Transform.translate(
              offset: const Offset(0, -22),
              child: Container(
                padding: const EdgeInsets.fromLTRB(24, 28, 24, 32),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Text(
                      '간편하게 시작하기',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w800,
                        letterSpacing: -0.5,
                        color: AppColors.forestDark,
                      ),
                    ),
                    const SizedBox(height: 6),
                    const Text(
                      '사용 중인 계정으로 바로 연결할 수 있어요.',
                      style: TextStyle(fontSize: 14, color: AppColors.muted),
                    ),
                    const SizedBox(height: 22),
                    SocialButton(
                      label: '카카오로 시작하기',
                      foreground: const Color(0xFF191600),
                      background: const Color(0xFFFEE500),
                      iconText: 'K',
                      onTap: () => _enter(context),
                    ),
                    const SizedBox(height: 11),
                    SocialButton(
                      label: '네이버로 시작하기',
                      foreground: Colors.white,
                      background: const Color(0xFF03C75A),
                      iconText: 'N',
                      onTap: () => _enter(context),
                    ),
                    const SizedBox(height: 11),
                    SocialButton(
                      label: 'Google로 시작하기',
                      foreground: AppColors.ink,
                      background: Colors.white,
                      border: AppColors.line,
                      iconText: 'G',
                      onTap: () => _enter(context),
                    ),
                    const SizedBox(height: 11),
                    SocialButton(
                      label: 'Apple로 시작하기',
                      foreground: Colors.white,
                      background: AppColors.forestDark,
                      icon: Icons.apple,
                      onTap: () => _enter(context),
                    ),
                    const SizedBox(height: 16),
                    TextButton(
                      onPressed: () => _enter(context),
                      child: const Text(
                        '로그인 없이 둘러보기  →',
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w800),
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      '계속 진행하면 서비스 이용약관과 개인정보 처리방침에 동의하게 됩니다.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 11, color: AppColors.subtle, height: 1.5),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _enter(BuildContext context) {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => const MainShell()),
    );
  }
}

class SocialButton extends StatelessWidget {
  const SocialButton({
    required this.label,
    required this.foreground,
    required this.background,
    required this.onTap,
    this.border,
    this.iconText,
    this.icon,
    super.key,
  });

  final String label;
  final Color foreground;
  final Color background;
  final Color? border;
  final String? iconText;
  final IconData? icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 52,
      child: OutlinedButton(
        onPressed: onTap,
        style: OutlinedButton.styleFrom(
          backgroundColor: background,
          foregroundColor: foreground,
          side: BorderSide(color: border ?? background),
          shape: const StadiumBorder(),
          elevation: 0,
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: icon == null
                  ? Text(
                      iconText ?? '',
                      style: TextStyle(
                        color: foreground,
                        fontSize: 18,
                        fontWeight: FontWeight.w900,
                      ),
                    )
                  : Icon(icon, color: foreground, size: 22),
            ),
            Text(
              label,
              style: TextStyle(
                color: foreground,
                fontSize: 16,
                fontWeight: FontWeight.w800,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
