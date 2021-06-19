import 'package:flutter/material.dart';

class Filter {
  RangeValues rangeValues = RangeValues(0, 8000);

  List<Map<String, dynamic>> colors = [
    {
      'color': Color(0xFF34283E),
      'isActive': false,
    },
    {
      'color': Color(0xFFCE3E3E),
      'isActive': false,
    },
    {
      'color': Color(0xFF76B559),
      'isActive': false,
    },
    {
      'color': Color(0xFF5D72E1),
      'isActive': false,
    },
    {
      'color': Color(0xFFB768B9),
      'isActive': false,
    },
    {
      'color': Color(0xFFE5D227),
      'isActive': false,
    },
  ];

  List<Map<String, dynamic>> sizes = [
    {
      'size': 'XXS',
      'isActive': false,
    },
    {
      'size': 'XS',
      'isActive': false,
    },
    {
      'size': 'S',
      'isActive': false,
    },
    {
      'size': 'M',
      'isActive': false,
    },
    {
      'size': 'L',
      'isActive': false,
    },
    {
      'size': 'XL',
      'isActive': false,
    },
  ];

  void clear() {
    for (int i = 0; i < colors.length; i++) {
      colors[i]['isActive'] = false;
    }
    for (int i = 0; i < sizes.length; i++) {
      sizes[i]['isActive'] = false;
    }
    rangeValues = RangeValues(0, 8000);
  }
}
