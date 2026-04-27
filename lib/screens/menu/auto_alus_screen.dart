import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../core/constants/colors.dart';

class AutoAlusScreen extends StatefulWidget {
  const AutoAlusScreen({super.key});

  @override
  State<AutoAlusScreen> createState() => _AutoAlusScreenState();
}

class _AutoAlusScreenState extends State<AutoAlusScreen> {
  final TextEditingController _inputController = TextEditingController();
  String _translatedText = "";
  bool _isLoading = false;

  // Simulasi data kamus sederhana untuk demo
  final Map<String, String> _mockDictionary = {
    // --- PRONOUNS (Tembung Sesulih) ---
    "aku": "dalem",
    "kowe": "panjenengan",
    "dheweke": "panjenenganipun",
    "kita": "kita",
    "iki": "punika",
    "kuwi": "punika",

    // --- VERBS (Tembung Kriya) ---
    "mangan": "dhahar",
    "turu": "sare",
    "lunga": "tindak",
    "teka": "rawuh",
    "bali": "kondur",
    "mlaku": "tindak",
    "maca": "maos",
    "nulis": "nyerat",
    "nonton": "mriksani",
    "ngrungokake": "miharsa",
    "ngomong": "ngendika",
    "takon": "nyuwun pirsa",
    "weneh": "maringi",
    "jaluk": "nyuwun",
    "tuku": "mundhut",
    "adol": "sade",
    "nggawa": "ngasta",
    "ngerti": "ngertos",
    "paham": "ngertos",
    "adus": "siram",
    "wisuh": "ngumbah asta",
    "mangkat": "bidhal",
    "metu": "miyos",
    "mlebu": "mlebet",
    "tangi": "wungu",
    "lungguh": "piniwan",
    "ngadeg": "jumeneng",
    "nginep": "nyare",
    "nyambut gawe": "ngasta damel",
    "sinau": "sinau",
    "mikir": "nggalih",
    "ngimpi": "nyupena",
    "lara": "gerah",
    "mari": "senggang",
    "ngombe": "ngunjuk",
    "nyawang": "mriksani",

    // --- NOUNS / BODY PARTS (Perangan Awak) ---
    "omah": "dalem",
    "jeneng": "asma",
    "sirah": "mustaka",
    "rambut": "rikma",
    "mripat": "paningal",
    "irung": "grana",
    "lambe": "lathi",
    "untune": "wajane",
    "tangan": "asta",
    "sikil": "sampeyan",
    "weteng": "padharan",
    "kuping": "talingan",
    "rai": "pasuryan",
    "gulu": "jangga",
    "pikir": "penggalih",
    "ati": "penggalih",

    // --- FAMILY & PEOPLE (Wong) ---
    "bapak": "rama",
    "ibu": "ibu",
    "anak": "putra",
    "putu": "wayah",
    "bojo": "garwa",
    "simbah": "eyang",
    "sedulur": "sederek",
    "kanca": "rencang",
    "wong": "tiyang",
    "bocah": "lare",

    // --- DAILY OBJECTS & PLACES (Panggonan) ---
    "klambi": "ageman",
    "kathok": "lancingan",
    "sepatu": "sepatu",
    "tas": "tas",
    "duwit": "arta",
    "sega": "sekul",
    "iwak": "ulam",
    "banyu": "toya",
    "geni": "latu",
    "sawah": "sabin",
    "pasar": "peken",
    "dalan": "margi",
    "panganan": "dhaharan",
    "ombenan": "unjukan",
    "neng": "datheng",

    // --- TIME & QUESTIONS (Wektu & Pitakon) ---
    "saiki": "sakmenika",
    "wingi": "wingi",
    "sesuk": "benjang",
    "esuk": "enjang",
    "awan": "siang",
    "sore": "sonten",
    "bengi": "ndalu",
    "suwe": "dangu",
    "sedhela": "sekedhap",
    "apa": "punapa",
    "sapa": "sinten",
    "ngendi": "pundi",
    "kapan": "benjang menapa",
    "piye": "kadospundi",
    "pira": "pinten",
    "kenapa": "punapa",

    // --- ADJECTIVES (Tembung Kahanan) ---
    "apik": "sae",
    "elek": "awon",
    "seneng": "bingah",
    "sedhih": "susah",
    "adoh": "tebih",
    "cedhak": "caket",
    "akeh": "kathah",
    "sithik": "sekedhik",
    "gedhe": "ageng",
    "cilik": "alit",
    "dhuwur": "inggil",
    "cendhek": "andhap",
    "anyar": "enggal",
    "lawas": "dangu",
    "murah": "mirah",
    "larang": "awis",
    "panas": "benther",
    "adem": "asrep",
    "luwe": "luwe",
    "wareg": "tuwuk",
  };

