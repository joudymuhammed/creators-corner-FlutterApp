import 'package:flutter/material.dart';

import '../Screens/Home.dart';
import '../main.dart';

class HomeScreenWrapper extends StatelessWidget {
  final String? selectedBrand;
  final int? selectedBrandIndex;

  const HomeScreenWrapper({Key? key, this.selectedBrand, this.selectedBrandIndex}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return HomeScreen(selectedBrand: selectedBrand, selectedBrandIndex: selectedBrandIndex);
  }
}