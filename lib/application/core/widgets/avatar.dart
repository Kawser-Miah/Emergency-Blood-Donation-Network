import 'package:flutter/material.dart';

import '../theme/colors.dart';

class Avatar extends StatelessWidget {
  const Avatar({
    super.key,
    required this.initials,
    required this.colorHex,
    this.size = 40,
    this.online = false,
  });

  final String initials;
  final String colorHex;
  final double size;
  final bool online;

  @override
  Widget build(BuildContext context) {
    final color = colorFromHex(colorHex);
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          width: size,
          height: size,
          alignment: Alignment.center,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          child: Text(
            initials,
            style: TextStyle(
              fontSize: size * 0.35,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
        ),
        if (online)
          Positioned(
            right: 0,
            bottom: 0,
            child: Container(
              width: 10,
              height: 10,
              decoration: BoxDecoration(
                color: AppColors.success,
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 2),
              ),
            ),
          ),
      ],
    );
  }
}
