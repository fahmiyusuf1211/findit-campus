
import 'package:flutter/material.dart';
import 'items_page.dart';
import 'detail_page.dart';

void main() {
  runApp(const FindItCampusApp());
}

const navy = Color(0xFF102F9F);
const blue = Color(0xFF2147B5);
const paleBlue = Color(0xFFEAEDFF);
const ink = Color(0xFF17213B);
const muted = Color(0xFF69738B);
const pageColor = Color(0xFFF8F8FE);

class FindItCampusApp extends StatelessWidget {
  const FindItCampusApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'FindIt Campus',
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: pageColor,
        colorScheme: ColorScheme.fromSeed(seedColor: navy),
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedCategory = 0;
  int selectedTab = 0;

  final TextEditingController searchController =
  TextEditingController();

  final List<String> categories = [
    'Semua',
    'Elektronik',
    'Aksesori & Helm',
    'Kartu Identitas',
    'Alat Tulis',
    'Lainnya',
  ];

  final List<Map<String, dynamic>> items = [
    {
      'name': 'Tumbler Biru',
      'category': 'Aksesori & Helm',
      'location': 'Perpustakaan Lt. 2',
      'time': 'Hari ini, 10:15 WIB',
      'status': 'Ditemukan',
      'icon': Icons.local_drink_outlined,
    },
    {
      'name': 'Dompet Hitam',
      'category': 'Kartu Identitas',
      'location': 'Kantin Gedung F',
      'time': 'Hari ini, 08:30 WIB',
      'status': 'Ditemukan',
      'icon': Icons.account_balance_wallet_outlined,
    },
    {
      'name': 'Earphone Putih',
      'category': 'Elektronik',
      'location': 'Lab Komputer 304',
      'time': 'Kemarin, 16:40 WIB',
      'status': 'Ditemukan',
      'icon': Icons.headphones_outlined,
    },
    {
      'name': 'Kunci Motor',
      'category': 'Aksesori & Helm',
      'location': 'Parkiran Timur B',
      'time': 'Kemarin, 14:10 WIB',
      'status': 'Ditemukan',
      'icon': Icons.key_outlined,
    },
    {
      'name': 'Kartu Mahasiswa',
      'category': 'Kartu Identitas',
      'location': 'Gedung Perkuliahan',
      'time': 'Hari ini, 09:00 WIB',
      'status': 'Hilang',
      'icon': Icons.badge_outlined,
    },
    {
      'name': 'Laptop Abu-abu',
      'category': 'Elektronik',
      'location': 'Ruang Kelas 201',
      'time': 'Hari ini, 07:45 WIB',
      'status': 'Hilang',
      'icon': Icons.laptop_outlined,
    },
    {
      'name': 'Buku Catatan',
      'category': 'Alat Tulis',
      'location': 'Perpustakaan',
      'time': 'Kemarin, 13:20 WIB',
      'status': 'Ditemukan',
      'icon': Icons.menu_book_outlined,
    },
    {
      'name': 'Payung Hitam',
      'category': 'Lainnya',
      'location': 'Lobi Fakultas',
      'time': 'Kemarin, 11:00 WIB',
      'status': 'Ditemukan',
      'icon': Icons.umbrella_outlined,
    },
  ];

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  List<Map<String, dynamic>> get filteredItems {
    final query = searchController.text.toLowerCase();

    return items.where((item) {
      final matchesCategory = selectedCategory == 0 ||
          item['category'] == categories[selectedCategory];

      final matchesSearch =
          item['name'].toString().toLowerCase().contains(query) ||
              item['location'].toString().toLowerCase().contains(query);

      return matchesCategory && matchesSearch;
    }).toList();
  }

