import 'package:flutter/material.dart';
import 'package:uidesign03/core/color.dart';
import 'package:uidesign03/core/text_style.dart';
import 'package:uidesign03/data/tab_bar_menu.dart';

class TabBarButton extends StatefulWidget {
  final Function(int) onCategorySelected;
  const TabBarButton({Key? key, required this.onCategorySelected}) : super(key: key);

  @override
  _TabBarButtonState createState() => _TabBarButtonState();
}

class _TabBarButtonState extends State<TabBarButton> {
  int id = 0;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      physics: BouncingScrollPhysics(),
      itemCount: tabBarMenu.length,
      itemBuilder: (context, i) {
        return Padding(
          padding: EdgeInsets.only(right: 10.0),
          child: InkWell(
            splashColor: Colors.transparent,
            onTap: () {
              setState(() {
                id = tabBarMenu[i].id;
                widget.onCategorySelected(id);
              });
            },
            child: Container(
              height: 40.0,
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              decoration: BoxDecoration(
                color: id == i ? gray : Colors.transparent,
                borderRadius: BorderRadius.circular(50.0),
              ),
              child: Center(
                child: Text(
                  tabBarMenu[i].name,
                  style: id == i ? tabButtonS : tabButtonU,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
