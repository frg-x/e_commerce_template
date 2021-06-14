import 'package:e_commerce_template/cubit/categories_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'catalogue_item.dart';
import 'loading_indicator.dart';

class CatalogueCarousel extends StatefulWidget {
  @override
  _CatalogueCarouselState createState() => _CatalogueCarouselState();
}

class _CatalogueCarouselState extends State<CatalogueCarousel> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CategoriesCubit, GetCategoriesState>(
        listener: (context, state) {
      if (state is GetCategoriesError) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(state.message),
        ));
      }
    }, builder: (context, state) {
      if (state is GetCategoriesLoading) {
        return LoadingIndicator(height: 92.0);
      } else if (state is GetCategoriesLoaded) {
        final category = state.category;
        //print('category: $category');
        return Container(
          height: 92.0,
          width: MediaQuery.of(context).size.width,
          child: ListView.separated(
            itemCount: category.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, int index) {
              return ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(8.0)),
                child: CatalogueItem(
                  title: category[index].title,
                  image: category[index].image,
                ),
              );
            },
            separatorBuilder: (context, int index) {
              return SizedBox(width: 16.0);
            },
          ),
        );
      } else {
        return Container();
      }
    });
  }
}
