import 'package:flutter/material.dart';
import 'package:uidesign03/core/color.dart';
import 'package:uidesign03/core/space.dart';
import 'package:uidesign03/core/text_style.dart';
import 'package:uidesign03/data/model_data.dart';
import 'package:uidesign03/widgets/Custom_app_bar.dart';
import 'package:uidesign03/widgets/item_card.dart';
import 'package:uidesign03/widgets/tabbar_button.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomAppBar(),
            Text(
              'Furniture in\nunique style',
              style: heading,
            ),
            SpaceVH(height: 10),
            Text(
              'We have wide rang of Furniture',
              style: subHeading,
            ),
            SpaceVH(height: 20),
            Container(
              height: 70.0,
              child: TabBarButton(),
            ),
            Expanded(
              child: ListView.builder(
                  physics: BouncingScrollPhysics(),
                  itemCount: models.length,
                  itemBuilder: (builder, index) {
                    final model = models[index];
                    return ItemCard(model: model);
                  }),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        elevation: 0.0,
        child: Container(
          height: 100.0,
          color: green,
          child: Stack(
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: Container(
                  height: 40.0,
                  decoration: BoxDecoration(
                    color: white,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(50.0),
                      bottomRight: Radius.circular(50.0),
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    bottomNavButton(
                      onPress: () {},
                      icon: Icons.home_outlined,
                    ),
                    SpaceVH(width: 60),
                    bottomNavButton(
                      onPress: () {},
                      icon: Icons.chat_outlined,
                    ),
                    SpaceVH(width: 60),
                    bottomNavButton(
                      onPress: () {},
                      icon: Icons.person_outline_outlined,
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

  IconButton bottomNavButton(
      {required Function() onPress, required IconData icon}) {
    return IconButton(
      onPressed: onPress,
      icon: Icon(
        icon,
        size: 40,
        color: white,
      ),
    );
  }
}
