import 'package:flutter/material.dart';


class BottomNavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const BottomNavItem({
    required this.icon,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: isSelected ? Colors.black : Colors.white),
          Text(
            label,
            style: TextStyle(
              color: isSelected ? Colors.black : Colors.white,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}