import 'package:e_commerce_template/constants.dart';
import 'package:e_commerce_template/cubit/favorite/favorite_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;

class RoundedFavoriteButton48x48 extends StatelessWidget {
  final bool favoriteStatus;
  final String productId;

  RoundedFavoriteButton48x48({
    required this.favoriteStatus,
    required this.productId,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48.0,
      width: 48.0,
      child: TextButton(
        child: favoriteStatus
            ? Icon(
                Icons.favorite,
                size: 26,
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
                  size: 26,
                ),
              ),
        onPressed: () {
          context.read<FavoriteCubit>().toggleFavorite(productId);
        },
        style: AllStyles.roundedButton8px48x48,
      ),
    );
  }
}
