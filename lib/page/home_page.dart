import 'package:flutter/material.dart';
import 'package:uidesign03/core/color.dart';
import 'package:uidesign03/core/space.dart';
import 'package:uidesign03/core/text_style.dart';
import 'package:uidesign03/data/model_data.dart';
import 'package:uidesign03/widgets/Custom_app_bar.dart';
import 'package:uidesign03/widgets/grid_item_card.dart';
import 'package:uidesign03/widgets/tabbar_button.dart';
import 'package:uidesign03/page/search_page.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedCategory = 0;
  int selectedNavIndex = 0;
  final PageController _pageController = PageController();

  List get filteredModels {
    if (selectedCategory == 0) {
      return models;
    } else {
      return models.where((model) {
        switch (selectedCategory) {
          case 1:
            return model.category == 'Chairs';
          case 2:
            return model.category == 'Lamps';
          case 3:
            return model.category == 'Tables';
          case 4:
            return model.category == 'Sofas';
          default:
            return true;
        }
      }).toList();
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            selectedNavIndex = index;
          });
        },
        children: [
          _buildHomePage(),
          SearchPage(),
          _buildCartPage(),
          _buildProfilePage(),
        ],
      ),
      bottomNavigationBar: Container(
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
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildNavItem(0, Icons.home_rounded, 'Home'),
                _buildNavItem(1, Icons.search_rounded, 'Search'),
                _buildNavItem(2, Icons.shopping_cart_rounded, 'Cart'),
                _buildNavItem(3, Icons.person_rounded, 'Profile'),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHomePage() {
    return SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomAppBar(),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Discover',
                  style: heading.copyWith(
                    fontSize: 32,
                    color: black.withOpacity(0.8),
                  ),
                ),
                Text(
                  'Find your perfect furniture',
                  style: subHeading.copyWith(fontSize: 16),
                ),
              ],
            ),
          ),
          SpaceVH(height: 20),
          Container(
            height: 70.0,
            child: TabBarButton(
              onCategorySelected: (categoryId) {
                setState(() {
                  selectedCategory = categoryId;
                });
              },
            ),
          ),
          Expanded(
            child: GridView.builder(
              padding: EdgeInsets.all(20),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.7,
                crossAxisSpacing: 15,
                mainAxisSpacing: 15,
              ),
              itemCount: filteredModels.length,
              itemBuilder: (context, index) {
                return GridItemCard(model: filteredModels[index]);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCartPage() {
    return Center(
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
    );
  }

  Widget _buildProfilePage() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: primary.withOpacity(0.1),
            ),
            child: Icon(
              Icons.person_outline,
              size: 60,
              color: primary,
            ),
          ),
          SizedBox(height: 20),
          Text(
            'Profile',
            style: heading.copyWith(
              color: primary,
              fontSize: 24,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem(int index, IconData icon, String label) {
    bool isSelected = selectedNavIndex == index;
    return InkWell(
      onTap: () {
        setState(() {
          selectedNavIndex = index;
          _pageController.animateToPage(
            index,
            duration: Duration(milliseconds: 300),
            curve: Curves.easeInOut,
          );
        });
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: 200),
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? primary.withOpacity(0.1) : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: isSelected ? primary : lightBlack,
              size: 24,
            ),
            if (isSelected) ...[
              SizedBox(width: 8),
              Text(
                label,
                style: TextStyle(
                  color: primary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
