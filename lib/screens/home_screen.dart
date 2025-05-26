import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wasty_reviews_app/providers/review_provider.dart';
import 'review_list_screen.dart';
import 'analytics_screen.dart';


class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [ReviewListScreen(), AnalyticsScreen()];

  @override
  Widget build(BuildContext context) {
    final isAdmin = ref.watch(adminModeProvider);
    
    return Scaffold(
      appBar: AppBar(
        title: Text(_selectedIndex == 0 ? "Reviews" : "Analytics"),
        actions: [
          Row(
            children: [
              const Text("Admin", style: TextStyle(fontSize: 16)),
              Switch(
                value: isAdmin,
                onChanged: (val) {
                  ref.read(adminModeProvider.notifier).state = val;
                },
              ),
            ],
          ),
        ],
      ),
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.reviews), label: "Reviews"),
          BottomNavigationBarItem(
            icon: Icon(Icons.analytics),
            label: "Analytics",
          ),
        ],
        onTap: (index) {
          setState(() => _selectedIndex = index);
        },
      ),
    );
  }
}
