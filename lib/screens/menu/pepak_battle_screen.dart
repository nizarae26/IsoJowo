import 'package:flutter/material.dart';
import '../../core/constants/colors.dart';

enum BattleStage { setup, quiz, result }

class PepakBattleScreen extends StatefulWidget {
  const PepakBattleScreen({super.key});

  @override
  State<PepakBattleScreen> createState() => _PepakBattleScreenState();
}

class _PepakBattleScreenState extends State<PepakBattleScreen> {
  BattleStage _currentStage = BattleStage.setup;
  int _questionCount = 10;
  int _currentQuestionIndex = 0;
  int _score = 0;
  int? _selectedOptionIndex;
  bool _hasAnswered = false;

  // Logika Switch Acak
  bool _isShuffleQuestions = true;
  bool _isShuffleOptions = true;

  final Color primaryAmber = const Color(0xFFE67E22);
  final Color figmaLightGrey = const Color(0xFFE0E0E0);

  final List<String> _allTypes = [
    "Indo -> Ngoko",
    "Indo -> krama",
    "Indo -> Krama Inggil",
    "Ngoko -> Indo",
    "Ngoko -> Krama",
    "Ngoko -> Krama Inggil",
    "Krama -> Indo",
    "Krama -> Ngoko",
    "Krama -> Krama Inggil",
    "Krama Inggil -> Indo",
    "Krama Inggil -> Ngoko",
    "Krama Inggil -> Krama"
  ];
  final List<String> _selectedTypes = ["Indo -> Ngoko", "Ngoko -> Krama"];

