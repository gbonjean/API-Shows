import 'package:flutter/material.dart';

class Hamburger extends StatelessWidget {
  const Hamburger({super.key, this.isDetails = false});

  final bool isDetails;

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return IconButton(
        onPressed: () => Scaffold.of(context).openDrawer(),
        icon: Image.asset(
          'assets/icons/menu.png',
          color: isDetails ? Colors.white : const Color(0xFFBDBDBD),
          height: 28,
        ),
      );
    });
  }
}
