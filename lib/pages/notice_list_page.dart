import 'package:flutter/material.dart';

import '../app_theme.dart';
import '../widgets/common_widgets.dart';
import 'notice_detail_page.dart';

class NoticeListPage extends StatelessWidget {
  const NoticeListPage({super.key});

  final List<Map<String, String>> notices = const [
    {
      'category': '가이드',
      'title': '[가이드] P-핸디 & 등급 시스템 안내',
      'date': '2026. 01. 20.',
      'content': '안녕하세요, GIGI Sports입니다.\n\n파크골프 유저분들을 위한 P-핸디 산정 기준 및 등급 산정 방식이 새로 개정되었습니다.\n\n1. 최근 10게임 스코어 기준 평균 계산\n2. 난이도 코스 보정치 적용\n3. 등급: 브론즈 -> 실버 -> 골드 -> 다이아\n\n즐거운 파크골프 플레이되시길 바랍니다!',
    },
    {
      'category': '안내',
      'title': 'GIGI Sports 성수점 타석 리뉴얼 및 4D 스크린 도입',
      'date': '2026. 01. 15.',
      'content': 'GIGI Sports 성수점에 초고화질 센서 및 4D 파크골프 스크린이 신규 도입되었습니다.\n\n더욱 정밀한 타구 분석과 실제 잔디 필드 같은 생생한 그래픽을 경험해 보세요!',
    },
    {
      'category': '이벤트',
      'title': '8월 여름 맞이 파크골프 예약 할인 쿠폰 이벤트',
      'date': '2026. 08. 01.',
      'content': '무더운 여름, 시원한 실내 스크린 파크골프장에서 즐기세요!\n\n평일 주간 20% 할인 쿠폰이 모든 회원분들께 지급되었습니다.',
    },
    {
      'category': '점검',
      'title': '시스템 정기 서버 점검 안내 (8/10 02:00 ~ 05:00)',
      'date': '2026. 07. 28.',
      'content': '안정적인 서비스 제공을 위해 정기 서버 점검이 진행될 예정입니다. 점검 시간 동안은 앱 예약 및 기록 조회가 제한될 수 있습니다.',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('공지사항', style: TextStyle(fontWeight: FontWeight.w900, color: AppColors.forestDark)),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      backgroundColor: AppColors.surface,
      body: ListView.separated(
        padding: const EdgeInsets.all(20),
        itemCount: notices.length,
        separatorBuilder: (_, __) => const SizedBox(height: 14),
        itemBuilder: (context, index) {
          final item = notices[index];
          return AppCard(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => NoticeDetailPage(
                    title: item['title']!,
                    date: item['date']!,
                    category: item['category']!,
                    content: item['content']!,
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
                  child: const Icon(Icons.campaign_outlined, color: AppColors.primary, size: 24),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            '[${item['category']}] ',
                            style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w800, color: AppColors.primaryDark),
                          ),
                          Text(item['date']!, style: const TextStyle(fontSize: 12, color: AppColors.muted)),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        item['title']!,
                        style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w800, color: AppColors.forestDark),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                const Icon(Icons.chevron_right, color: AppColors.muted, size: 22),
              ],
            ),
          );
        },
      ),
    );
  }
}
