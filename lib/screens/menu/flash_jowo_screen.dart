import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import '../../core/constants/colors.dart';

class FlashJowoScreen extends StatefulWidget {
  const FlashJowoScreen({super.key});

  @override
  State<FlashJowoScreen> createState() => _FlashJowoScreenState();
}

class _FlashJowoScreenState extends State<FlashJowoScreen> {
  // 1. ISOLASI STATE: Indeks kartu ora bakal ngerender kabeh layar
  final ValueNotifier<int> _currentIndex = ValueNotifier<int>(0);
  late AudioPlayer _audioPlayer;

  final List<Map<String, String>> _flashcards = [
    {
      'image': 'assets/images/uang.png',
      'indo': 'Uang',
      'ngoko': 'Dhuwit',
      'krama': 'Yatra',
      'inggil': 'Arta',
    },
    {
      'image': 'assets/images/makan.png',
      'indo': 'Makan',
      'ngoko': 'Mangan',
      'krama': 'Neda',
      'inggil': 'Dhahar',
    },
  ];

  @override
  void initState() {
    super.initState();
    _audioPlayer = AudioPlayer();
    _audioPlayer.setReleaseMode(ReleaseMode.stop);
  }

  @override
  void dispose() {
    _currentIndex.dispose();
    _audioPlayer.dispose();
    super.dispose();
  }

  // 2. AUDIO TANPA BLOCKING: Fire and forget
  void _playSound(String word) {
    String fileName = word.toLowerCase().replaceAll(' ', '_');
    _audioPlayer.play(
      AssetSource('sounds/$fileName.mp3'),
      mode: PlayerMode.lowLatency,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: JowoColors.navyBg,
      body: Stack(
        children: [
          // Background statis, di-pre-render sepisan wae
          const RepaintBoundary(child: _StaticBg()),

          SafeArea(
            child: Column(
              children: [
                const _MinimalHeader(),
                Expanded(
                  child: ValueListenableBuilder<int>(
                    valueListenable: _currentIndex,
                    builder: (context, index, _) {
                      final data = _flashcards[index];
                      return ListView(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        // Hapus BouncingScroll (kadhang nggawe lag neng HP lawas)
                        physics: const ClampingScrollPhysics(),
                        children: [
                          const SizedBox(height: 10),
                          const _TitleFlash(),
                          const SizedBox(height: 25),

                          // Area Gambar (Optimized)
                          _ImageArea(
                            imageUrl: data['image']!,
                            onPrev: () => _currentIndex.value =
                                (_currentIndex.value - 1 < 0)
                                    ? _flashcards.length - 1
                                    : _currentIndex.value - 1,
                            onNext: () => _currentIndex.value =
                                (_currentIndex.value + 1) % _flashcards.length,
                          ),

                          const SizedBox(height: 25),

                          // List Kata (Neo-Brutalism Style - Super Ringan)
                          _WordItem(
                              label: "INDONESIA",
                              value: data['indo']!,
                              onSound: _playSound),
                          _WordItem(
                              label: "NGOKO",
                              value: data['ngoko']!,
                              onSound: _playSound),
                          _WordItem(
                              label: "KRAMA",
                              value: data['krama']!,
                              onSound: _playSound),
                          _WordItem(
                              label: "KRAMA INGGIL",
                              value: data['inggil']!,
                              onSound: _playSound),

                          const SizedBox(height: 20),
                        ],
                      );
                    },
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

// --- WIDGETS KOMPONEN (SEMUA STATELESS) ---

class _WordItem extends StatelessWidget {
  final String label, value;
  final Function(String) onSound;
  const _WordItem(
      {required this.label, required this.value, required this.onSound});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: const Color(0xFFE0E0E0),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
            color: Colors.black, width: 2), // Solid border, 0% blur calculation
      ),
      child: InkWell(
        // Luwih enteng tinimbang GestureDetector
        onTap: () => onSound(value),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(label,
                      style: const TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFE67E22))),
                  Text(value,
                      style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1A1A2E))),
                ],
              ),
              const Icon(Icons.volume_up_rounded,
                  color: Colors.black, size: 20),
            ],
          ),
        ),
      ),
    );
  }
}

class _ImageArea extends StatelessWidget {
  final String imageUrl;
  final VoidCallback onPrev, onNext;
  const _ImageArea(
      {required this.imageUrl, required this.onPrev, required this.onNext});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      decoration: BoxDecoration(
        color: const Color(0xFFE0E0E0),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.black, width: 2),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Image.asset(imageUrl, fit: BoxFit.contain, cacheWidth: 400),
          Positioned(
              left: 10,
              child: _NavBtn(icon: Icons.chevron_left, onTap: onPrev)),
          Positioned(
              right: 10,
              child: _NavBtn(icon: Icons.chevron_right, onTap: onNext)),
        ],
      ),
    );
  }
}

class _NavBtn extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  const _NavBtn({required this.icon, required this.onTap});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
            color: const Color(0xFFE67E22),
            shape: BoxShape.circle,
            border: Border.all(color: Colors.black, width: 1.5)),
        child: Icon(icon, color: Colors.black, size: 28),
      ),
    );
  }
}

class _StaticBg extends StatelessWidget {
  const _StaticBg();
  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/images/HomePage.png',
      fit: BoxFit.cover,
      color: Colors.white.withOpacity(
          0.08), // Color filter neng kene luwih enteng tinimbang Opacity widget
      colorBlendMode: BlendMode.modulate,
      cacheWidth: 800,
    );
  }
}

class _MinimalHeader extends StatelessWidget {
  const _MinimalHeader();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Row(
        children: [
          IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => Navigator.pop(context)),
          const Text("IsoJowo",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 18)),
          const Spacer(),
          const Icon(Icons.notifications_none_rounded,
              color: Colors.white, size: 22),
          const SizedBox(width: 15),
          const Icon(Icons.account_circle, color: Colors.white, size: 24),
          const SizedBox(width: 15),
          const Icon(Icons.settings_outlined, color: Colors.white, size: 22),
        ],
      ),
    );
  }
}

class _TitleFlash extends StatelessWidget {
  const _TitleFlash();
  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Flash Jowo",
            style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: JowoColors.goldAccent)),
        Text("Klik kartu kanggo ngrungokake pelafalane.",
            style: TextStyle(color: Colors.white70, fontSize: 13)),
      ],
    );
  }
}
