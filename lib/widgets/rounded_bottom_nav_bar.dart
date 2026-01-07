import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RoundedBottomNavBar extends StatelessWidget {
  final int activeIndex;
  final ValueChanged<int>? onItemSelected;

  const RoundedBottomNavBar({
    super.key,
    required this.activeIndex,
    this.onItemSelected,
  });

  static const _items = [
    _NavItem(Icons.home_outlined, 'Home'),
    _NavItem(Icons.calendar_month, 'Calendar'),
    _NavItem(Icons.person_outline, 'Profile'),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
      decoration: BoxDecoration(
        color: const Color(0xFFE05C5C),
        borderRadius: BorderRadius.circular(40),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: List.generate(_items.length, (index) {
          final item = _items[index];
          final isActive = index == activeIndex;
          return GestureDetector(
            onTap: () => onItemSelected?.call(index),
            behavior: HitTestBehavior.opaque,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  item.icon,
                  color: isActive
                      ? Colors.white
                      : Colors.white.withOpacity(0.7),
                ),
                const SizedBox(height: 4),
                Text(
                  item.label,
                  style: GoogleFonts.poppins(
                    color: isActive
                        ? Colors.white
                        : Colors.white.withOpacity(0.8),
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 4),
                AnimatedOpacity(
                  duration: const Duration(milliseconds: 200),
                  opacity: isActive ? 1 : 0,
                  child: Container(
                    width: 30,
                    height: 3,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}

class _NavItem {
  final IconData icon;
  final String label;
  const _NavItem(this.icon, this.label);
}
