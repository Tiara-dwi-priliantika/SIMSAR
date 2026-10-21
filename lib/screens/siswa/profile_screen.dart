
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../data/akun_dummy.dart';
import '../../utils/app_colors.dart';
import '../auth/login_screen.dart';

class ProfileScreen extends StatefulWidget {
  final AkunDummy akun;

  const ProfileScreen({
    super.key,
    required this.akun,
  });

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final namaController = TextEditingController();
  final emailController = TextEditingController();
  final nisNipController = TextEditingController();

  Uint8List? fotoProfil;
  bool sedangEdit = false;

  @override
  void initState() {
    super.initState();
    isiDataProfil();
  }

  void isiDataProfil() {
    namaController.text = widget.akun.nama;
    emailController.text = widget.akun.email;
    nisNipController.text = widget.akun.nisNip;
  }

  Future<void> pilihFoto() async {
    final ImagePicker picker = ImagePicker();

    final XFile? foto = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 80,
      maxWidth: 800,
    );

    if (foto != null) {
      final bytes = await foto.readAsBytes();

      if (!mounted) return;

      setState(() {
        fotoProfil = bytes;
      });
    }
  }

  void simpanProfil() {
    final nama = namaController.text.trim();
    final email = emailController.text.trim();
    final nisNip = nisNipController.text.trim();

    if (nama.isEmpty || email.isEmpty || nisNip.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Semua data profil wajib diisi.'),
        ),
      );
      return;
    }

    if (!RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$')
        .hasMatch(email)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Masukkan email yang valid.'),
        ),
      );
      return;
    }

    // Pastikan email tidak digunakan akun lain.
    for (final akun in PengelolaAkun.daftarAkun) {
      if (!identical(akun, widget.akun) &&
          akun.email.toLowerCase() == email.toLowerCase()) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Email sudah digunakan akun lain.'),
          ),
        );
        return;
      }
    }

    setState(() {
      widget.akun.nama = nama;
      widget.akun.email = email;
      widget.akun.nisNip = nisNip;
      sedangEdit = false;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Profil berhasil diperbarui!'),
        backgroundColor: Colors.green,
      ),
    );
  }

  // Konfirmasi sebelum pengguna keluar dari akun.
  void konfirmasiLogout() {
    showDialog<void>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
          title: const Text(
            'Keluar dari Akun?',
            style: TextStyle(
              color: AppColors.navy,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: const Text(
            'Apakah kamu yakin ingin keluar dari akun SIMSAR?',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext);
              },
              child: const Text(
                'Batal',
                style: TextStyle(
                  color: AppColors.gray,
                ),
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: () {
                // Tutup dialog dan hapus riwayat halaman sebelumnya.
                Navigator.pop(dialogContext);

                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LoginScreen(),
                  ),
                  (route) => false,
                );
              },
              child: const Text('Ya, Keluar'),
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    namaController.dispose();
    emailController.dispose();
    nisNipController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text(
          'Profil Saya',
          style: TextStyle(
            color: AppColors.navy,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: AppColors.background,
        elevation: 0,
        iconTheme: const IconThemeData(
          color: AppColors.navy,
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              const SizedBox(height: 12),

              // FOTO PROFIL
              Stack(
                alignment: Alignment.bottomRight,
                children: [
                  CircleAvatar(
                    radius: 60,
                    backgroundColor: AppColors.lightBlue,
                    backgroundImage: fotoProfil != null
                        ? MemoryImage(fotoProfil!)
                        : null,
                    child: fotoProfil == null
                        ? const Icon(
                            Icons.person_rounded,
                            size: 65,
                            color: AppColors.navy,
                          )
                        : null,
                  ),
                  if (sedangEdit)
                    Material(
                      color: AppColors.blue,
                      shape: const CircleBorder(),
                      child: IconButton(
                        tooltip: 'Pilih foto',
                        onPressed: pilihFoto,
                        icon: const Icon(
                          Icons.camera_alt_outlined,
                          color: Colors.white,
                        ),
                      ),
                    ),
                ],
              ),

              const SizedBox(height: 16),

              Text(
                widget.akun.nama,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 23,
                  fontWeight: FontWeight.bold,
                  color: AppColors.navy,
                ),
              ),

              const SizedBox(height: 6),

              Text(
                widget.akun.email,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: AppColors.gray,
                  fontSize: 14,
                ),
              ),

              const SizedBox(height: 30),

              // KARTU DATA PROFIL
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: AppColors.lightGray,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Informasi Akun',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: AppColors.navy,
                      ),
                    ),

                    const SizedBox(height: 22),

                    _fieldProfil(
                      label: 'Nama Lengkap',
                      controller: namaController,
                      icon: Icons.person_outline,
                    ),

                    const SizedBox(height: 18),

                    _fieldProfil(
                      label: 'Email',
                      controller: emailController,
                      icon: Icons.email_outlined,
                      keyboardType: TextInputType.emailAddress,
                    ),

                    const SizedBox(height: 18),

                    _fieldProfil(
                      label: 'NIS/NIP',
                      controller: nisNipController,
                      icon: Icons.badge_outlined,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // TOMBOL EDIT DAN SIMPAN
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton.icon(
                  onPressed: () {
                    if (sedangEdit) {
                      simpanProfil();
                    } else {
                      setState(() {
                        sedangEdit = true;
                      });
                    }
                  },
                  icon: Icon(
                    sedangEdit
                        ? Icons.save_outlined
                        : Icons.edit_outlined,
                  ),
                  label: Text(
                    sedangEdit ? 'Simpan Perubahan' : 'Edit Profil',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.navy,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),

              if (sedangEdit) ...[
                const SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  height: 46,
                  child: OutlinedButton(
                    onPressed: () {
                      setState(() {
                        isiDataProfil();
                        sedangEdit = false;
                      });
                    },
                    child: const Text('Batal'),
                  ),
                ),
              ],

              const SizedBox(height: 28),

              // TOMBOL LOGOUT
              SizedBox(
                width: double.infinity,
                height: 50,
                child: OutlinedButton.icon(
                  onPressed: konfirmasiLogout,
                  icon: const Icon(Icons.logout_rounded),
                  label: const Text(
                    'Keluar dari Akun',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.red,
                    side: const BorderSide(
                      color: Colors.red,
                      width: 1.3,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 16),

              const Text(
                'SIMSAR • Sistem Informasi Sarana',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 12,
                  color: AppColors.gray,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _fieldProfil({
    required String label,
    required TextEditingController controller,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextField(
      controller: controller,
      readOnly: !sedangEdit,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
        filled: true,
        fillColor: sedangEdit
            ? AppColors.background
            : Colors.grey.shade50,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}
