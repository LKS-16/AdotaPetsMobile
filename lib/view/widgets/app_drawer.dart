import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onItemSelected;

  const AppDrawer({
    super.key,
    required this.selectedIndex,
    required this.onItemSelected,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Drawer(
      backgroundColor: theme.colorScheme.surface,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(top: 60, left: 20, bottom: 20),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Color(0xFFD35400),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.pets, color: Colors.white, size: 28),
                ),
                const SizedBox(width: 15),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "AdotaPets",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: theme.colorScheme.onSurface,
                      ),
                    ),
                    Text(
                      "ADOTE COM AMOR",
                      style: TextStyle(
                        fontSize: 12,
                        color: theme.brightness == Brightness.dark
                            ? Colors.grey[400]
                            : Colors.grey[600],
                        letterSpacing: 1,
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                IconButton(
                  icon: Icon(Icons.close, color: theme.colorScheme.onSurface),
                  onPressed: () => Navigator.pop(context),
                ),
                const SizedBox(width: 10),
              ],
            ),
          ),

          const Divider(),

          _buildDrawerItem(context, 0, Icons.home_outlined, "Feed"),
          _buildDrawerItem(context, 1, Icons.favorite_border, "Favoritos"),
          _buildDrawerItem(context, 2, Icons.pets, "Meus Pets"),
          _buildDrawerItem(context, 3, Icons.chat_bubble_outline, "Conversas"),
          _buildDrawerItem(context, 4, Icons.person_outline, "Perfil"),
          _buildDrawerItem(
            context,
            5,
            Icons.settings_outlined,
            "Configurações",
          ),
        ],
      ),
    );
  }

  Widget _buildDrawerItem(
    BuildContext context,
    index,
    IconData icon,
    String title,
  ) {
    final bool isSelected = selectedIndex == index;
    final theme = Theme.of(context);

    final Color itemColor = isSelected
        ? Colors.white
        : theme.colorScheme.onSurface.withOpacity(0.7);

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: isSelected ? const Color(0xFFD35400) : Colors.transparent,
        borderRadius: BorderRadius.circular(10),
      ),

      child: ListTile(
        leading: Icon(icon, color: itemColor),
        title: Text(
          title,
          style: TextStyle(
            color: itemColor,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        onTap: () {
          onItemSelected(index);
        },
      ),
    );
  }
}
