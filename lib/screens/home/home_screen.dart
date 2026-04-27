import 'package:flutter/material.dart';
import '../../core/constants/colors.dart';

class HomeScreen extends StatelessWidget {
  final List<Map<String, dynamic>> menuData = [
    {'title': 'Njawi Look', 'image': 'assets/images/njawilook.png'},
    {'title': 'Aksara Lab', 'image': 'assets/images/aksaralab.png'},
    {'title': 'Pepak Battle', 'image': 'assets/images/pepakbattle.png'},
    {'title': 'Auto Alus', 'image': 'assets/images/autoalus.png'},
    {'title': 'Flash Jowo', 'image': 'assets/images/flashjowo.png'},
    {'title': 'Gendhing Chill', 'image': 'assets/images/gendingchill.png'},
  ];

  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: JowoColors.navyBg,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          "IsoJowo",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none_rounded,
                color: Colors.white),
            onPressed: () {},
          ),
          IconButton(
            icon:
                const Icon(Icons.account_circle, size: 30, color: Colors.white),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.settings_outlined, color: Colors.white),
            onPressed: () {},
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/HomePage.png',
              fit: BoxFit.cover,
              opacity: const AlwaysStoppedAnimation(0.8),
            ),
          ),
          Positioned.fill(
            child: Column(
              children: [
                SizedBox(
                    height:
                        MediaQuery.of(context).padding.top + kToolbarHeight),
                Expanded(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 20),
                        // Banner Section
                        Container(
                          height: 210,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            image: const DecorationImage(
                              image: AssetImage(
                                  'assets/images/banner_wilujeng.png'),
                              fit: BoxFit.fill,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.3),
                                blurRadius: 10,
                                offset: const Offset(0, 5),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                        // Grid Menu Section
                        GridView.builder(
                          padding: const EdgeInsets.only(bottom: 20),
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 15,
                            mainAxisSpacing: 15,
                            childAspectRatio: 1.0,
                          ),
                          itemCount: menuData.length,
                          itemBuilder: (context, index) {
                            final title = menuData[index]['title'].toString();
                            final routeName =
                                '/${title.toLowerCase().replaceAll(' ', '_')}';
                            return InkWell(
                              onTap: () =>
                                  Navigator.pushNamed(context, routeName),
                              borderRadius: BorderRadius.circular(25),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: JowoColors.creamCard,
                                  borderRadius: BorderRadius.circular(25),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      menuData[index]['image'],
                                      width: 60,
                                      height: 60,
                                      fit: BoxFit.contain,
                                    ),
                                    const SizedBox(height: 12),
                                    Text(
                                      title,
                                      style: const TextStyle(
                                        color: JowoColors.navyBg,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
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
