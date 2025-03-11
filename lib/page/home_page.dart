import 'package:flutter/material.dart';
import 'package:uidesign03/core/color.dart';
import 'package:uidesign03/core/space.dart';
import 'package:uidesign03/core/text_style.dart';
import 'package:uidesign03/data/model_data.dart';
import 'package:uidesign03/page/cart_page.dart';
import 'package:uidesign03/page/profile_page.dart';
import 'package:uidesign03/widgets/Custom_app_bar.dart';
import 'package:uidesign03/widgets/grid_item_card.dart';
import 'package:uidesign03/widgets/tabbar_button.dart';
import 'package:uidesign03/page/search_page.dart';
import 'package:uidesign03/widgets/drawer_page.dart';
import 'package:uidesign03/widgets/bottom_nav_bar.dart';

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
      drawer: DrawerPage(),
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            selectedNavIndex = index;
          });
        },
        children: [_buildHomePage(), SearchPage(), CartPage(), ProfilePage()],
      ),
      bottomNavigationBar: BottomNavBar(
        selectedIndex: selectedNavIndex,
        onTap: (index) {
          setState(() {
            selectedNavIndex = index;
            _pageController.animateToPage(
              index,
              duration: Duration(milliseconds: 300),
              curve: Curves.easeInOut,
            );
          });
        },
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
}