  // BANK SOAL (20 Pertanyaan)
  final List<Map<String, dynamic>> _questions = [
    // --- Indo -> Ngoko ---
    {
      'question': 'Apa bahasa ngoko dari "Garam"?',
      'type': 'Indo -> Ngoko',
      'options': ['Mangan', 'Uyah', 'Gulo', 'Tangan'],
      'answer': 1
    },
    {
      'question': 'Apa bahasa ngoko dari "Lari"?',
      'type': 'Indo -> Ngoko',
      'options': ['Mlayu', 'Mlaku', 'Lungguh', 'Turu'],
      'answer': 0
    },

    // --- Indo -> Krama ---
    {
      'question': 'Apa bahasa krama dari "Rumah"?',
      'type': 'Indo -> krama',
      'options': ['Griya', 'Sabin', 'Peken', 'Margi'],
      'answer': 0
    },
    {
      'question': 'Apa bahasa krama dari "Air"?',
      'type': 'Indo -> krama',
      'options': ['Geni', 'Latu', 'Toya', 'Siti'],
      'answer': 2
    },

    // --- Indo -> Krama Inggil ---
    {
      'question': 'Apa krama inggil dari "Mata"?',
      'type': 'Indo -> Krama Inggil',
      'options': ['Paningal', 'Grana', 'Lathi', 'Asta'],
      'answer': 0
    },
    {
      'question': 'Apa krama inggil dari "Kepala"?',
      'type': 'Indo -> Krama Inggil',
      'options': ['Mustaka', 'Rikma', 'Pasuryan', 'Talingan'],
      'answer': 0
    },

    // --- Ngoko -> Indo ---
    {
      'question': 'Tembung "Sega" tegese yaiku...',
      'type': 'Ngoko -> Indo',
      'options': ['Garam', 'Nasi', 'Air', 'Ikan'],
      'answer': 1
    },
    {
      'question': 'Tembung "Dalan" tegese yaiku...',
      'type': 'Ngoko -> Indo',
      'options': ['Pasar', 'Sawah', 'Hutan', 'Jalan'],
      'answer': 3
    },

    // --- Ngoko -> Krama ---
    {
      'question': 'Basa kramane "Mangan" yaiku...',
      'type': 'Ngoko -> Krama',
      'options': ['Sare', 'Dhahar', 'Neda', 'Siram'],
      'answer': 2
    },
    {
      'question': 'Basa kramane "Lunga" yaiku...',
      'type': 'Ngoko -> Krama',
      'options': ['Kesah', 'Tindak', 'Mangkat', 'Bidhal'],
      'answer': 0
    },

    // --- Ngoko -> Krama Inggil ---
    {
      'question': 'Basa krama inggile "Ngombe" yaiku...',
      'type': 'Ngoko -> Krama Inggil',
      'options': ['Ngunjuk', 'Dhahar', 'Sare', 'Siram'],
      'answer': 0
    },
    {
      'question': 'Basa krama inggile "Turu" yaiku...',
      'type': 'Ngoko -> Krama Inggil',
      'options': ['Sare', 'Tilem', 'Wungu', 'Lungguh'],
      'answer': 0
    },

    // --- Krama -> Indo ---
    {
      'question': 'Tembung "Arta" tegese yaiku...',
      'type': 'Krama -> Indo',
      'options': ['Uang', 'Nama', 'Anak', 'Istri'],
      'answer': 0
    },
    {
      'question': 'Tembung "Peken" tegese yaiku...',
      'type': 'Krama -> Indo',
      'options': ['Sawah', 'Pasar', 'Jalan', 'Rumah'],
      'answer': 1
    },

    // --- Krama -> Ngoko ---
    {
      'question': 'Basa ngokone "Sade" yaiku...',
      'type': 'Krama -> Ngoko',
      'options': ['Tuku', 'Adol', 'Nggawa', 'Ngerti'],
      'answer': 1
    },
    {
      'question': 'Basa ngokone "Sekul" yaiku...',
      'type': 'Krama -> Ngoko',
      'options': ['Banyu', 'Geni', 'Sega', 'Iwak'],
      'answer': 2
    },

    // --- Krama -> Krama Inggil ---
    {
      'question': 'Tembung "Tilem" krama inggile yaiku...',
      'type': 'Krama -> Krama Inggil',
      'options': ['Sare', 'Dhahar', 'Tindak', 'Wungu'],
      'answer': 0
    },
    {
      'question': 'Tembung "Neda" krama inggile yaiku...',
      'type': 'Krama -> Krama Inggil',
      'options': ['Mangan', 'Dhahar', 'Ngunjuk', 'Sare'],
      'answer': 1
    },

    // --- Krama Inggil -> Indo ---
    {
      'question': 'Tembung "Kondur" tegese yaiku...',
      'type': 'Krama Inggil -> Indo',
      'options': ['Berangkat', 'Datang', 'Pergi', 'Pulang'],
      'answer': 3
    },
    {
      'question': 'Tembung "Asma" tegese yaiku...',
      'type': 'Krama Inggil -> Indo',
      'options': ['Nama', 'Rumah', 'Hati', 'Anak'],
      'answer': 0
    },

    // --- Krama Inggil -> Ngoko ---
    {
      'question': 'Basa ngokone "Rawuh" yaiku...',
      'type': 'Krama Inggil -> Ngoko',
      'options': ['Lunga', 'Teka', 'Muleh', 'Mangkat'],
      'answer': 1
    },
    {
      'question': 'Basa ngokone "Rikma" yaiku...',
      'type': 'Krama Inggil -> Ngoko',
      'options': ['Mripat', 'Untu', 'Rambut', 'Irung'],
      'answer': 2
    },

    // --- Krama Inggil -> Krama ---
    {
      'question': 'Tembung "Dalem" kramane yaiku...',
      'type': 'Krama Inggil -> Krama',
      'options': ['Griya', 'Omah', 'Sabin', 'Peken'],
      'answer': 0
    },
    {
      'question': 'Tembung "Mundhut" kramane yaiku...',
      'type': 'Krama Inggil -> Krama',
      'options': ['Sade', 'Tumbas', 'Tuku', 'Nyuwun'],
      'answer': 1
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: JowoColors.navyBg,
      body: Stack(
        children: [
          const RepaintBoundary(child: _StaticBackground()),
          SafeArea(
            child: Column(
              children: [
                _buildHeader(),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: _buildStageContent(),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.pop(context),
          ),
          // const Text("IsoJowo",
          //     style: TextStyle(
          //         fontWeight: FontWeight.bold,
          //         color: Colors.white,
          //         fontSize: 18)),
          const Spacer(),
          const Icon(Icons.notifications_none_rounded,
              color: Colors.white, size: 22),
          const SizedBox(width: 15),
          const Icon(Icons.account_circle, color: Colors.white, size: 26),
          const SizedBox(width: 15),
          const Icon(Icons.settings_outlined, color: Colors.white, size: 22),
        ],
      ),
    );
  }

  Widget _buildStageContent() {
    switch (_currentStage) {
      case BattleStage.setup:
        return _buildSetupView();
      case BattleStage.quiz:
        return _buildQuizView();
      case BattleStage.result:
        return _buildResultView();
    }
  }

  Widget _buildSetupView() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 10),
        const Text("Pepak Battle",
            style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: JowoColors.goldAccent)),
        const Text("Tentukan tantanganmu!",
            style: TextStyle(color: Colors.white, fontSize: 13)),
        const SizedBox(height: 20),
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
                color: figmaLightGrey, borderRadius: BorderRadius.circular(25)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Jumlah Pertanyaan",
                    style: TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [5, 10, 15, 20]
                      .map((n) => _buildChoiceChip(
                          n.toString(), _questionCount == n,
                          onTap: () => setState(() => _questionCount = n)))
                      .toList(),
                ),
                const SizedBox(height: 20),
                Text("Tipe Pertanyaan (${_selectedTypes.length} dipilih)",
                    style: const TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                Wrap(
                  spacing: 6,
                  runSpacing: 6,
                  children:
                      _allTypes.map((type) => _buildTypeChip(type)).toList(),
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Icon(Icons.shuffle_rounded, size: 18, color: primaryAmber),
                    const SizedBox(width: 8),
                    const Text("Tipe Acak",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ),
                const Divider(thickness: 1),
                Row(
                  children: [
                    _buildToggleBox(
                        "Acak Soal",
                        "Urutan diacak",
                        _isShuffleQuestions,
                        (v) => setState(() => _isShuffleQuestions = v)),
                    const SizedBox(width: 8),
                    _buildToggleBox(
                        "Acak Opsi",
                        "Opsi diacak",
                        _isShuffleOptions,
                        (v) => setState(() => _isShuffleOptions = v)),
                  ],
                ),
                const Spacer(),
                SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: primaryAmber,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15))),
                    onPressed: _selectedTypes.isEmpty
                        ? null
                        : () {
                            setState(() {
                              _score = 0;
                              _currentQuestionIndex = 0;
                              _selectedOptionIndex = null;
                              _hasAnswered = false;
                              if (_isShuffleQuestions) _questions.shuffle();
                              _currentStage = BattleStage.quiz;
                            });
                          },
                    child: const Text("Mulai Quiz",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18)),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  Widget _buildQuizView() {
    final q = _questions[_currentQuestionIndex % _questions.length];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 10),
        const Text("Pepak Battle",
            style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: JowoColors.goldAccent)),
        const SizedBox(height: 20),
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
              color: figmaLightGrey, borderRadius: BorderRadius.circular(25)),
          child: Column(
            children: [
              _buildQuizHeader(q['type']),
              const SizedBox(height: 20),
              Text(q['question'],
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: JowoColors.navyBg)),
              const SizedBox(height: 20),
              ...List.generate(4,
                  (i) => _buildOptionButton(i, q['options'][i], q['answer'])),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: primaryAmber,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12))),
                  onPressed: _hasAnswered ? _handleNextQuestion : null,
                  child: const Text("Lanjut",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold)),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildResultView() {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(30),
        decoration: BoxDecoration(
            color: figmaLightGrey, borderRadius: BorderRadius.circular(30)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.emoji_events_rounded, size: 80, color: primaryAmber),
            const SizedBox(height: 15),
            const Text("Kuis Rampung!",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            Text("$_score / ${_questionCount * 10}",
                style: TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.bold,
                    color: primaryAmber)),
            const SizedBox(height: 25),
            Row(
              children: [
                Expanded(
                    child: ElevatedButton(
                  style:
                      ElevatedButton.styleFrom(backgroundColor: primaryAmber),
                  onPressed: () => setState(() {
                    _score = 0;
                    _currentQuestionIndex = 0;
                    _hasAnswered = false;
                    if (_isShuffleQuestions) _questions.shuffle();
                    _currentStage = BattleStage.quiz;
                  }),
                  child: const Text("Main Maneh",
                      style: TextStyle(color: Colors.white)),
                )),
                const SizedBox(width: 10),
                Expanded(
                    child: OutlinedButton(
                  onPressed: () =>
                      setState(() => _currentStage = BattleStage.setup),
                  child: const Text("Setting"),
                )),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildToggleBox(
      String title, String sub, bool val, ValueChanged<bool> onChange) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
            color: primaryAmber.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: primaryAmber.withOpacity(0.3))),
        child: Row(
          children: [
            Expanded(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                  Text(title,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 10),
                      overflow: TextOverflow.ellipsis),
                  Text(sub,
                      style:
                          const TextStyle(fontSize: 8, color: Colors.black45),
                      overflow: TextOverflow.ellipsis),
                ])),
            Transform.scale(
                scale: 0.7,
                child: Switch(
                    value: val,
                    onChanged: onChange,
                    activeColor: primaryAmber,
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap)),
          ],
        ),
      ),
    );
  }

  Widget _buildQuizHeader(String type) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Soal ${_currentQuestionIndex + 1} / $_questionCount",
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                  color: primaryAmber, borderRadius: BorderRadius.circular(10)),
              child: Text(type,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.bold)),
            )
          ],
        ),
        const SizedBox(height: 10),
        LinearProgressIndicator(
            value: (_currentQuestionIndex + 1) / _questionCount,
            backgroundColor: Colors.white,
            valueColor: AlwaysStoppedAnimation(primaryAmber)),
      ],
    );
  }

  Widget _buildChoiceChip(String label, bool selected,
      {required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
        decoration: BoxDecoration(
            color: selected ? primaryAmber : Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.black12)),
        child: Text(label,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: selected ? Colors.white : Colors.black)),
      ),
    );
  }

  Widget _buildTypeChip(String label) {
    bool selected = _selectedTypes.contains(label);
    return GestureDetector(
      onTap: () => setState(() =>
          selected ? _selectedTypes.remove(label) : _selectedTypes.add(label)),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
            color: selected ? primaryAmber : Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.black12)),
        child: Text(label,
            style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.bold,
                color: selected ? Colors.white : Colors.black)),
      ),
    );
  }

  Widget _buildOptionButton(int index, String text, int correctIndex) {
    bool isSelected = _selectedOptionIndex == index;
    Color color = Colors.white;
    if (_hasAnswered) {
      if (index == correctIndex)
        color = Colors.green.shade400;
      else if (isSelected) color = Colors.red.shade400;
    }
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              backgroundColor: color,
              foregroundColor: JowoColors.navyBg,
              elevation: 0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                  side: const BorderSide(color: Colors.black12))),
          onPressed: _hasAnswered
              ? null
              : () => setState(() {
                    _selectedOptionIndex = index;
                    _hasAnswered = true;
                    if (index == correctIndex) _score += 10;
                  }),
          child: Align(alignment: Alignment.centerLeft, child: Text(text)),
        ),
      ),
    );
  }

  void _handleNextQuestion() {
    setState(() {
      _hasAnswered = false;
      _selectedOptionIndex = null;
      (_currentQuestionIndex + 1 < _questionCount)
          ? _currentQuestionIndex++
          : _currentStage = BattleStage.result;
    });
  }
}

class _StaticBackground extends StatelessWidget {
  const _StaticBackground();
  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
        child: Image.asset('assets/images/HomePage.png',
            fit: BoxFit.cover, opacity: const AlwaysStoppedAnimation(0.12)));
  }
}
