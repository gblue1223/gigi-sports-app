import 'package:flutter/material.dart';

import '../app_theme.dart';
import '../widgets/common_widgets.dart';
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
      child: ListView(
        padding: const EdgeInsets.fromLTRB(20, 14, 20, 32),
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const LogoHeader(compact: true),
              Stack(
                clipBehavior: Clip.none,
                children: [
                  IconButton.filledTonal(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (_) => const NotificationListPage()),
                      );
                    },
                    style: IconButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: AppColors.forestDark,
                      side: const BorderSide(color: AppColors.line),
                    ),
                    icon:
                        const Icon(Icons.notifications_none_rounded, size: 22),
                  ),
                  Positioned(
                    right: 6,
                    top: 5,
                    child: Container(
                      width: 8,
                      height: 8,
                      decoration: const BoxDecoration(
                          color: AppColors.primary, shape: BoxShape.circle),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 22),
          const Text(
            '오늘도 즐거운 라운드 되세요',
            style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w700,
                color: AppColors.primaryDark),
          ),
          const SizedBox(height: 5),
          const Text(
            '안녕하세요, GIGI님',
            style: TextStyle(
              fontSize: 27,
              height: 1.2,
              fontWeight: FontWeight.w800,
              letterSpacing: -0.8,
              color: AppColors.forestDark,
            ),
          ),
          const SizedBox(height: 20),
          PlayerSummaryCard(onTap: () => _openProfile(context)),
          const SizedBox(height: 34),
          const Text('빠른 메뉴', style: SectionTitle.style),
          const SizedBox(height: 14),
          Row(
            children: [
              Expanded(
                child: HomeShortcut(
                  icon: Icons.bar_chart_rounded,
                  label: '내 기록',
                  color: AppColors.primary,
                  bgColor: AppColors.mintSoft,
                  onTap: () => _openProfile(context),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: HomeShortcut(
                  icon: Icons.edit_note_rounded,
                  label: '스코어 카드',
                  color: AppColors.primaryDark,
                  bgColor: AppColors.mintSoft,
                  onTap: () => _openProfile(context),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: HomeShortcut(
                  icon: Icons.event_available_rounded,
                  label: '예약 내역',
                  color: AppColors.forestDark,
                  bgColor: AppColors.creamDark,
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (_) => const ReservationListPage()),
                    );
                  },
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: HomeShortcut(
                  icon: Icons.emoji_events_rounded,
                  label: '대회 정보',
                  color: AppColors.yellow,
                  bgColor: const Color(0xFFF8F0DD),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (_) => const TournamentListPage()),
                    );
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 34),
          _BookingBanner(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const BookingPage()),
              );
            },
          ),
          const SizedBox(height: 36),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('공지사항', style: SectionTitle.style),
              TextButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => const NoticeListPage()),
                  );
                },
                style: TextButton.styleFrom(foregroundColor: AppColors.primary),
                child: const Text('전체 보기',
                    style: TextStyle(fontWeight: FontWeight.w700)),
              ),
            ],
          ),
          const SizedBox(height: 10),
          const NoticeCard(),
        ],
      ),
    );
  }

  static void _openProfile(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => const ProfilePage(showBack: true)),
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
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(18),
      child: Container(
        height: 102,
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: AppColors.line),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: bgColor,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Icon(icon, color: color, size: 23),
            ),
            const SizedBox(height: 8),
            Text(
              label,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: AppColors.forestDark,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}

class _BookingBanner extends StatelessWidget {
  const _BookingBanner({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.mintSoft,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: const Color(0xFFD5EBDD)),
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(22),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(22),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 16, 20),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'ROUND RESERVATION',
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 1.4,
                          color: AppColors.primaryDark,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        '가까운 매장에서\n오늘의 라운드를 시작하세요',
                        style: TextStyle(
                          fontSize: 18,
                          height: 1.35,
                          fontWeight: FontWeight.w800,
                          letterSpacing: -0.4,
                          color: AppColors.forestDark,
                        ),
                      ),
                      const SizedBox(height: 14),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 14, vertical: 9),
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          borderRadius: BorderRadius.circular(999),
                        ),
                        child: const Text(
                          '매장 예약하기  →',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w800),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 76,
                  height: 92,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.7),
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: const Icon(Icons.sports_golf_rounded,
                      size: 42, color: AppColors.primaryDark),
                ),
              ],
            ),
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
    return AppCard(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => const NoticeDetailPage(
              title: '[가이드] P-핸디 & 등급 시스템 안내',
              date: '2026. 01. 20.',
              category: '가이드',
              content:
                  '안녕하세요, GIGI Sports입니다.\n\n파크골프 유저분들을 위한 P-핸디 산정 기준 및 등급 산정 방식이 새로 개정되었습니다.\n\n1. 최근 10게임 스코어 기준 평균 계산\n2. 난이도 코스 보정치 적용\n3. 등급: 브론즈 -> 실버 -> 골드 -> 다이아\n\n즐거운 파크골프 플레이되시길 바랍니다!',
            ),
          ),
        );
      },
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: AppColors.mintSoft,
              borderRadius: BorderRadius.circular(12),
            ),
            child:
                const Icon(Icons.campaign, color: AppColors.primary, size: 24),
          ),
          const SizedBox(width: 14),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '[가이드] P-핸디 & 등급 시스템 안내',
                  style: TextStyle(
                    fontSize: 16,
                    color: AppColors.forestDark,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                SizedBox(height: 4),
                Text('2026. 01. 20.',
                    style: TextStyle(fontSize: 13, color: AppColors.muted)),
              ],
            ),
          ),
          const Icon(Icons.chevron_right, color: AppColors.muted, size: 24),
        ],
      ),
    );
  }
}
