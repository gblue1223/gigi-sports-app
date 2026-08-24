import 'package:flutter/material.dart';

import '../app_theme.dart';
import '../widgets/common_widgets.dart';

class TournamentListPage extends StatefulWidget {
  const TournamentListPage({super.key});

  @override
  State<TournamentListPage> createState() => _TournamentListPageState();
}

class _TournamentListPageState extends State<TournamentListPage>
    with SingleTickerProviderStateMixin {
  late final TabController controller;

  @override
  void initState() {
    super.initState();
    controller = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('파크골프 대회',
            style: TextStyle(
                fontWeight: FontWeight.w900, color: AppColors.forestDark)),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      backgroundColor: AppColors.surface,
      body: Column(
        children: [
          Container(
            color: Colors.white,
            child: TabBar(
              controller: controller,
              labelColor: AppColors.primaryDark,
              unselectedLabelColor: AppColors.muted,
              indicatorColor: AppColors.primary,
              indicatorWeight: 3.0,
              labelStyle:
                  const TextStyle(fontSize: 16, fontWeight: FontWeight.w900),
              tabs: const [
                Tab(text: '접수중인 대회'),
                Tab(text: '진행중'),
                Tab(text: '종료된 대회'),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: controller,
              children: [
                _buildOpenTournaments(context),
                _buildOngoingTournaments(),
                _buildCompletedTournaments(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOpenTournaments(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        TournamentCard(
          title: '2026 GIGI Sports 전국 스크린파크골프 챔피언십',
          date: '2026. 08. 15 ~ 08. 31',
          prize: '총상금 500만원',
          location: '전국 GIGI Sports 매장',
          status: '접수중',
          statusColor: AppColors.primary,
          onApply: () =>
              _applyTournament(context, '2026 GIGI Sports 전국 스크린파크골프 챔피언십'),
        ),
        const SizedBox(height: 16),
        TournamentCard(
          title: '제3회 서울 성동구 파크골프 클럽 마스터즈',
          date: '2026. 09. 01 ~ 09. 10',
          prize: '최신 파크골프채 & 상패',
          location: 'GIGI Sports 성수점',
          status: 'D-5 접수',
          statusColor: const Color(0xFFD97706),
          onApply: () => _applyTournament(context, '제3회 서울 성동구 파크골프 클럽 마스터즈'),
        ),
      ],
    );
  }

  Widget _buildOngoingTournaments() {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: const [
        TournamentCard(
          title: '8월 썸머 챌린지 파크골프 리그',
          date: '2026. 08. 01 ~ 08. 10',
          prize: '상금 100만원 및 포인트',
          location: '온라인 스크린 리그',
          status: '진행중',
          statusColor: Color(0xFF2563EB),
          showApplyButton: false,
        ),
      ],
    );
  }

  Widget _buildCompletedTournaments() {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: const [
        TournamentCard(
          title: '2026 상반기 전국 왕중왕전',
          date: '2026. 06. 01 ~ 06. 20',
          prize: '우승자: GIGI Sports (70타)',
          location: 'GIGI Sports 세종 산울점',
          status: '종료',
          statusColor: AppColors.muted,
          showApplyButton: false,
        ),
      ],
    );
  }

  void _applyTournament(BuildContext context, String title) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: const BoxDecoration(
                  color: AppColors.mintSoft, shape: BoxShape.circle),
              child: const Icon(Icons.emoji_events,
                  color: AppColors.primary, size: 28),
            ),
            const SizedBox(width: 12),
            const Text('대회 참가 신청',
                style: TextStyle(
                    fontWeight: FontWeight.w900, color: AppColors.forestDark)),
          ],
        ),
        content: Text(
            '$title 대회 참가 신청을 진행하시겠습니까?\n\n참가비: 10,000원\n참가 신청 시 등록된 P-핸디 정보가 제출됩니다.',
            style: const TextStyle(
                fontSize: 15, color: AppColors.ink, height: 1.5)),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(ctx),
              child:
                  const Text('취소', style: TextStyle(color: AppColors.muted))),
          FilledButton(
            onPressed: () {
              Navigator.pop(ctx);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('대회 참가 신청이 완료되었습니다!')),
              );
            },
            style: FilledButton.styleFrom(backgroundColor: AppColors.primary),
            child: const Text('신청하기',
                style: TextStyle(fontWeight: FontWeight.w900)),
          ),
        ],
      ),
    );
  }
}

class TournamentCard extends StatelessWidget {
  const TournamentCard({
    required this.title,
    required this.date,
    required this.prize,
    required this.location,
    required this.status,
    required this.statusColor,
    this.onApply,
    this.showApplyButton = true,
    super.key,
  });

  final String title;
  final String date;
  final String prize;
  final String location;
  final String status;
  final Color statusColor;
  final VoidCallback? onApply;
  final bool showApplyButton;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: statusColor.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  status,
                  style: TextStyle(
                      color: statusColor,
                      fontSize: 13,
                      fontWeight: FontWeight.w900),
                ),
              ),
              const Spacer(),
              const Icon(Icons.emoji_events_outlined,
                  color: Color(0xFFF59E0B), size: 22),
            ],
          ),
          const SizedBox(height: 12),
          Text(title,
              style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w900,
                  color: AppColors.forestDark,
                  letterSpacing: -0.3)),
          const SizedBox(height: 10),
          Row(
            children: [
              const Icon(Icons.calendar_today_outlined,
                  size: 16, color: AppColors.muted),
              const SizedBox(width: 8),
              Text(date,
                  style: const TextStyle(
                      fontSize: 14,
                      color: AppColors.muted,
                      fontWeight: FontWeight.w600)),
            ],
          ),
          const SizedBox(height: 6),
          Row(
            children: [
              const Icon(Icons.place_outlined,
                  size: 16, color: AppColors.muted),
              const SizedBox(width: 8),
              Text(location,
                  style: const TextStyle(
                      fontSize: 14,
                      color: AppColors.muted,
                      fontWeight: FontWeight.w600)),
            ],
          ),
          const SizedBox(height: 6),
          Row(
            children: [
              const Icon(Icons.card_giftcard,
                  size: 16, color: AppColors.primary),
              const SizedBox(width: 8),
              Text(prize,
                  style: const TextStyle(
                      fontSize: 14,
                      color: AppColors.primaryDark,
                      fontWeight: FontWeight.w800)),
            ],
          ),
          if (showApplyButton) ...[
            const SizedBox(height: 14),
            const Divider(height: 1, color: AppColors.line),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: onApply,
                style: FilledButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
                child: const Text('대회 참가 신청',
                    style: TextStyle(fontWeight: FontWeight.w900)),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
