import 'package:flutter/material.dart';

class Bottom extends StatelessWidget {
  const Bottom({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 45, bottom: 14),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 25),
            child: Column(
              children: [
                Text("Search \nReturn & Policy \nDelivery \nContact info")
              ],
            ),
          ),
          Spacer(),
          Padding(
            padding: const  EdgeInsets.only(right: 25),
            child: Column(
              children: [
                Text("Facebook \nInstagram \nEgypt(EGP ج.م) \n2024,CreatorsCorner")
              ],
            ),
          )
        ],
      ),
    );
  }
}
