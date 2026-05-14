import 'package:flutter/material.dart';

class FiltroAnimais extends StatefulWidget {
  const FiltroAnimais({super.key});

  @override
  State<FiltroAnimais> createState() => _FiltroAnimaisState();
}

class _FiltroAnimaisState extends State<FiltroAnimais> {
  int selectedIndex = 0;

  final List<Map<String, dynamic>> filtros = [
    {'label': 'Todos', 'icon': Icons.pets},
    {'label': 'Cães', 'icon': Icons.pets},
    {'label': 'Gatos', 'icon': Icons.pets},
    {'label': 'Dragões', 'icon': Icons.pets},
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 45,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: filtros.length,
        itemBuilder: (context, index) {
          bool isSelected = selectedIndex == index;
          return GestureDetector(
            onTap: () => setState(() => selectedIndex = index),
            child: Container(
              margin: const EdgeInsets.only(right: 12),
              padding: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                color: isSelected ? const Color(0xFFD35400) : Colors.white,
                borderRadius: BorderRadius.circular(15),
                border: Border.all(
                  color: isSelected ? Colors.transparent : Colors.grey,
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    filtros[index]['icon'],
                    size: 18,
                    color: isSelected ? Colors.white : Colors.grey[600],
                  ),
                  const SizedBox(width: 8),
                  Text(
                    filtros[index]['label'],
                    style: TextStyle(
                      color: isSelected ? Colors.white : Colors.black,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
