import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_template/model/advertisement.dart';
import 'package:e_commerce_template/model/product.dart';
import 'package:e_commerce_template/model/category.dart';

class ShopRepository {
  Future<List<Product>> fetchProducts() async {
    List<Product> productsList = [];

    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('product_items').get();
    querySnapshot.docs.forEach((item) {
      var productData = item.data() as Map<String, dynamic>;
      Product product = Product(
        id: productData['id'],
        title: productData['title'],
        description: productData['description'],
        image: productData['image'],
        price: productData['price'].toDouble(),
        discount: productData['discount'].toDouble(),
        rating: productData['rating'],
      );
      productsList.add(product);
    });
    return productsList;
  }

  Future<List<Category>> fetchCategories() async {
    List<Category> categoryList = [];

    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('category_items').get();
    querySnapshot.docs.forEach((cat) {
      var categoryData = cat.data() as Map<String, dynamic>;
      Category category = Category(
        id: categoryData['id'],
        title: categoryData['title'],
        image: categoryData['image'],
      );
      categoryList.add(category);
    });
    return categoryList;
  }

  Future<List<Advertisement>> fetchAds() async {
    List<Advertisement> advList = [];
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('adv_items').get();
    querySnapshot.docs.forEach((adv) {
      var adData = adv.data() as Map<String, dynamic>;
      Advertisement advertisement = Advertisement(
        id: adData['id'],
        title: adData['title'],
        image: adData['image'],
      );
      advList.add(advertisement);
    });
    return advList;
  }

  Future<List<dynamic>> getUserFavoriteProducts({required String uid}) async {
    DocumentSnapshot<Map<String, dynamic>> querySnapshot =
        await FirebaseFirestore.instance.collection('users').doc(uid).get();
    var userData = querySnapshot.data();
    var favProducts = (userData!['favProducts'] as List)
        .map((item) => item as String)
        .toList();

    return favProducts;
  }

  List<String> favProducts = [];

  Future<void> toggleFavoriteProduct(
      {required String uid, required String productId}) async {
    DocumentSnapshot<Map<String, dynamic>> querySnapshot =
        await FirebaseFirestore.instance.collection('users').doc(uid).get();
    var userData = querySnapshot.data() as Map<String, dynamic>;
    favProducts = (userData['favProducts'] as List)
        .map((item) => item as String)
        .toList();
    if (favProducts.contains(productId)) {
      var favProductIndex = favProducts.indexWhere((prod) => prod == productId);
      favProducts.removeAt(favProductIndex);
      await FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .update({'favProducts': favProducts});
    } else {
      favProducts.add(productId);
      await FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .update({'favProducts': favProducts});
    }
  }
}

class NetworkException implements Exception {}

// abstract class WeatherRepository {
//   /// Throws [NetworkException].
//   Future<Weather> fetchWeather(String cityName);
// }

// void createNewUser() async {
//   FirebaseFirestore.instance.collection('users').doc(loggedInUser?.uid)
//       .set({});
// }
