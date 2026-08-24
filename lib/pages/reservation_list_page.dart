import 'package:flutter/material.dart';

import '../app_theme.dart';
import '../widgets/common_widgets.dart';
import 'qr_scanner_page.dart';

class ReservationListPage extends StatefulWidget {
  const ReservationListPage({super.key});

  @override
  State<ReservationListPage> createState() => _ReservationListPageState();
}

class _ReservationListPageState extends State<ReservationListPage> with SingleTickerProviderStateMixin {
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
        title: const Text('예약 내역', style: TextStyle(fontWeight: FontWeight.w900, color: AppColors.forestDark)),
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
              labelStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w900),
              tabs: const [
                Tab(text: '진행중인 예약'),
                Tab(text: '지난 이용 내역'),
                Tab(text: '취소 내역'),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: controller,
              children: [
                _buildActiveReservations(context),
                _buildPastReservations(),
                _buildCancelledReservations(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActiveReservations(BuildContext context) {
    return ListView(
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
                    child: const Text('예약 확정', style: TextStyle(color: AppColors.primaryDark, fontSize: 13, fontWeight: FontWeight.w900)),
                  ),
                  const Spacer(),
                  const Text('No. R-20260802', style: TextStyle(fontSize: 12, color: AppColors.muted)),
                ],
              ),
              const SizedBox(height: 14),
              const Text('GIGI Sports 성수점', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900, color: AppColors.forestDark)),
              const SizedBox(height: 8),
              const Row(
                children: [
                  Icon(Icons.calendar_month_outlined, color: AppColors.primary, size: 18),
                  SizedBox(width: 8),
                  Text('2026.08.02 (오늘) 14:00 - 16:00', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: AppColors.ink)),
                ],
              ),
              const SizedBox(height: 6),
              const Row(
                children: [
                  Icon(Icons.people_outline, color: AppColors.primary, size: 18),
                  SizedBox(width: 8),
                  Text('2명 (일반 룸 3번 타석)', style: TextStyle(fontSize: 14, color: AppColors.muted)),
                ],
              ),
              const SizedBox(height: 16),
              const Divider(height: 1, color: AppColors.line),
              const SizedBox(height: 14),
              Row(
                children: [
                  Expanded(
                    child: FilledButton.icon(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (_) => const QrScannerPage()),
                        );
                      },
                      icon: const Icon(Icons.qr_code, size: 20),
                      label: const Text('QR 체크인', style: TextStyle(fontWeight: FontWeight.w900)),
                      style: FilledButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  OutlinedButton(
                    onPressed: () => _showCancelDialog(context),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: const Color(0xFFEF4444),
                      side: const BorderSide(color: Color(0xFFFCA5A5)),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                    ),
                    child: const Text('예약 취소', style: TextStyle(fontWeight: FontWeight.w800)),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPastReservations() {
    return ListView(
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
                      color: const Color(0xFFE2E8F0),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Text('이용 완료', style: TextStyle(color: AppColors.muted, fontSize: 13, fontWeight: FontWeight.w900)),
                  ),
                  const Spacer(),
                  const Text('2026.07.25', style: TextStyle(fontSize: 13, color: AppColors.muted)),
                ],
              ),
              const SizedBox(height: 12),
              const Text('GIGI Sports 세종 산울점', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900, color: AppColors.forestDark)),
              const SizedBox(height: 6),
              const Text('이용 타석: VIP 룸 1번', style: TextStyle(fontSize: 14, color: AppColors.muted)),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCancelledReservations() {
    return ListView(
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
                      color: const Color(0xFFFEE2E2),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Text('취소 완료', style: TextStyle(color: Color(0xFFDC2626), fontSize: 13, fontWeight: FontWeight.w900)),
                  ),
                  const Spacer(),
                  const Text('2026.07.10', style: TextStyle(fontSize: 13, color: AppColors.muted)),
                ],
              ),
              const SizedBox(height: 12),
              const Text('GIGI Sports 성수점', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900, color: AppColors.forestDark)),
              const SizedBox(height: 6),
              const Text('사유: 일정 변경으로 인한 직접 취소', style: TextStyle(fontSize: 14, color: AppColors.muted)),
            ],
          ),
        ),
      ],
    );
  }

  void _showCancelDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text('예약 취소 확인', style: TextStyle(fontWeight: FontWeight.w900, color: AppColors.forestDark)),
        content: const Text('정말로 이 예약을 취소하시겠습니까?\n취소 후에는 복구할 수 없습니다.', style: TextStyle(fontSize: 15, color: AppColors.ink)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('닫기', style: TextStyle(color: AppColors.muted)),
          ),
          FilledButton(
            onPressed: () {
              Navigator.pop(ctx);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('예약이 취소되었습니다.')),
              );
            },
            style: FilledButton.styleFrom(backgroundColor: const Color(0xFFEF4444)),
            child: const Text('예약 취소', style: TextStyle(fontWeight: FontWeight.w900)),
          ),
        ],
      ),
    );
  }
}
