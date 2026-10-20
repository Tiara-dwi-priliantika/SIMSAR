
import 'package:flutter/material.dart';
import '../../data/laporan_dummy.dart';
import '../../utils/app_colors.dart';

class AdminLaporanScreen extends StatelessWidget {
  const AdminLaporanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.navy,
        foregroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Kelola Laporan',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: ValueListenableBuilder<List<Laporan>>(
        valueListenable: LaporanDummy.laporan,
        builder: (context, daftarLaporan, child) {
          if (daftarLaporan.isEmpty) {
            return const Center(
              child: Text('Belum ada laporan kerusakan.'),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: daftarLaporan.length,
            itemBuilder: (context, index) {
              final laporan = daftarLaporan[index];

              return Card(
                color: Colors.white,
                elevation: 2,
                margin: const EdgeInsets.only(bottom: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 48,
                            height: 48,
                            decoration: BoxDecoration(
                              color: AppColors.lightBlue,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Icon(
                              laporan.ikon,
                              color: AppColors.navy,
                              size: 26,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment:
                                  CrossAxisAlignment.start,
                              children: [
                                Text(
                                  laporan.judul,
                                  style: const TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  laporan.id,
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey.shade600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          _StatusBadge(status: laporan.status),
                        ],
                      ),
                      const SizedBox(height: 14),
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
                        'Deskripsi Kerusakan',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        laporan.deskripsi,
                        style: TextStyle(
                          color: Colors.grey.shade700,
                          height: 1.4,
                        ),
                      ),
                      if (laporan.foto != null) ...[
                        const SizedBox(height: 12),
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
                        'Ubah Status Laporan',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      DropdownButtonFormField<String>(
                        initialValue: laporan.status,
                        isExpanded: true,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: AppColors.background,
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 12,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide.none,
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
                          if (statusBaru == null) return;

                          final daftarBaru =
                              List<Laporan>.from(
                            LaporanDummy.laporan.value,
                          );

                          final indexLaporan =
                              daftarBaru.indexWhere(
                            (item) => item.id == laporan.id,
                          );

                          if (indexLaporan == -1) return;

                          final laporanLama =
                              daftarBaru[indexLaporan];

                          daftarBaru[indexLaporan] = Laporan(
                            id: laporanLama.id,
                            kategori: laporanLama.kategori,
                            lokasi: laporanLama.lokasi,
                            deskripsi: laporanLama.deskripsi,
                            tanggal: laporanLama.tanggal,
                            status: statusBaru,
                            foto: laporanLama.foto,
                          );

                          LaporanDummy.laporan.value = daftarBaru;
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  Widget _barisInfo(IconData ikon, String teks) {
    return Row(
      children: [
        Icon(
          ikon,
          size: 17,
          color: AppColors.navy,
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            teks,
            style: TextStyle(
              color: Colors.grey.shade700,
              fontSize: 13,
            ),
          ),
        ),
      ],
    );
  }
}

class _StatusBadge extends StatelessWidget {
  final String status;

  const _StatusBadge({required this.status});

  @override
  Widget build(BuildContext context) {
    Color warna;

    switch (status) {
      case 'Selesai':
        warna = Colors.green;
        break;
      case 'Diproses':
        warna = Colors.blue;
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
        color: warna.withValues(alpha: 0.12),
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

String _formatTanggal(DateTime tanggal) {
  final hari = tanggal.day.toString().padLeft(2, '0');
  final bulan = tanggal.month.toString().padLeft(2, '0');

  return '$hari-$bulan-${tanggal.year}';
}
