import 'package:flutter/foundation.dart';
import '../models/menu_item.dart';

class CartService extends ChangeNotifier {
  final List<CartItem> _items = [];

  List<CartItem> get items => List.unmodifiable(_items);

  int get itemCount => _items.fold(0, (sum, item) => sum + item.quantity);

  double get totalAmount =>
      _items.fold(0.0, (sum, item) => sum + item.totalPrice);

  void addItem(MenuItem menuItem) {
    final existingIndex = _items.indexWhere(
      (item) => item.menuItem.id == menuItem.id,
    );

    if (existingIndex >= 0) {
      _items[existingIndex].quantity++;
    } else {
      _items.add(CartItem(menuItem: menuItem));
    }
    notifyListeners();
  }

  void removeItem(String menuItemId) {
    _items.removeWhere((item) => item.menuItem.id == menuItemId);
    notifyListeners();
  }

  void updateQuantity(String menuItemId, int quantity) {
    final index = _items.indexWhere((item) => item.menuItem.id == menuItemId);

    if (index >= 0) {
      if (quantity <= 0) {
        _items.removeAt(index);
      } else {
        _items[index].quantity = quantity;
      }
      notifyListeners();
    }
  }

  void addSpecialInstructions(String menuItemId, String instructions) {
    final index = _items.indexWhere((item) => item.menuItem.id == menuItemId);

    if (index >= 0) {
      _items[index].specialInstructions = instructions;
      notifyListeners();
    }
  }

  void clearCart() {
    _items.clear();
    notifyListeners();
  }

  bool isInCart(String menuItemId) {
    return _items.any((item) => item.menuItem.id == menuItemId);
  }

  int getQuantity(String menuItemId) {
    final item = _items.firstWhere(
      (item) => item.menuItem.id == menuItemId,
      orElse: () => CartItem(
        menuItem: MenuItem(
          id: '',
          name: '',
          description: '',
          price: 0,
          category: '',
          imageUrl: '',
        ),
        quantity: 0,
      ),
    );
    return item.quantity;
  }
}
