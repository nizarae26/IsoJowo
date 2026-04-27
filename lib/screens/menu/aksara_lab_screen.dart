import 'package:flutter/material.dart';
import '../../core/constants/colors.dart';

class AksaraLabScreen extends StatefulWidget {
  const AksaraLabScreen({super.key});

  @override
  State<AksaraLabScreen> createState() => _AksaraLabScreenState();
}

class _AksaraLabScreenState extends State<AksaraLabScreen> {
  int _selectedIndex = 0;
  List<Offset?> _points = [];

  final List<Map<String, dynamic>> aksaraData = [
    {'symbol': 'ꦲ', 'latin': 'HA', 'ratio': 1.6, 'complexity': 40},
    {'symbol': 'ꦤ', 'latin': 'NA', 'ratio': 1.1, 'complexity': 35},
    {'symbol': 'ꦕ', 'latin': 'CA', 'ratio': 1.4, 'complexity': 45},
    {'symbol': 'ꦫ', 'latin': 'RA', 'ratio': 1.0, 'complexity': 25},
    {'symbol': 'ꦏ', 'latin': 'KA', 'ratio': 1.5, 'complexity': 45},
    {'symbol': 'ꦢ', 'latin': 'DA', 'ratio': 1.1, 'complexity': 35},
    {'symbol': 'ꦠ', 'latin': 'TA', 'ratio': 1.2, 'complexity': 40},
    {'symbol': 'ꦱ', 'latin': 'SA', 'ratio': 1.4, 'complexity': 40},
    {'symbol': 'ꦮ', 'latin': 'WA', 'ratio': 1.1, 'complexity': 30},
    {'symbol': 'ꦭ', 'latin': 'LA', 'ratio': 1.5, 'complexity': 45},
    {'symbol': 'ꦥ', 'latin': 'PA', 'ratio': 0.9, 'complexity': 25},
    {'symbol': 'ꦝ', 'latin': 'DHA', 'ratio': 1.2, 'complexity': 40},
    {'symbol': 'ꦗ', 'latin': 'JA', 'ratio': 1.3, 'complexity': 40},
    {'symbol': 'ꦪ', 'latin': 'YA', 'ratio': 1.6, 'complexity': 50},
    {'symbol': 'ꦚ', 'latin': 'NYA', 'ratio': 1.8, 'complexity': 55},
    {'symbol': 'ꦩ', 'latin': 'MA', 'ratio': 1.1, 'complexity': 35},
    {'symbol': 'ꦒ', 'latin': 'GA', 'ratio': 0.9, 'complexity': 30},
    {'symbol': 'ꦧ', 'latin': 'BA', 'ratio': 1.1, 'complexity': 35},
    {'symbol': 'ꦛ', 'latin': 'THA', 'ratio': 1.2, 'complexity': 40},
    {'symbol': 'ꦔ', 'latin': 'NGA', 'ratio': 1.2, 'complexity': 35},
  ];