  void openItems({String? status}) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ItemsPage(initialStatus: status),
      ),
    );
  }

  void openDetail(Map<String, dynamic> item) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => DetailPage(item: item),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: IndexedStack(
          index: selectedTab,
          children: [
            _buildHome(),
            _buildSearchPage(),
            _buildSimplePage(
              Icons.assignment_outlined,
              'Laporan Saya',
              'Laporan barang yang kamu buat akan tampil di sini.',
            ),
            _buildSimplePage(
              Icons.notifications_none,
              'Notifikasi',
              'Informasi terbaru tentang laporan barang.',
            ),
            _buildSimplePage(
              Icons.person_outline,
              'Profil Saya',
              'Informasi akun pengguna FindIt Campus.',
            ),
          ],
        ),
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: selectedTab,
        onDestinationSelected: (index) {
          setState(() {
            selectedTab = index;
          });
        },
        backgroundColor: Colors.white,
        indicatorColor: paleBlue,
        labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: 'Beranda',
          ),
          NavigationDestination(
            icon: Icon(Icons.search),
            label: 'Cari',
          ),
          NavigationDestination(
            icon: Icon(Icons.add_box_outlined),
            label: 'Laporan',
          ),
          NavigationDestination(
            icon: Icon(Icons.notifications_none),
            label: 'Notifikasi',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            label: 'Profil',
          ),
        ],
      ),
    );
  }

  Widget _buildHome() {
    final displayedItems = filteredItems;

    return ListView(
      padding: EdgeInsets.zero,
      children: [
        _buildHeader(),
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 22),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHero(),
              const SizedBox(height: 14),
              _buildSearchField(),
              const SizedBox(height: 12),
              _buildActionCards(),
              const SizedBox(height: 20),
              _buildCategoryHeader(),
              const SizedBox(height: 10),
              _buildCategoryChips(),
              const SizedBox(height: 22),
              Row(
                children: [
                  const Icon(
                    Icons.check_circle_outline,
                    color: Color(0xFF16845B),
                    size: 21,
                  ),
                  const SizedBox(width: 7),
                  const Expanded(
                    child: Text(
                      'Barang Terbaru Ditemukan',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: ink,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => openItems(),
                    child: const Row(
                      children: [
                        Text(
                          'Lihat Semua',
                          style: TextStyle(
                            color: navy,
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Icon(
                          Icons.chevron_right,
                          color: navy,
                          size: 17,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 5),
              const Text(
                'Sudah diamankan oleh pelapor atau dititipkan di pos kampus.',
                style: TextStyle(
                  color: muted,
                  fontSize: 11,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 12),
              if (displayedItems.isEmpty)
                const Padding(
                  padding: EdgeInsets.all(30),
                  child: Center(
                    child: Text('Barang tidak ditemukan.'),
                  ),
                )
              else
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: displayedItems.length,
                  gridDelegate:
                  const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    mainAxisExtent: 218,
                  ),
                  itemBuilder: (context, index) {
                    return _buildItemCard(displayedItems[index]);
                  },
                ),
              const SizedBox(height: 16),
              _buildSecurityCard(),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildHeader() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: navy,
              borderRadius: BorderRadius.circular(9),
            ),
            child: const Icon(
              Icons.search,
              color: Colors.white,
              size: 25,
            ),
          ),
          const SizedBox(width: 9),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Jejak Barang',
                  style: TextStyle(
                    color: navy,
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Beranda',
                  style: TextStyle(color: muted, fontSize: 12),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 9,
              vertical: 7,
            ),
            decoration: BoxDecoration(
              color: paleBlue,
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Row(
              children: [
                Icon(Icons.location_city, size: 14, color: navy),
                SizedBox(width: 4),
                Text(
                  'Kampus Utama',
                  style: TextStyle(fontSize: 10, color: ink),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          const Icon(
            Icons.notifications_none,
            color: ink,
            size: 25,
          ),
          const SizedBox(width: 12),
          const CircleAvatar(
            radius: 16,
            backgroundColor: navy,
            child: Icon(
              Icons.person_outline,
              color: Colors.white,
              size: 20,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHero() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF2148B5), Color(0xFF092B96)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: navy.withValues(alpha: 0.12),
            blurRadius: 12,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 6,
            ),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.16),
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.circle,
                  size: 8,
                  color: Color(0xFF75F1C1),
                ),
                SizedBox(width: 6),
                Text(
                  'Siap Siaga Kampus',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 11,
                  ),
                ),
                SizedBox(width: 5),
                Text(
                  '• Terintegrasi Satpam',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 15),
          const Text(
            'Ada barang tertinggal hari ini?',
            style: TextStyle(
              color: Colors.white,
              fontSize: 23,
              height: 1.15,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 9),
          const Text(
            'Jangan panik! Komunitas mahasiswa dapat '
                'saling membantu menelusuri jejak barangmu.',
            style: TextStyle(
              color: Colors.white,
              fontSize: 13,
              height: 1.6,
            ),
          ),
          const SizedBox(height: 17),
          Row(
            children: [
              _buildStat('142', 'Kembali\nMinggu Ini'),
              const SizedBox(width: 8),
              _buildStat('94%', 'Tingkat\nKembali'),
              const SizedBox(width: 8),
              _buildStat('6 Pos', 'Lokasi\nPenitipan'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStat(String value, String label) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(9),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.12),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              value,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 17,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 3),
            Text(
              label,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 10,
                height: 1.3,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchField() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14),
      decoration: BoxDecoration(
        color: paleBlue,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          const Icon(Icons.search, color: ink),
          const SizedBox(width: 10),
          Expanded(
            child: TextField(
              controller: searchController,
              onChanged: (_) => setState(() {}),
              decoration: const InputDecoration(
                hintText: 'Cari KTM, tumbler, helm, kunci motor...',
                hintStyle: TextStyle(fontSize: 12, color: muted),
                border: InputBorder.none,
              ),
            ),
          ),
          const Icon(Icons.tune, color: navy),
        ],
      ),
    );
  }

  Widget _buildActionCards() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: _buildActionCard(
            icon: Icons.crisis_alert,
            title: 'Saya Hilang Barang',
            description: 'Buat laporan pencarian cepat ke seluruh fakultas.',
            buttonText: 'Buat Tiket',
            background: Colors.white,
            foreground: ink,
            iconBackground: const Color(0xFFFFDFDB),
            iconColor: const Color(0xFFCE3434),
            onTap: () => openItems(status: 'Hilang'),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildActionCard(
            icon: Icons.back_hand_outlined,
            title: 'Saya Menemukan',
            description: 'Amankan barang teman kampus dan catat titik temu.',
            buttonText: 'Laporkan Temuan',
            background: blue,
            foreground: Colors.white,
            iconBackground: Colors.white,
            iconColor: navy,
            onTap: () => openItems(status: 'Ditemukan'),
          ),
        ),
      ],
    );
  }

  Widget _buildActionCard({
    required IconData icon,
    required String title,
    required String description,
    required String buttonText,
    required Color background,
    required Color foreground,
    required Color iconBackground,
    required Color iconColor,
    required VoidCallback onTap,
  }) {
    return Material(
      color: background,
      borderRadius: BorderRadius.circular(14),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(14),
        child: Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            border: background == Colors.white
                ? Border.all(color: const Color(0xFFEDEDF5))
                : null,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                  color: iconBackground,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(icon, color: iconColor, size: 24),
              ),
              const SizedBox(height: 14),
              Text(
                title,
                style: TextStyle(
                  color: foreground,
                  fontSize: 17,
                  height: 1.2,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                description,
                style: TextStyle(
                  color: foreground,
                  fontSize: 11,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                '$buttonText  →',
                style: TextStyle(
                  color: background == Colors.white
                      ? const Color(0xFFCE3434)
                      : const Color(0xFFB8FFEB),
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryHeader() {
    return const Row(
      children: [
        Expanded(
          child: Text(
            'Kategori Populer',
            style: TextStyle(
              color: ink,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Text(
          'Geser untuk filter',
          style: TextStyle(color: muted, fontSize: 10),
        ),
      ],
    );
  }

  Widget _buildCategoryChips() {
    return SizedBox(
      height: 38,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        separatorBuilder: (_, _) => const SizedBox(width: 7),
        itemBuilder: (context, index) {
          final selected = selectedCategory == index;

          final icons = [
            Icons.grid_view,
            Icons.devices_outlined,
            Icons.watch_outlined,
            Icons.badge_outlined,
            Icons.menu_book_outlined,
            Icons.category_outlined,
          ];

          return ChoiceChip(
            selected: selected,
            showCheckmark: false,
            avatar: Icon(
              icons[index],
              size: 14,
              color: selected ? Colors.white : ink,
            ),
            label: Text(categories[index]),
            labelStyle: TextStyle(
              color: selected ? Colors.white : ink,
              fontSize: 11,
              fontWeight: selected ? FontWeight.w600 : FontWeight.normal,
            ),
            backgroundColor: paleBlue,
            selectedColor: navy,
            side: BorderSide.none,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(22),
            ),
            onSelected: (_) {
              setState(() {
                selectedCategory = index;
              });
            },
          );
        },
      ),
    );
  }

  Widget _buildItemCard(Map<String, dynamic> item) {
    final found = item['status'] == 'Ditemukan';

    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(14),
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: () => openDetail(item),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: const Color(0xFFECECF5)),
          ),
          clipBehavior: Clip.antiAlias,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Container(
                  width: double.infinity,
                  color: const Color(0xFFE9EDFC),
                  child: Stack(
                    children: [
                      Center(
                        child: Icon(
                          item['icon'] as IconData,
                          size: 48,
                          color: const Color(0xFF536BB5),
                        ),
                      ),
                      Positioned(
                        top: 9,
                        right: 7,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 5,
                          ),
                          decoration: BoxDecoration(
                            color: found
                                ? const Color(0xFF8CF0C5)
                                : const Color(0xFFFFD9D9),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            item['status'] as String,
                            style: TextStyle(
                              color: found
                                  ? const Color(0xFF075C42)
                                  : const Color(0xFFB42323),
                              fontSize: 9,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(9, 9, 9, 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item['name'] as String,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: ink,
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        const Icon(
                          Icons.location_on_outlined,
                          size: 13,
                          color: navy,
                        ),
                        const SizedBox(width: 3),
                        Expanded(
                          child: Text(
                            item['location'] as String,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              color: muted,
                              fontSize: 9,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),
                    Row(
                      children: [
                        const Icon(
                          Icons.access_time,
                          size: 12,
                          color: muted,
                        ),
                        const SizedBox(width: 3),
                        Expanded(
                          child: Text(
                            item['time'] as String,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              color: muted,
                              fontSize: 9,
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 8),
                    SizedBox(
                      width: double.infinity,
                      height: 29,
                      child: FilledButton(
                        onPressed: () => openDetail(item),
                        style: FilledButton.styleFrom(
                          backgroundColor: paleBlue,
                          foregroundColor: navy,
                          padding: EdgeInsets.zero,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text(
                          'Lihat Barang',
                          style: TextStyle(fontSize: 10),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSecurityCard() {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: const Color(0xFFF0F1FF),
        borderRadius: BorderRadius.circular(15),
      ),
      child: const Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            backgroundColor: paleBlue,
            child: Icon(
              Icons.account_balance_outlined,
              color: navy,
            ),
          ),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Posko Pengambilan Resmi',
                  style: TextStyle(
                    color: ink,
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                  ),
                ),
                SizedBox(height: 6),
                Text(
                  'Barang berharga wajib diverifikasi '
                      'sebelum diserahkan kepada pemiliknya.',
                  style: TextStyle(
                    color: muted,
                    fontSize: 11,
                    height: 1.5,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  '☎  Hubungi petugas kampus',
                  style: TextStyle(
                    color: navy,
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchPage() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Cari Barang',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: ink,
            ),
          ),
          const SizedBox(height: 14),
          _buildSearchField(),
          const SizedBox(height: 18),
          Expanded(
            child: ListView.builder(
              itemCount: filteredItems.length,
              itemBuilder: (context, index) {
                final item = filteredItems[index];

                return ListTile(
                  leading: Icon(
                    item['icon'] as IconData,
                    color: navy,
                  ),
                  title: Text(item['name'] as String),
                  subtitle: Text(item['location'] as String),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () =>
                      openItems(status: item['status'] as String),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSimplePage(
      IconData icon,
      String title,
      String description,
      ) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(28),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 58, color: navy),
            const SizedBox(height: 16),
            Text(
              title,
              style: const TextStyle(
                color: ink,
                fontSize: 23,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              description,
              textAlign: TextAlign.center,
              style: const TextStyle(color: muted, height: 1.5),
            ),
          ],
        ),
      ),
    );
  }
}
