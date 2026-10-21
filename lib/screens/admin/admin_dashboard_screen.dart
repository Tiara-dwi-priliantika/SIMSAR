
import 'package:flutter/material.dart';

import '../../data/akun_dummy.dart';
import '../../data/laporan_dummy.dart';
import '../../utils/app_colors.dart';
import 'admin_laporan_screen.dart';
import 'admin_statistik_screen.dart';
import 'admin_profile_screen.dart';

class AdminDashboardScreen extends StatelessWidget {
  final AkunDummy akun;

  const AdminDashboardScreen({
    super.key,
    required this.akun,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: ValueListenableBuilder<List<Laporan>>(
          valueListenable: LaporanDummy.laporan,
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

            return SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header dashboard
                  Row(
                    children: [
                      Container(
                        width: 48,
                        height: 48,
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: Image.asset(
                          'assets/logo_simsar.png',
                          fit: BoxFit.contain,
                          errorBuilder: (context, error, stackTrace) {
                            return Icon(
                              Icons.business_rounded,
                              color: AppColors.navy,
                              size: 30,
                            );
                          },
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'SIMSAR',
                              style: TextStyle(
                                color: AppColors.navy,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              'Sistem Informasi Sarana',
                              style: TextStyle(
                                color: Colors.grey.shade600,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Notifikasi
                      IconButton(
                        tooltip: 'Notifikasi',
                        onPressed: () {
                          showDialog<void>(
                            context: context,
                            builder: (dialogContext) {
                              return AlertDialog(
                                title: const Row(
                                  children: [
                                    Icon(Icons.notifications_active_rounded),
                                    SizedBox(width: 10),
                                    Expanded(
                                      child: Text('Notifikasi'),
                                    ),
                                  ],
                                ),
                                content: SizedBox(
                                  width: double.maxFinite,
                                  child: daftarLaporan.isEmpty
                                      ? const Text(
                                          'Belum ada laporan kerusakan.',
                                        )
                                      : Column(
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              '$menunggu laporan menunggu '
                                              'ditindaklanjuti.',
                                            ),
                                            const SizedBox(height: 12),
                                            ...daftarLaporan.take(3).map(
                                              (laporan) => ListTile(
                                                contentPadding: EdgeInsets.zero,
                                                leading: Icon(
                                                  Icons.assignment_rounded,
                                                  color: AppColors.navy,
                                                ),
                                                title: Text(
                                                  laporan.judul,
                                                  maxLines: 2,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                                subtitle: Text(
                                                  'Status: ${laporan.status}',
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(dialogContext);
                                    },
                                    child: const Text('Tutup'),
                                  ),
                                  if (daftarLaporan.isNotEmpty)
                                    ElevatedButton(
                                      onPressed: () {
                                        Navigator.pop(dialogContext);
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                const AdminLaporanScreen(),
                                          ),
                                        );
                                      },
                                      child: const Text('Lihat Laporan'),
                                    ),
                                ],
                              );
                            },
                          );
                        },
                        icon: Stack(
                          clipBehavior: Clip.none,
                          children: [
                            Icon(
                              Icons.notifications_none_rounded,
                              color: AppColors.navy,
                              size: 27,
                            ),
                            if (menunggu > 0)
                              Positioned(
                                right: -2,
                                top: -2,
                                child: Container(
                                  width: 9,
                                  height: 9,
                                  decoration: const BoxDecoration(
                                    color: Colors.red,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),

                      // Profil admin
                      IconButton(
                        tooltip: 'Profil Admin',
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  AdminProfileScreen(akun: akun),
                            ),
                          );
                        },
                        icon: CircleAvatar(
                          radius: 17,
                          backgroundColor: AppColors.lightBlue,
                          child: Icon(
                            Icons.person_rounded,
                            color: AppColors.navy,
                            size: 22,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 24),

                  // Banner sambutan admin
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(22),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          AppColors.navy,
                          AppColors.blue,
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(22),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.18),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Text(
                            'ADMINISTRATOR',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1,
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Halo, ${akun.nama}!',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 23,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'Selamat datang di dashboard SIMSAR. '
                          'Pantau dan kelola laporan kerusakan '
                          'sarana sekolah dengan mudah.',
                          style: TextStyle(
                            color: Colors.white,
                            height: 1.5,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Ringkasan laporan
                  const Text(
                    'Ringkasan Laporan',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 14),

                  GridView.count(
                    crossAxisCount: 2,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    childAspectRatio: 1.5,
                    children: [
                      _KartuStatistik(
                        judul: 'Total Laporan',
                        jumlah: total,
                        ikon: Icons.assignment_rounded,
                        warna: AppColors.navy,
                      ),
                      _KartuStatistik(
                        judul: 'Menunggu',
                        jumlah: menunggu,
                        ikon: Icons.hourglass_empty_rounded,
                        warna: Colors.orange,
                      ),
                      _KartuStatistik(
                        judul: 'Diproses',
                        jumlah: diproses,
                        ikon: Icons.sync_rounded,
                        warna: Colors.blue,
                      ),
                      _KartuStatistik(
                        judul: 'Selesai',
                        jumlah: selesai,
                        ikon: Icons.check_circle_outline_rounded,
                        warna: Colors.green,
                      ),
                    ],
                  ),

                  const SizedBox(height: 26),

                  // Menu pengelolaan
                  const Text(
                    'Menu Pengelolaan',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 14),

                  _KartuMenuAdmin(
                    ikon: Icons.assignment_outlined,
                    judul: 'Kelola Laporan',
                    deskripsi:
                        'Lihat laporan dan perbarui status kerusakan.',
                    warna: AppColors.navy,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              const AdminLaporanScreen(),
                        ),
                      );
                    },
                  ),

                  const SizedBox(height: 12),

                  _KartuMenuAdmin(
                    ikon: Icons.bar_chart_rounded,
                    judul: 'Statistik Laporan',
                    deskripsi:
                        'Lihat ringkasan dan perkembangan laporan.',
                    warna: Colors.green,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              const AdminStatistikScreen(),
                        ),
                      );
                    },
                  ),

                  const SizedBox(height: 26),

                  // Laporan terbaru
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Laporan Terbaru',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  const AdminLaporanScreen(),
                            ),
                          );
                        },
                        child: const Text('Lihat Semua'),
                      ),
                    ],
                  ),

                  const SizedBox(height: 8),

                  if (daftarLaporan.isEmpty)
                    const _PesanKosong()
                  else
                    ...daftarLaporan.take(3).map(
                      (laporan) => _KartuLaporanTerbaru(
                        laporan: laporan,
                      ),
                    ),

                  const SizedBox(height: 20),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class _KartuStatistik extends StatelessWidget {
  final String judul;
  final int jumlah;
  final IconData ikon;
  final Color warna;

  const _KartuStatistik({
    required this.judul,
    required this.jumlah,
    required this.ikon,
    required this.warna,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(ikon, color: warna, size: 26),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '$jumlah',
                style: TextStyle(
                  color: warna,
                  fontSize: 23,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                judul,
                style: TextStyle(
                  color: Colors.grey.shade600,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _KartuMenuAdmin extends StatelessWidget {
  final IconData ikon;
  final String judul;
  final String deskripsi;
  final Color warna;
  final VoidCallback onTap;

  const _KartuMenuAdmin({
    required this.ikon,
    required this.judul,
    required this.deskripsi,
    required this.warna,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: warna.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(14),
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
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      deskripsi,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey.shade600,
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.chevron_right_rounded,
                color: Colors.grey.shade500,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _KartuLaporanTerbaru extends StatelessWidget {
  final Laporan laporan;

  const _KartuLaporanTerbaru({
    required this.laporan,
  });

  @override
  Widget build(BuildContext context) {
    Color warnaStatus;

    switch (laporan.status) {
      case 'Selesai':
        warnaStatus = Colors.green;
        break;
      case 'Diproses':
        warnaStatus = Colors.blue;
        break;
      default:
        warnaStatus = Colors.orange;
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: AppColors.lightBlue,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              laporan.ikon,
              color: AppColors.navy,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  laporan.judul,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  laporan.lokasi,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey.shade600,
                  ),
                ),
                const SizedBox(height: 7),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 9,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: warnaStatus.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    laporan.status,
                    style: TextStyle(
                      color: warnaStatus,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _PesanKosong extends StatelessWidget {
  const _PesanKosong();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Icon(
            Icons.assignment_outlined,
            size: 42,
            color: Colors.grey.shade400,
          ),
          const SizedBox(height: 10),
          Text(
            'Belum ada laporan',
            style: TextStyle(
              color: Colors.grey.shade600,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
