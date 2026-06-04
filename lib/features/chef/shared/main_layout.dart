import 'package:flutter/material.dart';
import 'package:savora_app/features/chef/dashboard/dashboard_page.dart';
import 'package:savora_app/features/chef/shared/add_item_page.dart';
import 'package:savora_app/features/chef/services/services_page.dart';
import 'package:savora_app/features/chef/settings/setting.dart';
import 'package:savora_app/features/chef/notifications/notifications_page.dart';
import 'package:savora_app/features/chef/shared/language_service.dart';

class MainLayout extends StatefulWidget {
  const MainLayout({super.key});

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  int currentIndex = 0;

  /// الصفحات الرئيسية
  final List<Widget> pages = [
    DashboardPage(),
    const ServicesPage(),
    const SizedBox(), 
    const NotificationsPage(),
    SettingChefs(),
  ];

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: LanguageManager.textDirection,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: pages[currentIndex],
        bottomNavigationBar: _buildBottomNavigationBar(context),
      ),
    );
  }

  Widget _buildBottomNavigationBar(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(12),
      padding: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFF4F4F61),
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _navItem(
            icon: Icons.home_rounded,
            label: LanguageManager.isArabic ? "الرئيسية" : "Home",
            index: 0,
          ),
          _navItem(
            icon: Icons.grid_view_rounded,
            label: LanguageManager.isArabic ? "خدماتي" : "My Services",
            index: 1,
          ),

          /// زر الإضافة
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const AddItemPage()),
              );
            },
            child: Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFFFF6B35),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFFFF6B35).withOpacity(0.35),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: const Icon(
                Icons.add_rounded,
                color: Colors.white,
                size: 30,
              ),
            ),
          ),

          _navItem(
            icon: Icons.notifications_rounded,
            label:
                LanguageManager.isArabic ? "الإشعارات" : "Notifications",
            index: 3,
          ),
          _navItem(
            icon: Icons.person_rounded,
            label: LanguageManager.isArabic ? "حسابي" : "Account",
            index: 4,
          ),
        ],
      ),
    );
  }

  Widget _navItem({
    required IconData icon,
    required String label,
    required int index,
  }) {
    final bool isActive = currentIndex == index;

    return GestureDetector(
      onTap: () => setState(() => currentIndex = index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 26,
            color:
                isActive ? const Color(0xFFFF6B35) : const Color(0xFF9CA3AF),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 11,
              fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
              color: isActive
                  ? const Color(0xFFFF6B35)
                  : const Color(0xFF9CA3AF),
            ),
          ),
        ],
      ),
    );
  }
}
