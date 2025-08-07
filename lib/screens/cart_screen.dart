import 'package:flutter/material.dart';
import '../services/cart_service.dart';
import '../models/menu_item.dart';
import 'order_confirmation_screen.dart';

class CartScreen extends StatefulWidget {
  final CartService cartService;

  const CartScreen({super.key, required this.cartService});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  void initState() {
    super.initState();
    // Listen to cart changes to update UI
    widget.cartService.addListener(_onCartChanged);
  }

  @override
  void dispose() {
    widget.cartService.removeListener(_onCartChanged);
    super.dispose();
  }

  void _onCartChanged() {
    setState(() {
      // This will trigger a rebuild when cart changes
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
          'Your Cart',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 4,
        shadowColor: Colors.black.withOpacity(0.3),
      ),
      body: widget.cartService.items.isEmpty
          ? _buildEmptyCart()
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: widget.cartService.items.length,
                    itemBuilder: (context, index) {
                      final cartItem = widget.cartService.items[index];
                      return _buildCartItem(cartItem);
                    },
                  ),
                ),
                _buildOrderSummary(),
              ],
            ),
    );
  }

  Widget _buildEmptyCart() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.shopping_cart_outlined,
            size: 100,
            color: const Color(0xFF2C1810).withOpacity(0.3),
          ),
          const SizedBox(height: 16),
          Text(
            'Your cart is empty',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF2C1810).withOpacity(0.7),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Add some delicious items to get started',
            style: TextStyle(
              fontSize: 16,
              color: const Color(0xFF2C1810).withOpacity(0.5),
            ),
          ),
          const SizedBox(height: 32),
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF2C1810),
              foregroundColor: const Color(0xFFFFF8E1),
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text(
              'Browse Menu',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCartItem(CartItem cartItem) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            // Item image
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: const Color(0xFF2C1810).withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: Text(
                  cartItem.menuItem.imageUrl,
                  style: const TextStyle(fontSize: 24),
                ),
              ),
            ),

            const SizedBox(width: 12),

            // Item details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    cartItem.menuItem.name,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF2C1810),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'TK ${cartItem.menuItem.price.toStringAsFixed(0)} each',
                    style: TextStyle(
                      fontSize: 14,
                      color: const Color(0xFF2C1810).withOpacity(0.6),
                    ),
                  ),
                  if (cartItem.specialInstructions?.isNotEmpty == true) ...[
                    const SizedBox(height: 4),
                    Text(
                      'Note: ${cartItem.specialInstructions}',
                      style: TextStyle(
                        fontSize: 12,
                        fontStyle: FontStyle.italic,
                        color: const Color(0xFF2C1810).withOpacity(0.7),
                      ),
                    ),
                  ],
                ],
              ),
            ),

            // Quantity controls
            Column(
              children: [
                Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        widget.cartService.updateQuantity(
                          cartItem.menuItem.id,
                          cartItem.quantity - 1,
                        );
                      },
                      icon: const Icon(Icons.remove_circle_outline),
                      color: const Color(0xFF2C1810),
                      iconSize: 20,
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFD4AF37),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        '${cartItem.quantity}',
                        style: const TextStyle(
                          color: Color(0xFF2C1810),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        widget.cartService.addItem(cartItem.menuItem);
                      },
                      icon: const Icon(Icons.add_circle_outline),
                      color: const Color(0xFF2C1810),
                      iconSize: 20,
                    ),
                  ],
                ),
                Text(
                  'TK ${cartItem.totalPrice.toStringAsFixed(0)}',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2C1810),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOrderSummary() {
    final subtotal = widget.cartService.totalAmount;
    final tax = subtotal * 0.08; // 8% tax
    final total = subtotal + tax;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF2C1810),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Subtotal:',
                style: TextStyle(color: Color(0xFFFFF8E1), fontSize: 16),
              ),
              Text(
                'TK ${subtotal.toStringAsFixed(0)}',
                style: const TextStyle(color: Color(0xFFFFF8E1), fontSize: 16),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Tax (8%):',
                style: TextStyle(color: Color(0xFFFFF8E1), fontSize: 16),
              ),
              Text(
                'TK ${tax.toStringAsFixed(0)}',
                style: const TextStyle(color: Color(0xFFFFF8E1), fontSize: 16),
              ),
            ],
          ),
          const Divider(color: Color(0xFFD4AF37), thickness: 2),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Total:',
                style: TextStyle(
                  color: Color(0xFFD4AF37),
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'TK ${total.toStringAsFixed(0)}',
                style: const TextStyle(
                  color: Color(0xFFD4AF37),
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => OrderConfirmationScreen(
                      cartService: widget.cartService,
                      total: total,
                    ),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFD4AF37),
                foregroundColor: const Color(0xFF2C1810),
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                elevation: 4,
              ),
              child: const Text(
                'Place Order',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
