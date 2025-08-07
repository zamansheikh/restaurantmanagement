import 'package:flutter/material.dart';
import '../models/menu_item.dart';
import '../services/cart_service.dart';
import '../data/menu_data.dart';
import '../widgets/menu_item_card.dart';
import '../widgets/category_chip.dart';
import 'cart_screen.dart';
import 'login_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final CartService _cartService = CartService();
  String _selectedCategory = 'All';
  List<MenuItem> _menuItems = [];
  List<MenuItem> _filteredItems = [];

  @override
  void initState() {
    super.initState();
    _menuItems = MenuData.getMenuItems();
    _filteredItems = _menuItems;

    // Listen to cart changes to update UI
    _cartService.addListener(_onCartChanged);
  }

  @override
  void dispose() {
    _cartService.removeListener(_onCartChanged);
    super.dispose();
  }

  void _onCartChanged() {
    setState(() {
      // This will trigger a rebuild when cart changes
    });
  }

  void _filterByCategory(String category) {
    setState(() {
      _selectedCategory = category;
      if (category == 'All') {
        _filteredItems = _menuItems;
      } else {
        _filteredItems = _menuItems
            .where((item) => item.category == category)
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF8E1),
      appBar: AppBar(
        backgroundColor: const Color(0xFF2C1810),
        foregroundColor: const Color(0xFFFFF8E1),
        title: const Text(
          'Mac \'n\' Cheese',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.2,
          ),
        ),
        centerTitle: true,
        elevation: 4,
        shadowColor: Colors.black.withOpacity(0.3),
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
        actions: [
          Stack(
            children: [
              IconButton(
                icon: const Icon(Icons.shopping_cart),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          CartScreen(cartService: _cartService),
                    ),
                  );
                },
              ),
              if (_cartService.itemCount > 0)
                Positioned(
                  right: 8,
                  top: 8,
                  child: Container(
                    padding: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      color: const Color(0xFFD4AF37),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    constraints: const BoxConstraints(
                      minWidth: 16,
                      minHeight: 16,
                    ),
                    child: Text(
                      '${_cartService.itemCount}',
                      style: const TextStyle(
                        color: Color(0xFF2C1810),
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
      body: Column(
        children: [
          // Header with restaurant info
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  const Color(0xFF2C1810),
                  const Color(0xFF2C1810).withOpacity(0.8),
                ],
              ),
            ),
            child: const Column(
              children: [
                Text(
                  'Welcome to Mac \'n\' Cheese',
                  style: TextStyle(
                    color: Color(0xFFFFF8E1),
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Authentic Bangladeshi cuisine served fresh',
                  style: TextStyle(
                    color: Color(0xFFD4AF37),
                    fontSize: 14,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
            ),
          ),

          // Category filters
          Container(
            height: 60,
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: MenuData.getCategories().length,
              itemBuilder: (context, index) {
                final category = MenuData.getCategories()[index];
                return Padding(
                  padding: const EdgeInsets.only(right: 12),
                  child: CategoryChip(
                    label: category,
                    isSelected: _selectedCategory == category,
                    onTap: () => _filterByCategory(category),
                  ),
                );
              },
            ),
          ),

          // Menu items
          Expanded(
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child: ListView.builder(
                key: ValueKey(_selectedCategory),
                padding: const EdgeInsets.all(16),
                itemCount: _filteredItems.length,
                itemBuilder: (context, index) {
                  final item = _filteredItems[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: MenuItemCard(
                      menuItem: item,
                      cartService: _cartService,
                      onAddToCart: () {
                        _cartService.addItem(item);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('${item.name} added to cart'),
                            backgroundColor: const Color(0xFF2C1810),
                            behavior: SnackBarBehavior.floating,
                            duration: const Duration(seconds: 1),
                          ),
                        );
                        // No need for manual setState() - listener handles it
                      },
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
      drawer: Drawer(
        child: Container(
          color: const Color(0xFFFFF8E1),
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              // Drawer header
              DrawerHeader(
                decoration: const BoxDecoration(color: Color(0xFF2C1810)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 60,
                      height: 60,
                      decoration: const BoxDecoration(
                        color: Color(0xFFD4AF37),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.restaurant,
                        size: 30,
                        color: Color(0xFF2C1810),
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Mac \'n\' Cheese',
                      style: TextStyle(
                        color: Color(0xFFFFF8E1),
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Text(
                      'Authentic Bangladeshi Cuisine',
                      style: TextStyle(
                        color: Color(0xFFD4AF37),
                        fontSize: 14,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ],
                ),
              ),

              // About Developer
              ListTile(
                leading: const Icon(Icons.person, color: Color(0xFF2C1810)),
                title: const Text(
                  'About Developer',
                  style: TextStyle(
                    color: Color(0xFF2C1810),
                    fontWeight: FontWeight.w600,
                  ),
                ),
                subtitle: const Text(
                  'Developed by Pritom',
                  style: TextStyle(color: Color(0xFF2C1810), fontSize: 12),
                ),
                onTap: () {
                  Navigator.pop(context);
                  _showAboutDeveloper(context);
                },
              ),

              const Divider(
                color: Color(0xFF2C1810),
                thickness: 0.5,
                indent: 16,
                endIndent: 16,
              ),

              // Logout
              ListTile(
                leading: const Icon(Icons.logout, color: Colors.red),
                title: const Text(
                  'Logout',
                  style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                onTap: () {
                  Navigator.pop(context);
                  _showLogoutDialog(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showAboutDeveloper(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        backgroundColor: const Color(0xFFFFF8E1),
        title: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: const BoxDecoration(
                color: Color(0xFF2C1810),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.code, color: Color(0xFFD4AF37), size: 20),
            ),
            const SizedBox(width: 12),
            const Text(
              'About Developer',
              style: TextStyle(
                color: Color(0xFF2C1810),
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Developer: Pritom',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF2C1810),
              ),
            ),
            const SizedBox(height: 12),
            const Text(
              'This Mac \'n\' Cheese Restaurant Management App was developed with love using Flutter.',
              style: TextStyle(
                fontSize: 14,
                color: Color(0xFF2C1810),
                height: 1.4,
              ),
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFFD4AF37).withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: const Color(0xFFD4AF37), width: 1),
              ),
              child: const Text(
                '🚀 Built with Flutter\n💛 Designed for Bengali food lovers\n✨ Crafted with passion',
                style: TextStyle(
                  fontSize: 12,
                  color: Color(0xFF2C1810),
                  height: 1.5,
                ),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            style: TextButton.styleFrom(
              foregroundColor: const Color(0xFF2C1810),
            ),
            child: const Text(
              'Close',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        backgroundColor: const Color(0xFFFFF8E1),
        title: Row(
          children: [
            const Icon(Icons.logout, color: Colors.red, size: 24),
            const SizedBox(width: 12),
            const Text(
              'Logout',
              style: TextStyle(
                color: Color(0xFF2C1810),
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        content: const Text(
          'Are you sure you want to logout?',
          style: TextStyle(fontSize: 16, color: Color(0xFF2C1810)),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            style: TextButton.styleFrom(
              foregroundColor: const Color(0xFF2C1810),
            ),
            child: const Text(
              'Cancel',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              // Clear cart on logout
              _cartService.clearCart();
              // Navigate to login screen
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => const LoginScreen()),
                (route) => false,
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text(
              'Logout',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }
}
