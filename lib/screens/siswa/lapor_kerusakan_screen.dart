
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../data/laporan_dummy.dart';
import '../../utils/app_colors.dart';

class LaporKerusakanScreen extends StatefulWidget {
  const LaporKerusakanScreen({super.key});

  @override
  State<LaporKerusakanScreen> createState() =>
      _LaporKerusakanScreenState();
}

class _LaporKerusakanScreenState
    extends State<LaporKerusakanScreen> {
  final _formKey = GlobalKey<FormState>();
  final _lokasiLainnyaController = TextEditingController();
  final _deskripsiController = TextEditingController();

  final ImagePicker _imagePicker = ImagePicker();

  String? _kategori;
  String? _lokasi;


  Uint8List? _fotoBytes;

  bool _sedangMengirim = false;

  final List<String> _daftarKategori = [
    'Meja dan Kursi',
    'Komputer dan Laptop',
    'Peralatan Laboratorium',
    'Lampu dan Listrik',
    'Pintu dan Jendela',
    'Toilet dan Sanitasi',
    'Proyektor',
    'Lainnya',
  ];

  final List<String> _daftarLokasi = [
    'Ruang Kelas 10A',
    'Ruang Kelas 10B',
    'Ruang Kelas 11A',
    'Ruang Kelas 11B',
    'Ruang Kelas 12A',
    'Ruang Kelas 12B',
    'Laboratorium Komputer',
    'Perpustakaan',
    'Ruang Guru',
    'Toilet',
    'Halaman Sekolah',
    'Lokasi Lainnya',
  ];

  @override
  void dispose() {
    _lokasiLainnyaController.dispose();
    _deskripsiController.dispose();
    super.dispose();
  }

  Future<void> _pilihFoto(ImageSource sumber) async {
    try {
      final XFile? gambar = await _imagePicker.pickImage(
        source: sumber,
        imageQuality: 80,
        maxWidth: 1200,
      );

      if (gambar == null) return;

      final Uint8List bytes = await gambar.readAsBytes();

      if (!mounted) return;

      setState(() {
        _fotoBytes = bytes;
      });
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Gagal memilih foto: $e'),
        ),
      );
    }
  }

  void _tampilkanPilihanFoto() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(22),
        ),
      ),
      builder: (sheetContext) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(22),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 45,
                  height: 5,
                  decoration: BoxDecoration(
                    color: AppColors.lightGray,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Pilih Sumber Foto',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.navy,
                  ),
                ),
                const SizedBox(height: 20),
                ListTile(
                  leading: const CircleAvatar(
                    backgroundColor: AppColors.lightBlue,
                    child: Icon(
                      Icons.photo_library_outlined,
                      color: AppColors.navy,
                    ),
                  ),
                  title: const Text('Galeri'),
                  subtitle: const Text(
                    'Pilih foto dari perangkat',
                  ),
                  onTap: () {
                    Navigator.pop(sheetContext);
                    _pilihFoto(ImageSource.gallery);
                  },
                ),
                ListTile(
                  leading: const CircleAvatar(
                    backgroundColor: AppColors.lightBlue,
                    child: Icon(
                      Icons.camera_alt_outlined,
                      color: AppColors.navy,
                    ),
                  ),
                  title: const Text('Kamera'),
                  subtitle: const Text(
                    'Ambil foto secara langsung',
                  ),
                  onTap: () {
                    Navigator.pop(sheetContext);
                    _pilihFoto(ImageSource.camera);
                  },
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> _kirimLaporan() async {
    if (_sedangMengirim) return;

    if (!_formKey.currentState!.validate()) {
      return;
    }

    if (_fotoBytes == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Silakan tambahkan foto kerusakan terlebih dahulu.',
          ),
          backgroundColor: Colors.redAccent,
        ),
      );
      return;
    }

    setState(() {
      _sedangMengirim = true;
    });

    try {
      // Simulasi proses pengiriman laporan.
      await Future.delayed(const Duration(seconds: 1));

      if (!mounted) return;

      final String lokasiLaporan =
          _lokasi == 'Lokasi Lainnya'
              ? _lokasiLainnyaController.text.trim()
              : _lokasi!;

      // Simpan laporan ke sumber data bersama.
      final laporanBaru = Laporan(
        id: 'L${DateTime.now().microsecondsSinceEpoch}',
        kategori: _kategori!,
        lokasi: lokasiLaporan,
        deskripsi: _deskripsiController.text.trim(),
        tanggal: DateTime.now(),
        status: 'Menunggu',
        foto: _fotoBytes,
      );

      LaporanDummy.tambah(laporanBaru);

      setState(() {
        _sedangMengirim = false;
      });

      await showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (dialogContext) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            contentPadding: const EdgeInsets.fromLTRB(
              24,
              26,
              24,
              20,
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 70,
                  height: 70,
                  decoration: const BoxDecoration(
                    color: Color(0xFFE4F7EE),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.check_circle_rounded,
                    size: 45,
                    color: AppColors.green,
                  ),
                ),
                const SizedBox(height: 18),
                const Text(
                  'Laporan Berhasil Dibuat!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.bold,
                    color: AppColors.navy,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Laporan berhasil ditambahkan dan dapat '
                  'dilihat di riwayat laporan. Status awal '
                  'laporan adalah Menunggu.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 13,
                    height: 1.5,
                    color: AppColors.gray,
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(dialogContext);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.navy,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        vertical: 13,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text('Mengerti'),
                  ),
                ),
              ],
            ),
          );
        },
      );

      if (!mounted) return;

      _formKey.currentState!.reset();

      setState(() {
        _kategori = null;
        _lokasi = null;
        _fotoBytes = null;
        _lokasiLainnyaController.clear();
        _deskripsiController.clear();
      });
    } catch (e) {
      if (!mounted) return;

      setState(() {
        _sedangMengirim = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Gagal menambahkan laporan: $e'),
          backgroundColor: Colors.redAccent,
        ),
      );
    }
  }

  InputDecoration _dekorasiInput({
    required String label,
    required String hint,
    required IconData icon,
  }) {
    return InputDecoration(
      labelText: label,
      hintText: hint,
      prefixIcon: Icon(
        icon,
        color: AppColors.navy,
      ),
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 16,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(13),
        borderSide: const BorderSide(
          color: AppColors.lightGray,
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(13),
        borderSide: const BorderSide(
          color: AppColors.lightGray,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(13),
        borderSide: const BorderSide(
          color: AppColors.blue,
          width: 1.5,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(13),
        borderSide: const BorderSide(
          color: Colors.redAccent,
        ),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(13),
        borderSide: const BorderSide(
          color: Colors.redAccent,
          width: 1.5,
        ),
      ),
    );
  }

  Widget _judulBagian(
    String judul,
    String keterangan,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          judul,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
            color: AppColors.navy,
          ),
        ),
        const SizedBox(height: 5),
        Text(
          keterangan,
          style: const TextStyle(
            fontSize: 12,
            height: 1.5,
            color: AppColors.gray,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        foregroundColor: AppColors.navy,
        elevation: 0,
        centerTitle: false,
        title: const Text(
          'Buat Laporan',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(
              20,
              8,
              20,
              30,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // HEADER FORMULIR
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [
                        AppColors.navy,
                        AppColors.blue,
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Row(
                    children: [
                      Icon(
                        Icons.report_problem_outlined,
                        color: Colors.white,
                        size: 42,
                      ),
                      SizedBox(width: 15),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Laporkan Kerusakan',
                              style: TextStyle(
                                fontSize: 19,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(height: 6),
                            Text(
                              'Bantu kami menjaga fasilitas sekolah '
                              'tetap aman dan nyaman.',
                              style: TextStyle(
                                fontSize: 12,
                                height: 1.5,
                                color: Colors.white70,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 27),

                // KATEGORI KERUSAKAN
                _judulBagian(
                  'Kategori Kerusakan',
                  'Pilih fasilitas yang mengalami kerusakan.',
                ),
                const SizedBox(height: 12),

                DropdownButtonFormField<String>(
                  initialValue: _kategori,
                  isExpanded: true,
                  decoration: _dekorasiInput(
                    label: 'Kategori',
                    hint: 'Pilih kategori kerusakan',
                    icon: Icons.category_outlined,
                  ),
                  items: _daftarKategori.map((kategori) {
                    return DropdownMenuItem<String>(
                      value: kategori,
                      child: Text(kategori),
                    );
                  }).toList(),
                  onChanged: (nilai) {
                    setState(() {
                      _kategori = nilai;
                    });
                  },
                  validator: (nilai) {
                    if (nilai == null || nilai.isEmpty) {
                      return 'Silakan pilih kategori kerusakan.';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 25),

                // LOKASI KERUSAKAN
                _judulBagian(
                  'Lokasi Kerusakan',
                  'Tentukan lokasi fasilitas yang rusak.',
                ),
                const SizedBox(height: 12),

                DropdownButtonFormField<String>(
                  initialValue: _lokasi,
                  isExpanded: true,
                  decoration: _dekorasiInput(
                    label: 'Lokasi',
                    hint: 'Pilih lokasi kerusakan',
                    icon: Icons.location_on_outlined,
                  ),
                  items: _daftarLokasi.map((lokasi) {
                    return DropdownMenuItem<String>(
                      value: lokasi,
                      child: Text(lokasi),
                    );
                  }).toList(),
                  onChanged: (nilai) {
                    setState(() {
                      _lokasi = nilai;

                      if (nilai != 'Lokasi Lainnya') {
                        _lokasiLainnyaController.clear();
                      }
                    });
                  },
                  validator: (nilai) {
                    if (nilai == null || nilai.isEmpty) {
                      return 'Silakan pilih lokasi kerusakan.';
                    }
                    return null;
                  },
                ),

                if (_lokasi == 'Lokasi Lainnya') ...[
                  const SizedBox(height: 14),
                  TextFormField(
                    controller: _lokasiLainnyaController,
                    decoration: _dekorasiInput(
                      label: 'Lokasi Lainnya',
                      hint: 'Contoh: Gudang belakang sekolah',
                      icon: Icons.edit_location_alt_outlined,
                    ),
                    validator: (nilai) {
                      if (_lokasi == 'Lokasi Lainnya' &&
                          (nilai == null || nilai.trim().isEmpty)) {
                        return 'Silakan tulis lokasi kerusakan.';
                      }
                      return null;
                    },
                  ),
                ],

                const SizedBox(height: 25),

                // DESKRIPSI KERUSAKAN
                _judulBagian(
                  'Deskripsi Kerusakan',
                  'Jelaskan kondisi dan kerusakan yang ditemukan.',
                ),
                const SizedBox(height: 12),

                TextFormField(
                  controller: _deskripsiController,
                  maxLines: 5,
                  maxLength: 500,
                  textCapitalization: TextCapitalization.sentences,
                  decoration: _dekorasiInput(
                    label: 'Deskripsi',
                    hint: 'Contoh: Kaki kursi patah dan tidak '
                        'dapat digunakan.',
                    icon: Icons.description_outlined,
                  ),
                  validator: (nilai) {
                    if (nilai == null || nilai.trim().isEmpty) {
                      return 'Deskripsi kerusakan wajib diisi.';
                    }

                    if (nilai.trim().length < 10) {
                      return 'Deskripsi minimal 10 karakter.';
                    }

                    return null;
                  },
                ),

                const SizedBox(height: 20),

                // FOTO KERUSAKAN
                _judulBagian(
                  'Foto Kerusakan',
                  'Tambahkan foto sebagai bukti kondisi fasilitas.',
                ),
                const SizedBox(height: 12),

                if (_fotoBytes == null)
                  InkWell(
                    onTap: _tampilkanPilihanFoto,
                    borderRadius: BorderRadius.circular(16),
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                        vertical: 30,
                        horizontal: 20,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: AppColors.blue,
                          width: 1.2,
                        ),
                      ),
                      child: const Column(
                        children: [
                          Icon(
                            Icons.add_a_photo_outlined,
                            size: 45,
                            color: AppColors.blue,
                          ),
                          SizedBox(height: 12),
                          Text(
                            'Tambah Foto',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                              color: AppColors.navy,
                            ),
                          ),
                          SizedBox(height: 5),
                          Text(
                            'Ketuk untuk memilih galeri atau kamera',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 12,
                              color: AppColors.gray,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                else
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: AppColors.lightGray,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(15),
                          ),
                          child: Image.memory(
                            _fotoBytes!,
                            width: double.infinity,
                            height: 220,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return const SizedBox(
                                height: 220,
                                child: Center(
                                  child: Text(
                                    'Foto gagal ditampilkan',
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(12),
                          child: Row(
                            children: [
                              const Expanded(
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.check_circle,
                                      color: AppColors.green,
                                      size: 19,
                                    ),
                                    SizedBox(width: 7),
                                    Flexible(
                                      child: Text(
                                        'Foto berhasil dipilih',
                                        style: TextStyle(
                                          fontSize: 13,
                                          color: AppColors.navy,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              IconButton(
                                tooltip: 'Hapus foto',
                                onPressed: () {
                                  setState(() {
                                    _fotoBytes = null;
                                  });
                                },
                                icon: const Icon(
                                  Icons.delete_outline,
                                  color: Colors.redAccent,
                                ),
                              ),
                              IconButton(
                                tooltip: 'Ganti foto',
                                onPressed: _tampilkanPilihanFoto,
                                icon: const Icon(
                                  Icons.edit_outlined,
                                  color: AppColors.blue,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                const SizedBox(height: 30),

                // TOMBOL KIRIM LAPORAN
                SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: ElevatedButton.icon(
                    onPressed:
                        _sedangMengirim ? null : _kirimLaporan,
                    icon: _sedangMengirim
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            ),
                          )
                        : const Icon(Icons.send_rounded),
                    label: Text(
                      _sedangMengirim
                          ? 'Memproses...'
                          : 'Kirim Laporan',
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.navy,
                      foregroundColor: Colors.white,
                      disabledBackgroundColor: AppColors.gray,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 14),

                const Center(
                  child: Text(
                    'Pastikan informasi yang kamu masukkan sudah benar.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 11,
                      color: AppColors.gray,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
