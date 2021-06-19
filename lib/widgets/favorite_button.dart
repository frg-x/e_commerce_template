import 'dart:ui' as ui;
import 'package:e_commerce_template/constants.dart';
import 'package:e_commerce_template/cubit/favorite/favorite_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoriteButton extends StatelessWidget {
  final bool favoriteStatus;
  final String productId;

  FavoriteButton({
    required this.favoriteStatus,
    required this.productId,
  });

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
              color: AllColors.mainYellow,
            )
          : ShaderMask(
              blendMode: BlendMode.srcIn,
              shaderCallback: (Rect bounds) {
                return ui.Gradient.linear(
                  Offset(0, 20),
                  Offset(12, 8),
                  AllColors.purpleGradient,
                );
              },
              child: Icon(
                Icons.favorite_border_outlined,
                size: 20,
              ),
            ),
      onPressed: () {
        context.read<FavoriteCubit>().toggleFavorite(productId);
      },
    );
  }
}
