import 'package:flutter/material.dart';
import '../models/menu_item.dart';
import '../services/cart_service.dart';
import '../data/menu_data.dart';
import '../widgets/menu_item_card.dart';
import '../widgets/category_chip.dart';
import 'cart_screen.dart';

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
    );
  }
}
