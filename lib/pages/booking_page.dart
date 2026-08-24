import 'package:flutter/material.dart';

import '../app_theme.dart';
import '../widgets/common_widgets.dart';
import 'store_reservation_page.dart';

class StoreItem {
  StoreItem({
    required this.id,
    required this.name,
    required this.address,
    required this.hours,
    required this.slots,
    required this.isVisited,
    required this.isFavorite,
    required this.rating,
    required this.reviewCount,
    required this.leftOffsetRatio,
    required this.topOffsetRatio,
  });

  final String id;
  final String name;
  final String address;
  final String hours;
  final int slots;
  final bool isVisited;
  bool isFavorite;
  final double rating;
  final int reviewCount;
  final double leftOffsetRatio;
  final double topOffsetRatio;
}

class BookingPage extends StatefulWidget {
  const BookingPage({super.key});

  @override
  State<BookingPage> createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage>
    with SingleTickerProviderStateMixin {
  late final TabController tabController;

  final List<StoreItem> stores = [
    StoreItem(
      id: '1',
      name: 'GIGI Sports 성수점',
      address: '서울특별시 성동구 성수이로 137 지층 101호',
      hours: '평일 06:30-22:30 / 주말 09:00-19:00',
      slots: 4,
      isVisited: true,
      isFavorite: true,
      rating: 4.9,
      reviewCount: 128,
      leftOffsetRatio: 0.52,
      topOffsetRatio: 0.28,
    ),
    StoreItem(
      id: '2',
      name: 'GIGI Sports 세종 산울점',
      address: '세종특별자치시 산울7로 11',
      hours: '매일 08:00-22:00',
      slots: 6,
      isVisited: true,
      isFavorite: false,
      rating: 4.8,
      reviewCount: 94,
      leftOffsetRatio: 0.38,
      topOffsetRatio: 0.62,
    ),
    StoreItem(
      id: '3',
      name: 'GIGI Sports 강남 루프탑점',
      address: '서울특별시 강남구 테헤란로 152 12층',
      hours: '평일 07:00-23:00 / 주말 09:00-21:00',
      slots: 8,
      isVisited: false,
      isFavorite: true,
      rating: 4.95,
      reviewCount: 210,
      leftOffsetRatio: 0.56,
      topOffsetRatio: 0.33,
    ),
    StoreItem(
      id: '4',
      name: 'GIGI Sports 판교 테크노점',
      address: '경기도 성남시 분당구 판교역로 235 B1',
      hours: '평일 06:00-22:00 / 주말 휴무',
      slots: 5,
      isVisited: false,
      isFavorite: false,
      rating: 4.7,
      reviewCount: 62,
      leftOffsetRatio: 0.58,
      topOffsetRatio: 0.42,
    ),
    StoreItem(
      id: '5',
      name: 'GIGI Sports 부산 해운대점',
      address: '부산광역시 해운대구 해운대해변로 298',
      hours: '매일 09:00-23:00',
      slots: 6,
      isVisited: true,
      isFavorite: true,
      rating: 4.92,
      reviewCount: 175,
      leftOffsetRatio: 0.78,
      topOffsetRatio: 0.82,
    ),
  ];

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  void _toggleFavorite(StoreItem store) {
    setState(() {
      store.isFavorite = !store.isFavorite;
    });
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          store.isFavorite
              ? '${store.name}이(가) 즐겨찾기에 추가되었습니다.'
              : '${store.name}이(가) 즐겨찾기에서 해제되었습니다.',
        ),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(18, 12, 18, 8),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 920),
                  child: _BookingHeader(
                    controller: tabController,
                    canPop: Navigator.of(context).canPop(),
                  ),
                ),
              ),
            ),
            Expanded(
              child: TabBarView(
                controller: tabController,
                children: [
                  StoreListView(
                    stores: stores,
                    onToggleFavorite: _toggleFavorite,
                  ),
                  StoreMapView(
                    stores: stores,
                    onToggleFavorite: _toggleFavorite,
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

class _BookingHeader extends StatelessWidget {
  const _BookingHeader({required this.controller, required this.canPop});

  final TabController controller;
  final bool canPop;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 48,
          child: Stack(
            alignment: Alignment.center,
            children: [
              const Text(
                '매장 예약',
                style: TextStyle(
                  color: AppColors.forestDark,
                  fontSize: 21,
                  fontWeight: FontWeight.w900,
                  letterSpacing: -0.5,
                ),
              ),
              if (canPop)
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
                  tooltip: '내 예약',
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('예약 내역을 준비하고 있습니다.')),
                    );
                  },
                  icon: const Icon(Icons.event_note_outlined),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Container(
          height: 48,
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: AppColors.creamDark,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppColors.line),
          ),
          child: TabBar(
            controller: controller,
            indicatorSize: TabBarIndicatorSize.tab,
            dividerColor: Colors.transparent,
            indicator: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            labelColor: AppColors.forestDark,
            unselectedLabelColor: AppColors.muted,
            labelStyle:
                const TextStyle(fontSize: 13, fontWeight: FontWeight.w900),
            unselectedLabelStyle:
                const TextStyle(fontSize: 13, fontWeight: FontWeight.w700),
            tabs: const [
              Tab(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.view_agenda_outlined, size: 17),
                    SizedBox(width: 7),
                    Text('매장 목록'),
                  ],
                ),
              ),
              Tab(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.map_outlined, size: 17),
                    SizedBox(width: 7),
                    Text('지도 보기'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class StoreListView extends StatefulWidget {
  const StoreListView({
    required this.stores,
    required this.onToggleFavorite,
    super.key,
  });

  final List<StoreItem> stores;
  final Function(StoreItem) onToggleFavorite;

  @override
  State<StoreListView> createState() => _StoreListViewState();
}

class _StoreListViewState extends State<StoreListView> {
  int selectedFilterIndex = 0; // 0: 전체, 1: 방문매장, 2: 즐겨찾기
  String searchQuery = '';
  final TextEditingController searchController = TextEditingController();

  List<StoreItem> get filteredStores {
    return widget.stores.where((store) {
      // Filter Category
      if (selectedFilterIndex == 1 && !store.isVisited) return false;
      if (selectedFilterIndex == 2 && !store.isFavorite) return false;

      // Text Search Query Filter
      if (searchQuery.trim().isNotEmpty) {
        final query = searchQuery.trim().toLowerCase();
        final nameMatch = store.name.toLowerCase().contains(query);
        final addrMatch = store.address.toLowerCase().contains(query);
        if (!nameMatch && !addrMatch) return false;
      }
      return true;
    }).toList();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final displayList = filteredStores;
    return LayoutBuilder(
      builder: (context, constraints) {
        final isWide = constraints.maxWidth >= 760;
        final horizontal = isWide ? 28.0 : 18.0;

        return ListView(
          padding: EdgeInsets.fromLTRB(horizontal, 12, horizontal, 32),
          children: [
            Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 920),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextField(
                      controller: searchController,
                      onChanged: (val) => setState(() => searchQuery = val),
                      decoration: InputDecoration(
                        hintText: '지역이나 매장 이름을 검색하세요',
                        prefixIcon: const Icon(Icons.search_rounded,
                            color: AppColors.primaryDark),
                        suffixIcon: searchQuery.isNotEmpty
                            ? IconButton(
                                tooltip: '검색어 지우기',
                                icon: const Icon(Icons.close_rounded,
                                    size: 19, color: AppColors.muted),
                                onPressed: () {
                                  searchController.clear();
                                  setState(() => searchQuery = '');
                                },
                              )
                            : null,
                      ),
                    ),
                    const SizedBox(height: 13),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          FilterPill(
                            label: '전체 ${widget.stores.length}',
                            selected: selectedFilterIndex == 0,
                            onTap: () =>
                                setState(() => selectedFilterIndex = 0),
                          ),
                          const SizedBox(width: 8),
                          FilterPill(
                            label:
                                '방문 매장 ${widget.stores.where((s) => s.isVisited).length}',
                            selected: selectedFilterIndex == 1,
                            onTap: () =>
                                setState(() => selectedFilterIndex = 1),
                          ),
                          const SizedBox(width: 8),
                          FilterPill(
                            label:
                                '즐겨찾기 ${widget.stores.where((s) => s.isFavorite).length}',
                            selected: selectedFilterIndex == 2,
                            onTap: () =>
                                setState(() => selectedFilterIndex = 2),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 22),
                    Row(
                      children: [
                        const Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('가까운 GIGI 매장',
                                  style: TextStyle(
                                      color: AppColors.forestDark,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w900,
                                      letterSpacing: -0.5)),
                              SizedBox(height: 3),
                              Text('원하는 매장에서 바로 라운드를 예약하세요.',
                                  style: TextStyle(
                                      color: AppColors.muted,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600)),
                            ],
                          ),
                        ),
                        Text('${displayList.length}개 매장',
                            style: const TextStyle(
                                color: AppColors.primaryDark,
                                fontSize: 13,
                                fontWeight: FontWeight.w900)),
                      ],
                    ),
                    const SizedBox(height: 14),
                    if (displayList.isEmpty)
                      _EmptyStoreState(filterIndex: selectedFilterIndex)
                    else
                      GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: displayList.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: isWide ? 2 : 1,
                          crossAxisSpacing: 14,
                          mainAxisSpacing: 14,
                          mainAxisExtent: isWide ? 285 : 275,
                        ),
                        itemBuilder: (context, index) {
                          final store = displayList[index];
                          return StoreCard(
                            store: store,
                            onToggleFavorite: () =>
                                widget.onToggleFavorite(store),
                          );
                        },
                      ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class _EmptyStoreState extends StatelessWidget {
  const _EmptyStoreState({required this.filterIndex});

  final int filterIndex;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 34),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(15),
              decoration: const BoxDecoration(
                  color: AppColors.mintSoft, shape: BoxShape.circle),
              child: const Icon(Icons.storefront_outlined,
                  size: 34, color: AppColors.primaryDark),
            ),
            const SizedBox(height: 14),
            Text(
              filterIndex == 2
                  ? '즐겨찾는 매장이 없습니다.'
                  : filterIndex == 1
                      ? '방문한 매장 내역이 없습니다.'
                      : '검색 결과와 일치하는 매장이 없습니다.',
              style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w900,
                  color: AppColors.forestDark),
            ),
            const SizedBox(height: 5),
            const Text('필터를 바꾸거나 다른 지역을 검색해 보세요.',
                style: TextStyle(fontSize: 12, color: AppColors.muted)),
          ],
        ),
      ),
    );
  }
}

