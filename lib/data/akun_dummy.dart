
class AkunDummy {
  String nama;
  String email;
  String nisNip;
  String password;

  AkunDummy({
    required this.nama,
    required this.email,
    required this.nisNip,
    required this.password,
  });
}

class PengelolaAkun {
  static final List<AkunDummy> daftarAkun = [
    AkunDummy(
      nama: 'Tiara',
      email: 'tiara@gmail.com',
      nisNip: '123456',
      password: 'tiara123',
    ),
  ];

  // Mendaftarkan akun baru
  static String? daftar({
    required String nama,
    required String email,
    required String nisNip,
    required String password,
  }) {
    for (AkunDummy akun in daftarAkun) {
      if (akun.email.toLowerCase() == email.toLowerCase()) {
        return 'Email sudah terdaftar.';
      }
    }

    daftarAkun.add(
      AkunDummy(
        nama: nama,
        email: email,
        nisNip: nisNip,
        password: password,
      ),
    );

    return null;
  }

  // Memeriksa akun saat login
  static AkunDummy? login({
    required String email,
    required String password,
  }) {
    for (AkunDummy akun in daftarAkun) {
      if (akun.email.toLowerCase() == email.toLowerCase() &&
          akun.password == password) {
        return akun;
      }
    }

    return null;
  }
}
