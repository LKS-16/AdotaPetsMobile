import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Tab extends StatelessWidget {
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  const Tab({required this.label, required this.isActive, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          margin: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: isActive ? Colors.white : Colors.transparent,
            borderRadius: BorderRadius.circular(9),
            boxShadow: isActive
                ? [BoxShadow(color: Colors.black.withOpacity(0.08), blurRadius: 6, offset: const Offset(0, 2))]
                : null,
          ),
          child: Center(
            child: Text(
              label,
              style: TextStyle(
                fontSize: 14,
                fontWeight: isActive ? FontWeight.w700 : FontWeight.w500,
                color: isActive ? const Color(0xFF1A1A1A) : const Color(0xFF888888),
              ),
            ),
          ),
        ),
      ),
    );
  }
}