class FilterPill extends StatelessWidget {
  const FilterPill({
    required this.label,
    required this.selected,
    required this.onTap,
    super.key,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onTap,
      style: OutlinedButton.styleFrom(
        minimumSize: const Size(0, 40),
        backgroundColor: selected ? AppColors.forestDark : Colors.white,
        foregroundColor: selected ? Colors.white : AppColors.forestDark,
        side:
            BorderSide(color: selected ? AppColors.forestDark : AppColors.line),
        padding: const EdgeInsets.symmetric(vertical: 9, horizontal: 16),
      ),
      child: Text(
        label,
        maxLines: 1,
        style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w800),
      ),
    );
  }
}

class StoreCard extends StatelessWidget {
  const StoreCard({
    required this.store,
    required this.onToggleFavorite,
    super.key,
  });

  final StoreItem store;
  final VoidCallback onToggleFavorite;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      padding: const EdgeInsets.all(17),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.mintSoft,
                  borderRadius: BorderRadius.circular(999),
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.circle, size: 7, color: AppColors.primary),
                    SizedBox(width: 5),
                    Text('영업중',
                        style: TextStyle(
                            color: AppColors.primaryDark,
                            fontSize: 11,
                            fontWeight: FontWeight.w900)),
                  ],
                ),
              ),
              if (store.isVisited) ...[
                const SizedBox(width: 6),
                const Text('방문 매장',
                    style: TextStyle(
                        color: AppColors.yellow,
                        fontSize: 11,
                        fontWeight: FontWeight.w900)),
              ],
              const Spacer(),
              SizedBox(
                width: 36,
                height: 36,
                child: IconButton(
                  tooltip: '즐겨찾기',
                  padding: EdgeInsets.zero,
                  onPressed: onToggleFavorite,
                  icon: Icon(
                    store.isFavorite
                        ? Icons.favorite_rounded
                        : Icons.favorite_border_rounded,
                    size: 21,
                    color: store.isFavorite
                        ? const Color(0xFFEF4444)
                        : AppColors.subtle,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            store.name,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
                fontSize: 18,
                color: AppColors.forestDark,
                fontWeight: FontWeight.w900,
                letterSpacing: -0.4),
          ),
          const SizedBox(height: 5),
          Row(
            children: [
              const Icon(Icons.star_rounded,
                  color: Color(0xFFF59E0B), size: 17),
              const SizedBox(width: 3),
              Text('${store.rating}',
                  style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w900,
                      color: AppColors.forestDark)),
              const SizedBox(width: 4),
              Text('리뷰 ${store.reviewCount}',
                  style: const TextStyle(fontSize: 11, color: AppColors.muted)),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.cream,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text('예약 가능 ${store.slots}석',
                    style: const TextStyle(
                        color: AppColors.primaryDark,
                        fontSize: 11,
                        fontWeight: FontWeight.w900)),
              ),
            ],
          ),
          const SizedBox(height: 13),
          StoreInfoLine(icon: Icons.location_on_outlined, text: store.address),
          StoreInfoLine(icon: Icons.schedule_outlined, text: store.hours),
          const Spacer(),
          Row(
            children: [
              StoreActionButton(
                icon: Icons.calendar_month_outlined,
                label: '예약하기',
                primary: true,
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => StoreReservationPage(
                        storeName: store.name,
                        address: store.address,
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(width: 8),
              StoreActionButton(
                icon: Icons.phone_outlined,
                label: '전화',
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                        content:
                            Text('${store.name} (02-1234-5678) 전화 연결 중...')),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class StoreInfoLine extends StatelessWidget {
  const StoreInfoLine({required this.icon, required this.text, super.key});

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: AppColors.primaryDark, size: 16),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 12, color: AppColors.muted),
            ),
          ),
        ],
      ),
    );
  }
}

