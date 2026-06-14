import 'package:flutter/material.dart';

class BotaoAdotar extends StatelessWidget {
  final String petName;
  final VoidCallback onPressed;

  const BotaoAdotar({
    super.key,
    required this.petName,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 52,
      child: ElevatedButton.icon(
        onPressed: onPressed,
        icon: const Icon(Icons.favorite_border, size: 20, color: Colors.white),
        label: Text(
          'Adotar $petName',
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFE8622A),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          elevation: 0,
        ),
      ),
    );
  }
}
