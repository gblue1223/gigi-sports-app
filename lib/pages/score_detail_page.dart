import 'package:flutter/material.dart';

import '../app_theme.dart';
import '../widgets/common_widgets.dart';

class ScoreDetailPage extends StatelessWidget {
  const ScoreDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('스코어카드 세부 정보',
            style: TextStyle(fontWeight: FontWeight.w900, color: AppColors.forestDark)),
        centerTitle: true,
        backgroundColor: AppColors.surface,
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 24, 20, 28),
          children: const [
            Text('내 스코어카드', style: SectionTitle.style),
            SizedBox(height: 18),
            ScoreCardTable(),
            SizedBox(height: 36),
            Text('같이 플레이한 유저', style: SectionTitle.style),
            SizedBox(height: 18),
            PlayerResultCard(),
            SizedBox(height: 12),
            PlayerResultCard(name: '김프로2', cat: false, score: 68, delta: '+2'),
          ],
        ),
      ),
    );
  }
}

class ScoreCardTable extends StatelessWidget {
  const ScoreCardTable({super.key});

  @override
  Widget build(BuildContext context) {
    const firstHoles = [1, 2, 3, 4, 5, 6, 7, 8, 9];
    const firstPar = [4, 4, 3, 3, 5, 4, 3, 3, 4];
    const firstScores = [4, -1, 0, 1, 1, 0, 0, -1, 0];
    const secondHoles = [10, 11, 12, 13, 14, 15, 16, 17, 18];
    const secondPar = [3, 3, 3, 4, 4, 3, 4, 4, 5];
    const secondScores = [0, 1, -1, 0, -1, 1, -1, -1, 4];

    return AppCard(
      padding: EdgeInsets.zero,
      child: Column(
        children: const [
          Padding(
            padding: EdgeInsets.fromLTRB(18, 20, 18, 18),
            child: Row(
              children: [
                AvatarBadge(),
                SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RankBadge(),
                      SizedBox(height: 6),
                      Text(
                        'GIGI Sports',
                        style: TextStyle(
                            fontSize: 22,
                            color: AppColors.forestDark,
                            fontWeight: FontWeight.w900),
                      ),
                    ],
                  ),
                ),
                ScorePill(score: '72', delta: '+6'),
              ],
            ),
          ),
          ScoreGrid(
              holes: firstHoles,
              pars: firstPar,
              scores: firstScores,
              total: '4'),
          ScoreGrid(
              holes: secondHoles,
              pars: secondPar,
              scores: secondScores,
              total: '2'),
        ],
      ),
    );
  }
}

class ScoreGrid extends StatelessWidget {
  const ScoreGrid({
    required this.holes,
    required this.pars,
    required this.scores,
    required this.total,
    super.key,
  });

  final List<int> holes;
  final List<int> pars;
  final List<int> scores;
  final String total;

  @override
  Widget build(BuildContext context) {
    return Table(
      border: TableBorder.symmetric(
          inside: const BorderSide(color: AppColors.line)),
      columnWidths: const {
        0: FixedColumnWidth(52),
        10: FixedColumnWidth(58),
      },
      children: [
        _row('HOLE', holes.map((e) => '$e').toList(), 'TOTAL', shaded: true),
        _row('PAR', pars.map((e) => '$e').toList(), '33'),
        _row('SCORE', scores.map((e) => '$e').toList(), total, score: true),
      ],
    );
  }

  TableRow _row(String label, List<String> cells, String total,
      {bool shaded = false, bool score = false}) {
    return TableRow(
      decoration:
          BoxDecoration(color: shaded ? AppColors.mintLight : Colors.white),
      children: [
        _cell(label, small: true),
        ...cells.map((value) => _cell(value, score: score)),
        _cell(total, bold: true),
      ],
    );
  }

  Widget _cell(String text,
      {bool small = false, bool bold = false, bool score = false}) {
    return Container(
      height: 44,
      alignment: Alignment.center,
      child: score
          ? ScoreMark(value: text)
          : Text(
              text,
              style: TextStyle(
                fontSize: small ? 12 : 16,
                fontWeight: bold ? FontWeight.w900 : FontWeight.w600,
                color: AppColors.forestDark,
              ),
            ),
    );
  }
}

class ScoreMark extends StatelessWidget {
  const ScoreMark({required this.value, super.key});

  final String value;

  @override
  Widget build(BuildContext context) {
    final intValue = int.tryParse(value) ?? 0;
    final isBirdie = intValue < 0;
    final isBox = intValue > 0;
    return Container(
      width: 26,
      height: 26,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        border:
            isBox ? Border.all(color: const Color(0xFFF59E0B), width: 1.5) : null,
        borderRadius: BorderRadius.circular(isBirdie ? 13 : 4),
        color: isBirdie ? AppColors.mintSoft : Colors.transparent,
      ),
      child: Text(
        value,
        style: TextStyle(
            fontSize: 16,
            color: isBirdie ? AppColors.primaryDark : AppColors.ink,
            fontWeight: FontWeight.w900),
      ),
    );
  }
}

class PlayerResultCard extends StatelessWidget {
  const PlayerResultCard({
    this.name = '박프로1',
    this.cat = true,
    this.score = 72,
    this.delta = '+6',
    super.key,
  });

  final String name;
  final bool cat;
  final int score;
  final String delta;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: Row(
        children: [
          AvatarBadge(cat: cat),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RankBadge(label: cat ? '다이아' : '골드', blue: cat),
                const SizedBox(height: 6),
                Text(
                  name,
                  style: const TextStyle(
                      fontSize: 20,
                      color: AppColors.forestDark,
                      fontWeight: FontWeight.w900),
                ),
              ],
            ),
          ),
          ScorePill(score: '$score', delta: delta),
          const SizedBox(width: 8),
          const Icon(Icons.keyboard_arrow_down, size: 28, color: AppColors.primary),
        ],
      ),
    );
  }
}
