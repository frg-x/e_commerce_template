import 'model/progress_item.dart';

const int autoScrollDuration = 5;

List<ProgressItem> progressItemList = [
  ProgressItem(
    id: 0,
    title: 'Fashion Sale',
    bgImage: 'assets/images/adv_bg.png',
    startAnimation: false,
  ),
  ProgressItem(
    id: 1,
    title: 'New Arrivals',
    bgImage: 'assets/images/adv_bg.png',
    startAnimation: false,
  ),
  ProgressItem(
    id: 2,
    title: 'Hot Deals',
    bgImage: 'assets/images/adv_bg.png',
    startAnimation: false,
  ),
  ProgressItem(
    id: 3,
    title: 'Mega Discounts',
    bgImage: 'assets/images/adv_bg.png',
    startAnimation: false,
  ),
  ProgressItem(
    id: 4,
    title: 'Super Deals',
    bgImage: 'assets/images/adv_bg.png',
    startAnimation: false,
  ),
];

List<Map<String, String>> categoryItems = [
  {
    'title': 'Women\'s \nFashion',
    'image': 'assets/images/category_items/cat_item1.jpg'
  },
  {
    'title': 'Men\'s \nFashion',
    'image': 'assets/images/category_items/cat_item2.jpg',
  },
  {
    'title': 'Phones',
    'image': 'assets/images/category_items/cat_item3.jpg',
  },
  {
    'title': 'Computers',
    'image': 'assets/images/category_items/cat_item4.jpg',
  },
  {
    'title': 'Smart home',
    'image': 'assets/images/category_items/cat_item5.jpg',
  },
  {
    'title': 'Arts & \nCrafts',
    'image': 'assets/images/category_items/cat_item6.jpg',
  },
  {
    'title': 'Baby',
    'image': 'assets/images/category_items/cat_item7.jpg',
  },
  {
    'title': 'Sport',
    'image': 'assets/images/category_items/cat_item8.jpg',
  },
];

List<Map<String, dynamic>> items = [
  {
    'title': 'Saodimallsu Womens Turtleneck Oversized...',
    'description':
        'Women\'s Casual V-Neck Pullover Sweater Long Sleeved Sweater Top with High Low Hemline is going to be the newest staple in your wardrobe! Living up to its namesake, this sweater is unbelievably soft, li...',
    'image': 'assets/images/products/item1.png',
    'price': 99,
    'discount': 50,
    'rating': 4,
    'sizes': [
      'XXS',
      'XS',
      'S',
      'M',
      'L',
      'XL',
    ],
    'isFavorite': false,
  },
  {
    'title': 'Astylish Women Open Front Long Sleeve Chunky Knit Cardigan',
    'description':
        'Women\'s Casual V-Neck Pullover Sweater Long Sleeved Sweater Top with High Low Hemline is going to be the newest staple in your wardrobe! Living up to its namesake, this sweater is unbelievably soft, li...',
    'image': 'assets/images/products/item2.png',
    'price': 89.99,
    'discount': 0,
    'rating': 2,
    'sizes': [
      'XXS',
      'XS',
      'S',
      'M',
      'L',
      'XL',
    ],
    'isFavorite': true,
  },
  {
    'title': 'ECOWISH Womens Color Block Striped Draped',
    'description':
        'Women\'s Casual V-Neck Pullover Sweater Long Sleeved Sweater Top with High Low Hemline is going to be the newest staple in your wardrobe! Living up to its namesake, this sweater is unbelievably soft, li...',
    'image': 'assets/images/products/item3.png',
    'price': 102.33,
    'discount': 0,
    'rating': 5,
    'sizes': [
      'XXS',
      'XS',
      'S',
      'M',
      'L',
      'XL',
    ],
    'isFavorite': false,
  },
  {
    'title':
        'Angashion Women\'s Sweaters Casual Long Angashion Women\'s Sweaters Casual Long',
    'description':
        'Women\'s Casual V-Neck Pullover Sweater Long Sleeved Sweater Top with High Low Hemline is going to be the newest staple in your wardrobe! Living up to its namesake, this sweater is unbelievably soft, li...',
    'image': 'assets/images/products/item4.png',
    'price': 132.98,
    'discount': 0,
    'rating': 3,
    'sizes': [
      'XXS',
      'XS',
      'S',
      'M',
      'L',
      'XL',
    ],
    'isFavorite': false,
  },
  // {'title': 'Men\'s \nFashion', 'image': 'assets/images/products/item1.jpg'},
  // {'title': 'Phones', 'image': 'assets/images/products/item2.jpg'},
  // {'title': 'Computers', 'image': 'assets/images/products/item3.jpg'},
  // {'title': 'Smart home', 'image': 'assets/images/products/item4.jpg'},
  // {'title': 'Arts & \nCrafts', 'image': 'assets/images/products/item4.jpg'},
  // {'title': 'Baby', 'image': 'assets/images/products/item5.jpg'},
  // {'title': 'Sport', 'image': 'assets/images/products/item6.jpg'},
];
