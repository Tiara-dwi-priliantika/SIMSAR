
import 'package:flutter/material.dart';
import '../../utils/app_colors.dart';
import '../siswa/home_screen.dart';
import 'register_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController =
      TextEditingController();

  final TextEditingController passwordController =
      TextEditingController();

  String? emailError;
  String? passwordError;

  bool sembunyikanPassword = true;

  // PROSES LOGIN DAN VALIDASI
  void login() {
    String email = emailController.text.trim();
    String password = passwordController.text;

    setState(() {
      emailError = null;
      passwordError = null;

      if (email.isEmpty) {
        emailError = 'Email wajib diisi.';
      } else if (!RegExp(
        r'^[^@\s]+@[^@\s]+\.[^@\s]+$',
      ).hasMatch(email)) {
        emailError = 'Masukkan alamat email yang valid.';
      }

      if (password.isEmpty) {
        passwordError = 'Password wajib diisi.';
      }
    });

    if (emailError != null || passwordError != null) {
      return;
    }

    // MENGAMBIL NAMA DARI EMAIL
    String nama = email.split('@')[0];

    nama = nama
        .replaceAll('.', ' ')
        .replaceAll('_', ' ')
        .split(' ')
        .map(
          (kata) => kata.isEmpty
              ? ''
              : kata[0].toUpperCase() + kata.substring(1),
        )
        .join(' ');

    // MASUK KE BERANDA
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => HomeScreen(
          namaPengguna: nama,
        ),
      ),
    );
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(
              horizontal: 24,
              vertical: 30,
            ),
            child: Column(
              children: [
                // LOGO SIMSAR
                Image.asset(
                  'assets/logo_simsar.png',
                  width: 150,
                  height: 150,
                  fit: BoxFit.contain,
                ),

                const SizedBox(height: 20),

                // JUDUL
                const Text(
                  'Selamat Datang di SIMSAR',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: AppColors.navy,
                  ),
                ),

                const SizedBox(height: 8),

                const Text(
                  'Sistem Informasi Sarana dan Prasarana Sekolah',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    color: AppColors.gray,
                  ),
                ),

                const SizedBox(height: 35),

                // INPUT EMAIL
                TextField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  onChanged: (value) {
                    if (emailError != null) {
                      setState(() {
                        emailError = null;
                      });
                    }
                  },
                  decoration: InputDecoration(
                    labelText: 'Email',
                    hintText: 'Masukkan email',
                    prefixIcon: const Icon(
                      Icons.email_outlined,
                    ),
                    errorText: emailError,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(
                        color: AppColors.lightGray,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(
                        color: AppColors.blue,
                        width: 2,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 18),

                // INPUT PASSWORD
                TextField(
                  controller: passwordController,
                  obscureText: sembunyikanPassword,
                  textInputAction: TextInputAction.done,
                  onSubmitted: (value) {
                    login();
                  },
                  onChanged: (value) {
                    if (passwordError != null) {
                      setState(() {
                        passwordError = null;
                      });
                    }
                  },
                  decoration: InputDecoration(
                    labelText: 'Password',
                    hintText: 'Masukkan password',
                    prefixIcon: const Icon(
                      Icons.lock_outline,
                    ),
                    suffixIcon: IconButton(
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
                      ),
                    ),
                    errorText: passwordError,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(
                        color: AppColors.lightGray,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(
                        color: AppColors.blue,
                        width: 2,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 25),

                // TOMBOL LOGIN
                SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: ElevatedButton(
                    onPressed: login,
                    child: const Text(
                      'Login',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                // MENU DAFTAR
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Belum punya akun?',
                      style: TextStyle(
                        color: AppColors.gray,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                const RegisterScreen(),
                          ),
                        );
                      },
                      child: const Text('Daftar'),
                    ),
                  ],
                ),

                const SizedBox(height: 5),

                const Text(
                  'Silakan masuk menggunakan akun yang telah terdaftar.',
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
      ),
    );
  }
}
