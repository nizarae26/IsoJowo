import 'package:flutter/material.dart';
import '../../core/constants/colors.dart';
import '../../widgets/custom_input.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Menggunakan warna navy sebagai dasar agar transisi gambar lebih halus
      backgroundColor: JowoColors.navyBg,
      body: Stack(
        children: [
          // 1. LAYER BACKGROUND: Gambar Batik (Sesuaikan dengan Home)
          Image.asset(
            'assets/images/HomePage.png',
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
            // Opacity 0.8 agar tetap elegan dan teks di atasnya terbaca jelas
            opacity: const AlwaysStoppedAnimation(0.8),
            errorBuilder: (context, error, stackTrace) {
              return Container(color: JowoColors.navyBg);
            },
          ),

          // 2. LAYER KONTEN
          SingleChildScrollView(
            child: Container(
              height: MediaQuery.of(context).size.height,
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Judul Aplikasi
                  Text(
                    "IsoJowo",
                    style: TextStyle(
                      fontSize: 42,
                      fontWeight: FontWeight.bold,
                      color: JowoColors.whiteText,
                      // Tambahkan sedikit shadow agar teks lebih "keluar" dari background
                      shadows: [
                        Shadow(
                          blurRadius: 10,
                          color: Colors.black.withOpacity(0.5),
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 40),

                  Text(
                    "Mlebu ning IsoJowo",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: JowoColors.whiteText,
                    ),
                  ),
                  Text(
                    "Mlebu karo akunmu kanggo neruske sinau",
                    style: TextStyle(color: JowoColors.greyText),
                  ),
                  const SizedBox(height: 40),

                  // Input Fields
                  const CustomInput(
                    hint: "Username utawa Email",
                    icon: Icons.person_outline,
                  ),
                  const SizedBox(height: 20),
                  const CustomInput(
                    hint: "Password",
                    icon: Icons.lock_outline,
                    isPassword: true,
                  ),

                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {},
                      child: const Text(
                        "Lali Password?",
                        style: TextStyle(color: JowoColors.goldAccent),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Tombol Mlebu
                  SizedBox(
                    width: double.infinity,
                    height: 55,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: JowoColors.goldAccent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        elevation: 5,
                      ),
                      onPressed: () =>
                          Navigator.pushReplacementNamed(context, '/home'),
                      child: const Text(
                        "Mlebu",
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Navigasi ke Register
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Durung duwe akun? ",
                        style: TextStyle(color: Colors.white),
                      ),
                      GestureDetector(
                        onTap: () => Navigator.pushNamed(context, '/register'),
                        child: const Text(
                          "Daftar Saiki",
                          style: TextStyle(
                            color: JowoColors.goldAccent,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
