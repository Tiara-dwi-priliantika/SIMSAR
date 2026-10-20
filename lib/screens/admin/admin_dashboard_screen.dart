
import 'package:flutter/material.dart';

import '../../data/akun_dummy.dart';
import '../../data/laporan_dummy.dart';
import '../../utils/app_colors.dart';
import '../auth/login_screen.dart';

class AdminDashboardScreen extends StatelessWidget {
  final AkunDummy akun;

  const AdminDashboardScreen({
    super.key,
    required this.akun,
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<List<Laporan>>(
      valueListenable: LaporanDummy.daftarLaporan,
      builder: (context, daftarLaporan, child) {
        final total = daftarLaporan.length;

        final menunggu = daftarLaporan
            .where((laporan) => laporan.status == 'Menunggu')
            .length;

        final diproses = daftarLaporan
            .where((laporan) => laporan.status == 'Diproses')
            .length;

        final selesai = daftarLaporan
            .where((laporan) => laporan.status == 'Selesai')
            .length;

        return Scaffold(
          backgroundColor: AppColors.background,
          appBar: AppBar(
            backgroundColor: Colors.white,
            surfaceTintColor: Colors.white,
            elevation: 0,
            automaticallyImplyLeading: false,
            title: Row(
              children: [
                Image.asset(
                  'assets/logo_simsar.png',
                  width: 42,
                  height: 42,
                  fit: BoxFit.contain,
                ),
                const SizedBox(width: 10),
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'SIMSAR',
                      style: TextStyle(
                        color: AppColors.navy,
                        fontSize: 19,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    Text(
                      'Panel Administrator',
                      style: TextStyle(
                        color: AppColors.gray,
                        fontSize: 10,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            actions: [
              IconButton(
                tooltip: 'Keluar',
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (dialogContext) => AlertDialog(
                      title: const Text('Keluar dari akun?'),
                      content: const Text(
                        'Kamu akan kembali ke halaman login SIMSAR.',
                      ),
                      actions: [
                        TextButton(
                          onPressed: () =>
                              Navigator.pop(dialogContext),
                          child: const Text('Batal'),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pop(dialogContext);

                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const LoginScreen(),
                              ),
                              (route) => false,
                            );
                          },
                          child: const Text('Keluar'),
                        ),
                      ],
                    ),
                  );
                },
                icon: const Icon(
                  Icons.logout_rounded,
                  color: AppColors.navy,
                ),
              ),
              const SizedBox(width: 8),
            ],
          ),
          body: SafeArea(
            child: RefreshIndicator(
              onRefresh: () async {
                await Future<void>.delayed(
                  const Duration(milliseconds: 300),
                );
              },
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: const EdgeInsets.fromLTRB(20, 18, 20, 28),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Sapaan admin
                    Text(
                      'Halo, ${akun.nama}! 👋',
                      style: const TextStyle(
                        color: AppColors.navy,
                        fontSize: 25,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 7),
                    const Text(
                      'Pantau kondisi sarana dan prasarana sekolah.',
                      style: TextStyle(
                        color: AppColors.gray,
                        fontSize: 13,
                        height: 1.5,
                      ),
                    ),

                    const SizedBox(height: 22),

                    // Banner admin
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(21),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [
                            AppColors.blue,
                            AppColors.navy,
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(22),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.navy.withValues(alpha: 0.15),
                            blurRadius: 18,
                            offset: const Offset(0, 8),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment:
                                  CrossAxisAlignment.start,
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 10,
                                    vertical: 5,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.white.withValues(
                                      alpha: 0.17,
                                    ),
                                    borderRadius:
                                        BorderRadius.circular(20),
                                  ),
                                  child: const Text(
                                    'ADMINISTRATOR',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 1,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 13),
                                const Text(
                                  'Kelola laporan\nkerusakan sekolah',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    height: 1.35,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                const Text(
                                  'Pantau laporan dan status perbaikan.',
                                  style: TextStyle(
                                    color: Colors.white70,
                                    fontSize: 12,
                                    height: 1.5,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 10),
                          Image.asset(
                            'assets/logo_simsar.png',
                            width: 76,
                            height: 76,
                            fit: BoxFit.contain,
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 27),

                    // Statistik
                    const Text(
                      'Ringkasan Laporan',
                      style: TextStyle(
                        color: AppColors.navy,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 5),
                    const Text(
                      'Statistik seluruh laporan yang masuk',
                      style: TextStyle(
                        color: AppColors.gray,
                        fontSize: 12,
                      ),
                    ),

                    const SizedBox(height: 15),

                    GridView.count(
                      crossAxisCount: 2,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      crossAxisSpacing: 13,
                      mainAxisSpacing: 13,
                      childAspectRatio: 1.48,
                      children: [
                        _kartuStatistik(
                          judul: 'Total Laporan',
                          jumlah: total,
                          ikon: Icons.assignment_outlined,
                          warna: const Color(0xFF3975D5),
                          latar: const Color(0xFFEAF2FF),
                        ),
                        _kartuStatistik(
                          judul: 'Menunggu',
                          jumlah: menunggu,
                          ikon: Icons.schedule_rounded,
                          warna: const Color(0xFFD18A16),
                          latar: const Color(0xFFFFF5E3),
                        ),
                        _kartuStatistik(
                          judul: 'Diproses',
                          jumlah: diproses,
                          ikon: Icons.handyman_outlined,
                          warna: const Color(0xFF1685B8),
                          latar: const Color(0xFFE7F6FC),
                        ),
                        _kartuStatistik(
                          judul: 'Selesai',
                          jumlah: selesai,
                          ikon: Icons.check_circle_outline_rounded,
                          warna: const Color(0xFF26965B),
                          latar: const Color(0xFFE8F8EE),
                        ),
                      ],
                    ),

                    const SizedBox(height: 28),

                    // Menu admin
                    const Text(
                      'Menu Pengelolaan',
                      style: TextStyle(
                        color: AppColors.navy,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 14),

                    _kartuMenu(
                      ikon: Icons.assignment_outlined,
                      judul: 'Kelola Laporan',
                      deskripsi:
                          'Lihat laporan dan tindak lanjuti kerusakan.',
                      warna: AppColors.blue,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => AdminLaporanScreen(
                              daftarLaporan: daftarLaporan,
                            ),
                          ),
                        );
                      },
                    ),

                    const SizedBox(height: 12),

                    _kartuMenu(
                      ikon: Icons.people_outline_rounded,
                      judul: 'Data Pengguna',
                      deskripsi:
                          'Lihat akun yang sudah terdaftar di SIMSAR.',
                      warna: AppColors.blue,
                      onTap: () {
                        _tampilkanPesan(
                          context,
                          'Menu data pengguna akan dikembangkan berikutnya.',
                        );
                      },
                    ),

                    const SizedBox(height: 12),

                    _kartuMenu(
                      ikon: Icons.bar_chart_rounded,
                      judul: 'Laporan Statistik',
                      deskripsi:
                          'Pantau ringkasan kondisi laporan kerusakan.',
                      warna: AppColors.blue,
                      onTap: () {
                        _tampilkanPesan(
                          context,
                          'Menu laporan statistik akan dikembangkan berikutnya.',
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _kartuStatistik({
    required String judul,
    required int jumlah,
    required IconData ikon,
    required Color warna,
    required Color latar,
  }) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(19),
        border: Border.all(
          color: const Color(0xFFE9EEF5),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: 39,
            height: 39,
            decoration: BoxDecoration(
              color: latar,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(ikon, color: warna, size: 22),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '$jumlah',
                style: TextStyle(
                  color: warna,
                  fontSize: 25,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                judul,
                style: const TextStyle(
                  color: AppColors.gray,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _kartuMenu({
    required IconData ikon,
    required String judul,
    required String deskripsi,
    required Color warna,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(18),
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            border: Border.all(
              color: const Color(0xFFE9EEF5),
            ),
          ),
          child: Row(
            children: [
              Container(
                width: 49,
                height: 49,
                decoration: BoxDecoration(
                  color: const Color(0xFFEAF2FF),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Icon(ikon, color: warna, size: 25),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      judul,
                      style: const TextStyle(
                        color: AppColors.navy,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      deskripsi,
                      style: const TextStyle(
                        color: AppColors.gray,
                        fontSize: 11,
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              const Icon(
                Icons.chevron_right_rounded,
                color: AppColors.gray,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _tampilkanPesan(BuildContext context, String pesan) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(pesan),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}

// Halaman daftar laporan yang bisa dibuka dari dashboard admin.
class AdminLaporanScreen extends StatelessWidget {
  final List<Laporan> daftarLaporan;

  const AdminLaporanScreen({
    super.key,
    required this.daftarLaporan,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Kelola Laporan'),
        backgroundColor: Colors.white,
        foregroundColor: AppColors.navy,
        surfaceTintColor: Colors.white,
      ),
      body: daftarLaporan.isEmpty
          ? Center(
              child: Padding(
                padding: const EdgeInsets.all(28),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.inbox_outlined,
                      size: 65,
                      color: AppColors.gray.withValues(alpha: 0.65),
                    ),
                    const SizedBox(height: 15),
                    const Text(
                      'Belum ada laporan',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: AppColors.navy,
                      ),
                    ),
                    const SizedBox(height: 7),
                    const Text(
                      'Laporan kerusakan yang masuk akan tampil di sini.',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: AppColors.gray),
                    ),
                  ],
                ),
              ),
            )
          : ListView.separated(
              padding: const EdgeInsets.all(18),
              itemCount: daftarLaporan.length,
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final laporan = daftarLaporan[index];

                return Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(17),
                    border: Border.all(
                      color: const Color(0xFFE9EEF5),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Icon(
                            Icons.build_outlined,
                            color: AppColors.blue,
                          ),
                          const SizedBox(width: 9),
                          Expanded(
                            child: Text(
                              laporan.kategori,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: AppColors.navy,
                              ),
                            ),
                          ),
                          _labelStatus(laporan.status),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Text(
                        laporan.lokasi,
                        style: const TextStyle(
                          fontSize: 13,
                          color: AppColors.gray,
                        ),
                      ),
                      const SizedBox(height: 7),
                      Text(
                        laporan.deskripsi,
                        style: const TextStyle(
                          color: AppColors.navy,
                          height: 1.4,
                        ),
                      ),
                      if (laporan.foto != null) ...[
                        const SizedBox(height: 12),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.memory(
                            laporan.foto!,
                            height: 160,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ],
                      const SizedBox(height: 12),
                      const Divider(),
                      Row(
                        children: [
                          const Icon(
                            Icons.calendar_today_outlined,
                            size: 14,
                            color: AppColors.gray,
                          ),
                          const SizedBox(width: 6),
                          Expanded(
                            child: Text(
                              laporan.tanggal,
                              style: const TextStyle(
                                color: AppColors.gray,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }

  Widget _labelStatus(String status) {
    Color warna;
    Color latar;

    switch (status.toLowerCase()) {
      case 'selesai':
        warna = const Color(0xFF23834B);
        latar = const Color(0xFFE8F8EE);
        break;
      case 'diproses':
      case 'sedang diperbaiki':
        warna = const Color(0xFF2475B8);
        latar = const Color(0xFFE7F3FF);
        break;
      default:
        warna = const Color(0xFFB7791F);
        latar = const Color(0xFFFFF3DC);
    }

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 9,
        vertical: 5,
      ),
      decoration: BoxDecoration(
        color: latar,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        status,
        style: TextStyle(
          color: warna,
          fontSize: 10,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
