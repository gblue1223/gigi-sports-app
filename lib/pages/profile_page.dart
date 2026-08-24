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

class _ProfilePageState extends State<ProfilePage> {
  int selectedSection = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final isWide = constraints.maxWidth >= 760;
            final horizontal = isWide ? 28.0 : 18.0;

            return SingleChildScrollView(
              padding: EdgeInsets.fromLTRB(horizontal, 12, horizontal, 32),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 920),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _ProfileTopBar(showBack: widget.showBack),
                      SizedBox(height: isWide ? 24 : 18),
                      if (isWide)
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 300,
                              child: _ProfileIdentityCard(
                                onEdit: _openProfileEditor,
                              ),
                            ),
                            const SizedBox(width: 22),
                            Expanded(child: _buildContentPanel(isWide: true)),
                          ],
                        )
                      else ...[
                        _ProfileIdentityCard(onEdit: _openProfileEditor),
                        const SizedBox(height: 16),
                        _buildContentPanel(isWide: false),
                      ],
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  void _openProfileEditor() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => const EditProfilePage()),
    );
  }

  Widget _buildContentPanel({required bool isWide}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _ProfileSegments(
          selectedIndex: selectedSection,
          onChanged: (value) => setState(() => selectedSection = value),
        ),
        const SizedBox(height: 18),
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 180),
          child: switch (selectedSection) {
            0 =>
              _RecordsSection(key: const ValueKey('records'), isWide: isWide),
            1 => const _ScorecardsSection(key: ValueKey('scores')),
            _ => _NetworkSection(
                key: const ValueKey('network'),
                isWide: isWide,
              ),
          },
        ),
      ],
    );
  }
}

class _ProfileTopBar extends StatelessWidget {
  const _ProfileTopBar({required this.showBack});

  final bool showBack;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      child: Stack(
        alignment: Alignment.center,
        children: [
          const Text(
            '프로필',
            style: TextStyle(
              color: AppColors.forestDark,
              fontSize: 21,
              fontWeight: FontWeight.w900,
              letterSpacing: -0.5,
            ),
          ),
          if (showBack)
            Align(
              alignment: Alignment.centerLeft,
              child: IconButton(
                tooltip: '뒤로',
                onPressed: () => Navigator.of(context).maybePop(),
                icon: const Icon(Icons.arrow_back_rounded),
              ),
            ),
          Align(
            alignment: Alignment.centerRight,
            child: IconButton(
              tooltip: '설정',
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('설정 화면을 준비하고 있습니다.')),
                );
              },
              icon: const Icon(Icons.settings_outlined),
            ),
          ),
        ],
      ),
    );
  }
}

class _ProfileIdentityCard extends StatelessWidget {
  const _ProfileIdentityCard({required this.onEdit});

  final VoidCallback onEdit;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF1B1A14), AppColors.deepGreen],
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: const [
          BoxShadow(
            color: Color(0x2415140F),
            blurRadius: 28,
            offset: Offset(0, 12),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(3),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(21),
                ),
                child: const AvatarBadge(),
              ),
              const Spacer(),
              OutlinedButton.icon(
                onPressed: onEdit,
                icon: const Icon(Icons.edit_outlined, size: 16),
                label: const Text('수정'),
                style: OutlinedButton.styleFrom(
                  minimumSize: const Size(0, 38),
                  foregroundColor: Colors.white,
                  side: BorderSide(
                    color: Colors.white.withValues(alpha: 0.24),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 13),
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          const RankBadge(label: '골드'),
          const SizedBox(height: 10),
          const Text(
            'GIGI님',
            style: TextStyle(
              color: Colors.white,
              fontSize: 26,
              fontWeight: FontWeight.w900,
              letterSpacing: -0.7,
            ),
          ),
          const SizedBox(height: 4),
          const Text(
            '꾸준히 성장하는 스크린파크 골퍼',
            style: TextStyle(
              color: Color(0xFFB9B6A8),
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 22),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 14),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.07),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
            ),
            child: const Row(
              children: [
                Expanded(child: _IdentityStat(value: '42', label: '라운드')),
                _DarkDivider(),
                Expanded(child: _IdentityStat(value: '58.4', label: '평균 타수')),
                _DarkDivider(),
                Expanded(child: _IdentityStat(value: '49', label: '베스트')),
              ],
            ),
          ),
          const SizedBox(height: 14),
          const Row(
            children: [
              Icon(Icons.trending_up_rounded,
                  color: AppColors.primary, size: 18),
              SizedBox(width: 7),
              Expanded(
                child: Text(
                  '지난달보다 평균 2.1타 좋아졌어요',
                  style: TextStyle(
                    color: Color(0xFFD6D3C8),
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _IdentityStat extends StatelessWidget {
  const _IdentityStat({required this.value, required this.label});

  final String value;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(value,
            style: const TextStyle(
                color: Colors.white,
                fontSize: 19,
                fontWeight: FontWeight.w900)),
        const SizedBox(height: 3),
        Text(label,
            style: const TextStyle(
                color: Color(0xFFAAA79C),
                fontSize: 11,
                fontWeight: FontWeight.w600)),
      ],
    );
  }
}

class _DarkDivider extends StatelessWidget {
  const _DarkDivider();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1,
      height: 30,
      color: Colors.white.withValues(alpha: 0.12),
    );
  }
}

