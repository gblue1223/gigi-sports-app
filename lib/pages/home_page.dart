import 'package:flutter/material.dart';

import '../app_theme.dart';
import 'booking_page.dart';
import 'notice_detail_page.dart';
import 'notice_list_page.dart';
import 'notification_list_page.dart';
import 'profile_page.dart';
import 'reservation_list_page.dart';
import 'tournament_list_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: LayoutBuilder(
        builder: (context, constraints) {
          final isWide = constraints.maxWidth >= 760;
          final horizontalPadding = isWide ? 28.0 : 18.0;

          final heroColumn = Column(
            children: [
              _HomeHeroCard(onTap: () => _openProfile(context), isWide: isWide),
              const SizedBox(height: 12),
              _ReservationStrip(
                onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const BookingPage()),
                ),
              ),
            ],
          );

          final sideColumn = Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const _SectionHeader(title: '바로가기'),
              const SizedBox(height: 12),
              _QuickActions(
                onRecord: () => _openProfile(context),
                onScore: () => _openProfile(context),
                onReservations: () => Navigator.of(context).push(
                  MaterialPageRoute(
                      builder: (_) => const ReservationListPage()),
                ),
                onTournaments: () => Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const TournamentListPage()),
                ),
              ),
              const SizedBox(height: 26),
              _SectionHeader(
                title: '공지사항',
                actionLabel: '전체 보기',
                onAction: () => Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const NoticeListPage()),
                ),
              ),
              const SizedBox(height: 8),
              const NoticeCard(),
            ],
          );

          return ListView(
            padding: EdgeInsets.fromLTRB(
                horizontalPadding, 8, horizontalPadding, 30),
            children: [
              Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 920),
                  child: Column(
                    children: [
                      _DashboardTopBar(
                        isWide: isWide,
                        onNotifications: () => Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (_) => const NotificationListPage()),
                        ),
                      ),
                      SizedBox(height: isWide ? 22 : 16),
                      if (isWide)
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(flex: 6, child: heroColumn),
                            const SizedBox(width: 22),
                            Expanded(flex: 4, child: sideColumn),
                          ],
                        )
                      else ...[
                        heroColumn,
                        const SizedBox(height: 28),
                        sideColumn,
                      ],
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  static void _openProfile(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => const ProfilePage(showBack: true)),
    );
  }
}

class _DashboardTopBar extends StatelessWidget {
  const _DashboardTopBar({required this.isWide, required this.onNotifications});

