import 'package:flutter/material.dart';

class SpaceVH extends StatelessWidget {
  final double? height;
  final double? width;
  const SpaceVH({Key? key, this.height, this.width}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height != null ? height : 0.0,
      width: width != null ? width : 0.0,
    );
  }
}