class StoreActionButton extends StatelessWidget {
  const StoreActionButton({
    required this.icon,
    required this.label,
    this.primary = false,
    this.onPressed,
    super.key,
  });

  final IconData icon;
  final String label;
  final bool primary;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: OutlinedButton.icon(
        onPressed: onPressed,
        icon: Icon(icon, size: 16),
        label: Text(label,
            maxLines: 1,
            style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w800)),
        style: OutlinedButton.styleFrom(
          minimumSize: const Size(0, 42),
          foregroundColor: primary ? Colors.white : AppColors.forestDark,
          backgroundColor: primary ? AppColors.primary : Colors.white,
          side: BorderSide(color: primary ? AppColors.primary : AppColors.line),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          padding: const EdgeInsets.symmetric(vertical: 9, horizontal: 2),
        ),
      ),
    );
  }
}

class StoreMapView extends StatefulWidget {
  const StoreMapView({
    required this.stores,
    required this.onToggleFavorite,
    super.key,
  });

  final List<StoreItem> stores;
  final Function(StoreItem) onToggleFavorite;

  @override
  State<StoreMapView> createState() => _StoreMapViewState();
}

class _StoreMapViewState extends State<StoreMapView> {
  String searchMapQuery = '';

  List<StoreItem> get mapFilteredStores {
    if (searchMapQuery.trim().isEmpty) return widget.stores;
    final query = searchMapQuery.trim().toLowerCase();
    return widget.stores
        .where((s) =>
            s.name.toLowerCase().contains(query) ||
            s.address.toLowerCase().contains(query))
        .toList();
  }