  final bool isWide;
  final VoidCallback onNotifications;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: isWide ? 64 : 54,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Text.rich(
            TextSpan(
              children: [
                const TextSpan(
                    text: 'GIGI',
                    style: TextStyle(fontWeight: FontWeight.w900)),
                TextSpan(
                  text: ' SPORTS',
                  style: TextStyle(
                      fontWeight: isWide ? FontWeight.w600 : FontWeight.w700),
                ),
              ],
            ),
            style: TextStyle(
              fontSize: isWide ? 23 : 21,
              letterSpacing: 1.2,
              color: AppColors.forestDark,
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                IconButton(
                  onPressed: onNotifications,
                  style: IconButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: AppColors.forestDark,
                    side: const BorderSide(color: AppColors.line),
                  ),
                  icon: const Icon(Icons.notifications_none_rounded, size: 21),
                ),
                Positioned(
                  right: 5,
                  top: 4,
                  child: Container(
                    width: 8,
                    height: 8,
                    decoration: const BoxDecoration(
                        color: AppColors.primary, shape: BoxShape.circle),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _HomeHeroCard extends StatelessWidget {
  const _HomeHeroCard({required this.onTap, required this.isWide});

  final VoidCallback onTap;
  final bool isWide;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: isWide ? 252 : 230,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF1B1A14), Color(0xFF0D2417)],
        ),
        borderRadius: BorderRadius.circular(26),
        boxShadow: const [
          BoxShadow(
              color: Color(0x2414140A), blurRadius: 30, offset: Offset(0, 14)),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(26),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(26),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(26),
            child: Stack(
              children: [
                Positioned(
                  right: -84,
                  top: -98,
                  child: Container(
                    width: 250,
                    height: 250,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                          color: Colors.white.withValues(alpha: 0.055),
                          width: 34),
                    ),
                  ),
                ),
                Positioned(
                  right: 20,
                  top: 18,
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
                    decoration: BoxDecoration(
                      color: const Color(0xFF5B491F),
                      borderRadius: BorderRadius.circular(999),
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.workspace_premium_rounded,
                            color: Color(0xFFE0BE6B), size: 15),
                        SizedBox(width: 5),
                        Text(
                          'GOLD',
                          style: TextStyle(
                            color: Color(0xFFF1D88F),
                            fontSize: 11,
                            fontWeight: FontWeight.w800,
                            letterSpacing: 0.6,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(
                      isWide ? 26 : 22, 22, isWide ? 26 : 22, 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'TODAY’S ROUND',
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 1.5,
                          color: Color(0xFF8FE0B4),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'GIGI님,\n좋은 라운드 준비되셨나요?',
                        style: TextStyle(
                          fontSize: isWide ? 28 : 25,
                          height: 1.25,
                          fontWeight: FontWeight.w800,
                          letterSpacing: -0.8,
                          color: Colors.white,
                        ),
                      ),
                      const Spacer(),
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.07),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                              color: Colors.white.withValues(alpha: 0.08)),
                        ),
                        child: const Row(
                          children: [
                            Expanded(
                                child: _HeroStat(label: 'P-핸디', value: '61.9')),
                            _HeroDivider(),
                            Expanded(
                                child:
                                    _HeroStat(label: '전국 랭킹', value: '1,248위')),
                            _HeroDivider(),
                            Expanded(
                                child:
                                    _HeroStat(label: '최근 평균', value: '58.4타')),
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

class _HeroStat extends StatelessWidget {
  const _HeroStat({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(label,
            style: const TextStyle(fontSize: 10.5, color: Color(0xFFB9B6A8))),
        const SizedBox(height: 5),
        Text(
          value,
          style: const TextStyle(
              fontSize: 15, fontWeight: FontWeight.w800, color: Colors.white),
        ),
      ],
    );
  }
}

class _HeroDivider extends StatelessWidget {
  const _HeroDivider();

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 1, height: 30, color: Colors.white.withValues(alpha: 0.12));
  }
}

class _ReservationStrip extends StatelessWidget {
  const _ReservationStrip({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 92,
      decoration: BoxDecoration(
        color: AppColors.mintSoft,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFD5EBDD)),
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(20),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(20),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 17),
            child: Row(
              children: [
                Container(
                  width: 46,
                  height: 46,
                  decoration: const BoxDecoration(
                      color: Colors.white, shape: BoxShape.circle),
                  child: const Icon(Icons.sports_golf_rounded,
                      color: AppColors.primaryDark, size: 24),
                ),
                const SizedBox(width: 14),
                const Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '라운드 예약',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w800,
                            color: AppColors.forestDark),
                      ),
                      SizedBox(height: 4),
                      Text('가까운 매장과 가능한 시간을 찾아보세요',
                          style:
                              TextStyle(fontSize: 12, color: AppColors.muted)),
                    ],
                  ),
                ),
                Container(
                  width: 36,
                  height: 36,
                  decoration: const BoxDecoration(
                      color: AppColors.primary, shape: BoxShape.circle),
                  child: const Icon(Icons.arrow_forward_rounded,
                      color: Colors.white, size: 18),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({required this.title, this.actionLabel, this.onAction});

  final String title;
  final String? actionLabel;
  final VoidCallback? onAction;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 30,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 19,
              fontWeight: FontWeight.w800,
              letterSpacing: -0.4,
              color: AppColors.forestDark,
            ),
          ),
          if (actionLabel != null)
            TextButton(
              onPressed: onAction,
              style: TextButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                minimumSize: const Size(0, 30),
              ),
              child: Text(actionLabel!,
                  style: const TextStyle(
                      fontSize: 12, fontWeight: FontWeight.w700)),
            ),
        ],
      ),
    );
  }
}

