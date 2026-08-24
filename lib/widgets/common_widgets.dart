import 'package:flutter/material.dart';

import '../app_theme.dart';

class AppCard extends StatelessWidget {
  const AppCard({
    required this.child,
    this.onTap,
    this.padding = const EdgeInsets.all(20),
    this.color = Colors.white,
    super.key,
  });

  final Widget child;
  final VoidCallback? onTap;
  final EdgeInsetsGeometry padding;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.line, width: 1),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0F14140A),
            blurRadius: 24,
            offset: Offset(0, 6),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(20),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(20),
          child: Padding(
            padding: padding,
            child: child,
          ),
        ),
      ),
    );
  }
}

class LogoHeader extends StatelessWidget {
  const LogoHeader({this.compact = false, this.onDark = false, super.key});

  final bool compact;
  final bool onDark;

  @override
  Widget build(BuildContext context) {
    return Text(
      'GIGI SPORTS',
      style: TextStyle(
        fontSize: compact ? 23 : 28,
        height: 1,
        letterSpacing: 0.5,
        fontWeight: FontWeight.w900,
        color: onDark ? Colors.white : AppColors.forestDark,
      ),
    );
  }
}

class AvatarBadge extends StatelessWidget {
  const AvatarBadge({this.cat = false, super.key});

  final bool cat;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 60,
      height: 60,
      decoration: BoxDecoration(
        color: AppColors.cream,
        borderRadius: BorderRadius.circular(18),
        border:
            Border.all(color: Colors.white.withValues(alpha: 0.8), width: 2),
      ),
      alignment: Alignment.center,
      child: Text(cat ? '😺' : '🐰', style: const TextStyle(fontSize: 34)),
    );
  }
}

class RankBadge extends StatelessWidget {
  const RankBadge({this.label = '골드', this.blue = false, super.key});

  final String label;
  final bool blue;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 27,
      constraints: const BoxConstraints(minWidth: 82),
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: blue ? AppColors.primaryDark : AppColors.yellow,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.workspace_premium_rounded,
              color: Colors.white, size: 14),
          const SizedBox(width: 5),
          Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w800,
              fontSize: 12,
              letterSpacing: -0.2,
            ),
          ),
        ],
      ),
    );
  }
}

class PlayerSummaryCard extends StatelessWidget {
  const PlayerSummaryCard({this.onTap, super.key});

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF1B1A14), Color(0xFF0D2417)],
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: const [
          BoxShadow(
              color: Color(0x2914140A), blurRadius: 30, offset: Offset(0, 14)),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(24),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(24),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(24),
            child: Stack(
              children: [
                Positioned(
                  right: -35,
                  top: -36,
                  child: Opacity(
                    opacity: 0.055,
                    child: Image.asset(
                      'assets/brand/gigi_character.png',
                      width: 190,
                      height: 190,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(22),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          const AvatarBadge(),
                          const SizedBox(width: 14),
                          const Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'GIGI Sports',
                                  style: TextStyle(
                                    fontSize: 21,
                                    fontWeight: FontWeight.w800,
                                    color: Colors.white,
                                    letterSpacing: -0.5,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                                SizedBox(height: 4),
                                Text(
                                  '스크린파크 골퍼',
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xFFB9B6A8),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: 34,
                            height: 34,
                            decoration: BoxDecoration(
                                color: Color(0x1FFFFFFF),
                                shape: BoxShape.circle),
                            child: Icon(Icons.arrow_forward_rounded,
                                color: Colors.white, size: 18),
                          ),
                        ],
                      ),
                      const SizedBox(height: 22),
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.07),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                              color: Colors.white.withValues(alpha: 0.08)),
                        ),
                        child: const Row(
                          children: [
                            Expanded(
                                child: _DarkStat(
                                    label: '등급', value: 'GOLD', gold: true)),
                            _StatDivider(),
                            Expanded(
                                child: _DarkStat(label: 'P-핸디', value: '61.9')),
                            _StatDivider(),
                            Expanded(
                                child:
                                    _DarkStat(label: '전국 랭킹', value: '1,248위')),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _DarkStat extends StatelessWidget {
  const _DarkStat(
      {required this.label, required this.value, this.gold = false});

  final String label;
  final String value;
  final bool gold;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          label,
          style: const TextStyle(
              fontSize: 11,
              color: Color(0xFFB9B6A8),
              fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 6),
        Text(
          value,
          style: TextStyle(
            fontSize: 16,
            color: gold ? const Color(0xFFE0BE6B) : Colors.white,
            fontWeight: FontWeight.w800,
            letterSpacing: gold ? 0.7 : -0.2,
          ),
        ),
      ],
    );
  }
}

class _StatDivider extends StatelessWidget {
  const _StatDivider();

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 1, height: 32, color: Colors.white.withValues(alpha: 0.12));
  }
}

class StatColumn extends StatelessWidget {
  const StatColumn({required this.label, this.value, this.child, super.key});

  final String label;
  final String? value;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          label,
          style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: AppColors.muted),
        ),
        const SizedBox(height: 8),
        child ??
            Text(
              value ?? '',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w900,
                color: AppColors.forestDark,
              ),
            ),
      ],
    );
  }
}

class ScorePill extends StatelessWidget {
  const ScorePill({required this.score, required this.delta, super.key});

  final String score;
  final String delta;

  @override
  Widget build(BuildContext context) {
    final isPositive = delta.startsWith('+');
    return Column(
      children: [
        Text(
          score,
          style: const TextStyle(
            fontSize: 28,
            color: AppColors.forestDark,
            fontWeight: FontWeight.w900,
          ),
        ),
        const SizedBox(height: 4),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: isPositive
                  ? const [Color(0xFFF59E0B), Color(0xFFD97706)]
                  : const [Color(0xFF059669), Color(0xFF10B981)],
            ),
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: isPositive
                    ? const Color(0x29F59E0B)
                    : const Color(0x29059669),
                blurRadius: 6,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Text(
            delta,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.white,
              fontWeight: FontWeight.w900,
            ),
          ),
        ),
      ],
    );
  }
}
