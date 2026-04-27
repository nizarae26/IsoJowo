import 'package:flutter/material.dart';
import '../core/constants/colors.dart';

class CustomInput extends StatelessWidget {
  final String hint;
  final IconData icon;
  final bool isPassword;

  const CustomInput({
    required this.hint, 
    required this.icon, 
    this.isPassword = false
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: isPassword,
      style: TextStyle(color: Colors.black87),
      decoration: InputDecoration(
        hintText: hint,
        prefixIcon: Icon(icon, color: Colors.grey),
        filled: true,
        fillColor: Colors.white.withOpacity(0.9),
        contentPadding: EdgeInsets.symmetric(vertical: 18),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}