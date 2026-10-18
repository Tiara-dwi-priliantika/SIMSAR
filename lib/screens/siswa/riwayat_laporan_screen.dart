
import 'package:flutter/material.dart';
import '../../utils/app_colors.dart';

class RiwayatLaporanScreen extends StatefulWidget {
  const RiwayatLaporanScreen({super.key});

  @override
  State<RiwayatLaporanScreen> createState() =>
      _RiwayatLaporanScreenState();
}

class _RiwayatLaporanScreenState extends State<RiwayatLaporanScreen> {
  final TextEditingController _searchController =
      TextEditingController();

  String _filterStatus = 'Semua';

  final List<Map<String, dynamic>> _laporan = [
    {
      'judul': 'Kursi Kelas Rusak',
      'kategori': 'Meja dan Kursi',
      'lokasi': 'Ruang Kelas 10A',
      'tanggal': '18 Okt 2026',
      'status': 'Diproses',
      'deskripsi': 'Kaki kursi mengalami kerusakan.',
      'icon': Icons.chair_alt_rounded,
    },
    {
      'judul': 'Lampu Tidak Menyala',
      'kategori': 'Kelistrikan',
      'lokasi': 'Ruang Kelas 8B',
      'tanggal': '16 Okt 2026',
      'status': 'Selesai',
      'deskripsi': 'Lampu kelas tidak dapat menyala.',
      'icon': Icons.lightbulb_outline_rounded,
    },
    {
      'judul': 'Komputer Tidak Berfungsi',
      'kategori': 'Elektronik',
      'lokasi': 'Laboratorium Komputer',
      'tanggal': '14 Okt 2026',
      'status': 'Menunggu',
      'deskripsi': 'Komputer tidak dapat dihidupkan.',
      'icon': Icons.computer_rounded,
    },
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<Map<String, dynamic>> get _laporanTersaring {
    final kataKunci = _searchController.text.toLowerCase();

    return _laporan.where((laporan) {
      final cocokStatus = _filterStatus == 'Semua' ||
          laporan['status'] == _filterStatus;

      final cocokPencarian =
          laporan['judul'].toString().toLowerCase().contains(
                kataKunci,
              ) ||
              laporan['lokasi'].toString().toLowerCase().contains(
                    kataKunci,
                  ) ||
              laporan['kategori'].toString().toLowerCase().contains(
                    kataKunci,
                  );

      return cocokStatus && cocokPencarian;
    }).toList();
  }

  Color _warnaStatus(String status) {
    switch (status) {
      case 'Menunggu':
        return const Color(0xFFE58A27);
      case 'Diproses':
        return const Color(0xFF2878C8);
      case 'Selesai':
        return const Color(0xFF21966A);
      default:
        return AppColors.gray;
    }
  }

  Color _latarStatus(String status) {
    switch (status) {
      case 'Menunggu':
        return const Color(0xFFFFF2DF);
      case 'Diproses':
        return const Color(0xFFE8F2FF);
      case 'Selesai':
        return const Color(0xFFE4F7EE);
      default:
        return AppColors.lightBlue;
    }
  }

  void _tampilkanDetail(Map<String, dynamic> laporan) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(24),
        ),
      ),
      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(22, 12, 22, 28),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 42,
                    height: 5,
                    decoration: BoxDecoration(
                      color: AppColors.lightGray,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                const SizedBox(height: 22),
                const Text(
                  'Detail Laporan',
                  style: TextStyle(
                    fontSize: 21,
                    fontWeight: FontWeight.bold,
                    color: AppColors.navy,
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Container(
                      width: 54,
                      height: 54,
                      decoration: BoxDecoration(
                        color: AppColors.lightBlue,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Icon(
                        laporan['icon'] as IconData,
                        size: 29,
                        color: AppColors.navy,
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            laporan['judul'].toString(),
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: AppColors.navy,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            laporan['tanggal'].toString(),
                            style: const TextStyle(
                              fontSize: 12,
                              color: AppColors.gray,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 22),
                _detailBaris(
                  'Kategori',
                  laporan['kategori'].toString(),
                ),
                _detailBaris(
                  'Lokasi',
                  laporan['lokasi'].toString(),
                ),
                _detailBaris(
                  'Tanggal',
                  laporan['tanggal'].toString(),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Deskripsi Kerusakan',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppColors.navy,
                  ),
                ),
                const SizedBox(height: 7),
                Text(
                  laporan['deskripsi'].toString(),
                  style: const TextStyle(
                    height: 1.5,
                    color: AppColors.gray,
                  ),
                ),
                const SizedBox(height: 18),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 13,
                    vertical: 9,
                  ),
                  decoration: BoxDecoration(
                    color: _latarStatus(
                      laporan['status'].toString(),
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    'Status: ${laporan['status']}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: _warnaStatus(
                        laporan['status'].toString(),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _detailBaris(String judul, String isi) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 13),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 85,
            child: Text(
              judul,
              style: const TextStyle(
                color: AppColors.gray,
                fontSize: 13,
              ),
            ),
          ),
          const Text(':  '),
          Expanded(
            child: Text(
              isi,
              style: const TextStyle(
                color: AppColors.navy,
                fontWeight: FontWeight.w500,
                fontSize: 13,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final laporan = _laporanTersaring;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(
            Icons.arrow_back_rounded,
            color: AppColors.navy,
          ),
        ),
        title: const Text(
          'Riwayat Laporan',
          style: TextStyle(
            color: AppColors.navy,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(20, 18, 20, 22),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(24),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Pantau laporan kerusakanmu',
                    style: TextStyle(
                      color: AppColors.gray,
                      fontSize: 13,
                    ),
                  ),
                  const SizedBox(height: 17),
                  Row(
                    children: [
                      _kartuRingkasan(
                        'Semua',
                        _laporan.length,
                        AppColors.navy,
                      ),
                      const SizedBox(width: 10),
                      _kartuRingkasan(
                        'Diproses',
                        _laporan
                            .where((e) => e['status'] == 'Diproses')
                            .length,
                        const Color(0xFF2878C8),
                      ),
                      const SizedBox(width: 10),
                      _kartuRingkasan(
                        'Selesai',
                        _laporan
                            .where((e) => e['status'] == 'Selesai')
                            .length,
                        const Color(0xFF21966A),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 18, 20, 10),
              child: TextField(
                controller: _searchController,
                onChanged: (_) => setState(() {}),
                decoration: InputDecoration(
                  hintText: 'Cari laporan atau lokasi...',
                  prefixIcon: const Icon(
                    Icons.search_rounded,
                    color: AppColors.gray,
                  ),
                  suffixIcon: _searchController.text.isNotEmpty
                      ? IconButton(
                          onPressed: () {
                            _searchController.clear();
                            setState(() {});
                          },
                          icon: const Icon(Icons.close_rounded),
                        )
                      : null,
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 15,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 48,
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                scrollDirection: Axis.horizontal,
                children: [
                  _tombolFilter('Semua'),
                  _tombolFilter('Menunggu'),
                  _tombolFilter('Diproses'),
                  _tombolFilter('Selesai'),
                ],
              ),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: laporan.isEmpty
                  ? _tampilanKosong()
                  : ListView.separated(
                      padding: const EdgeInsets.fromLTRB(
                        20,
                        8,
                        20,
                        24,
                      ),
                      itemCount: laporan.length,
                      separatorBuilder: (_, _) =>
                          const SizedBox(height: 12),
                      itemBuilder: (context, index) {
                        final item = laporan[index];
                        final status = item['status'].toString();
                        final warna = _warnaStatus(status);

                        return Material(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(17),
                          child: InkWell(
                            borderRadius: BorderRadius.circular(17),
                            onTap: () => _tampilkanDetail(item),
                            child: Container(
                              padding: const EdgeInsets.all(15),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(17),
                                border: Border.all(
                                  color: AppColors.lightGray,
                                ),
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    width: 52,
                                    height: 52,
                                    decoration: BoxDecoration(
                                      color: AppColors.lightBlue,
                                      borderRadius: BorderRadius.circular(14),
                                    ),
                                    child: Icon(
                                      item['icon'] as IconData,
                                      color: AppColors.navy,
                                      size: 28,
                                    ),
                                  ),
                                  const SizedBox(width: 13),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          item['judul'].toString(),
                                          style: const TextStyle(
                                            color: AppColors.navy,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14,
                                          ),
                                        ),
                                        const SizedBox(height: 7),
                                        Text(
                                          item['kategori'].toString(),
                                          style: const TextStyle(
                                            color: AppColors.gray,
                                            fontSize: 12,
                                          ),
                                        ),
                                        const SizedBox(height: 5),
                                        Row(
                                          children: [
                                            const Icon(
                                              Icons.location_on_outlined,
                                              size: 14,
                                              color: AppColors.gray,
                                            ),
                                            const SizedBox(width: 3),
                                            Expanded(
                                              child: Text(
                                                item['lokasi'].toString(),
                                                style: const TextStyle(
                                                  color: AppColors.gray,
                                                  fontSize: 12,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 9),
                                        Wrap(
                                          spacing: 8,
                                          runSpacing: 6,
                                          crossAxisAlignment:
                                              WrapCrossAlignment.center,
                                          children: [
                                            Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                horizontal: 9,
                                                vertical: 5,
                                              ),
                                              decoration: BoxDecoration(
                                                color: _latarStatus(status),
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                              child: Text(
                                                status,
                                                style: TextStyle(
                                                  color: warna,
                                                  fontSize: 11,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ),
                                            Text(
                                              item['tanggal'].toString(),
                                              style: const TextStyle(
                                                color: AppColors.gray,
                                                fontSize: 11,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  const Icon(
                                    Icons.chevron_right_rounded,
                                    color: AppColors.gray,
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
      ),
    );
  }

  Widget _kartuRingkasan(
    String judul,
    int jumlah,
    Color warna,
  ) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 13,
          horizontal: 5,
        ),
        decoration: BoxDecoration(
          color: AppColors.background,
          borderRadius: BorderRadius.circular(13),
        ),
        child: Column(
          children: [
            Text(
              jumlah.toString(),
              style: TextStyle(
                color: warna,
                fontSize: 23,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              judul,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: AppColors.gray,
                fontSize: 11,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _tombolFilter(String status) {
    final aktif = _filterStatus == status;

    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: ChoiceChip(
        label: Text(status),
        selected: aktif,
        onSelected: (_) {
          setState(() {
            _filterStatus = status;
          });
        },
        selectedColor: AppColors.navy,
        backgroundColor: Colors.white,
        side: BorderSide(
          color: aktif ? AppColors.navy : AppColors.lightGray,
        ),
        labelStyle: TextStyle(
          color: aktif ? Colors.white : AppColors.gray,
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
        showCheckmark: false,
      ),
    );
  }

  Widget _tampilanKosong() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 85,
              height: 85,
              decoration: const BoxDecoration(
                color: AppColors.lightBlue,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.search_off_rounded,
                size: 42,
                color: AppColors.navy,
              ),
            ),
            const SizedBox(height: 18),
            const Text(
              'Laporan tidak ditemukan',
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
                color: AppColors.navy,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Coba gunakan kata kunci atau filter status lain.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColors.gray,
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
