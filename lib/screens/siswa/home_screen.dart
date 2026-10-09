
import 'package:flutter/material.dart';
import '../../utils/app_colors.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // HEADER SIMSAR
              Container(
                width: double.infinity,
                padding: const EdgeInsets.fromLTRB(20, 20, 16, 24),
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [AppColors.navy, AppColors.blue],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(28),
                    bottomRight: Radius.circular(28),
                  ),
                ),
                child: Row(
                  children: [
                    // LOGO ASLI SIMSAR
                    Container(
                      width: 54,
                      height: 54,
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(13),
                      ),
                      child: Image.asset(
                        'assets/logo_simsar.png',
                        width: 54,
                        height: 54,
                        fit: BoxFit.cover,
                        alignment: Alignment.center,
                      ),
                    ),
                    const SizedBox(width: 12),

                    // NAMA APLIKASI
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'SIMSAR',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 23,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            'Sistem Informasi Sarana dan '
                            'Prasarana Sekolah',
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 11,
                              height: 1.4,
                            ),
                          ),
                        ],
                      ),
                    ),

                    // NOTIFIKASI
                    IconButton(
                      tooltip: 'Notifikasi',
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              'Fitur notifikasi belum tersedia.',
                            ),
                          ),
                        );
                      },
                      icon: const Icon(
                        Icons.notifications_none_rounded,
                        color: Colors.white,
                        size: 27,
                      ),
                    ),
                  ],
                ),
              ),

              Padding(
                padding: const EdgeInsets.fromLTRB(20, 25, 20, 28),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // SAPAAN PENGGUNA
                    const Text(
                      'Halo, Tiara! 👋',
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: AppColors.navy,
                      ),
                    ),
                    const SizedBox(height: 7),
                    const Text(
                      'Yuk, ikut menjaga fasilitas sekolah '
                      'agar tetap nyaman digunakan.',
                      style: TextStyle(
                        fontSize: 14,
                        height: 1.5,
                        color: AppColors.gray,
                      ),
                    ),

                    const SizedBox(height: 24),

                    // AKSI UTAMA: BUAT LAPORAN
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [AppColors.navy, AppColors.blue],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.navy.withValues(alpha: 0.15),
                            blurRadius: 14,
                            offset: const Offset(0, 6),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 48,
                            height: 48,
                            decoration: BoxDecoration(
                              color: Colors.white24,
                              borderRadius: BorderRadius.circular(14),
                            ),
                            child: const Icon(
                              Icons.campaign_outlined,
                              color: Colors.white,
                              size: 29,
                            ),
                          ),
                          const SizedBox(height: 17),
                          const Text(
                            'Temukan fasilitas yang rusak?',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 19,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            'Laporkan kerusakannya agar dapat '
                            'segera ditindaklanjuti.',
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 13,
                              height: 1.5,
                            ),
                          ),
                          const SizedBox(height: 19),
                          SizedBox(
                            width: double.infinity,
                            height: 46,
                            child: ElevatedButton.icon(
                              onPressed: () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                      'Form laporan akan dibuat '
                                      'pada langkah berikutnya.',
                                    ),
                                  ),
                                );
                              },
                              icon: const Icon(Icons.add_rounded),
                              label: const Text(
                                'Buat Laporan',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                foregroundColor: AppColors.navy,
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 30),

                    // RINGKASAN LAPORAN
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Ringkasan Laporan',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: AppColors.navy,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 9,
                            vertical: 5,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.lightBlue,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Text(
                            'Data contoh',
                            style: TextStyle(
                              fontSize: 10,
                              color: AppColors.navy,
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 15),

                    Row(
                      children: [
                        Expanded(
                          child: _summaryCard(
                            icon: Icons.hourglass_top_rounded,
                            title: 'Menunggu',
                            count: '2',
                            color: const Color(0xFFE58A27),
                            background: const Color(0xFFFFF2DF),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: _summaryCard(
                            icon: Icons.handyman_outlined,
                            title: 'Diproses',
                            count: '1',
                            color: const Color(0xFF2878C8),
                            background: const Color(0xFFE8F2FF),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: _summaryCard(
                            icon: Icons.check_circle_outline_rounded,
                            title: 'Selesai',
                            count: '3',
                            color: const Color(0xFF21966A),
                            background: const Color(0xFFE4F7EE),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 30),

                    // LAPORAN TERBARU
                    const Text(
                      'Laporan Terbaru',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: AppColors.navy,
                      ),
                    ),
                    const SizedBox(height: 6),
                    const Text(
                      'Berikut beberapa laporan yang pernah dibuat.',
                      style: TextStyle(
                        fontSize: 13,
                        color: AppColors.gray,
                      ),
                    ),

                    const SizedBox(height: 15),

                    _reportCard(
                      icon: Icons.chair_alt_rounded,
                      title: 'Kursi Kelas Rusak',
                      location: 'Ruang Kelas 10A',
                      status: 'Diproses',
                      statusColor: const Color(0xFF2878C8),
                      statusBackground: const Color(0xFFE8F2FF),
                    ),

                    const SizedBox(height: 12),

                    _reportCard(
                      icon: Icons.lightbulb_outline_rounded,
                      title: 'Lampu Tidak Menyala',
                      location: 'Ruang Kelas 8B',
                      status: 'Selesai',
                      statusColor: const Color(0xFF21966A),
                      statusBackground: const Color(0xFFE4F7EE),
                    ),

                    const SizedBox(height: 22),

                    // INFORMASI PENDUKUNG
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: AppColors.lightBlue,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: const Color(0xFFD5E8F7),
                        ),
                      ),
                      child: const Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.info_outline_rounded,
                            color: AppColors.blue,
                            size: 25,
                          ),
                          SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Tips Pelaporan',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.navy,
                                  ),
                                ),
                                SizedBox(height: 6),
                                Text(
                                  'Gunakan foto yang jelas, pilih lokasi '
                                  'yang sesuai, dan jelaskan kerusakan '
                                  'secara singkat.',
                                  style: TextStyle(
                                    fontSize: 12,
                                    height: 1.5,
                                    color: AppColors.gray,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
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

  // KARTU RINGKASAN STATUS
  Widget _summaryCard({
    required IconData icon,
    required String title,
    required String count,
    required Color color,
    required Color background,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 15,
        horizontal: 5,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.lightGray),
      ),
      child: Column(
        children: [
          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              color: background,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              icon,
              color: color,
              size: 22,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            count,
            style: TextStyle(
              fontSize: 23,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 10,
              color: AppColors.gray,
            ),
          ),
        ],
      ),
    );
  }

  // KARTU LAPORAN TERBARU
  Widget _reportCard({
    required IconData icon,
    required String title,
    required String location,
    required String status,
    required Color statusColor,
    required Color statusBackground,
  }) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.lightGray),
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: AppColors.lightBlue,
              borderRadius: BorderRadius.circular(13),
            ),
            child: Icon(
              icon,
              color: AppColors.navy,
              size: 27,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: AppColors.navy,
                  ),
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    const Icon(
                      Icons.location_on_outlined,
                      size: 14,
                      color: AppColors.gray,
                    ),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        location,
                        style: const TextStyle(
                          fontSize: 12,
                          color: AppColors.gray,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    color: statusBackground,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    status,
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: statusColor,
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
