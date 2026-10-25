
import 'package:flutter/material.dart';
import 'detail_page.dart';

class ItemsPage extends StatefulWidget {
  final String? initialStatus;

  const ItemsPage({
    super.key,
    this.initialStatus,
  });

  @override
  State<ItemsPage> createState() => _ItemsPageState();
}

class _ItemsPageState extends State<ItemsPage> {
  int selectedCategory = 0;

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
      'name': 'Dompet Hitam',
      'category': 'Aksesori & Helm',
      'location': 'Perpustakaan Kampus',
      'time': 'Hari ini, 08:30 WIB',
      'status': 'Hilang',
      'icon': Icons.account_balance_wallet_outlined,
      'description': 'Dompet hitam dilaporkan hilang di '
          'sekitar perpustakaan kampus.',
    },
    {
      'name': 'Kunci Motor',
      'category': 'Aksesori & Helm',
      'location': 'Area Parkir Fakultas',
      'time': 'Kemarin, 14:10 WIB',
      'status': 'Ditemukan',
      'icon': Icons.key_outlined,
      'description': 'Satu set kunci motor ditemukan di area '
          'parkir fakultas.',
    },
    {
      'name': 'Kartu Mahasiswa',
      'category': 'Kartu Identitas',
      'location': 'Gedung Perkuliahan',
      'time': 'Hari ini, 09:00 WIB',
      'status': 'Hilang',
      'icon': Icons.badge_outlined,
      'description': 'Kartu mahasiswa dilaporkan hilang di '
          'sekitar gedung perkuliahan.',
    },
    {
      'name': 'Botol Minum Biru',
      'category': 'Aksesori & Helm',
      'location': 'Ruang Kelas',
      'time': 'Hari ini, 10:15 WIB',
      'status': 'Ditemukan',
      'icon': Icons.local_drink_outlined,
      'description': 'Botol minum biru ditemukan di ruang kelas.',
    },
    {
      'name': 'Earphone Putih',
      'category': 'Elektronik',
      'location': 'Lab Komputer 304',
      'time': 'Kemarin, 16:40 WIB',
      'status': 'Ditemukan',
      'icon': Icons.headphones_outlined,
      'description': 'Earphone putih ditemukan di laboratorium '
          'komputer 304.',
    },
    {
      'name': 'Laptop Abu-abu',
      'category': 'Elektronik',
      'location': 'Ruang Kelas 201',
      'time': 'Hari ini, 07:45 WIB',
      'status': 'Hilang',
      'icon': Icons.laptop_outlined,
      'description': 'Laptop abu-abu dilaporkan hilang di '
          'ruang kelas 201.',
    },
    {
      'name': 'Buku Catatan',
      'category': 'Alat Tulis',
      'location': 'Perpustakaan',
      'time': 'Kemarin, 13:20 WIB',
      'status': 'Ditemukan',
      'icon': Icons.menu_book_outlined,
      'description': 'Buku catatan ditemukan di perpustakaan.',
    },
    {
      'name': 'Payung Hitam',
      'category': 'Lainnya',
      'location': 'Lobi Fakultas',
      'time': 'Kemarin, 11:00 WIB',
      'status': 'Ditemukan',
      'icon': Icons.umbrella_outlined,
      'description': 'Payung hitam ditemukan di lobi fakultas.',
    },
  ];

  List<Map<String, dynamic>> get filteredItems {
    return items.where((item) {
      final matchesStatus = widget.initialStatus == null ||
          item['status'] == widget.initialStatus;

      final matchesCategory = selectedCategory == 0 ||
          item['category'] == categories[selectedCategory];

      return matchesStatus && matchesCategory;
    }).toList();
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
    final visibleItems = filteredItems;

    return Scaffold(
      backgroundColor: const Color(0xFFF8F8FE),
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: const Color(0xFF17213B),
        elevation: 0,
        title: Text(
          widget.initialStatus == null
              ? 'Daftar Barang'
              : 'Barang ${widget.initialStatus}',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: const Text(
              'Kategori Barang',
              style: TextStyle(
                color: Color(0xFF17213B),
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(
            height: 46,
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              scrollDirection: Axis.horizontal,
              itemCount: categories.length,
              separatorBuilder: (_, __) =>
              const SizedBox(width: 8),
              itemBuilder: (context, index) {
                final selected = selectedCategory == index;

                return ChoiceChip(
                  label: Text(categories[index]),
                  selected: selected,
                  showCheckmark: false,
                  labelStyle: TextStyle(
                    color: selected
                        ? Colors.white
                        : const Color(0xFF17213B),
                    fontSize: 11,
                    fontWeight: selected
                        ? FontWeight.w600
                        : FontWeight.normal,
                  ),
                  backgroundColor: const Color(0xFFEAEDFF),
                  selectedColor: const Color(0xFF102F9F),
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
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(18, 12, 18, 8),
            child: Text(
              '${visibleItems.length} barang ditemukan',
              style: const TextStyle(
                color: Color(0xFF69738B),
                fontSize: 12,
              ),
            ),
          ),
          Expanded(
            child: visibleItems.isEmpty
                ? const Center(
              child: Padding(
                padding: EdgeInsets.all(24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.inventory_2_outlined,
                      size: 48,
                      color: Color(0xFF69738B),
                    ),
                    SizedBox(height: 12),
                    Text(
                      'Tidak ada barang pada kategori ini.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xFF69738B),
                      ),
                    ),
                  ],
                ),
              ),
            )
                : ListView.separated(
              padding: const EdgeInsets.fromLTRB(
                16, 8, 16, 20,
              ),
              itemCount: visibleItems.length,
              separatorBuilder: (_, __) =>
              const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final item = visibleItems[index];
                final isFound =
                    item['status'] == 'Ditemukan';

                final statusColor = isFound
                    ? const Color(0xFF16845B)
                    : const Color(0xFFD94848);

                return Material(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(16),
                    onTap: () => openDetail(item),
                    child: Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: const Color(0xFFECECF5),
                        ),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 54,
                            height: 54,
                            decoration: BoxDecoration(
                              color: const Color(0xFFE9EDFC),
                              borderRadius:
                              BorderRadius.circular(13),
                            ),
                            child: Icon(
                              item['icon'] as IconData,
                              color: const Color(0xFF2147B5),
                              size: 27,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item['name'] as String,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF17213B),
                                  ),
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  item['category'] as String,
                                  style: const TextStyle(
                                    fontSize: 11,
                                    color: Color(0xFF69738B),
                                  ),
                                ),
                                const SizedBox(height: 5),
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.location_on_outlined,
                                      size: 13,
                                      color: Color(0xFF69738B),
                                    ),
                                    const SizedBox(width: 3),
                                    Expanded(
                                      child: Text(
                                        item['location'] as String,
                                        style: const TextStyle(
                                          fontSize: 10,
                                          color: Color(0xFF69738B),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 7),
                                Container(
                                  padding:
                                  const EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 4,
                                  ),
                                  decoration: BoxDecoration(
                                    color: statusColor.withValues(
                                      alpha: 0.10,
                                    ),
                                    borderRadius:
                                    BorderRadius.circular(7),
                                  ),
                                  child: Text(
                                    item['status'] as String,
                                    style: TextStyle(
                                      color: statusColor,
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 4),
                          const Icon(
                            Icons.chevron_right,
                            color: Color(0xFF69738B),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
