
import 'package:flutter/material.dart';
import '../../utils/app_colors.dart';
import '../../data/akun_dummy.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final namaController = TextEditingController();
  final emailController = TextEditingController();
  final nisNipController = TextEditingController();
  final passwordController = TextEditingController();
  final konfirmasiController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  bool sembunyikanPassword = true;
  bool sembunyikanKonfirmasi = true;
  bool sedangMendaftar = false;

  void tampilkanPesan(String pesan, {bool berhasil = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(pesan),
        backgroundColor: berhasil ? Colors.green.shade700 : AppColors.navy,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }

  void daftar() {
    if (!formKey.currentState!.validate()) return;

    setState(() {
      sedangMendaftar = true;
    });

    final String nama = namaController.text.trim();
    final String email = emailController.text.trim();
    final String nisNip = nisNipController.text.trim();
    final String password = passwordController.text;
    final String konfirmasi = konfirmasiController.text;

    if (password != konfirmasi) {
      setState(() {
        sedangMendaftar = false;
      });
      tampilkanPesan('Konfirmasi password tidak cocok.');
      return;
    }

    final String? pesan = PengelolaAkun.daftar(
      nama: nama,
      email: email,
      nisNip: nisNip,
      password: password,
    );

    setState(() {
      sedangMendaftar = false;
    });

    if (pesan != null) {
      tampilkanPesan(pesan);
      return;
    }

    tampilkanPesan(
      'Registrasi berhasil! Silakan login.',
      berhasil: true,
    );

    Future.delayed(const Duration(milliseconds: 700), () {
      if (mounted) {
        Navigator.pop(context);
      }
    });
  }

  InputDecoration dekorasiInput({
    required String label,
    required String hint,
    required IconData ikon,
    Widget? suffix,
  }) {
    return InputDecoration(
      labelText: label,
      hintText: hint,
      prefixIcon: Icon(ikon, color: AppColors.blue),
      suffixIcon: suffix,
      filled: true,
      fillColor: const Color(0xFFF7F9FC),
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 18,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: const BorderSide(color: Color(0xFFE6EBF2)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: const BorderSide(
          color: AppColors.blue,
          width: 1.5,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: const BorderSide(color: Colors.redAccent),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: const BorderSide(color: Colors.redAccent, width: 1.5),
      ),
      labelStyle: const TextStyle(color: AppColors.gray),
      hintStyle: const TextStyle(
        color: Color(0xFF9AA5B5),
        fontSize: 13,
      ),
    );
  }

  Widget labelBagian(String teks) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8, left: 2),
      child: Text(
        teks,
        style: const TextStyle(
          color: AppColors.navy,
          fontSize: 13,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  @override
  void dispose() {
    namaController.dispose();
    emailController.dispose();
    nisNipController.dispose();
    passwordController.dispose();
    konfirmasiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFFEAF3FF),
              Color(0xFFF7F9FC),
              Colors.white,
            ],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(22, 12, 22, 28),
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 500),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Tombol kembali
                    Align(
                      alignment: Alignment.centerLeft,
                      child: IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: const Icon(
                          Icons.arrow_back_rounded,
                          color: AppColors.navy,
                        ),
                        style: IconButton.styleFrom(
                          backgroundColor: Colors.white,
                          padding: const EdgeInsets.all(12),
                        ),
                      ),
                    ),

                    const SizedBox(height: 10),

                    // Logo dan judul
                    Center(
                      child: Container(
                        width: 92,
                        height: 92,
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(26),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.navy.withValues(alpha: 0.08),
                              blurRadius: 24,
                              offset: const Offset(0, 8),
                            ),
                          ],
                        ),
                        child: Image.asset(
                          'assets/logo_simsar.png',
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    const Text(
                      'Buat Akun Baru ✨',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: AppColors.navy,
                        fontSize: 27,
                        fontWeight: FontWeight.w800,
                        letterSpacing: -0.5,
                      ),
                    ),

                    const SizedBox(height: 8),

                    const Text(
                      'Daftar untuk mulai menggunakan SIMSAR',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: AppColors.gray,
                        fontSize: 14,
                      ),
                    ),

                    const SizedBox(height: 28),

                    // Form registrasi
                    Container(
                      padding: const EdgeInsets.all(22),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(26),
                        border: Border.all(
                          color: const Color(0xFFEAF0F7),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.navy.withValues(alpha: 0.06),
                            blurRadius: 28,
                            offset: const Offset(0, 10),
                          ),
                        ],
                      ),
                      child: Form(
                        key: formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            const Text(
                              'Informasi Akun',
                              style: TextStyle(
                                color: AppColors.navy,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            const SizedBox(height: 5),

                            const Text(
                              'Lengkapi data diri kamu di bawah ini.',
                              style: TextStyle(
                                color: AppColors.gray,
                                fontSize: 12,
                              ),
                            ),

                            const SizedBox(height: 22),

                            labelBagian('Nama lengkap'),
                            TextFormField(
                              controller: namaController,
                              textCapitalization: TextCapitalization.words,
                              textInputAction: TextInputAction.next,
                              decoration: dekorasiInput(
                                label: 'Nama Lengkap',
                                hint: 'Masukkan nama lengkap',
                                ikon: Icons.person_outline_rounded,
                              ),
                              validator: (value) {
                                if (value == null || value.trim().isEmpty) {
                                  return 'Nama lengkap wajib diisi.';
                                }
                                return null;
                              },
                            ),

                            const SizedBox(height: 18),

                            labelBagian('Email'),
                            TextFormField(
                              controller: emailController,
                              keyboardType: TextInputType.emailAddress,
                              textInputAction: TextInputAction.next,
                              decoration: dekorasiInput(
                                label: 'Email',
                                hint: 'contoh@email.com',
                                ikon: Icons.email_outlined,
                              ),
                              validator: (value) {
                                final email = value?.trim() ?? '';
                                if (email.isEmpty) {
                                  return 'Email wajib diisi.';
                                }
                                if (!RegExp(
                                  r'^[^@\s]+@[^@\s]+\.[^@\s]+$',
                                ).hasMatch(email)) {
                                  return 'Masukkan email yang valid.';
                                }
                                return null;
                              },
                            ),

                            const SizedBox(height: 18),

                            labelBagian('Nomor identitas'),
                            TextFormField(
                              controller: nisNipController,
                              textInputAction: TextInputAction.next,
                              decoration: dekorasiInput(
                                label: 'NIS/NIP',
                                hint: 'Masukkan NIS atau NIP',
                                ikon: Icons.badge_outlined,
                              ),
                              validator: (value) {
                                if (value == null || value.trim().isEmpty) {
                                  return 'NIS/NIP wajib diisi.';
                                }
                                return null;
                              },
                            ),

                            const SizedBox(height: 18),

                            labelBagian('Password'),
                            TextFormField(
                              controller: passwordController,
                              obscureText: sembunyikanPassword,
                              textInputAction: TextInputAction.next,
                              decoration: dekorasiInput(
                                label: 'Password',
                                hint: 'Minimal 6 karakter',
                                ikon: Icons.lock_outline_rounded,
                                suffix: IconButton(
                                  tooltip: sembunyikanPassword
                                      ? 'Tampilkan password'
                                      : 'Sembunyikan password',
                                  onPressed: () {
                                    setState(() {
                                      sembunyikanPassword =
                                          !sembunyikanPassword;
                                    });
                                  },
                                  icon: Icon(
                                    sembunyikanPassword
                                        ? Icons.visibility_outlined
                                        : Icons.visibility_off_outlined,
                                    color: AppColors.gray,
                                  ),
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Password wajib diisi.';
                                }
                                if (value.length < 6) {
                                  return 'Password minimal 6 karakter.';
                                }
                                return null;
                              },
                            ),

                            const SizedBox(height: 18),

                            labelBagian('Konfirmasi password'),
                            TextFormField(
                              controller: konfirmasiController,
                              obscureText: sembunyikanKonfirmasi,
                              textInputAction: TextInputAction.done,
                              onFieldSubmitted: (_) => daftar(),
                              decoration: dekorasiInput(
                                label: 'Konfirmasi Password',
                                hint: 'Masukkan ulang password',
                                ikon: Icons.lock_reset_rounded,
                                suffix: IconButton(
                                  tooltip: sembunyikanKonfirmasi
                                      ? 'Tampilkan password'
                                      : 'Sembunyikan password',
                                  onPressed: () {
                                    setState(() {
                                      sembunyikanKonfirmasi =
                                          !sembunyikanKonfirmasi;
                                    });
                                  },
                                  icon: Icon(
                                    sembunyikanKonfirmasi
                                        ? Icons.visibility_outlined
                                        : Icons.visibility_off_outlined,
                                    color: AppColors.gray,
                                  ),
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Konfirmasi password wajib diisi.';
                                }
                                if (value != passwordController.text) {
                                  return 'Password belum cocok.';
                                }
                                return null;
                              },
                            ),

                            const SizedBox(height: 26),

                            // Tombol daftar
                            SizedBox(
                              height: 55,
                              child: DecoratedBox(
                                decoration: BoxDecoration(
                                  gradient: const LinearGradient(
                                    colors: [
                                      AppColors.blue,
                                      AppColors.navy,
                                    ],
                                  ),
                                  borderRadius: BorderRadius.circular(16),
                                  boxShadow: [
                                    BoxShadow(
                                      color: AppColors.blue.withValues(
                                        alpha: 0.22,
                                      ),
                                      blurRadius: 14,
                                      offset: const Offset(0, 6),
                                    ),
                                  ],
                                ),
                                child: ElevatedButton(
                                  onPressed: sedangMendaftar ? null : daftar,
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.transparent,
                                    disabledBackgroundColor: Colors.transparent,
                                    shadowColor: Colors.transparent,
                                    foregroundColor: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                  ),
                                  child: sedangMendaftar
                                      ? const SizedBox(
                                          width: 23,
                                          height: 23,
                                          child: CircularProgressIndicator(
                                            strokeWidth: 2.5,
                                            color: Colors.white,
                                          ),
                                        )
                                      : const Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Icon(Icons.person_add_alt_1),
                                            SizedBox(width: 10),
                                            Text(
                                              'Daftar Sekarang',
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 22),

                    // Navigasi login
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Flexible(
                          child: Text(
                            'Sudah punya akun?',
                            style: TextStyle(
                              color: AppColors.gray,
                              fontSize: 13,
                            ),
                          ),
                        ),
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text(
                            'Login',
                            style: TextStyle(
                              color: AppColors.blue,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 8),

                    const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.verified_user_outlined,
                          size: 15,
                          color: AppColors.gray,
                        ),
                        SizedBox(width: 6),
                        Text(
                          'Lengkapi data dengan benar',
                          style: TextStyle(
                            color: AppColors.gray,
                            fontSize: 11,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