  void _translate() async {
    if (_inputController.text.isEmpty) return;

    setState(() => _isLoading = true);

    // Simulasi delay proses penerjemahan
    await Future.delayed(const Duration(milliseconds: 800));

    String input = _inputController.text.toLowerCase();
    List<String> words = input.split(' ');
    List<String> results = [];

    for (var word in words) {
      results.add(_mockDictionary[word] ?? word);
    }

    setState(() {
      _translatedText = results.join(' ');
      _isLoading = false;
    });
  }

  void _copyToClipboard() {
    if (_translatedText.isEmpty) return;
    Clipboard.setData(ClipboardData(text: _translatedText));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Hasil terjemahan wis disalin!"),
        backgroundColor: Colors.green,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    const Color figmaOrange = Color(0xFFFFA726);
    // const Color figmaLightGrey = Color(0xFFE0E0E0);

    return Scaffold(
      backgroundColor: JowoColors.navyBg,
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          // 1. BACKGROUND FIXED
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
                // 2. APPBAR KUSTOM (Sesuai permintaan terbaru)
                Padding(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).padding.top + 5,
                      left: 10,
                      right: 10),
                  child: Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back, color: Colors.white),
                        onPressed: () => Navigator.pop(context),
                      ),
                      // const Text(
                      //   "IsoJowo",
                      //   style: TextStyle(
                      //       fontWeight: FontWeight.bold,
                      //       color: Colors.white,
                      //       fontSize: 18),
                      // ),
                      const Spacer(),
                      IconButton(
                        icon: const Icon(Icons.notifications_none_rounded,
                            color: Colors.white, size: 22),
                        onPressed: () {},
                      ),
                      IconButton(
                        icon: const Icon(Icons.account_circle,
                            color: Colors.white, size: 26),
                        onPressed: () {},
                      ),
                      IconButton(
                        icon: const Icon(Icons.settings_outlined,
                            color: Colors.white, size: 22),
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),

                // 3. KONTEN UTAMA
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 25),
                        const Text(
                          "Auto Alus",
                          style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: JowoColors.goldAccent),
                        ),
                        const Text(
                          "Ubah ukara Ngoko dadi Krama Alus kanthi gampang.",
                          style: TextStyle(fontSize: 12, color: Colors.white70),
                        ),
                        const SizedBox(height: 30),

                        // --- INPUT BOX (NGOKO) ---
                        const Text("Basa Ngoko",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold)),
                        const SizedBox(height: 10),
                        Container(
                          padding: const EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: TextField(
                            controller: _inputController,
                            maxLines: 4,
                            style: const TextStyle(color: JowoColors.navyBg),
                            decoration: const InputDecoration(
                              hintText: "Tulis ukara Ngoko neng kene...",
                              border: InputBorder.none,
                            ),
                          ),
                        ),

                        const SizedBox(height: 20),

                        // --- TOMBOL TERJEMAH ---
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: figmaOrange,
                              padding: const EdgeInsets.symmetric(vertical: 15),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15)),
                            ),
                            onPressed: _isLoading ? null : _translate,
                            child: _isLoading
                                ? const SizedBox(
                                    height: 20,
                                    width: 20,
                                    child: CircularProgressIndicator(
                                        color: Colors.white, strokeWidth: 2),
                                  )
                                : const Text("Terjemahke",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold)),
                          ),
                        ),

                        const SizedBox(height: 30),

                        // --- OUTPUT BOX (KRAMA ALUS) ---
                        const Text("Krama Alus",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold)),
                        const SizedBox(height: 10),
                        Container(
                          width: double.infinity,
                          constraints: const BoxConstraints(minHeight: 120),
                          padding: const EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            color: JowoColors.creamCard.withOpacity(0.9),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                                color: JowoColors.goldAccent.withOpacity(0.5)),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                _translatedText.isEmpty
                                    ? "Hasil terjemahan bakal muncul neng kene..."
                                    : _translatedText,
                                style: TextStyle(
                                    fontSize: 16,
                                    color: _translatedText.isEmpty
                                        ? Colors.grey
                                        : JowoColors.navyBg,
                                    fontStyle: _translatedText.isEmpty
                                        ? FontStyle.italic
                                        : FontStyle.normal),
                              ),
                              if (_translatedText.isNotEmpty) ...[
                                const Divider(height: 30),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: IconButton(
                                    onPressed: _copyToClipboard,
                                    icon: const Icon(Icons.copy_rounded,
                                        color: JowoColors.navyBg),
                                  ),
                                )
                              ]
                            ],
                          ),
                        ),
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
