import 'dart:ui';

import 'package:e_commerce_template/constants.dart';
import 'package:e_commerce_template/model/category.dart';
import 'package:e_commerce_template/screens/subcatalogue_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CatalogueScreenItem extends StatelessWidget {
  const CatalogueScreenItem({
    required this.categories,
    required this.index,
  });

  final List<Category> categories;
  final int index;

  void _showMyModalBottomSheet(BuildContext context) {
    var category = categories[index];
    int modalSheetHeight = (category.subCategories.length * 32) + 100;
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24.0),
      ),
      builder: (BuildContext context) {
        return Container(
          height: modalSheetHeight.toDouble(),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(24.0),
              topRight: Radius.circular(24.0),
            ),
            boxShadow: [
              BoxShadow(
                blurRadius: 12.0,
                color: AllColors.deepPurple.withOpacity(0.08),
                offset: Offset(4.0, 0),
              )
            ],
            color: Colors.white,
          ),
          padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
          child: Column(
            children: [
              modalSheetDivider(),
              SizedBox(height: 16.0),
              Center(
                child: Text(
                  category.title,
                  style: AllStyles.fontSize19w700deepPurple,
                ),
              ),
              SizedBox(height: 5.0),
              Expanded(
                child: ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.popAndPushNamed(
                            context, SubCatalogueScreen.routeName,
                            arguments: {
                              'id': category.subCategories[index]['id'],
                              'title': category.subCategories[index]['title']
                            });
                      },
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 0, vertical: 8.0),
                        child: Text(
                          category.subCategories[index]['title'],
                          style: AllStyles.fontSize14w400lightPurpleGray,
                        ),
                      ),
                    );
                  },
                  shrinkWrap: true,
                  itemCount: category.subCategories.length,
                ),
              )
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _showMyModalBottomSheet(context),
      child: Container(
        margin: EdgeInsets.only(top: 16.0),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: AllColors.deepPurple.withOpacity(0.08),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          child: Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    categories[index].title,
                    style: AllStyles.fontSize17w700deepPurple,
                  ),
                ),
                SizedBox(
                  width: 88.0,
                  height: 88.0,
                  child: Image.asset(
                    categories[index].image,
                    fit: BoxFit.cover,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget modalSheetDivider() {
  return Container(
    height: 5.0,
    width: 60.0,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.all(Radius.circular(100.0)),
      color: Color(0XFFE3E3E3),
    ),
  );
}
