import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:regive_v3/screens/ConfigurationScreen.dart';
import 'package:regive_v3/screens/ProductManagerScreen.dart';
import 'package:regive_v3/screens/MessageScreen.dart';
import 'package:regive_v3/screens/MyRequestScreen.dart';
import 'package:regive_v3/screens/MainScreen.dart';

final currentIndexProvider = StateProvider<int>((ref) => 0);

class TabBarWidget extends ConsumerWidget {
  const TabBarWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentIndex = ref.watch(currentIndexProvider);

    final List<Widget> _pages = [
      MainScreen(),
      MyRequestScreen(),
      ProductManagerScreen(),
      MessageScreen(),
      ConfigurationScreen()
    ];

    void _onItemTapped(int index) {
      ref.read(currentIndexProvider.notifier).state = index;
    }

    return Scaffold(
      body: _pages[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: _onItemTapped,
        backgroundColor: Colors.black12,
        selectedItemColor: Colors.black87,
        unselectedItemColor: Colors.grey,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'My Requests',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: 'Requests',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.message),
            label: 'Manage Products',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Manage Products',
          ),
        ],
      ),
    );
  }
}
