import 'package:flutter/material.dart';
import '../models/menu_item.dart';
import '../services/cart_service.dart';

class MenuItemCard extends StatefulWidget {
  final MenuItem menuItem;
  final CartService cartService;
  final VoidCallback onAddToCart;

  const MenuItemCard({
    super.key,
    required this.menuItem,
    required this.cartService,
    required this.onAddToCart,
  });

  @override
  State<MenuItemCard> createState() => _MenuItemCardState();
}

class _MenuItemCardState extends State<MenuItemCard> {
  @override
  void initState() {
    super.initState();
    // Listen to cart changes to update the card state
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
    final isInCart = widget.cartService.isInCart(widget.menuItem.id);
    final quantity = widget.cartService.getQuantity(widget.menuItem.id);

    return Card(
      elevation: 8,
      shadowColor: Colors.black.withOpacity(0.2),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              const Color(0xFFFFF8E1),
              const Color(0xFFFFF8E1).withOpacity(0.95),
            ],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Menu item image/emoji
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: const Color(0xFF2C1810).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: Text(
                    widget.menuItem.imageUrl,
                    style: const TextStyle(fontSize: 32),
                  ),
                ),
              ),

              const SizedBox(width: 16),

              // Menu item details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            widget.menuItem.name,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF2C1810),
                            ),
                          ),
                        ),
                        if (widget.menuItem.isVegetarian)
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Text(
                              'VEG',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        if (widget.menuItem.isSpicy)
                          const Padding(
                            padding: EdgeInsets.only(left: 4),
                            child: Text('🌶️', style: TextStyle(fontSize: 16)),
                          ),
                      ],
                    ),

                    const SizedBox(height: 8),

                    Text(
                      widget.menuItem.description,
                      style: TextStyle(
                        fontSize: 14,
                        color: const Color(0xFF2C1810).withOpacity(0.7),
                        height: 1.3,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),

                    const SizedBox(height: 12),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'TK ${widget.menuItem.price.toStringAsFixed(0)}',
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF2C1810),
                          ),
                        ),

                        if (isInCart && quantity > 0)
                          Row(
                            children: [
                              IconButton(
                                onPressed: () {
                                  widget.cartService.updateQuantity(
                                    widget.menuItem.id,
                                    quantity - 1,
                                  );
                                },
                                icon: const Icon(Icons.remove_circle_outline),
                                color: const Color(0xFF2C1810),
                                iconSize: 24,
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFD4AF37),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(
                                  '$quantity',
                                  style: const TextStyle(
                                    color: Color(0xFF2C1810),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  widget.cartService.addItem(widget.menuItem);
                                },
                                icon: const Icon(Icons.add_circle_outline),
                                color: const Color(0xFF2C1810),
                                iconSize: 24,
                              ),
                            ],
                          )
                        else
                          ElevatedButton(
                            onPressed: widget.onAddToCart,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF2C1810),
                              foregroundColor: const Color(0xFFFFF8E1),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              elevation: 2,
                            ),
                            child: const Text(
                              'Add to Cart',
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
