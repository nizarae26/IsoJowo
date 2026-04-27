import 'package:flutter/material.dart';
import '../../core/constants/colors.dart';
import '../../widgets/custom_input.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key}); // Tambahkan const constructor

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Set warna dasar navy agar transisi saat memuat gambar lebih halus
      backgroundColor: JowoColors.navyBg,
      body: Stack(
        children: [
          // 1. LAYER BACKGROUND: Gambar Batik (Sama dengan Login & Home)
          Image.asset(
            'assets/images/HomePage.png',
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
            // Opacity 0.8 sesuai dengan standar halaman sebelumnya
            opacity: const AlwaysStoppedAnimation(0.8),
            errorBuilder: (context, error, stackTrace) {
              return Container(color: JowoColors.navyBg);
            },
          ),

          // 2. LAYER KONTEN
          SingleChildScrollView(
            child: Container(
              // Pastikan container minimal setinggi layar agar konten berada di tengah
              height: MediaQuery.of(context).size.height,
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Judul Aplikasi dengan Shadow agar tidak "tenggelam" di batik
                  Text(
                    "IsoJowo",
                    style: TextStyle(
                      fontSize: 42,
                      fontWeight: FontWeight.bold,
                      color: JowoColors.whiteText,
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

                  const Text(
                    "Gawe Akun Anyar",
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: JowoColors.whiteText),
                  ),
                  const Text(
                    "Ayo gabung lan dadi master tatakrama.",
                    style: TextStyle(color: JowoColors.greyText),
                  ),
                  const SizedBox(height: 30),

                  // Input Fields
                  const CustomInput(
                      hint: "Jeneng Lengkap", icon: Icons.person_outline),
                  const SizedBox(height: 15),
                  const CustomInput(
                      hint: "Username utawa Email", icon: Icons.email_outlined),
                  const SizedBox(height: 15),
                  const CustomInput(
                      hint: "Password",
                      icon: Icons.lock_outline,
                      isPassword: true),

                  const SizedBox(height: 30),

                  // Button Daftar
                  SizedBox(
                    width: double.infinity,
                    height: 55,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: JowoColors.goldAccent,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                        elevation: 5,
                      ),
                      onPressed: () {
                        // Logika pendaftaran
                      },
                      child: const Text(
                        "Daftar Saiki",
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Navigasi balik ke Login
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Wis duwe akun? ",
                          style: TextStyle(color: Colors.white)),
                      GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: const Text(
                          "Mlebu Kene",
                          style: TextStyle(
                              color: JowoColors.goldAccent,
                              fontWeight: FontWeight.bold),
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
