import 'package:flutter/material.dart';

import '../app_theme.dart';
import '../widgets/common_widgets.dart';

class NoticeDetailPage extends StatelessWidget {
  const NoticeDetailPage({
    required this.title,
    required this.date,
    required this.category,
    required this.content,
    super.key,
  });

  final String title;
  final String date;
  final String category;
  final String content;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('공지사항 상세', style: TextStyle(fontWeight: FontWeight.w900, color: AppColors.forestDark)),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      backgroundColor: AppColors.surface,
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            AppCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: AppColors.mintSoft,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(category, style: const TextStyle(color: AppColors.primaryDark, fontSize: 13, fontWeight: FontWeight.w900)),
                      ),
                      const Spacer(),
                      Text(date, style: const TextStyle(fontSize: 13, color: AppColors.muted)),
                    ],
                  ),
                  const SizedBox(height: 14),
                  Text(
                    title,
                    style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w900, color: AppColors.forestDark, height: 1.3),
                  ),
                  const SizedBox(height: 16),
                  const Divider(height: 1, color: AppColors.line),
                  const SizedBox(height: 18),
                  Text(
                    content,
                    style: const TextStyle(fontSize: 16, color: AppColors.ink, height: 1.6),
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
