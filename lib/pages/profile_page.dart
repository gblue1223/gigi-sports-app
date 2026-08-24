import 'package:flutter/material.dart';

import '../app_theme.dart';
import '../widgets/common_widgets.dart';
import 'edit_profile_page.dart';
import 'score_detail_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({this.showBack = false, super.key});

  final bool showBack;

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage>
    with SingleTickerProviderStateMixin {
  late final TabController controller;

  @override
  void initState() {
    super.initState();
    controller = TabController(length: 3, vsync: this, initialIndex: 1);
    controller.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: widget.showBack
          ? AppBar(
              title: const Text('프로필',
                  style: TextStyle(
                      fontWeight: FontWeight.w900,
                      color: AppColors.forestDark)),
              centerTitle: true,
              backgroundColor: AppColors.surface,
            )
          : null,
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 22, 20, 28),
          children: [
            PlayerSummaryCard(
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const EditProfilePage()),
              ),
            ),
            const SizedBox(height: 24),
            TabBar(
              controller: controller,
              labelColor: AppColors.forestDark,
              unselectedLabelColor: AppColors.muted,
              indicatorColor: AppColors.primary,
              indicatorWeight: 3.0,
              labelStyle:
                  const TextStyle(fontSize: 16, fontWeight: FontWeight.w900),
              tabs: const [
                Tab(text: '내 기록'),
                Tab(text: '스코어카드'),
                Tab(text: '네트워크'),
              ],
            ),
            const SizedBox(height: 20),
            if (controller.index == 0) _buildMyRecords(),
            if (controller.index == 1) _buildScorecards(),
            if (controller.index == 2) _buildNetwork(context),
          ],
        ),
      ),
    );
  }

  Widget _buildMyRecords() {
    return const Column(
      children: [
        AppCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('통산 게임 성적',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w900,
                      color: AppColors.forestDark)),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  StatColumn(label: '총 게임 수', value: '42회'),
                  StatColumn(label: '평균 타수', value: '58.4타'),
                  StatColumn(label: '베스트 스코어', value: '49타'),
                ],
              ),
              Divider(height: 24, color: AppColors.line),
              Row(
                children: [
                  Icon(Icons.workspace_premium,
                      color: Color(0xFFF59E0B), size: 20),
                  SizedBox(width: 8),
                  Text('홀인원 기록: ',
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: AppColors.forestDark)),
                  Text('3회 달성',
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w900,
                          color: AppColors.primaryDark)),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildScorecards() {
    return Column(
      children: const [
        Row(
          children: [
            SelectChip(label: '2026년'),
            SizedBox(width: 12),
            SelectChip(label: '전체 월'),
          ],
        ),
        SizedBox(height: 16),
        ScoreListItem(
            score: 72, delta: '+6', title: '양양파크골프장AB', positive: true),
        ScoreListItem(score: 49, delta: '-17', title: '위천파크골프장CD'),
        ScoreListItem(score: 53, delta: '-13', title: '위천파크골프장AB'),
      ],
    );
  }

  Widget _buildNetwork(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('골퍼 네트워크 (4명)',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w900,
                    color: AppColors.forestDark)),
            TextButton.icon(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('골퍼 친구 초대 링크가 복사되었습니다.')),
                );
              },
              icon: const Icon(Icons.person_add_alt, size: 18),
              label: const Text('친구 초대',
                  style: TextStyle(fontWeight: FontWeight.w800)),
              style: TextButton.styleFrom(foregroundColor: AppColors.primary),
            ),
          ],
        ),
        const SizedBox(height: 12),
        const FriendItem(
            name: '박프로1', rank: '다이아', handicap: '58.2', cat: true),
        const FriendItem(
            name: '김프로2', rank: '골드', handicap: '64.1', cat: false),
        const FriendItem(name: '이파크', rank: '골드', handicap: '66.8', cat: false),
        const FriendItem(name: '최골퍼', rank: '실버', handicap: '72.0', cat: true),
      ],
    );
  }
}

class FriendItem extends StatelessWidget {
  const FriendItem({
    required this.name,
    required this.rank,
    required this.handicap,
    required this.cat,
    super.key,
  });

  final String name;
  final String rank;
  final String handicap;
  final bool cat;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: AppCard(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Row(
          children: [
            AvatarBadge(cat: cat),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      RankBadge(label: rank, blue: cat),
                      const SizedBox(width: 8),
                      Text(name,
                          style: const TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w900,
                              color: AppColors.forestDark)),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text('P-핸디: $handicap타',
                      style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: AppColors.muted)),
                ],
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.chat_bubble_outline,
                  color: AppColors.primary, size: 22),
            ),
          ],
        ),
      ),
    );
  }
}

class SelectChip extends StatelessWidget {
  const SelectChip({required this.label, super.key});

  final String label;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: () {},
      style: OutlinedButton.styleFrom(
        backgroundColor: Colors.white,
        side: const BorderSide(color: AppColors.line),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(label,
              style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: AppColors.forestDark)),
          const SizedBox(width: 6),
          const Icon(Icons.arrow_drop_down, color: AppColors.primary),
        ],
      ),
    );
  }
}

class ScoreListItem extends StatelessWidget {
  const ScoreListItem({
    required this.score,
    required this.delta,
    required this.title,
    this.positive = false,
    super.key,
  });

  final int score;
  final String delta;
  final String title;
  final bool positive;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: AppCard(
        onTap: () => Navigator.of(context).push(
          MaterialPageRoute(builder: (_) => const ScoreDetailPage()),
        ),
        child: Row(
          children: [
            SizedBox(
              width: 100,
              child: Column(
                children: [
                  Text(
                    '$score',
                    style: const TextStyle(
                      fontSize: 32,
                      color: AppColors.forestDark,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 18, vertical: 5),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: positive
                            ? const [Color(0xFFF59E0B), Color(0xFFD97706)]
                            : const [Color(0xFF059669), Color(0xFF10B981)],
                      ),
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: positive
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
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w900),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 14),
            Container(width: 1, height: 86, color: AppColors.line),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('2025.05.19',
                      style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: AppColors.muted)),
                  const SizedBox(height: 2),
                  Text(
                    title,
                    style: const TextStyle(
                        fontSize: 18,
                        color: AppColors.forestDark,
                        fontWeight: FontWeight.w900,
                        letterSpacing: -0.3),
                  ),
                  const SizedBox(height: 4),
                  const Text('GIGI Sports Lab',
                      style: TextStyle(
                          fontSize: 14,
                          color: AppColors.primaryDark,
                          fontWeight: FontWeight.w600)),
                  const SizedBox(height: 6),
                  const Row(
                    children: [
                      Icon(Icons.people_alt_outlined,
                          size: 16, color: AppColors.muted),
                      SizedBox(width: 6),
                      Text('동반 플레이어 4명',
                          style: TextStyle(
                              fontSize: 13,
                              color: AppColors.muted,
                              fontWeight: FontWeight.w600)),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
