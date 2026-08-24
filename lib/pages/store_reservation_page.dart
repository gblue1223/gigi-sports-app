import 'package:flutter/material.dart';

import '../app_theme.dart';
import '../widgets/common_widgets.dart';

class StoreReservationPage extends StatefulWidget {
  const StoreReservationPage({
    this.storeName = 'GIGI Sports 성수점',
    this.address = '서울특별시 성동구 성수이로 137 지층 101호',
    super.key,
  });

  final String storeName;
  final String address;

  @override
  State<StoreReservationPage> createState() => _StoreReservationPageState();
}

class _StoreReservationPageState extends State<StoreReservationPage> {
  int selectedDateIndex = 0;
  String selectedTime = '14:00';
  int playerCount = 2;
  String selectedRoom = '일반 룸 (1~4인)';

  final List<Map<String, String>> dates = [
    {'day': '오늘', 'date': '08.02', 'week': '일'},
    {'day': '내일', 'date': '08.03', 'week': '월'},
    {'day': '화', 'date': '08.04', 'week': '화'},
    {'day': '수', 'date': '08.05', 'week': '수'},
    {'day': '목', 'date': '08.06', 'week': '목'},
    {'day': '금', 'date': '08.07', 'week': '금'},
    {'day': '토', 'date': '08.08', 'week': '토'},
  ];

