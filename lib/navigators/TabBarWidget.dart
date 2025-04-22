import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:regive_v3/providers/global_providers.dart';
import 'package:regive_v3/screens/ConfigurationScreen.dart';
import 'package:regive_v3/screens/MainScreen.dart';
import 'package:regive_v3/screens/MessageScreen.dart';
import 'package:regive_v3/screens/MyRequestScreen.dart';
import 'package:regive_v3/screens/ProductManagerScreen.dart';

final currentIndexProvider = StateProvider<int>((ref) => 0);

class TabBarWidget extends ConsumerWidget {
  const TabBarWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentIndex = ref.watch(currentIndexProvider);

    final List<Widget> _pages = [
      MainScreen(),
      MyRequestScreen(),
      ProductManagerScreen(),
      MessageScreen(),
      ConfigurationScreen(),
    ];

    void _onItemTapped(int index) {
      ref.read(currentIndexProvider.notifier).state = index;

      final shouldShow = index != 2;
      ref.read(showOwnerAndOrderProvider.notifier).state = shouldShow;
    }

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFEFA354), Color(0xFFE56230)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 10, top: 35),
              child: SvgPicture.asset(
                'assets/ReGive_logo_horizontal.svg',
                width: 180,
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 45),
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFE0C0),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  width: double.infinity,
                  child: Column(
                    children: [
                      Expanded(child: _pages[currentIndex]),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: BottomNavigationBar(
                            backgroundColor: Colors.transparent,
                            elevation: 0,
                            selectedItemColor: Color(0xFFC05A27),
                            unselectedItemColor: Color(0xFFE9773B),
                            currentIndex: currentIndex,
                            items: const <BottomNavigationBarItem>[
                              BottomNavigationBarItem(
                                icon: Icon(Icons.home, size: 35),
                                label: 'Home',
                              ),
                              BottomNavigationBarItem(
                                icon: Icon(Icons.list, size: 35),
                                label: 'My Requests',
                              ),
                              BottomNavigationBarItem(
                                icon: Icon(Icons.widgets, size: 35),
                                label: 'My Products',
                              ),
                              BottomNavigationBarItem(
                                icon: Icon(Icons.message, size: 35),
                                label: 'Messages',
                              ),
                              BottomNavigationBarItem(
                                icon: Icon(Icons.settings, size: 35),
                                label: 'Configuration',
                              ),
                            ],
                            onTap: _onItemTapped,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
