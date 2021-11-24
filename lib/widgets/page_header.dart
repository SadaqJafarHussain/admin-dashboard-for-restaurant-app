import 'package:flutter/material.dart';

import 'custom_text.dart';

class PageHeader extends StatelessWidget {
  final String text;

  const PageHeader({Key key, this.text}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Row(
      textDirection: TextDirection.rtl,
      children: [
        Padding(
          padding: const EdgeInsets.all(10),
          child: CustomText(text: text, size: 40, weight: FontWeight.bold, color: Colors.grey,),
        ),
      ],
    );
  }
}
