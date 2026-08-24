import 'package:flutter/material.dart';

import '../app_theme.dart';
import '../widgets/common_widgets.dart';

class NotificationListPage extends StatelessWidget {
  const NotificationListPage({super.key});

  final List<Map<String, dynamic>> notifications = const [
    {
      'title': '예약 확정 안내',
      'body': 'GIGI Sports 성수점 08.02(일) 14:00 예약이 완료되었습니다.',
      'time': '방금 전',
      'icon': Icons.calendar_month,
      'isNew': true,
    },
    {
      'title': 'P-핸디캡 갱신',
      'body': '축하합니다! P-핸디캡이 61.9타로 상향 조정되었습니다.',
      'time': '2시간 전',
      'icon': Icons.show_chart,
      'isNew': true,
    },
    {
      'title': '8월 대회 접수 시작',
      'body': '2026 GIGI Sports 전국 스크린파크골프 챔피언십 참가 신청이 오픈되었습니다.',
      'time': '1일 전',
      'icon': Icons.emoji_events,
      'isNew': false,
    },
    {
      'title': '쿠폰 발급 완료',
      'body': '여름맞이 실내 파크골프 20% 할인 쿠폰이 지급되었습니다.',
      'time': '3일 전',
      'icon': Icons.confirmation_number_outlined,
      'isNew': false,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('알림 센터', style: TextStyle(fontWeight: FontWeight.w900, color: AppColors.forestDark)),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      backgroundColor: AppColors.surface,
      body: ListView.separated(
        padding: const EdgeInsets.all(20),
        itemCount: notifications.length,
        separatorBuilder: (_, __) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          final n = notifications[index];
          final isNew = n['isNew'] as bool;
          return AppCard(
            color: isNew ? Colors.white : const Color(0xFFFAFBFB),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: isNew ? AppColors.mintSoft : const Color(0xFFF1F5F9),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(n['icon'] as IconData, color: isNew ? AppColors.primary : AppColors.muted, size: 22),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            n['title'] as String,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w900,
                              color: isNew ? AppColors.forestDark : AppColors.muted,
                            ),
                          ),
                          Text(n['time'] as String, style: const TextStyle(fontSize: 12, color: AppColors.muted)),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Text(
                        n['body'] as String,
                        style: TextStyle(fontSize: 14, color: isNew ? AppColors.ink : AppColors.muted, height: 1.4),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
