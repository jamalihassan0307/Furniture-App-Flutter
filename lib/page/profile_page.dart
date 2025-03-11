import 'package:flutter/material.dart';
import 'package:uidesign03/core/color.dart';
import 'package:uidesign03/core/text_style.dart';
import 'package:provider/provider.dart';
import 'package:uidesign03/model/cart_model.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          // Profile Header
          Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: white,
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(30)),
              boxShadow: [
                BoxShadow(
                  color: black.withOpacity(0.1),
                  blurRadius: 10,
                  offset: Offset(0, 5),
                ),
              ],
            ),
            child: Column(
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundImage: AssetImage('assets/image.jpg'),
                ),
                SizedBox(height: 15),
                Text(
                  'Ali Hassan Jamal',
                  style: heading.copyWith(fontSize: 24),
                ),
                SizedBox(height: 5),
                Text(
                  'hassan0307@gmail.com',
                  style: subHeading.copyWith(color: lightBlack),
                ),
              ],
            ),
          ),
          // Profile Options
          Expanded(
            child: ListView(
              padding: EdgeInsets.all(20),
              children: [
                _buildProfileOption(
                  icon: Icons.shopping_bag_outlined,
                  title: 'My Orders',
                  onTap: () {},
                ),
                _buildProfileOption(
                  icon: Icons.favorite_border,
                  title: 'Wishlist',
                  onTap: () {},
                ),
                _buildProfileOption(
                  icon: Icons.location_on_outlined,
                  title: 'Shipping Address',
                  onTap: () {},
                ),
                _buildProfileOption(
                  icon: Icons.settings_outlined,
                  title: 'Settings',
                  onTap: () {},
                ),
                _buildProfileOption(
                  icon: Icons.help_outline,
                  title: 'Help & Support',
                  onTap: () {},
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileOption({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return Container(
      margin: EdgeInsets.only(bottom: 15),
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
      child: ListTile(
        leading: Icon(icon, color: primary),
        title: Text(title, style: subHeading),
        trailing: Icon(Icons.arrow_forward_ios, size: 16),
        onTap: onTap,
      ),
    );
  }
} 