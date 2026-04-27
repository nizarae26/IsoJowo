import 'package:flutter/material.dart';
import 'screens/auth/login_screen.dart';
import 'screens/auth/register_screen.dart';
import 'screens/home/home_screen.dart';
import 'screens/menu/aksara_lab_screen.dart';
import 'screens/menu/auto_alus_screen.dart';
import 'screens/menu/pepak_battle_screen.dart';
import 'screens/menu/flash_jowo_screen.dart';
import 'core/constants/colors.dart'; // Pastikan import warna kustom kamu

void main() {
  runApp(const IsoJowoApp());
}

class IsoJowoApp extends StatelessWidget {
  const IsoJowoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Iso Jowo',
      theme: ThemeData(
        fontFamily: 'Poppins',
        // Menggunakan warna Navy global yang sudah kita sepakati
        scaffoldBackgroundColor: const Color(0xFF102C44), 
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFFF6D1A5), // Warna krem cerah baru untuk AppBar
          elevation: 0,
          titleTextStyle: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.bold,
            color: Color(0xFF102C44), // Teks AppBar navy agar kontras dengan krem
            fontSize: 20,
          ),
        ),
      ),
      // PERBAIKAN: Ubah dari '/splash' ke '/' agar langsung ke LoginScreen
      initialRoute: '/', 
      routes: {
        '/': (context) => LoginScreen(), 
        '/register': (context) => RegisterScreen(),
        '/home': (context) => HomeScreen(),
        '/aksara_lab': (context) =>  AksaraLabScreen(),
        '/auto_alus': (context) =>  AutoAlusScreen(),
        '/pepak_battle': (context) =>  PepakBattleScreen(),
        '/flash_jowo': (context) =>  FlashJowoScreen(),
      },
    );
  }
}