class _QuickActions extends StatelessWidget {
  const _QuickActions({
    required this.onRecord,
    required this.onScore,
    required this.onReservations,
    required this.onTournaments,
  });

  final VoidCallback onRecord;
  final VoidCallback onScore;
  final VoidCallback onReservations;
  final VoidCallback onTournaments;

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      childAspectRatio: 1.82,
      children: [
        HomeShortcut(
          icon: Icons.bar_chart_rounded,
          label: '내 기록',
          color: AppColors.primary,
          bgColor: AppColors.mintSoft,
          onTap: onRecord,
        ),
        HomeShortcut(
          icon: Icons.edit_note_rounded,
          label: '스코어 카드',
          color: AppColors.primaryDark,
          bgColor: AppColors.mintSoft,
          onTap: onScore,
        ),
        HomeShortcut(
          icon: Icons.event_available_rounded,
          label: '예약 내역',
          color: AppColors.forestDark,
          bgColor: AppColors.creamDark,
          onTap: onReservations,
        ),
        HomeShortcut(
          icon: Icons.emoji_events_rounded,
          label: '대회 정보',
          color: AppColors.yellow,
          bgColor: const Color(0xFFF8F0DD),
          onTap: onTournaments,
        ),
      ],
    );
  }
}

class HomeShortcut extends StatelessWidget {
  const HomeShortcut({
    required this.icon,
    required this.label,
    required this.color,
    required this.bgColor,
    required this.onTap,
    super.key,
  });

  final IconData icon;
  final String label;
  final Color color;
  final Color bgColor;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(18),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(18),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 13),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: AppColors.line),
          ),
          child: Row(
            children: [
              Container(
                width: 38,
                height: 38,
                decoration: BoxDecoration(
                    color: bgColor, borderRadius: BorderRadius.circular(12)),
                child: Icon(icon, color: color, size: 20),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  label,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 12.5,
                    height: 1.25,
                    fontWeight: FontWeight.w700,
                    color: AppColors.forestDark,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class NoticeCard extends StatelessWidget {
  const NoticeCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(18),
      child: InkWell(
        onTap: () => Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => const NoticeDetailPage(
              title: '[가이드] P-핸디 & 등급 시스템 안내',
              date: '2026. 01. 20.',
              category: '가이드',
              content:
                  '안녕하세요, GIGI Sports입니다.\n\n파크골프 유저분들을 위한 P-핸디 산정 기준 및 등급 산정 방식이 새로 개정되었습니다.\n\n1. 최근 10게임 스코어 기준 평균 계산\n2. 난이도 코스 보정치 적용\n3. 등급: 브론즈 -> 실버 -> 골드 -> 다이아\n\n즐거운 파크골프 플레이되시길 바랍니다!',
            ),
          ),
        ),
        borderRadius: BorderRadius.circular(18),
        child: Container(
          height: 90,
          padding: const EdgeInsets.symmetric(horizontal: 15),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: AppColors.line),
          ),
          child: Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                    color: AppColors.mintSoft,
                    borderRadius: BorderRadius.circular(12)),
                child: const Icon(Icons.campaign_outlined,
                    color: AppColors.primary, size: 21),
              ),
              const SizedBox(width: 12),
              const Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'P-핸디 & 등급 시스템 안내',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 13.5,
                        height: 1.3,
                        fontWeight: FontWeight.w800,
                        color: AppColors.forestDark,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text('2026. 01. 20.',
                        style:
                            TextStyle(fontSize: 11.5, color: AppColors.subtle)),
                  ],
                ),
              ),
              const Icon(Icons.chevron_right_rounded,
                  size: 20, color: AppColors.muted),
            ],
          ),
        ),
      ),
    );
  }
}