  final List<Map<String, dynamic>> timeSlots = [
    {'time': '09:00', 'available': true},
    {'time': '11:00', 'available': true},
    {'time': '13:00', 'available': false},
    {'time': '14:00', 'available': true},
    {'time': '16:00', 'available': true},
    {'time': '18:00', 'available': true},
    {'time': '20:00', 'available': false},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('매장 예약', style: TextStyle(fontWeight: FontWeight.w900, color: AppColors.forestDark)),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      backgroundColor: AppColors.surface,
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 28),
          children: [
            // Store Info Summary Header Card
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
                        child: const Text('파크골프 예약', style: TextStyle(color: AppColors.primaryDark, fontSize: 13, fontWeight: FontWeight.w900)),
                      ),
                      const Spacer(),
                      const Icon(Icons.star_rounded, color: Color(0xFFF59E0B), size: 20),
                      const SizedBox(width: 4),
                      const Text('4.9 (128건)', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: AppColors.muted)),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(widget.storeName, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w900, color: AppColors.forestDark)),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      const Icon(Icons.location_on_outlined, color: AppColors.primary, size: 18),
                      const SizedBox(width: 6),
                      Expanded(child: Text(widget.address, style: const TextStyle(fontSize: 14, color: AppColors.muted))),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Date Selector
            const Text('날짜 선택', style: SectionTitle.style),
            const SizedBox(height: 14),
            SizedBox(
              height: 84,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: dates.length,
                separatorBuilder: (_, __) => const SizedBox(width: 10),
                itemBuilder: (context, index) {
                  final isSelected = selectedDateIndex == index;
                  final d = dates[index];
                  return InkWell(
                    onTap: () => setState(() => selectedDateIndex = index),
                    borderRadius: BorderRadius.circular(16),
                    child: Container(
                      width: 68,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      decoration: BoxDecoration(
                        color: isSelected ? AppColors.primary : Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: isSelected ? AppColors.primary : AppColors.line),
                        boxShadow: isSelected
                            ? [const BoxShadow(color: Color(0x33059669), blurRadius: 10, offset: Offset(0, 4))]
                            : null,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            d['day']!,
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w700,
                              color: isSelected ? Colors.white : AppColors.muted,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            d['date']!,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w900,
                              color: isSelected ? Colors.white : AppColors.forestDark,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 28),

            // Time Slot Selector
            const Text('시간대 선택', style: SectionTitle.style),
            const SizedBox(height: 14),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: timeSlots.map((slot) {
                final time = slot['time'] as String;
                final available = slot['available'] as bool;
                final isSelected = selectedTime == time;
                return SizedBox(
                  width: (MediaQuery.of(context).size.width - 60) / 3,
                  child: InkWell(
                    onTap: available ? () => setState(() => selectedTime = time) : null,
                    borderRadius: BorderRadius.circular(14),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      decoration: BoxDecoration(
                        color: !available
                            ? const Color(0xFFF1F5F9)
                            : isSelected
                                ? AppColors.mintSoft
                                : Colors.white,
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(
                          color: isSelected ? AppColors.primary : AppColors.line,
                          width: isSelected ? 2 : 1,
                        ),
                      ),
                      child: Column(
                        children: [
                          Text(
                            time,
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w900,
                              color: !available
                                  ? const Color(0xFFCBD5E1)
                                  : isSelected
                                      ? AppColors.primaryDark
                                      : AppColors.forestDark,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            available ? (isSelected ? '선택됨' : '예약가능') : '마감',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                              color: !available
                                  ? const Color(0xFF94A3B8)
                                  : isSelected
                                      ? AppColors.primary
                                      : AppColors.muted,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 28),

            // Player Count & Room Type Card
            const Text('예약 상세 정보', style: SectionTitle.style),
            const SizedBox(height: 14),
            AppCard(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('플레이어 인원', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: AppColors.forestDark)),
                      Row(
                        children: [
                          IconButton(
                            onPressed: playerCount > 1 ? () => setState(() => playerCount--) : null,
                            icon: const Icon(Icons.remove_circle_outline),
                            color: AppColors.primary,
                          ),
                          Text('$playerCount명', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w900, color: AppColors.forestDark)),
                          IconButton(
                            onPressed: playerCount < 4 ? () => setState(() => playerCount++) : null,
                            icon: const Icon(Icons.add_circle_outline),
                            color: AppColors.primary,
                          ),
                        ],
                      ),
                    ],
                  ),
                  const Divider(height: 24, color: AppColors.line),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('타석 타입', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: AppColors.forestDark)),
                      DropdownButton<String>(
                        value: selectedRoom,
                        underline: const SizedBox(),
                        icon: const Icon(Icons.arrow_drop_down, color: AppColors.primary),
                        items: ['일반 룸 (1~4인)', 'VIP 프리미엄 룸']
                            .map((e) => DropdownMenuItem(value: e, child: Text(e, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: AppColors.forestDark))))
                            .toList(),
                        onChanged: (val) {
                          if (val != null) setState(() => selectedRoom = val);
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),

            // Submit Button
            FilledButton(
              onPressed: () => _confirmBooking(context),
              style: FilledButton.styleFrom(
                minimumSize: const Size.fromHeight(56),
                backgroundColor: AppColors.primary,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                elevation: 0,
              ),
              child: Text(
                '${dates[selectedDateIndex]['date']} $selectedTime 예약 신청하기',
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w900),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _confirmBooking(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: const BoxDecoration(color: AppColors.mintSoft, shape: BoxShape.circle),
              child: const Icon(Icons.check_circle_rounded, color: AppColors.primary, size: 28),
            ),
            const SizedBox(width: 12),
            const Text('예약 완료', style: TextStyle(fontWeight: FontWeight.w900, color: AppColors.forestDark)),
          ],
        ),
        content: Text(
          '${widget.storeName}\n${dates[selectedDateIndex]['date']} (${dates[selectedDateIndex]['week']}) $selectedTime\n인원: $playerCount명 ($selectedRoom)\n\n예약이 성공적으로 완료되었습니다!',
          style: const TextStyle(fontSize: 15, color: AppColors.ink, height: 1.5),
        ),
        actions: [
          FilledButton(
            onPressed: () {
              Navigator.of(ctx).pop();
              Navigator.of(context).pop();
            },
            style: FilledButton.styleFrom(
              backgroundColor: AppColors.primary,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            child: const Text('확인', style: TextStyle(fontWeight: FontWeight.w900)),
          ),
        ],
      ),
    );
  }
}
