import 'package:flutter/material.dart';
import 'dart:math';
import '../services/cart_service.dart';
import '../utils/image_utils.dart';

class OrderConfirmationScreen extends StatefulWidget {
  final CartService cartService;
  final double total;

  const OrderConfirmationScreen({
    super.key,
    required this.cartService,
    required this.total,
  });

  @override
  State<OrderConfirmationScreen> createState() =>
      _OrderConfirmationScreenState();
}

class _OrderConfirmationScreenState extends State<OrderConfirmationScreen>
    with TickerProviderStateMixin {
  late AnimationController _checkmarkController;
  late AnimationController _confettiController;
  late Animation<double> _checkmarkAnimation;
  late Animation<double> _confettiAnimation;

  String orderId = '';
  int estimatedTime = 0;

  @override
  void initState() {
    super.initState();

    // Generate random order ID and estimated time
    orderId = 'MC${Random().nextInt(9999).toString().padLeft(4, '0')}';
    estimatedTime = 25 + Random().nextInt(20); // 25-45 minutes

    _checkmarkController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    _confettiController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );

    _checkmarkAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _checkmarkController, curve: Curves.elasticOut),
    );

    _confettiAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _confettiController, curve: Curves.easeOut),
    );

    // Start animations
    _checkmarkController.forward();
    Future.delayed(const Duration(milliseconds: 500), () {
      _confettiController.forward();
    });
  }

  @override
  void dispose() {
    _checkmarkController.dispose();
    _confettiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF8E1),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Success animation
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        // Confetti effect
                        AnimatedBuilder(
                          animation: _confettiAnimation,
                          builder: (context, child) {
                            return Transform.scale(
                              scale: _confettiAnimation.value,
                              child: Container(
                                width: 200,
                                height: 200,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  gradient: RadialGradient(
                                    colors: [
                                      const Color(0xFFD4AF37).withOpacity(0.3),
                                      const Color(0xFFD4AF37).withOpacity(0.1),
                                      Colors.transparent,
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),

                        // Checkmark
                        AnimatedBuilder(
                          animation: _checkmarkAnimation,
                          builder: (context, child) {
                            return Transform.scale(
                              scale: _checkmarkAnimation.value,
                              child: Container(
                                width: 120,
                                height: 120,
                                decoration: const BoxDecoration(
                                  color: Color(0xFF2C1810),
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(
                                  Icons.check,
                                  color: Color(0xFFD4AF37),
                                  size: 60,
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),

                    const SizedBox(height: 40),

                    // Success message
                    const Text(
                      'Order Confirmed!',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF2C1810),
                      ),
                      textAlign: TextAlign.center,
                    ),

                    const SizedBox(height: 16),

                    Text(
                      'Thank you for choosing Mac \'n\' Cheese',
                      style: TextStyle(
                        fontSize: 18,
                        color: const Color(0xFF2C1810).withOpacity(0.7),
                        fontStyle: FontStyle.italic,
                      ),
                      textAlign: TextAlign.center,
                    ),

                    const SizedBox(height: 40),

                    // Order details card
                    Card(
                      elevation: 8,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(24),
                        child: Column(
                          children: [
                            _buildOrderDetail('Order ID', orderId),
                            const SizedBox(height: 16),
                            _buildOrderDetail(
                              'Total Amount',
                              'TK ${widget.total.toStringAsFixed(0)}',
                            ),
                            const SizedBox(height: 16),
                            _buildOrderDetail(
                              'Estimated Time',
                              '$estimatedTime minutes',
                            ),
                            const SizedBox(height: 16),
                            _buildOrderDetail(
                              'Items',
                              '${widget.cartService.itemCount} items',
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 30),

                    // Status message
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: const Color(0xFFD4AF37).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: const Color(0xFFD4AF37),
                          width: 1,
                        ),
                      ),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.timer,
                            color: Color(0xFF2C1810),
                            size: 24,
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              'Your order is being prepared. You will be notified when it\'s ready for pickup.',
                              style: TextStyle(
                                color: const Color(0xFF2C1810).withOpacity(0.8),
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // Action buttons
              Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        // Clear cart and navigate to home
                        widget.cartService.clearCart();
                        Navigator.of(
                          context,
                        ).popUntil((route) => route.isFirst);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF2C1810),
                        foregroundColor: const Color(0xFFFFF8E1),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        elevation: 4,
                      ),
                      child: const Text(
                        'Back to Menu',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 12),

                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                      onPressed: () {
                        _showOrderDetails(context);
                      },
                      style: OutlinedButton.styleFrom(
                        foregroundColor: const Color(0xFF2C1810),
                        side: const BorderSide(
                          color: Color(0xFF2C1810),
                          width: 2,
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text(
                        'View Order Details',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOrderDetail(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 16,
            color: const Color(0xFF2C1810).withOpacity(0.7),
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Color(0xFF2C1810),
          ),
        ),
      ],
    );
  }

  void _showOrderDetails(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.75,
        decoration: const BoxDecoration(
          color: Color(0xFFFFF8E1),
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          children: [
            // Handle bar
            Container(
              margin: const EdgeInsets.symmetric(vertical: 12),
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey[400],
                borderRadius: BorderRadius.circular(2),
              ),
            ),

            // Header
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Order #$orderId',
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF2C1810),
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.close, color: Color(0xFF2C1810)),
                  ),
                ],
              ),
            ),

            const Divider(
              color: Color(0xFF2C1810),
              thickness: 1,
              indent: 20,
              endIndent: 20,
            ),

            const SizedBox(height: 10),

            // Order items list
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    ...widget.cartService.items
                        .map(
                          (item) => Card(
                            margin: const EdgeInsets.only(bottom: 12),
                            elevation: 4,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(16),
                              child: Row(
                                children: [
                                  // Image
                                  ImageUtils.getRoundedImage(
                                    item.menuItem.imageUrl,
                                    width: 60,
                                    height: 60,
                                    borderRadius: 8,
                                  ),

                                  const SizedBox(width: 16),

                                  // Details
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          item.menuItem.name,
                                          style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: Color(0xFF2C1810),
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          'Quantity: ${item.quantity}',
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: const Color(
                                              0xFF2C1810,
                                            ).withOpacity(0.7),
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          'TK ${item.menuItem.price.toStringAsFixed(0)} each',
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: const Color(
                                              0xFF2C1810,
                                            ).withOpacity(0.5),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                  // Total price
                                  Text(
                                    'TK ${item.totalPrice.toStringAsFixed(0)}',
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF2C1810),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )
                        .toList(),

                    const SizedBox(height: 20),

                    // Total summary
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: const Color(0xFF2C1810),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Total Items:',
                                style: TextStyle(
                                  color: Color(0xFFFFF8E1),
                                  fontSize: 16,
                                ),
                              ),
                              Text(
                                '${widget.cartService.itemCount}',
                                style: const TextStyle(
                                  color: Color(0xFFFFF8E1),
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Grand Total:',
                                style: TextStyle(
                                  color: Color(0xFFD4AF37),
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                'TK ${widget.total.toStringAsFixed(0)}',
                                style: const TextStyle(
                                  color: Color(0xFFD4AF37),
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
