import 'package:flutter/material.dart';
import '../../utils/app_colors.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,

      appBar: AppBar(
        title: const Text(
          'SIMSAR',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.notifications_none),
          ),
        ],
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // Sapaan
            const Text(
              'Halo, Tiara! 👋',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: AppColors.navy,
              ),
            ),

            const SizedBox(height: 6),

            const Text(
              'Laporkan kerusakan fasilitas sekolah dengan mudah.',
              style: TextStyle(
                color: AppColors.gray,
              ),
            ),

            const SizedBox(height: 25),

            // Tombol lapor
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppColors.navy,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  const Icon(
                    Icons.report_problem_outlined,
                    color: Colors.white,
                    size: 40,
                  ),

                  const SizedBox(height: 15),

                  const Text(
                    'Ada fasilitas yang rusak?',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 6),

                  const Text(
                    'Yuk laporkan agar dapat segera ditindaklanjuti.',
                    style: TextStyle(
                      color: Colors.white70,
                    ),
                  ),

                  const SizedBox(height: 15),

                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: AppColors.navy,
                    ),
                    child: const Text(
                      'Lapor Kerusakan',
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 25),

            // Menu
            const Text(
              'Menu',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.navy,
              ),
            ),

            const SizedBox(height: 15),

            Row(
              children: [

                Expanded(
                  child: _menuCard(
                    icon: Icons.history,
                    title: 'Riwayat',
                  ),
                ),

                const SizedBox(width: 15),

                Expanded(
                  child: _menuCard(
                    icon: Icons.person_outline,
                    title: 'Profil',
                  ),
                ),
              ],
            ),

            const SizedBox(height: 25),

            // Informasi
            const Text(
              'Informasi',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.navy,
              ),
            ),

            const SizedBox(height: 15),

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
              ),
              child: const Row(
                children: [

                  Icon(
                    Icons.info_outline,
                    color: AppColors.blue,
                    size: 30,
                  ),

                  SizedBox(width: 12),

                  Expanded(
                    child: Text(
                      'Gunakan SIMSAR untuk melaporkan kerusakan fasilitas sekolah dan memantau status laporan.',
                      style: TextStyle(
                        color: AppColors.gray,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),

      // Navigasi bawah
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        selectedItemColor: AppColors.navy,
        unselectedItemColor: AppColors.gray,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: 'Beranda',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'Riwayat',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: 'Profil',
          ),
        ],
      ),
    );
  }

  Widget _menuCard({
    required IconData icon,
    required String title,
  }) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        children: [

          Icon(
            icon,
            size: 35,
            color: AppColors.navy,
          ),

          const SizedBox(height: 10),

          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: AppColors.navy,
            ),
          ),
        ],
      ),
    );
  }
}
