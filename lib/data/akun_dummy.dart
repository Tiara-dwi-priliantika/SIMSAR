
class AkunDummy {
  String nama;
  String email;
  String nisNip;
  String password;
  String role;

  AkunDummy({
    required this.nama,
    required this.email,
    required this.nisNip,
    required this.password,
    this.role = 'pengguna',
  });
}

class PengelolaAkun {
  static final List<AkunDummy> daftarAkun = [
    AkunDummy(
      nama: 'Tiara',
      email: 'tiara@gmail.com',
      nisNip: '123456',
      password: 'tiara123',
      role: 'admin',
    ),
  ];

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
        role: 'pengguna',
      ),
    );

    return null;
  }

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
