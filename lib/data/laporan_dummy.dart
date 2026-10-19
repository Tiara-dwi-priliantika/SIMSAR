
import 'dart:typed_data';

import 'package:flutter/material.dart';

class Laporan {
  final String id;
  final String kategori;
  final String lokasi;
  final String deskripsi;
  final DateTime tanggal;
  final String status;
  final Uint8List? foto;

  Laporan({
    required this.id,
    required this.kategori,
    required this.lokasi,
    required this.deskripsi,
    required this.tanggal,
    required this.status,
    this.foto,
  });

  String get judul {
    switch (kategori) {
      case 'Meja dan Kursi':
        return 'Kerusakan Meja dan Kursi';
      case 'Komputer dan Laptop':
        return 'Kerusakan Komputer';
      case 'Peralatan Laboratorium':
        return 'Kerusakan Peralatan Laboratorium';
      case 'Lampu dan Listrik':
        return 'Kerusakan Lampu dan Listrik';
      case 'Pintu dan Jendela':
        return 'Kerusakan Pintu dan Jendela';
      case 'Toilet dan Sanitasi':
        return 'Kerusakan Toilet dan Sanitasi';
      case 'Proyektor':
        return 'Kerusakan Proyektor';
      default:
        return 'Laporan Kerusakan Lainnya';
    }
  }

  IconData get ikon {
    switch (kategori) {
      case 'Meja dan Kursi':
        return Icons.chair_alt_rounded;
      case 'Komputer dan Laptop':
        return Icons.computer_rounded;
      case 'Peralatan Laboratorium':
        return Icons.science_rounded;
      case 'Lampu dan Listrik':
        return Icons.lightbulb_outline_rounded;
      case 'Pintu dan Jendela':
        return Icons.door_front_door_rounded;
      case 'Toilet dan Sanitasi':
        return Icons.wash_rounded;
      case 'Proyektor':
        return Icons.videocam_outlined;
      default:
        return Icons.build_rounded;
    }
  }
}

class LaporanDummy {
  static final ValueNotifier<List<Laporan>> laporan =
      ValueNotifier<List<Laporan>>([
    Laporan(
      id: 'L001',
      kategori: 'Meja dan Kursi',
      lokasi: 'Ruang Kelas 10A',
      deskripsi: 'Kaki kursi mengalami kerusakan.',
      tanggal: DateTime(2026, 10, 18),
      status: 'Diproses',
    ),
    Laporan(
      id: 'L002',
      kategori: 'Lampu dan Listrik',
      lokasi: 'Ruang Kelas 8B',
      deskripsi: 'Lampu kelas tidak dapat menyala.',
      tanggal: DateTime(2026, 10, 16),
      status: 'Selesai',
    ),
    Laporan(
      id: 'L003',
      kategori: 'Komputer dan Laptop',
      lokasi: 'Laboratorium Komputer',
      deskripsi: 'Komputer tidak dapat dihidupkan.',
      tanggal: DateTime(2026, 10, 14),
      status: 'Menunggu',
    ),
  ]);

  static void tambah(Laporan laporanBaru) {
    laporan.value = [
      laporanBaru,
      ...laporan.value,
    ];
  }
}
