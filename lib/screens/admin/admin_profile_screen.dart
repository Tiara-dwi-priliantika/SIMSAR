
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../data/akun_dummy.dart';
import '../../utils/app_colors.dart';
import '../auth/login_screen.dart';

class AdminProfileScreen extends StatefulWidget {
  final AkunDummy akun;

  const AdminProfileScreen({
    super.key,
    required this.akun,
  });

  @override
  State<AdminProfileScreen> createState() => _AdminProfileScreenState();
}

class _AdminProfileScreenState extends State<AdminProfileScreen> {
  late TextEditingController namaController;
  late TextEditingController emailController;
  late TextEditingController nisNipController;

  Uint8List? fotoProfil;
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();

    namaController = TextEditingController(text: widget.akun.nama);
    emailController = TextEditingController(text: widget.akun.email);
    nisNipController = TextEditingController(text: widget.akun.nisNip);
  }

  @override
  void dispose() {
    namaController.dispose();
    emailController.dispose();
    nisNipController.dispose();
    super.dispose();
  }

  // Memilih foto profil dari perangkat
  Future<void> _pilihFotoProfil() async {
    try {
      final XFile? gambar = await _picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 80,
        maxWidth: 800,
      );

      if (gambar == null) return;

      final Uint8List bytes = await gambar.readAsBytes();

      if (!mounted) return;

      setState(() {
        fotoProfil = bytes;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Foto profil berhasil diganti.'),
        ),
      );
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Gagal memilih foto. Silakan coba lagi.'),
        ),
      );
    }
  }

  // Mengembalikan foto profil ke ikon default
  void _hapusFotoProfil() {
    setState(() {
      fotoProfil = null;
    });

    Navigator.pop(context);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Foto profil dikembalikan ke foto default.'),
      ),
    );
  }

  // Menu untuk mengatur foto profil
  void _tampilkanMenuFoto() {
    showModalBottomSheet<void>(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(22),
        ),
      ),
      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Foto Profil Admin',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 18),
                ListTile(
                  leading: const Icon(
                    Icons.photo_library_outlined,
                    color: Color(0xFF173A67),
                  ),
                  title: const Text('Pilih Foto dari Galeri'),
                  onTap: () {
                    Navigator.pop(context);
                    _pilihFotoProfil();
                  },
                ),
                if (fotoProfil != null)
                  ListTile(
                    leading: const Icon(
                      Icons.delete_outline_rounded,
                      color: Colors.red,
                    ),
                    title: const Text('Hapus Foto Profil'),
                    onTap: _hapusFotoProfil,
                  ),
                const SizedBox(height: 8),
              ],
            ),
          ),
        );
      },
    );
  }

  // Mengedit informasi akun
  void _editProfil() {
    namaController.text = widget.akun.nama;
    emailController.text = widget.akun.email;
    nisNipController.text = widget.akun.nisNip;

    showDialog<void>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Edit Profil'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: namaController,
                  decoration: const InputDecoration(
                    labelText: 'Nama Lengkap',
                    prefixIcon: Icon(Icons.person_outline_rounded),
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 14),
                TextField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    prefixIcon: Icon(Icons.email_outlined),
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 14),
                TextField(
                  controller: nisNipController,
                  decoration: const InputDecoration(
                    labelText: 'NIS/NIP',
                    prefixIcon: Icon(Icons.badge_outlined),
                    border: OutlineInputBorder(),
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: const Text('Batal'),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.navy,
                foregroundColor: Colors.white,
              ),
              onPressed: () {
                final nama = namaController.text.trim();
                final email = emailController.text.trim();
                final nisNip = nisNipController.text.trim();

                if (nama.isEmpty ||
                    email.isEmpty ||
                    nisNip.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Semua kolom harus diisi.'),
                    ),
                  );
                  return;
                }

                setState(() {
                  widget.akun.nama = nama;
                  widget.akun.email = email;
                  widget.akun.nisNip = nisNip;
                });

                Navigator.pop(dialogContext);

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Profil berhasil diperbarui.'),
                  ),
                );
              },
              child: const Text('Simpan'),
            ),
          ],
        );
      },
    );
  }

  // Konfirmasi logout
  void _konfirmasiKeluar() {
    showDialog<void>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Keluar dari akun?'),
          content: const Text(
            'Apakah kamu yakin ingin keluar dari akun admin?',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: const Text('Batal'),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.navy,
                foregroundColor: Colors.white,
              ),
              onPressed: () {
                Navigator.pop(dialogContext);

                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LoginScreen(),
                  ),
                  (route) => false,
                );
              },
              child: const Text('Keluar'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.navy,
        foregroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Profil Admin',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          // Kartu profil admin
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(24),
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
              children: [
                // Foto profil dengan tombol kamera
                Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.2),
                        shape: BoxShape.circle,
                      ),
                      child: CircleAvatar(
                        radius: 48,
                        backgroundColor: Colors.white,
                        backgroundImage: fotoProfil != null
                            ? MemoryImage(fotoProfil!)
                            : null,
                        child: fotoProfil == null
                            ? const Icon(
                                Icons.person_rounded,
                                size: 58,
                                color: Color(0xFF173A67),
                              )
                            : null,
                      ),
                    ),
                    Material(
                      color: Colors.white,
                      shape: const CircleBorder(),
                      child: InkWell(
                        onTap: _tampilkanMenuFoto,
                        customBorder: const CircleBorder(),
                        child: const Padding(
                          padding: EdgeInsets.all(9),
                          child: Icon(
                            Icons.camera_alt_rounded,
                            size: 20,
                            color: Color(0xFF173A67),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 12),

                TextButton.icon(
                  onPressed: _tampilkanMenuFoto,
                  icon: const Icon(
                    Icons.add_a_photo_outlined,
                    size: 17,
                  ),
                  label: const Text('Ganti Foto Profil'),
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.white,
                  ),
                ),

                const SizedBox(height: 8),

                Text(
                  widget.akun.nama,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 21,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 6),

                Text(
                  widget.akun.email,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 13,
                  ),
                ),

                const SizedBox(height: 14),

                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 7,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.18),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.verified_user_rounded,
                        color: Colors.white,
                        size: 16,
                      ),
                      SizedBox(width: 7),
                      Text(
                        'ADMINISTRATOR',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 26),

          const Text(
            'Informasi Akun',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 14),

          _InformasiProfil(
            ikon: Icons.person_outline_rounded,
            judul: 'Nama Lengkap',
            isi: widget.akun.nama,
          ),

          _InformasiProfil(
            ikon: Icons.email_outlined,
            judul: 'Alamat Email',
            isi: widget.akun.email,
          ),

          _InformasiProfil(
            ikon: Icons.badge_outlined,
            judul: 'NIS/NIP',
            isi: widget.akun.nisNip,
          ),

          _InformasiProfil(
            ikon: Icons.admin_panel_settings_outlined,
            judul: 'Hak Akses',
            isi: 'Administrator',
          ),

          const SizedBox(height: 24),

          SizedBox(
            height: 50,
            child: ElevatedButton.icon(
              onPressed: _editProfil,
              icon: const Icon(Icons.edit_rounded),
              label: const Text(
                'Edit Profil',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.navy,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
            ),
          ),

          const SizedBox(height: 12),

          SizedBox(
            height: 50,
            child: OutlinedButton.icon(
              onPressed: _konfirmasiKeluar,
              icon: const Icon(Icons.logout_rounded),
              label: const Text(
                'Keluar dari Akun',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              style: OutlinedButton.styleFrom(
                foregroundColor: Colors.red,
                side: const BorderSide(color: Colors.red),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
            ),
          ),

          const SizedBox(height: 24),

          Center(
            child: Text(
              'SIMSAR • Sistem Informasi Sarana',
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey.shade600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _InformasiProfil extends StatelessWidget {
  final IconData ikon;
  final String judul;
  final String isi;

  const _InformasiProfil({
    required this.ikon,
    required this.judul,
    required this.isi,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
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
              ikon,
              color: AppColors.navy,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  judul,
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  isi.isEmpty ? '-' : isi,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
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
