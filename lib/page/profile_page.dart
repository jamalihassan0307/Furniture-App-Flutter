import 'package:flutter/material.dart';
import 'package:uidesign03/core/color.dart';
import 'package:uidesign03/core/text_style.dart';
import 'package:provider/provider.dart';
import 'package:uidesign03/model/cart_model.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            // Profile Header with Gradient and Pattern
            Container(
              height: 280,
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    primary,
                    primary.withOpacity(0.8),
                    primary.withOpacity(0.6),
                  ],
                ),
              ),
              child: Stack(
                children: [
                  // Decorative Patterns
                  Positioned(
                    right: -50,
                    top: -50,
                    child: Container(
                      width: 200,
                      height: 200,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: white.withOpacity(0.1),
                      ),
                    ),
                  ),
                  Positioned(
                    left: -30,
                    bottom: -30,
                    child: Container(
                      width: 140,
                      height: 140,
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
                        padding: EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: white, width: 3),
                          boxShadow: [
                            BoxShadow(
                              color: black.withOpacity(0.1),
                              blurRadius: 15,
                              offset: Offset(0, 5),
                            ),
                          ],
                        ),
                        child: CircleAvatar(
                          radius: 60,
                          backgroundImage: AssetImage('assets/image.jpg'),
                        ),
                      ),
                      SizedBox(height: 20),
                      Text(
                        'Ali Hassan Jamal',
                        style: heading.copyWith(
                          fontSize: 28,
                          color: white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'hassan0307@gmail.com',
                        style: subHeading.copyWith(
                          color: white.withOpacity(0.9),
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Transform.translate(
              offset: Offset(0, -30),
              child: Container(
                decoration: BoxDecoration(
                  color: background,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
                ),
                child: Column(
                  children: [
                    // Stats Section
                    Padding(
                      padding: EdgeInsets.all(20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          _buildStatItem('Orders', '12', Icons.shopping_bag),
                          _buildStatItem('Wishlist', '24', Icons.favorite),
                          _buildStatItem('Reviews', '8', Icons.star),
                        ],
                      ),
                    ),
                    // Profile Options
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
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
                            icon: Icons.notifications_outlined,
                            title: 'Notifications',
                            subtitle: 'Set your notifications preferences',
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
                          SizedBox(height: 20),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem(String label, String value, IconData icon) {
    return Container(
      width: 100,
      padding: EdgeInsets.symmetric(vertical: 15),
      decoration: BoxDecoration(
        color: white,
        borderRadius: BorderRadius.circular(20),
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
          Icon(icon, color: primary, size: 24),
          SizedBox(height: 8),
          Text(
            value,
            style: heading.copyWith(
              fontSize: 20,
              color: primary,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 4),
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
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: black.withOpacity(0.05),
            blurRadius: 10,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: onTap,
          child: Padding(
            padding: EdgeInsets.all(15),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: isDestructive ? Colors.red.withOpacity(0.1) : primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Icon(
                    icon,
                    color: isDestructive ? Colors.red : primary,
                    size: 22,
                  ),
                ),
                SizedBox(width: 15),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: subHeading.copyWith(
                          color: isDestructive ? Colors.red : black,
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        subtitle,
                        style: TextStyle(
                          fontSize: 12,
                          color: lightBlack,
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  size: 16,
                  color: isDestructive ? Colors.red : primary,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