  void _showStoreBottomSheet(BuildContext context, StoreItem store) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (ctx) => Container(
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                    color: AppColors.line,
                    borderRadius: BorderRadius.circular(2)),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                      color: AppColors.mintSoft,
                      borderRadius: BorderRadius.circular(8)),
                  child: const Text('영업중',
                      style: TextStyle(
                          color: AppColors.primaryDark,
                          fontSize: 13,
                          fontWeight: FontWeight.w900)),
                ),
                const Spacer(),
                IconButton(
                  onPressed: () {
                    widget.onToggleFavorite(store);
                    Navigator.pop(ctx);
                  },
                  icon: Icon(
                    store.isFavorite ? Icons.favorite : Icons.favorite_border,
                    color: store.isFavorite
                        ? const Color(0xFFEF4444)
                        : AppColors.muted,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(store.name,
                style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w900,
                    color: AppColors.forestDark)),
            const SizedBox(height: 6),
            Row(
              children: [
                const Icon(Icons.star_rounded,
                    color: Color(0xFFF59E0B), size: 18),
                const SizedBox(width: 4),
                Text('${store.rating}',
                    style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w900,
                        color: AppColors.forestDark)),
                const SizedBox(width: 6),
                Text(store.address,
                    style:
                        const TextStyle(fontSize: 13, color: AppColors.muted)),
              ],
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: () {
                  Navigator.pop(ctx);
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => StoreReservationPage(
                        storeName: store.name,
                        address: store.address,
                      ),
                    ),
                  );
                },
                style: FilledButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14)),
                ),
                child: const Text('매장 예약하기',
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.w900)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final displayMapStores = mapFilteredStores;

    return Padding(
      padding: const EdgeInsets.fromLTRB(18, 12, 18, 24),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 920),
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
              border: Border.all(color: AppColors.line),
              boxShadow: const [
                BoxShadow(
                    color: Color(0x1415140F),
                    blurRadius: 24,
                    offset: Offset(0, 8)),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(24),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final size = constraints.biggest;
                  return Stack(
                    children: [
                      Positioned.fill(
                          child: CustomPaint(painter: MapPainter())),
                      Positioned(
                        left: 16,
                        right: 16,
                        top: 16,
                        child: TextField(
                          onChanged: (val) =>
                              setState(() => searchMapQuery = val),
                          decoration: const InputDecoration(
                            hintText: '지도에서 매장 이름 검색',
                            prefixIcon: Icon(Icons.search_rounded,
                                color: AppColors.primaryDark),
                          ),
                        ),
                      ),
                      ...displayMapStores.map((store) {
                        final left = (size.width - 100) * store.leftOffsetRatio;
                        final top =
                            (size.height - 210) * store.topOffsetRatio + 82;
                        return Positioned(
                          left: left.clamp(8, size.width - 95),
                          top: top.clamp(86, size.height - 100),
                          child: InkWell(
                            onTap: () => _showStoreBottomSheet(context, store),
                            borderRadius: BorderRadius.circular(14),
                            child: Column(
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: AppColors.forestDark,
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: const [
                                      BoxShadow(
                                          color: Colors.black26, blurRadius: 6),
                                    ],
                                  ),
                                  child: Text(
                                    store.name.replaceAll('GIGI Sports ', ''),
                                    style: const TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w900,
                                        color: Colors.white),
                                  ),
                                ),
                                const SizedBox(height: 2),
                                const MapFlag(),
                              ],
                            ),
                          ),
                        );
                      }),
                      Positioned(
                        left: 0,
                        right: 0,
                        bottom: 18,
                        child: Center(
                          child: MapCountBadge(count: displayMapStores.length),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class MapFlag extends StatelessWidget {
  const MapFlag({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: 28, height: 40, child: CustomPaint(painter: FlagPainter()));
  }
}

class FlagPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawLine(
      Offset(size.width * 0.25, 4),
      Offset(size.width * 0.25, size.height),
      Paint()
        ..color = AppColors.forestDark
        ..strokeWidth = 2.5,
    );

    final flag = Path()
      ..moveTo(size.width * 0.25, 4)
      ..lineTo(size.width, 13)
      ..lineTo(size.width * 0.25, 24)
      ..close();
    canvas.drawPath(flag, Paint()..color = AppColors.primary);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class MapPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawRect(
        Offset.zero & size, Paint()..color = const Color(0xFFE8F5E9));

    final waterPath = Path()
      ..moveTo(0, size.height * 0.35)
      ..quadraticBezierTo(
          size.width * 0.24, size.height * 0.42, size.width * 0.18, size.height)
      ..lineTo(0, size.height)
      ..close();
    canvas.drawPath(waterPath, Paint()..color = const Color(0xFF7DD3FC));

    final fairway = Path()
      ..moveTo(size.width * 0.4, 0)
      ..cubicTo(size.width * 0.7, size.height * 0.3, size.width * 0.3,
          size.height * 0.7, size.width, size.height)
      ..lineTo(size.width, 0)
      ..close();
    canvas.drawPath(
      fairway,
      Paint()..color = const Color(0xFFC8E6C9).withValues(alpha: 0.5),
    );

    final road = Paint()
      ..color = const Color(0xFFA7F3D0)
      ..strokeWidth = 4
      ..style = PaintingStyle.stroke;
    for (int i = 0; i < 8; i++) {
      final y = 90.0 + i * 86;
      final path = Path()
        ..moveTo(-20, y)
        ..cubicTo(size.width * 0.2, y + 44, size.width * 0.55, y - 52,
            size.width + 20, y + 22);
      canvas.drawPath(path, road);
    }

    final labels = {
      const Offset(190, 180): '서울',
      const Offset(100, 280): '인천',
      const Offset(240, 340): '수원',
      const Offset(160, 520): '천안',
      const Offset(260, 640): '대전',
    };
    final textPainter = TextPainter(textDirection: TextDirection.ltr);
    labels.forEach((offset, text) {
      textPainter.text = TextSpan(
        text: text,
        style: const TextStyle(
            color: AppColors.forestDark,
            fontSize: 16,
            fontWeight: FontWeight.w900),
      );
      textPainter.layout();
      textPainter.paint(canvas, offset);
    });
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class MapCountBadge extends StatelessWidget {
  const MapCountBadge({required this.count, super.key});

  final int count;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(28),
        border: Border.all(color: AppColors.mintSoft, width: 2),
        boxShadow: const [
          BoxShadow(
              color: Color(0x1F059669), blurRadius: 16, offset: Offset(0, 6)),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.place, color: AppColors.primary, size: 20),
          const SizedBox(width: 8),
          Text(
            '검색된 매장 $count개',
            style: const TextStyle(
                fontSize: 15,
                color: AppColors.forestDark,
                fontWeight: FontWeight.w900),
          ),
        ],
      ),
    );
  }
}
