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
          // Profile Header with Background
          Container(
            height: 200,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [primary, primary.withOpacity(0.8)],
              ),
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(30)),
            ),
            child: Stack(
              children: [
                // Background Design
                Positioned(
                  right: -50,
                  top: -50,
                  child: Container(
                    width: 150,
                    height: 150,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: white.withOpacity(0.1),
                    ),
                  ),
                ),
                // Profile Content
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: EdgeInsets.all(3),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: white, width: 2),
                      ),
                      child: CircleAvatar(
                        radius: 50,
                        backgroundImage: AssetImage('assets/image.jpg'),
                      ),
                    ),
                    SizedBox(height: 15),
                    Text(
                      'Ali Hassan Jamal',
                      style: heading.copyWith(
                        fontSize: 24,
                        color: white,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      'hassan0307@gmail.com',
                      style: subHeading.copyWith(color: white.withOpacity(0.9)),
                    ),
                  ],
                ),
              ],
            ),
          ),
          // Stats Section
          Padding(
            padding: EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildStatItem('Orders', '12'),
                _buildStatItem('Wishlist', '24'),
                _buildStatItem('Reviews', '8'),
              ],
            ),
          ),
          // Profile Options
          Expanded(
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: 20),
              children: [
                _buildProfileOption(
                  icon: Icons.shopping_bag_outlined,
                  title: 'My Orders',
                  subtitle: 'Check your order status',
                  onTap: () {},
                ),
                _buildProfileOption(
                  icon: Icons.favorite_border,
                  title: 'Wishlist',
                  subtitle: 'Your favorite items',
                  onTap: () {},
                ),
                _buildProfileOption(
                  icon: Icons.location_on_outlined,
                  title: 'Shipping Address',
                  subtitle: 'Manage delivery addresses',
                  onTap: () {},
                ),
                _buildProfileOption(
                  icon: Icons.settings_outlined,
                  title: 'Settings',
                  subtitle: 'App settings and preferences',
                  onTap: () {},
                ),
                _buildProfileOption(
                  icon: Icons.help_outline,
                  title: 'Help & Support',
                  subtitle: 'Get help and support',
                  onTap: () {},
                ),
                _buildProfileOption(
                  icon: Icons.logout,
                  title: 'Logout',
                  subtitle: 'Sign out from your account',
                  onTap: () {},
                  isDestructive: true,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(String label, String value) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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
      child: Column(
        children: [
          Text(
            value,
            style: heading.copyWith(
              fontSize: 20,
              color: primary,
            ),
          ),
          SizedBox(height: 5),
          Text(
            label,
            style: subHeading.copyWith(fontSize: 12),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileOption({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
    bool isDestructive = false,
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
        leading: Icon(
          icon,
          color: isDestructive ? Colors.red : primary,
        ),
        title: Text(
          title,
          style: subHeading.copyWith(
            color: isDestructive ? Colors.red : black,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: TextStyle(
            fontSize: 12,
            color: lightBlack,
          ),
        ),
        trailing: Icon(
          Icons.arrow_forward_ios,
          size: 16,
          color: isDestructive ? Colors.red : primary,
        ),
        onTap: onTap,
      ),
    );
  }
}
