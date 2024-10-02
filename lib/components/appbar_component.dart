import 'package:atma_cinema/utils/constants.dart';
import 'package:flutter/material.dart';

class GradientAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            colorPrimary,
            Color(0xFF45111E),
          ],
          stops: [0.1, 0.9],
        ),
      ),
      child: AppBar(
        primary: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(20.0);
}