class _ProfileSegments extends StatelessWidget {
  const _ProfileSegments({
    required this.selectedIndex,
    required this.onChanged,
  });

  final int selectedIndex;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    const labels = ['내 기록', '스코어카드', '네트워크'];
    return Container(
      height: 50,
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: AppColors.creamDark,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.line),
      ),
      child: Row(
        children: List.generate(labels.length, (index) {
          final selected = selectedIndex == index;
          return Expanded(
            child: Material(
              color: selected ? Colors.white : Colors.transparent,
              borderRadius: BorderRadius.circular(12),
              child: InkWell(
                onTap: () => onChanged(index),
                borderRadius: BorderRadius.circular(12),
                child: Center(
                  child: Text(
                    labels[index],
                    style: TextStyle(
                      color: selected ? AppColors.forestDark : AppColors.muted,
                      fontSize: 13,
                      fontWeight: selected ? FontWeight.w900 : FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}

class _RecordsSection extends StatelessWidget {
  const _RecordsSection({required this.isWide, super.key});

  final bool isWide;

  @override
  Widget build(BuildContext context) {
    const metrics = [
      _MetricData('42회', '총 게임 수', Icons.flag_outlined),
      _MetricData('58.4타', '평균 타수', Icons.analytics_outlined),
      _MetricData('49타', '베스트 스코어', Icons.emoji_events_outlined),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _SectionHeading(
          title: '통산 게임 성적',
          subtitle: '모든 라운드 기록을 기준으로 집계했어요.',
        ),
        const SizedBox(height: 14),
        if (isWide)
          Row(
            children: metrics
                .map((item) => Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(
                          right: item == metrics.last ? 0 : 10,
                        ),
                        child: _MetricCard(data: item),
                      ),
                    ))
                .toList(),
          )
        else
          Column(
            children: metrics
                .map((item) => Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: _MetricCard(data: item, horizontal: true),
                    ))
                .toList(),
          ),
        const SizedBox(height: 4),
        AppCard(
          padding: const EdgeInsets.all(18),
          child: Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: const Color(0xFFFFF4D8),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: const Icon(Icons.workspace_premium_rounded,
                    color: AppColors.yellow),
              ),
              const SizedBox(width: 14),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('홀인원 컬렉터',
                        style: TextStyle(
                            color: AppColors.forestDark,
                            fontSize: 16,
                            fontWeight: FontWeight.w900)),
                    SizedBox(height: 3),
                    Text('통산 3회 달성 · 다음 배지까지 2회',
                        style: TextStyle(
                            color: AppColors.muted,
                            fontSize: 12,
                            fontWeight: FontWeight.w600)),
                  ],
                ),
              ),
              const Icon(Icons.arrow_forward_rounded,
                  color: AppColors.subtle, size: 19),
            ],
          ),
        ),
      ],
    );
  }
}

class _MetricData {
  const _MetricData(this.value, this.label, this.icon);

  final String value;
  final String label;
  final IconData icon;
}

class _MetricCard extends StatelessWidget {
  const _MetricCard({required this.data, this.horizontal = false});

  final _MetricData data;
  final bool horizontal;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      padding: const EdgeInsets.all(16),
      child: Flex(
        direction: horizontal ? Axis.horizontal : Axis.vertical,
        crossAxisAlignment:
            horizontal ? CrossAxisAlignment.center : CrossAxisAlignment.start,
        children: [
          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              color: AppColors.mintSoft,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(data.icon, color: AppColors.primaryDark, size: 20),
          ),
          SizedBox(width: horizontal ? 14 : 0, height: horizontal ? 0 : 14),
          if (horizontal)
            Expanded(child: _MetricText(data: data))
          else
            _MetricText(data: data),
        ],
      ),
    );
  }
}

class _MetricText extends StatelessWidget {
  const _MetricText({required this.data});

  final _MetricData data;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(data.value,
            style: const TextStyle(
                color: AppColors.forestDark,
                fontSize: 22,
                fontWeight: FontWeight.w900)),
        const SizedBox(height: 2),
        Text(data.label,
            style: const TextStyle(
                color: AppColors.muted,
                fontSize: 12,
                fontWeight: FontWeight.w600)),
      ],
    );
  }
}

class _ScorecardsSection extends StatelessWidget {
  const _ScorecardsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _SectionHeading(
          title: '최근 스코어카드',
          subtitle: '라운드별 상세 기록을 확인해 보세요.',
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              _SelectChip(label: '2026년'),
              SizedBox(width: 8),
              _SelectChip(label: '전체'),
            ],
          ),
        ),
        SizedBox(height: 14),
        ScoreListItem(
          score: 72,
          delta: '+6',
          title: '양양파크골프장 AB',
          positive: true,
        ),
        ScoreListItem(score: 49, delta: '-17', title: '위천파크골프장 CD'),
        ScoreListItem(score: 53, delta: '-13', title: '위천파크골프장 AB'),
      ],
    );
  }
}

