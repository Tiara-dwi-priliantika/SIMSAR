
import 'package:flutter/material.dart';
import '../../data/laporan_dummy.dart';
import '../../utils/app_colors.dart';

class AdminStatistikScreen extends StatelessWidget {
  const AdminStatistikScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.navy,
        foregroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Statistik Laporan',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: ValueListenableBuilder<List<Laporan>>(
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

          return ListView(
            padding: const EdgeInsets.all(20),
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      AppColors.navy,
                      AppColors.blue,
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Total Laporan Kerusakan',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '$total',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'Jumlah seluruh laporan yang tercatat',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              const Text(
                'Ringkasan Status',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              _BarisStatistik(
                judul: 'Menunggu',
                jumlah: menunggu,
                total: total,
                warna: Colors.orange,
                ikon: Icons.hourglass_empty_rounded,
              ),
              const SizedBox(height: 18),
              _BarisStatistik(
                judul: 'Diproses',
                jumlah: diproses,
                total: total,
                warna: Colors.blue,
                ikon: Icons.sync_rounded,
              ),
              const SizedBox(height: 18),
              _BarisStatistik(
                judul: 'Selesai',
                jumlah: selesai,
                total: total,
                warna: Colors.green,
                ikon: Icons.check_circle_outline_rounded,
              ),
              const SizedBox(height: 24),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.info_outline_rounded,
                      color: AppColors.navy,
                    ),
                    const SizedBox(width: 12),
                    const Expanded(
                      child: Text(
                        'Statistik diperbarui secara otomatis '
                        'ketika status laporan berubah. Data '
                        'saat ini masih menggunakan penyimpanan '
                        'dummy di dalam aplikasi.',
                        style: TextStyle(height: 1.5),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _BarisStatistik extends StatelessWidget {
  final String judul;
  final int jumlah;
  final int total;
  final Color warna;
  final IconData ikon;

  const _BarisStatistik({
    required this.judul,
    required this.jumlah,
    required this.total,
    required this.warna,
    required this.ikon,
  });

  @override
  Widget build(BuildContext context) {
    final persentase = total == 0 ? 0.0 : jumlah / total;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                  color: warna.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(ikon, color: warna),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  judul,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Text(
                '$jumlah laporan',
                style: TextStyle(
                  color: warna,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: LinearProgressIndicator(
              value: persentase,
              minHeight: 8,
              backgroundColor: Colors.grey.shade200,
              valueColor: AlwaysStoppedAnimation<Color>(warna),
            ),
          ),
          const SizedBox(height: 6),
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              '${(persentase * 100).toStringAsFixed(1)}%',
              style: TextStyle(
                color: Colors.grey.shade600,
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
