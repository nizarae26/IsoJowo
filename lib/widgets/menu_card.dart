import 'package:flutter/material.dart';
import '../core/constants/colors.dart';

class MenuCard extends StatelessWidget {
  final String title;
  final IconData icon;

  const MenuCard({required this.title, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: JowoColors.creamCard,
        borderRadius: BorderRadius.circular(25),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 50, color: JowoColors.navyBg),
          const SizedBox(height: 10),
          Text(title, 
            style: const TextStyle(color: JowoColors.navyBg, fontWeight: FontWeight.bold, fontSize: 16)),
        ],
      ),
    );
  }
}