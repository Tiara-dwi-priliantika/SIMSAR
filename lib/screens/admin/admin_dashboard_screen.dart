
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
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: ValueListenableBuilder<List<Laporan>>(
          valueListenable: LaporanDummy.laporan,
          builder: (context, daftarLaporan, child) {
            final jumlahMenunggu = daftarLaporan
                .where((laporan) => laporan.status == 'Menunggu')
                .length;
            final jumlahDiproses = daftarLaporan
                .where((laporan) => laporan.status == 'Diproses')
                .length;
            final jumlahSelesai = daftarLaporan
                .where((laporan) => laporan.status == 'Selesai')
                .length;

            return ListView(
              padding: const EdgeInsets.all(20),
              children: [
                Row(
                  children: [
                    Image.asset(
                      'assets/logo_simsar.png',
                      width: 52,
                      height: 52,
                      fit: BoxFit.contain,
                    ),
                    const SizedBox(width: 12),
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'SIMSAR',
                            style: TextStyle(
                              color: AppColors.navy,
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'Sistem Informasi Sarana',
                            style: TextStyle(
                              color: AppColors.gray,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      tooltip: 'Keluar',
                      onPressed: () => _konfirmasiKeluar(context),
                      icon: const Icon(
                        Icons.logout_rounded,
                        color: AppColors.navy,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),

                Container(
                  padding: const EdgeInsets.all(22),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
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
                          'ADMIN SIMSAR',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Halo, ${akun.nama}!',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Pantau dan kelola laporan kerusakan sarana '
                        'sekolah melalui dashboard admin.',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 13,
                          height: 1.5,
                        ),
                      ),
                      const SizedBox(height: 18),
                      Row(
                        children: [
                          const Icon(
                            Icons.assignment_rounded,
                            color: Colors.white,
                            size: 20,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            '${daftarLaporan.length} laporan tercatat',
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 26),
                const Text(
                  'Ringkasan Laporan',
                  style: TextStyle(
                    color: AppColors.navy,
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
                  childAspectRatio: 1.45,
                  children: [
                    _kartuStatistik(
                      judul: 'Menunggu',
                      jumlah: jumlahMenunggu,
                      ikon: Icons.pending_actions_rounded,
                      warna: Colors.orange,
                    ),
                    _kartuStatistik(
                      judul: 'Diproses',
                      jumlah: jumlahDiproses,
                      ikon: Icons.build_circle_outlined,
                      warna: AppColors.blue,
                    ),
                    _kartuStatistik(
                      judul: 'Selesai',
                      jumlah: jumlahSelesai,
                      ikon: Icons.check_circle_outline_rounded,
                      warna: Colors.green,
                    ),
                    _kartuStatistik(
                      judul: 'Total Laporan',
                      jumlah: daftarLaporan.length,
                      ikon: Icons.assignment_outlined,
                      warna: AppColors.navy,
                    ),
                  ],
                ),

                const SizedBox(height: 26),
                const Text(
                  'Menu Admin',
                  style: TextStyle(
                    color: AppColors.navy,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 14),

                _kartuMenu(
                  ikon: Icons.assignment_rounded,
                  warna: AppColors.blue,
                  judul: 'Kelola Laporan',
                  deskripsi: 'Lihat laporan dan perbarui statusnya.',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const AdminLaporanScreen(),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 12),
                _kartuMenu(
                  ikon: Icons.bar_chart_rounded,
                  warna: Colors.green,
                  judul: 'Statistik Laporan',
                  deskripsi: 'Lihat ringkasan laporan berdasarkan status.',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const AdminStatistikScreen(),
                      ),
                    );
                  },
                ),

                const SizedBox(height: 26),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Expanded(
                      child: Text(
                        'Laporan Terbaru',
                        style: TextStyle(
                          color: AppColors.navy,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const AdminLaporanScreen(),
                          ),
                        );
                      },
                      child: const Text('Lihat semua'),
                    ),
                  ],
                ),
                const SizedBox(height: 8),

                if (daftarLaporan.isEmpty)
                  const _PesanKosong(
                    pesan: 'Belum ada laporan kerusakan.',
                  )
                else
                  ...daftarLaporan.take(3).map(
                    (laporan) => _kartuLaporanRingkas(laporan),
                  ),

                const SizedBox(height: 20),
                const Center(
                  child: Text(
                    'SIMSAR • Dashboard Admin',
                    style: TextStyle(
                      color: AppColors.gray,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _kartuStatistik({
    required String judul,
    required int jumlah,
    required IconData ikon,
    required Color warna,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColors.lightGray),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(ikon, color: warna, size: 28),
          Text(
            '$jumlah',
            style: const TextStyle(
              color: AppColors.navy,
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            judul,
            style: const TextStyle(
              color: AppColors.gray,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  Widget _kartuMenu({
    required IconData ikon,
    required Color warna,
    required String judul,
    required String deskripsi,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(18),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(18),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: AppColors.lightGray),
          ),
          child: Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: warna.withValues(alpha: 0.10),
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
                        color: AppColors.navy,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      deskripsi,
                      style: const TextStyle(
                        color: AppColors.gray,
                        fontSize: 12,
                      ),
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
  }

  Widget _kartuLaporanRingkas(Laporan laporan) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.lightGray),
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
                  style: const TextStyle(
                    color: AppColors.navy,
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  laporan.lokasi,
                  style: const TextStyle(
                    color: AppColors.gray,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 7),
                _labelStatus(laporan.status),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _labelStatus(String status) {
    final Color warna;

    switch (status) {
      case 'Selesai':
        warna = Colors.green;
        break;
      case 'Diproses':
        warna = AppColors.blue;
        break;
      default:
        warna = Colors.orange;
    }

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 9,
        vertical: 5,
      ),
      decoration: BoxDecoration(
        color: warna.withValues(alpha: 0.10),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        status,
        style: TextStyle(
          color: warna,
          fontSize: 11,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  void _konfirmasiKeluar(BuildContext context) {
    showDialog<void>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Keluar dari SIMSAR?'),
        content: const Text(
          'Apakah kamu yakin ingin keluar dari akun admin?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
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
  }
}

class AdminLaporanScreen extends StatelessWidget {
  const AdminLaporanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Kelola Laporan'),
        backgroundColor: AppColors.navy,
        foregroundColor: Colors.white,
      ),
      body: ValueListenableBuilder<List<Laporan>>(
        valueListenable: LaporanDummy.laporan,
        builder: (context, daftarLaporan, child) {
          if (daftarLaporan.isEmpty) {
            return const _PesanKosong(
              pesan: 'Belum ada laporan kerusakan.',
            );
          }

          return ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: daftarLaporan.length,
            separatorBuilder: (_, index) =>
                const SizedBox(height: 12),
            itemBuilder: (context, index) {
              final laporan = daftarLaporan[index];

              return _KartuDetailLaporan(
                laporan: laporan,
                onUbahStatus: (statusBaru) {
                  _ubahStatus(laporan, statusBaru);

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'Status laporan ${laporan.id} diperbarui.',
                      ),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }

  void _ubahStatus(Laporan laporan, String statusBaru) {
    final daftarBaru = LaporanDummy.laporan.value.map((item) {
      if (item.id != laporan.id) {
        return item;
      }

      return Laporan(
        id: item.id,
        kategori: item.kategori,
        lokasi: item.lokasi,
        deskripsi: item.deskripsi,
        tanggal: item.tanggal,
        status: statusBaru,
        foto: item.foto,
      );
    }).toList();

    LaporanDummy.laporan.value = daftarBaru;
  }
}

class _KartuDetailLaporan extends StatelessWidget {
  final Laporan laporan;
  final ValueChanged<String> onUbahStatus;

  const _KartuDetailLaporan({
    required this.laporan,
    required this.onUbahStatus,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColors.lightGray),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  laporan.judul,
                  style: const TextStyle(
                    color: AppColors.navy,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              _StatusBadge(status: laporan.status),
            ],
          ),
          const SizedBox(height: 12),
          _barisInfo(
            Icons.location_on_outlined,
            laporan.lokasi,
          ),
          const SizedBox(height: 8),
          _barisInfo(
            Icons.calendar_today_outlined,
            _formatTanggal(laporan.tanggal),
          ),
          const SizedBox(height: 12),
          const Text(
            'Deskripsi kerusakan',
            style: TextStyle(
              color: AppColors.navy,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            laporan.deskripsi,
            style: const TextStyle(
              color: AppColors.gray,
              height: 1.5,
            ),
          ),
          if (laporan.foto != null) ...[
            const SizedBox(height: 14),
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.memory(
                laporan.foto!,
                height: 180,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
          ],
          const SizedBox(height: 16),
          const Text(
            'Perbarui status laporan',
            style: TextStyle(
              color: AppColors.navy,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          DropdownButtonFormField<String>(
            initialValue: laporan.status,
            decoration: InputDecoration(
              filled: true,
              fillColor: AppColors.background,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 10,
              ),
            ),
            items: const [
              DropdownMenuItem(
                value: 'Menunggu',
                child: Text('Menunggu'),
              ),
              DropdownMenuItem(
                value: 'Diproses',
                child: Text('Diproses'),
              ),
              DropdownMenuItem(
                value: 'Selesai',
                child: Text('Selesai'),
              ),
            ],
            onChanged: (statusBaru) {
              if (statusBaru != null &&
                  statusBaru != laporan.status) {
                onUbahStatus(statusBaru);
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _barisInfo(IconData ikon, String teks) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          ikon,
          color: AppColors.gray,
          size: 17,
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            teks,
            style: const TextStyle(
              color: AppColors.gray,
              fontSize: 13,
            ),
          ),
        ),
      ],
    );
  }
}

class AdminStatistikScreen extends StatelessWidget {
  const AdminStatistikScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Statistik Laporan'),
        backgroundColor: AppColors.navy,
        foregroundColor: Colors.white,
      ),
      body: ValueListenableBuilder<List<Laporan>>(
        valueListenable: LaporanDummy.laporan,
        builder: (context, daftarLaporan, child) {
          final menunggu = daftarLaporan
              .where((item) => item.status == 'Menunggu')
              .length;
          final diproses = daftarLaporan
              .where((item) => item.status == 'Diproses')
              .length;
          final selesai = daftarLaporan
              .where((item) => item.status == 'Selesai')
              .length;
          final total = daftarLaporan.length;

          return ListView(
            padding: const EdgeInsets.all(20),
            children: [
              const Text(
                'Ringkasan Status Laporan',
                style: TextStyle(
                  color: AppColors.navy,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Jumlah laporan berdasarkan status saat ini.',
                style: TextStyle(color: AppColors.gray),
              ),
              const SizedBox(height: 24),
              _barisStatistik(
                'Menunggu',
                menunggu,
                total,
                Colors.orange,
              ),
              _barisStatistik(
                'Diproses',
                diproses,
                total,
                AppColors.blue,
              ),
              _barisStatistik(
                'Selesai',
                selesai,
                total,
                Colors.green,
              ),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(color: AppColors.lightGray),
                ),
                child: Column(
                  children: [
                    const Text(
                      'Total Laporan',
                      style: TextStyle(color: AppColors.gray),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '$total',
                      style: const TextStyle(
                        color: AppColors.navy,
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
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

  Widget _barisStatistik(
    String judul,
    int jumlah,
    int total,
    Color warna,
  ) {
    final progress = total == 0 ? 0.0 : jumlah / total;

    return Container(
      margin: const EdgeInsets.only(bottom: 18),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.lightGray),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  judul,
                  style: const TextStyle(
                    color: AppColors.navy,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Text(
                '$jumlah',
                style: TextStyle(
                  color: warna,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 9,
              backgroundColor: AppColors.lightGray,
              valueColor: AlwaysStoppedAnimation<Color>(warna),
            ),
          ),
        ],
      ),
    );
  }
}

class _StatusBadge extends StatelessWidget {
  final String status;

  const _StatusBadge({
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    final Color warna;

    switch (status) {
      case 'Selesai':
        warna = Colors.green;
        break;
      case 'Diproses':
        warna = AppColors.blue;
        break;
      default:
        warna = Colors.orange;
    }

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 6,
      ),
      decoration: BoxDecoration(
        color: warna.withValues(alpha: 0.10),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        status,
        style: TextStyle(
          color: warna,
          fontSize: 11,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class _PesanKosong extends StatelessWidget {
  final String pesan;

  const _PesanKosong({
    required this.pesan,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.lightGray),
      ),
      child: Column(
        children: [
          const Icon(
            Icons.inbox_outlined,
            color: AppColors.gray,
            size: 42,
          ),
          const SizedBox(height: 10),
          Text(
            pesan,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: AppColors.gray,
            ),
          ),
        ],
      ),
    );
  }
}

String _formatTanggal(DateTime tanggal) {
  final hari = tanggal.day.toString().padLeft(2, '0');
  final bulan = tanggal.month.toString().padLeft(2, '0');

  return '$hari-$bulan-${tanggal.year}';
}
