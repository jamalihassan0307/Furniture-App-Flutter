import 'package:flutter/material.dart';
import 'package:uidesign03/core/color.dart';
import 'package:uidesign03/core/text_style.dart';
import 'package:provider/provider.dart';
import 'package:uidesign03/model/cart_model.dart';

class DrawerPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          UserAccountsDrawerHeader(
            decoration: BoxDecoration(color: primary),
            accountName: Text('Ali Hassan Jamal', style: heading.copyWith(color: white)),
            accountEmail: Text('hassan0307@gmail.com', style: subHeading.copyWith(color: white)),
            currentAccountPicture: CircleAvatar(
              backgroundImage: AssetImage('assets/image.jpg'),
            ),
          ),
          Expanded(
            child: Consumer<CartManager>(
              builder: (context, cartManager, child) {
                return ListView(
                  children: [
                    ListTile(
                      leading: Icon(Icons.shopping_cart, color: primary),
                      title: Text('My Cart (${cartManager.itemCount})', style: subHeading),
                      onTap: () {
                        Navigator.pop(context);
                        // Navigate to cart page
                      },
                    ),
                    ListTile(
                      leading: Icon(Icons.shopping_bag, color: primary),
                      title: Text('My Orders', style: subHeading),
                      onTap: () {},
                    ),
                    ListTile(
                      leading: Icon(Icons.favorite, color: primary),
                      title: Text('Wishlist', style: subHeading),
                      onTap: () {},
                    ),
                    Divider(),
                    ListTile(
                      leading: Icon(Icons.settings, color: primary),
                      title: Text('Settings', style: subHeading),
                      onTap: () {},
                    ),
                    ListTile(
                      leading: Icon(Icons.help, color: primary),
                      title: Text('Help & Support', style: subHeading),
                      onTap: () {},
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
} 