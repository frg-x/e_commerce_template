import 'dart:ui' as ui;

import 'package:e_commerce_template/dummy_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

class FavoriteButton extends StatelessWidget {
  final bool favoriteStatus;

  FavoriteButton({required this.favoriteStatus});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape: CircleBorder(),
        padding: EdgeInsets.all(0),
        primary: Colors.white,
        elevation: 5,
      ),
      child: favoriteStatus
          ? Icon(
              Icons.favorite,
              size: 20,
              color: Color(0xFFE7B944),
            )
          : ShaderMask(
              blendMode: BlendMode.srcIn,
              shaderCallback: (Rect bounds) {
                return ui.Gradient.linear(
                  Offset(0, 20),
                  Offset(12, 8),
                  [
                    Color(0xFF34283E),
                    Color(0xFF845FA1),
                  ],
                );
              },
              child: Icon(
                Icons.favorite_border_outlined,
                size: 20,
              ),
            ),
      onPressed: () {},
    );
  }
}
