
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
  Uint8List? fotoProfilSebelumEdit;

  final ImagePicker _picker = ImagePicker();

  bool sedangEdit = false;

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

  // Memulai mode edit untuk seluruh informasi profil.
  void _mulaiEditProfil() {
    setState(() {
      namaController.text = widget.akun.nama;
      emailController.text = widget.akun.email;
      nisNipController.text = widget.akun.nisNip;

      fotoProfilSebelumEdit = fotoProfil;
      sedangEdit = true;
    });
  }

  // Memilih foto hanya ketika mode edit aktif.
  Future<void> _pilihFotoProfil() async {
    if (!sedangEdit) return;

    try {
      final XFile? gambar = await _picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 80,
        maxWidth: 800,
      );

      if (gambar == null) return;

      final Uint8List bytes = await gambar.readAsBytes();

      if (!mounted || !sedangEdit) return;

      setState(() {
        fotoProfil = bytes;
      });
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Gagal memilih foto. Silakan coba lagi.'),
        ),
      );
    }
  }

  // Menghapus foto sementara ketika sedang mengedit.
  void _hapusFotoProfil() {
    setState(() {
      fotoProfil = null;
    });
  }

  // Menyimpan seluruh perubahan profil sekaligus.
  void _simpanProfil() {
    final nama = namaController.text.trim();
    final email = emailController.text.trim();
    final nisNip = nisNipController.text.trim();

    if (nama.isEmpty || email.isEmpty || nisNip.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Semua kolom harus diisi.'),
        ),
      );
      return;
    }

    if (!RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(email)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Masukkan alamat email yang valid.'),
        ),
      );
      return;
    }

    // Memastikan email tidak digunakan akun lain.
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

      fotoProfilSebelumEdit = null;
      sedangEdit = false;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Profil berhasil diperbarui!'),
        backgroundColor: Colors.green,
      ),
    );
  }

  // Membatalkan semua perubahan, termasuk foto.
  void _batalEditProfil() {
    setState(() {
      namaController.text = widget.akun.nama;
      emailController.text = widget.akun.email;
      nisNipController.text = widget.akun.nisNip;

      fotoProfil = fotoProfilSebelumEdit;
      fotoProfilSebelumEdit = null;

      sedangEdit = false;
    });
  }

  // Konfirmasi logout.
  void _konfirmasiKeluar() {
    showDialog<void>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
          title: const Text(
            'Keluar dari akun?',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
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
        title: Text(
          sedangEdit ? 'Edit Profil Admin' : 'Profil Admin',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          // KARTU PROFIL ADMIN
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(24),
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
              children: [
                // FOTO PROFIL
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
                                color: AppColors.navy,
                              )
                            : null,
                      ),
                    ),

                    // Tombol kamera hanya tampil saat mode edit.
                    if (sedangEdit)
                      Material(
                        color: Colors.white,
                        shape: const CircleBorder(),
                        child: InkWell(
                          onTap: _pilihFotoProfil,
                          customBorder: const CircleBorder(),
                          child: const Padding(
                            padding: EdgeInsets.all(9),
                            child: Icon(
                              Icons.camera_alt_rounded,
                              size: 20,
                              color: AppColors.navy,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),

                const SizedBox(height: 12),

                if (sedangEdit) ...[
                  TextButton.icon(
                    onPressed: _pilihFotoProfil,
                    icon: const Icon(
                      Icons.add_a_photo_outlined,
                      size: 17,
                    ),
                    label: const Text('Ganti Foto Profil'),
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.white,
                    ),
                  ),

                  if (fotoProfil != null)
                    TextButton.icon(
                      onPressed: _hapusFotoProfil,
                      icon: const Icon(
                        Icons.delete_outline_rounded,
                        size: 17,
                      ),
                      label: const Text('Hapus Foto'),
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.white,
                      ),
                    ),
                ],

                const SizedBox(height: 8),

                Text(
                  sedangEdit
                      ? namaController.text.isEmpty
                          ? widget.akun.nama
                          : namaController.text
                      : widget.akun.nama,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 21,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 6),

                Text(
                  sedangEdit
                      ? emailController.text.isEmpty
                          ? widget.akun.email
                          : emailController.text
                      : widget.akun.email,
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

          Text(
            sedangEdit ? 'Ubah Informasi Akun' : 'Informasi Akun',
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 14),

          // Semua kolom diedit langsung di halaman ini.
          _fieldProfil(
            label: 'Nama Lengkap',
            controller: namaController,
            ikon: Icons.person_outline_rounded,
          ),

          _fieldProfil(
            label: 'Alamat Email',
            controller: emailController,
            ikon: Icons.email_outlined,
            keyboardType: TextInputType.emailAddress,
          ),

          _fieldProfil(
            label: 'NIS/NIP',
            controller: nisNipController,
            ikon: Icons.badge_outlined,
          ),

          _InformasiProfil(
            ikon: Icons.admin_panel_settings_outlined,
            judul: 'Hak Akses',
            isi: 'Administrator',
          ),

          const SizedBox(height: 24),

          // Tombol edit berubah menjadi tombol simpan.
          SizedBox(
            height: 50,
            child: ElevatedButton.icon(
              onPressed: sedangEdit
                  ? _simpanProfil
                  : _mulaiEditProfil,
              icon: Icon(
                sedangEdit
                    ? Icons.save_outlined
                    : Icons.edit_rounded,
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
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
            ),
          ),

          // Tombol batal hanya muncul dalam mode edit.
          if (sedangEdit) ...[
            const SizedBox(height: 12),
            SizedBox(
              height: 48,
              child: OutlinedButton.icon(
                onPressed: _batalEditProfil,
                icon: const Icon(Icons.close_rounded),
                label: const Text('Batal'),
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppColors.navy,
                  side: const BorderSide(
                    color: AppColors.navy,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
              ),
            ),
          ],

          const SizedBox(height: 12),

          // LOGOUT tetap tersedia di luar mode edit.
          if (!sedangEdit)
            SizedBox(
              height: 50,
              child: OutlinedButton.icon(
                onPressed: _konfirmasiKeluar,
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
                  ),
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

  Widget _fieldProfil({
    required String label,
    required TextEditingController controller,
    required IconData ikon,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      child: TextField(
        controller: controller,
        readOnly: !sedangEdit,
        keyboardType: keyboardType,
        onChanged: (_) {
          setState(() {});
        },
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(ikon),
          filled: true,
          fillColor: sedangEdit
              ? Colors.white
              : Colors.grey.shade50,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide(
              color: AppColors.lightGray,
            ),
          ),
        ),
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