  Future<void> _showCheckResult() async {
    final actualPoints = _points.whereType<Offset>().toList();
    final target = aksaraData[_selectedIndex];

    if (actualPoints.length < 10) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text("Tulisen dhisik sing bener, Lur!"),
            backgroundColor: Colors.orange),
      );
      return;
    }

    double minX = actualPoints.first.dx, maxX = actualPoints.first.dx;
    double minY = actualPoints.first.dy, maxY = actualPoints.first.dy;
    for (var p in actualPoints) {
      if (p.dx < minX) minX = p.dx;
      if (p.dx > maxX) maxX = p.dx;
      if (p.dy < minY) minY = p.dy;
      if (p.dy > maxY) maxY = p.dy;
    }

    double userRatio = (maxX - minX) / ((maxY - minY) == 0 ? 1 : (maxY - minY));
    bool isRatioCorrect = (userRatio - (target['ratio'] as double)).abs() < 0.6;
    bool isComplexEnough =
        actualPoints.length >= ((target['complexity'] as int) * 0.6);

    _showLoadingDialog();
    await Future.delayed(const Duration(seconds: 2));
    if (!mounted) return;
    Navigator.pop(context);
    _showResultBottomSheet(isRatioCorrect && isComplexEnough);
  }

  void _showLoadingDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Center(
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
              color: JowoColors.navyBg,
              borderRadius: BorderRadius.circular(15)),
          child: const Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircularProgressIndicator(color: Color(0xFFFFA726)),
              SizedBox(height: 15),
              Text("Lagi mriksa...",
                  style: TextStyle(
                      color: Colors.white,
                      decoration: TextDecoration.none,
                      fontSize: 14)),
            ],
          ),
        ),
      ),
    );
  }

  void _showResultBottomSheet(bool success) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        padding: const EdgeInsets.all(30),
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(30))),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(success ? Icons.check_circle : Icons.error_outline,
                size: 80, color: success ? Colors.green : Colors.red),
            const SizedBox(height: 20),
            Text(success ? "Apik Banget!" : "Cobo Meneh!",
                style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: JowoColors.navyBg)),
            const SizedBox(height: 10),
            Text(
              success
                  ? "Tulisan '${aksaraData[_selectedIndex]['latin']}' wis bener."
                  : "Tulisanmu kurang presisi, jajal baleni maneh.",
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      success ? Colors.green : const Color(0xFFFFA726),
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                ),
                onPressed: () {
                  Navigator.pop(context);
                  if (!success) setState(() => _points.clear());
                },
                child: Text(success ? "Lanjut" : "Baleni",
                    style: const TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    const Color figmaOrange = Color(0xFFFFA726);
    const Color figmaLightGrey = Color(0xFFE0E0E0);

    return Scaffold(
      backgroundColor: JowoColors.navyBg,
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/HomePage.png',
              fit: BoxFit.cover,
              opacity: const AlwaysStoppedAnimation(0.15),
            ),
          ),
          Positioned.fill(
            child: Column(
              children: [
                // APPBAR KUSTOM
                Padding(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).padding.top + 5,
                      left: 10,
                      right: 10),
                  child: Row(
                    children: [
                      IconButton(
                          icon:
                              const Icon(Icons.arrow_back, color: Colors.white),
                          onPressed: () => Navigator.pop(context)),
                      // const Text("IsoJowo",
                      //     style: TextStyle(
                      //         fontWeight: FontWeight.bold,
                      //         color: Colors.white,
                      //         fontSize: 18)),
                      const Spacer(),
                      IconButton(
                          icon: const Icon(Icons.notifications_none_rounded,
                              color: Colors.white, size: 22),
                          onPressed: () {}),
                      IconButton(
                          icon: const Icon(Icons.account_circle,
                              color: Colors.white, size: 26),
                          onPressed: () {}),
                      IconButton(
                          icon: const Icon(Icons.settings_outlined,
                              color: Colors.white, size: 22),
                          onPressed: () {}),
                    ],
                  ),
                ),

                // KONTEN UTAMA (Tanpa Scroll)
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                            height:
                                25), // Jarak antara heading dan judul aksara lab
                        const Text("Aksara Lab",
                            style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: JowoColors.goldAccent)),
                        const SizedBox(height: 4),
                        // KALIMAT INSTRUKSI BARU
                        const Text(
                          "Pilih aksara sing arep mbok sinaoni. Terus jajal tulis neng kanvas sebelah ngisor kuwi ya!",
                          style: TextStyle(fontSize: 12, color: Colors.white70),
                        ),
                        const SizedBox(height: 20),

                        // GRID BOX AKSARA (Diperkecil agar hemat ruang)
                        Stack(
                          clipBehavior: Clip.none,
                          children: [
                            Container(
                              height: 180, // Perkecil tinggi box aksara
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                  color: figmaLightGrey,
                                  borderRadius: BorderRadius.circular(15)),
                              child: GridView.builder(
                                padding: EdgeInsets.zero,
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 3,
                                        crossAxisSpacing: 8,
                                        mainAxisSpacing: 8,
                                        childAspectRatio: 1.3),
                                itemCount: aksaraData.length,
                                itemBuilder: (context, index) {
                                  bool isSelected = _selectedIndex == index;
                                  return GestureDetector(
                                    onTap: () =>
                                        setState(() => _selectedIndex = index),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: isSelected
                                              ? figmaOrange
                                              : Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          border: Border.all(
                                              color: Colors.black, width: 1)),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(aksaraData[index]['symbol'],
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  color: isSelected
                                                      ? Colors.white
                                                      : Colors.black,
                                                  fontFamily: 'AksaraJawa')),
                                          Text(aksaraData[index]['latin'],
                                              style: TextStyle(
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.bold,
                                                  color: isSelected
                                                      ? Colors.white
                                                      : Colors.black)),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                            Positioned(
                                top: -8,
                                right: -8,
                                child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 4),
                                    decoration: BoxDecoration(
                                        color: figmaOrange,
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    child: Text("${_selectedIndex + 1}/20",
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                            fontSize: 10)))),
                          ],
                        ),

                        const SizedBox(height: 20),
                        const Text("Coba Tulis neng kene:",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 14)),
                        const SizedBox(height: 8),

                        // KANVAS MENGGAMBAR (Mengambil sisa ruang layar)
                        Expanded(
                          child: Stack(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: Container(
                                  width: double.infinity,
                                  color: Colors.white,
                                  child: RepaintBoundary(
                                    child: GestureDetector(
                                      onPanUpdate: (details) => setState(() =>
                                          _points.add(details.localPosition)),
                                      onPanEnd: (details) =>
                                          setState(() => _points.add(null)),
                                      child: CustomPaint(
                                          painter:
                                              DrawingPainter(points: _points),
                                          size: Size.infinite),
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                  top: 10,
                                  right: 10,
                                  child: InkWell(
                                      onTap: () =>
                                          setState(() => _points.clear()),
                                      child: Container(
                                          padding: const EdgeInsets.all(6),
                                          decoration: BoxDecoration(
                                              color: figmaLightGrey,
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              border: Border.all(
                                                  color: Colors.black)),
                                          child: const Icon(
                                              Icons.delete_outline,
                                              size: 20,
                                              color: Colors.black)))),
                            ],
                          ),
                        ),

                        const SizedBox(height: 20),
                        // TOMBOL PERIKSA
                        SizedBox(
                            width: double.infinity,
                            height: 50,
                            child: ElevatedButton.icon(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: figmaOrange,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(15))),
                                onPressed: _showCheckResult,
                                icon: const Icon(Icons.check_circle_outline,
                                    color: Colors.white),
                                label: const Text("Periksa Tulisan",
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold)))),
                        const SizedBox(height: 20),
                      ],
                    ),
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

class DrawingPainter extends CustomPainter {
  final List<Offset?> points;
  DrawingPainter({required this.points});
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.black
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 4.0;
    for (int i = 0; i < points.length - 1; i++) {
      if (points[i] != null && points[i + 1] != null)
        canvas.drawLine(points[i]!, points[i + 1]!, paint);
    }
  }

  @override
  bool shouldRepaint(DrawingPainter oldDelegate) => true;
}
