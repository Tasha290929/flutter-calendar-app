import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Footer extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const Footer({super.key, required this.currentIndex, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      left: false,
      right: false,
      bottom: true,
      child: SizedBox(
        height: 60 + MediaQuery.of(context).padding.bottom,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Align(
              alignment: Alignment.bottomCenter,
              child: NavigationBar(
                selectedIndex: currentIndex,
                onDestinationSelected: onTap,
                indicatorColor: Colors.blueAccent,
                destinations: [
                  const NavigationDestination(
                    selectedIcon: Icon(Icons.today_outlined),
                    icon: Icon(Icons.today_outlined),
                    label: 'Today',
                  ),
                  const NavigationDestination(
                    selectedIcon: Icon(Icons.calendar_month_outlined),
                    icon: Icon(Icons.calendar_today_outlined),
                    label: 'Calendar',
                  ),
                  NavigationDestination(
                    label: '',
                    icon: Container(
                      width: 40,
                      height: 40,
                      decoration: const BoxDecoration(
                        color: Color(0xFF777ED3),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.add,
                        color: Colors.white,
                        size: 24,
                      ),
                    ),
                  ),

                  const NavigationDestination(
                    selectedIcon: Icon(Icons.auto_graph_outlined),
                    icon: Icon(Icons.auto_graph_outlined),
                    label: 'Reports',
                  ),
                  const NavigationDestination(
                    selectedIcon: Icon(Icons.settings),
                    icon: Icon(Icons.settings),
                    label: 'Settings',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
