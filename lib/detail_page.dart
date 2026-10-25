
import 'package:flutter/material.dart';

const Color detailNavy = Color(0xFF102F9F);
const Color detailBlue = Color(0xFF2147B5);
const Color detailPaleBlue = Color(0xFFEAEDFF);
const Color detailInk = Color(0xFF17213B);
const Color detailMuted = Color(0xFF69738B);
const Color detailBackground = Color(0xFFF8F8FE);

class DetailPage extends StatelessWidget {
  final Map<String, dynamic> item;

  const DetailPage({
    super.key,
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    final isFound = item['status'] == 'Ditemukan';

    final statusColor = isFound
        ? const Color(0xFF16845B)
        : const Color(0xFFD94848);

    final statusBackground = isFound
        ? const Color(0xFFE0F7EC)
        : const Color(0xFFFFE8E8);

    return Scaffold(
      backgroundColor: detailBackground,
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: detailInk,
        elevation: 0,
        title: const Text(
          'Detail Barang',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: false,
      ),
      body: ListView(
        padding: const EdgeInsets.all(18),
        children: [
          _buildItemPreview(),
          const SizedBox(height: 18),
          Container(
            padding: const EdgeInsets.all(18),
            decoration: _cardDecoration(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 11,
                        vertical: 7,
                      ),
                      decoration: BoxDecoration(
                        color: statusBackground,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        item['status'] as String? ?? 'Tidak diketahui',
                        style: TextStyle(
                          color: statusColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 11,
                        vertical: 7,
                      ),
                      decoration: BoxDecoration(
                        color: detailPaleBlue,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        item['category'] as String? ?? 'Lainnya',
                        style: const TextStyle(
                          color: detailNavy,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                Text(
                  item['name'] as String? ?? 'Barang tanpa nama',
                  style: const TextStyle(
                    fontSize: 23,
                    fontWeight: FontWeight.bold,
                    color: detailInk,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Informasi barang',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: detailMuted,
                  ),
                ),
                const SizedBox(height: 17),
                _buildInfoRow(
                  Icons.category_outlined,
                  'Kategori',
                  item['category'] as String? ?? 'Lainnya',
                ),
                const SizedBox(height: 16),
                _buildInfoRow(
                  Icons.location_on_outlined,
                  'Lokasi',
                  item['location'] as String? ??
                      'Lokasi belum dicantumkan',
                ),
                const SizedBox(height: 16),
                _buildInfoRow(
                  Icons.access_time,
                  'Waktu laporan',
                  item['time'] as String? ??
                      'Waktu belum dicantumkan',
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(18),
            decoration: _cardDecoration(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Deskripsi Barang',
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: detailInk,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  item['description'] as String? ??
                      'Belum ada deskripsi tambahan untuk barang ini. '
                          'Silakan periksa kategori, lokasi, dan status '
                          'barang sebelum melakukan tindak lanjut.',
                  style: const TextStyle(
                    fontSize: 13,
                    height: 1.7,
                    color: detailMuted,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: detailPaleBlue,
              borderRadius: BorderRadius.circular(15),
            ),
            child: const Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.info_outline,
                  color: detailNavy,
                  size: 22,
                ),
                SizedBox(width: 10),
                Expanded(
                  child: Text(
                    'Pastikan ciri-ciri barang sesuai sebelum '
                        'mengambil atau menyerahkan barang. Untuk barang '
                        'berharga, lakukan verifikasi melalui petugas kampus.',
                    style: TextStyle(
                      fontSize: 12,
                      height: 1.6,
                      color: detailInk,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 22),
          SizedBox(
            height: 50,
            child: FilledButton.icon(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      isFound
                          ? 'Fitur klaim barang akan dikembangkan '
                          'pada tahap berikutnya.'
                          : 'Fitur tindak lanjut laporan akan '
                          'dikembangkan pada tahap berikutnya.',
                    ),
                  ),
                );
              },
              icon: Icon(
                isFound
                    ? Icons.check_circle_outline
                    : Icons.campaign_outlined,
              ),
              label: Text(
                isFound ? 'Klaim Barang' : 'Tindak Lanjuti',
              ),
              style: FilledButton.styleFrom(
                backgroundColor: detailNavy,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(13),
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildItemPreview() {
    final icon = item['icon'];

    return Container(
      height: 190,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            Color(0xFFE9EDFC),
            Color(0xFFDCE5FF),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Stack(
        children: [
          const Positioned(
            right: 14,
            top: 14,
            child: Icon(
              Icons.inventory_2_outlined,
              color: Color(0x33536BB5),
              size: 65,
            ),
          ),
          Center(
            child: Icon(
              icon is IconData ? icon : Icons.category_outlined,
              color: detailBlue,
              size: 82,
            ),
          ),
          Positioned(
            left: 14,
            bottom: 14,
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 11,
                vertical: 7,
              ),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.9),
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.image_outlined,
                    size: 15,
                    color: detailNavy,
                  ),
                  SizedBox(width: 5),
                  Text(
                    'Pratinjau barang',
                    style: TextStyle(
                      fontSize: 11,
                      color: detailNavy,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(
      IconData icon,
      String label,
      String value,
      ) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 39,
          height: 39,
          decoration: BoxDecoration(
            color: detailPaleBlue,
            borderRadius: BorderRadius.circular(11),
          ),
          child: Icon(
            icon,
            size: 20,
            color: detailNavy,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(
                  color: detailMuted,
                  fontSize: 11,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                value,
                style: const TextStyle(
                  color: detailInk,
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  BoxDecoration _cardDecoration() {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(17),
      border: Border.all(
        color: const Color(0xFFECECF5),
      ),
    );
  }
}
