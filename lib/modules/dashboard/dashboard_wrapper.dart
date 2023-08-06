import 'package:flutter/material.dart';
import 'package:grade_management_app/modules/dashboard/dashboard_page/dashboard_view.dart';
import 'package:iconsax/iconsax.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

class DashboardWrapper extends StatefulWidget {
  const DashboardWrapper({super.key});

  @override
  State<DashboardWrapper> createState() => _DashboardWrapperState();
}

class _DashboardWrapperState extends State<DashboardWrapper> {
  int currentIndex = 0;

  Widget _buildBody(int currentIndex) {
    switch (currentIndex) {
      case 0:
        return const DashboardView();

      case 1:
        return Container(
          child: const Center(
            child: Text("Analytics"),
          ),
        );
      default:
        return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: _buildBody(currentIndex),
        bottomNavigationBar: SalomonBottomBar(
            backgroundColor: const Color(0xff1B1C19),
            currentIndex: currentIndex,
            onTap: (i) => setState(() => currentIndex = i),
            items: [
              SalomonBottomBarItem(
                  icon: const Icon(Iconsax.category_2),
                  activeIcon: const Icon(Iconsax.category_25),
                  title: const Text("Dashboard"),
                  selectedColor: const Color(0xffCAEEA3),
                  unselectedColor: const Color(0XffABACA5)),
              SalomonBottomBarItem(
                  icon: const Icon(Iconsax.chart_3),
                  activeIcon: const Icon(Iconsax.chart_34),
                  title: const Text("Analytics"),
                  selectedColor: const Color(0xffCAEEA3),
                  unselectedColor: const Color(0XffABACA5)),
            ]));
  }
}
