import 'package:e_commerce_template/cubit/categories/categories_cubit.dart';
import 'package:e_commerce_template/screens/home/catalogue_screen_item.dart';
import 'package:e_commerce_template/widgets/loading_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CatalogueScreen extends StatefulWidget {
  @override
  _CatalogueScreenState createState() => _CatalogueScreenState();
}

class _CatalogueScreenState extends State<CatalogueScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoriesCubit, GetCategoriesState>(
      builder: (context, state) {
        if (state is GetCategoriesLoaded) {
          var categories = state.category;
          return SingleChildScrollView(
            child: Column(
              children: [
                ListView.builder(
                  primary: false,
                  padding: EdgeInsets.only(top: 20.0, left: 16.0, right: 16.0),
                  itemBuilder: (context, index) {
                    return CatalogueScreenItem(
                      categories: categories,
                      index: index,
                    );
                  },
                  shrinkWrap: true,
                  itemCount: categories.length,
                ),
                SizedBox(height: 104),
              ],
            ),
          );
        } else if (state is GetCategoriesLoading) {
          return LoadingIndicator(height: MediaQuery.of(context).size.height);
        } else
          return Container();
      },
    );
  }
}
