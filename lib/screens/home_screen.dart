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

  // List of screens for bottom navigation tabs
  final List<Widget> _screens = [ReviewListScreen(), AnalyticsScreen()];

  @override
  Widget build(BuildContext context) {
    // Watch admin mode toggle state (true = admin, false = user)
    final isAdmin = ref.watch(adminModeProvider);
    
    return Scaffold(
      appBar: AppBar(
        // Dynamic title based on selected tab
        title: Text(_selectedIndex == 0 ? "Reviews" : "Analytics"),
        actions: [
          Row(
            children: [
              const Text("Admin", style: TextStyle(fontSize: 16)),
              // Toggle switch for admin/user mode
              Switch(
                value: isAdmin,
                onChanged: (val) {
                  // Update admin mode in provider state
                  ref.read(adminModeProvider.notifier).state = val;
                },
              ),
            ],
          ),
        ],
      ),
      // Show selected screen from bottom navigation
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
        // Change selected tab on tap
        onTap: (index) {
          setState(() => _selectedIndex = index);
        },
      ),
    );
  }
}