class _NetworkSection extends StatelessWidget {
  const _NetworkSection({required this.isWide, super.key});

  final bool isWide;

  @override
  Widget build(BuildContext context) {
    const friends = [
      FriendItem(name: '박프로1', rank: '다이아', handicap: '58.2', cat: true),
      FriendItem(name: '김프로2', rank: '골드', handicap: '64.1', cat: false),
      FriendItem(name: '이파크', rank: '골드', handicap: '66.8', cat: false),
      FriendItem(name: '최골퍼', rank: '실버', handicap: '72.0', cat: true),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _SectionHeading(
          title: '골퍼 네트워크',
          subtitle: '함께 라운드한 골퍼 4명',
          trailing: FilledButton.icon(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('골퍼 친구 초대 링크가 복사되었습니다.')),
              );
            },
            icon: const Icon(Icons.person_add_alt_rounded, size: 17),
            label: const Text('친구 초대'),
            style: FilledButton.styleFrom(
              minimumSize: const Size(0, 42),
              padding: const EdgeInsets.symmetric(horizontal: 14),
            ),
          ),
        ),
        const SizedBox(height: 14),
        if (isWide)
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: friends
                .map((friend) => SizedBox(width: 284, child: friend))
                .toList(),
          )
        else
          ...friends,
      ],
    );
  }
}

class _SectionHeading extends StatelessWidget {
  const _SectionHeading({
    required this.title,
    required this.subtitle,
    this.trailing,
  });

  final String title;
  final String subtitle;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title,
                  style: const TextStyle(
                      color: AppColors.forestDark,
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                      letterSpacing: -0.5)),
              const SizedBox(height: 4),
              Text(subtitle,
                  style: const TextStyle(
                      color: AppColors.muted,
                      fontSize: 12,
                      fontWeight: FontWeight.w600)),
            ],
          ),
        ),
        if (trailing != null) ...[
          const SizedBox(width: 10),
          trailing!,
        ],
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
      padding: const EdgeInsets.only(bottom: 10),
      child: AppCard(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 14),
        child: Row(
          children: [
            AvatarBadge(cat: cat),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name,
                      style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w900,
                          color: AppColors.forestDark)),
                  const SizedBox(height: 4),
                  Text('$rank · P-핸디 $handicap타',
                      style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: AppColors.muted)),
                ],
              ),
            ),
            IconButton(
              tooltip: '메시지 보내기',
              onPressed: () {},
              icon: const Icon(Icons.chat_bubble_outline_rounded,
                  color: AppColors.primaryDark, size: 20),
            ),
          ],
        ),
      ),
    );
  }
}

class _SelectChip extends StatelessWidget {
  const _SelectChip({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: () {},
      style: OutlinedButton.styleFrom(
        minimumSize: const Size(0, 38),
        backgroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 11),
        side: const BorderSide(color: AppColors.line),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(label,
              style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w800,
                  color: AppColors.forestDark)),
          const SizedBox(width: 3),
          const Icon(Icons.keyboard_arrow_down_rounded, size: 16),
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
      padding: const EdgeInsets.only(bottom: 10),
      child: AppCard(
        onTap: () => Navigator.of(context).push(
          MaterialPageRoute(builder: (_) => const ScoreDetailPage()),
        ),
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Container(
              width: 66,
              height: 66,
              decoration: BoxDecoration(
                color: positive ? const Color(0xFFFFF4D8) : AppColors.mintSoft,
                borderRadius: BorderRadius.circular(18),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('$score',
                      style: const TextStyle(
                          color: AppColors.forestDark,
                          fontSize: 23,
                          fontWeight: FontWeight.w900)),
                  Text(delta,
                      style: TextStyle(
                          color: positive
                              ? const Color(0xFFD97706)
                              : AppColors.primaryDark,
                          fontSize: 12,
                          fontWeight: FontWeight.w900)),
                ],
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('2025.05.19 · GIGI Sports Lab',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          color: AppColors.primaryDark)),
                  const SizedBox(height: 4),
                  Text(title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          fontSize: 16,
                          color: AppColors.forestDark,
                          fontWeight: FontWeight.w900,
                          letterSpacing: -0.3)),
                  const SizedBox(height: 5),
                  const Row(
                    children: [
                      Icon(Icons.people_alt_outlined,
                          size: 14, color: AppColors.muted),
                      SizedBox(width: 5),
                      Text('동반 플레이어 4명',
                          style: TextStyle(
                              fontSize: 11,
                              color: AppColors.muted,
                              fontWeight: FontWeight.w600)),
                    ],
                  ),
                ],
              ),
            ),
            const Icon(Icons.arrow_forward_ios_rounded,
                size: 15, color: AppColors.subtle),
          ],
        ),
      ),
    );
  }
}
