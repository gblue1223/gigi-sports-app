import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../app_theme.dart';
import '../main_shell.dart';
import '../widgets/common_widgets.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.cream,
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isWide = constraints.maxWidth >= 760;
          return isWide
              ? _DesktopLogin(
                  viewportHeight: constraints.maxHeight,
                  onEnter: () => _enter(context),
                )
              : _MobileLogin(onEnter: () => _enter(context));
        },
      ),
    );
  }

  void _enter(BuildContext context) {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => const MainShell()),
    );
  }
}

class _DesktopLogin extends StatelessWidget {
  const _DesktopLogin({required this.viewportHeight, required this.onEnter});

  final double viewportHeight;
  final VoidCallback onEnter;

  @override
  Widget build(BuildContext context) {
    final shellHeight = math.max(620.0, math.min(672.0, viewportHeight - 48));

    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: ConstrainedBox(
          constraints: BoxConstraints(
              minHeight: math.max(shellHeight, viewportHeight - 48)),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 960),
              child: Container(
                height: shellHeight,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(32),
                  border: Border.all(color: Colors.white),
                  boxShadow: const [
                    BoxShadow(
                        color: Color(0x1F14140A),
                        blurRadius: 45,
                        offset: Offset(0, 20)),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(31),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Expanded(flex: 54, child: _LoginArtwork()),
                      Expanded(
                        flex: 46,
                        child: SingleChildScrollView(
                          padding: const EdgeInsets.fromLTRB(40, 36, 40, 32),
                          child: _AuthForm(onEnter: onEnter, showBrand: true),
                        ),
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
  }
}

class _MobileLogin extends StatelessWidget {
  const _MobileLogin({required this.onEnter});

  final VoidCallback onEnter;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 72,
              child: Center(child: LogoHeader(compact: true)),
            ),
            Stack(
              children: [
                const SizedBox(
                  width: double.infinity,
                  height: 260,
                  child: _LoginArtwork(mobile: true),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 236),
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.fromLTRB(24, 29, 24, 30),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(28)),
                    ),
                    child: _AuthForm(onEnter: onEnter),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _LoginArtwork extends StatelessWidget {
  const _LoginArtwork({this.mobile = false});

  final bool mobile;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: const AssetImage('assets/brand/login_hero_clean.png'),
          fit: BoxFit.cover,
          alignment:
              mobile ? const Alignment(0.35, 0) : const Alignment(0.62, 0),
        ),
      ),
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: mobile
                ? const [Color(0x0D061009), Color(0x33061009)]
                : const [Color(0x00061009), Color(0x52061009)],
          ),
        ),
      ),
    );
  }
}

class _AuthForm extends StatelessWidget {
  const _AuthForm({required this.onEnter, this.showBrand = false});

  final VoidCallback onEnter;
  final bool showBrand;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (showBrand) ...[
          const Align(
              alignment: Alignment.centerLeft,
              child: LogoHeader(compact: true)),
          const SizedBox(height: 44),
        ],
        const Text(
          'WELCOME',
          style: TextStyle(
            fontSize: 10.5,
            fontWeight: FontWeight.w800,
            letterSpacing: 1.8,
            color: AppColors.primaryDark,
          ),
        ),
        const SizedBox(height: 9),
        const Text(
          '라운드를 시작해볼까요?',
          style: TextStyle(
            fontSize: 24,
            height: 1.22,
            fontWeight: FontWeight.w800,
            letterSpacing: -0.7,
            color: AppColors.forestDark,
          ),
        ),
        const SizedBox(height: 7),
        const Text(
          '사용 중인 계정으로 간편하게 연결하세요.',
          style: TextStyle(fontSize: 13.5, color: AppColors.muted),
        ),
        const SizedBox(height: 25),
        SocialButton(
          label: '카카오로 계속하기',
          foreground: const Color(0xFF191600),
          background: const Color(0xFFFEE500),
          iconText: 'K',
          onTap: onEnter,
        ),
        const SizedBox(height: 10),
        SocialButton(
          label: '네이버로 계속하기',
          foreground: Colors.white,
          background: const Color(0xFF03C75A),
          iconText: 'N',
          onTap: onEnter,
        ),
        const SizedBox(height: 19),
        const Row(
          children: [
            Expanded(child: Divider(color: AppColors.line)),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12),
              child: Text('또는',
                  style: TextStyle(fontSize: 11.5, color: AppColors.subtle)),
            ),
            Expanded(child: Divider(color: AppColors.line)),
          ],
        ),
        const SizedBox(height: 17),
        Row(
          children: [
            Expanded(
              child: SocialButton(
                label: 'Google',
                foreground: AppColors.ink,
                background: Colors.white,
                border: AppColors.line,
                iconText: 'G',
                compact: true,
                onTap: onEnter,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: SocialButton(
                label: 'Apple',
                foreground: Colors.white,
                background: AppColors.forestDark,
                icon: Icons.apple,
                compact: true,
                onTap: onEnter,
              ),
            ),
          ],
        ),
        const SizedBox(height: 15),
        OutlinedButton(
          onPressed: onEnter,
          style: OutlinedButton.styleFrom(
            minimumSize: const Size.fromHeight(50),
            backgroundColor: AppColors.mintSoft,
            foregroundColor: AppColors.primaryDark,
            side: BorderSide.none,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
          ),
          child: const Text('로그인 없이 둘러보기  →'),
        ),
        const SizedBox(height: 15),
        const Text(
          '계속 진행하면 서비스 이용약관과 개인정보 처리방침에 동의하게 됩니다.',
          textAlign: TextAlign.center,
          style:
              TextStyle(fontSize: 10.5, height: 1.5, color: AppColors.subtle),
        ),
      ],
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
    this.compact = false,
    super.key,
  });

  final String label;
  final Color foreground;
  final Color background;
  final Color? border;
  final String? iconText;
  final IconData? icon;
  final bool compact;
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
          padding: EdgeInsets.symmetric(horizontal: compact ? 14 : 17),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
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
                          fontSize: 17,
                          fontWeight: FontWeight.w900),
                    )
                  : Icon(icon, color: foreground, size: 21),
            ),
            Text(
              label,
              style: TextStyle(
                color: foreground,
                fontSize: compact ? 14 : 15,
                fontWeight: FontWeight.w800,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
