import 'package:flutter/material.dart';
import 'package:uidesign03/core/color.dart';
import 'package:uidesign03/core/text_style.dart';
import 'package:uidesign03/model/cart_model.dart';
import 'package:uidesign03/page/checkout_page.dart';
import 'package:provider/provider.dart';

class CartPage extends StatefulWidget {
  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<CartManager>(
      builder: (context, cartManager, child) {
        print("cartManager: ${cartManager.items}");
        return SafeArea(
          child: Column(
            children: [
              // Header
              Padding(
                padding: EdgeInsets.all(20),
                child: Row(
                  children: [
                    Text(
                      'My Cart',
                      style: heading.copyWith(
                        fontSize: 24,
                        color: black.withOpacity(0.8),
                      ),
                    ),
                    Spacer(),
                    Text(
                      '${cartManager.itemCount} items',
                      style: subHeading,
                    ),
                  ],
                ),
              ),
              // Cart Items
              Expanded(
                child: cartManager.items.length == 0
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.shopping_cart_outlined,
                              size: 100,
                              color: primary.withOpacity(0.5),
                            ),
                            SizedBox(height: 20),
                            Text(
                              'Your Cart is Empty',
                              style: heading.copyWith(
                                color: primary,
                                fontSize: 24,
                              ),
                            ),
                          ],
                        ),
                      )
                    : ListView.builder(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        itemCount: cartManager.items.length,
                        itemBuilder: (context, index) {
                          final item = cartManager.items[index];
                          return _buildCartItem(context, item);
                        },
                      ),
              ),
              // Bottom section with total
              if (cartManager.items.isNotEmpty)
                Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: white,
                    boxShadow: [
                      BoxShadow(
                        color: black.withOpacity(0.1),
                        blurRadius: 10,
                        offset: Offset(0, -5),
                      ),
                    ],
                  ),
                  child: SafeArea(
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Total:',
                              style: subHeading,
                            ),
                            Text(
                              '\$${cartManager.total.toStringAsFixed(2)}',
                              style: heading.copyWith(
                                color: primary,
                                fontSize: 24,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CheckoutPage(),
                              ),
                            );
                          },
                          child: Container(
                            width: double.infinity,
                            padding: EdgeInsets.symmetric(vertical: 15),
                            decoration: BoxDecoration(
                              color: primary,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Center(
                              child: Text(
                                'Proceed to Checkout',
                                style: heading.copyWith(
                                  color: white,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildCartItem(BuildContext context, CartItem item) {
    final cartManager = Provider.of<CartManager>(context);
    return Container(
      margin: EdgeInsets.only(bottom: 15),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: black.withOpacity(0.1),
            blurRadius: 10,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        children: [
          // Image
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                image: AssetImage(item.image),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(width: 15),
          // Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.name,
                  style: itemCardHeading.copyWith(fontSize: 16),
                ),
                SizedBox(height: 5),
                Text(
                  '\$${item.price}',
                  style: itemCardPrice,
                ),
              ],
            ),
          ),
          // Quantity
          Row(
            children: [
              IconButton(
                icon: Icon(Icons.remove_circle_outline),
                onPressed: () => cartManager.updateQuantity(item.id, item.quantity - 1),
              ),
              Text('${item.quantity}', style: itemCardHeading),
              IconButton(
                icon: Icon(Icons.add_circle_outline),
                onPressed: () => cartManager.updateQuantity(item.id, item.quantity + 1),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
