import 'package:ecommerce_admin_tut/widgets/cards/cards_list.dart';
import 'package:ecommerce_admin_tut/widgets/custom_text.dart';
import 'package:ecommerce_admin_tut/widgets/page_header.dart';
import 'package:ecommerce_admin_tut/widgets/charts/sales_chart.dart';
import 'package:ecommerce_admin_tut/widgets/top_buyer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePageDesktop extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        PageHeader(text: "الصفحه الرئيسية",),
        Directionality(
            textDirection: TextDirection.rtl,
            child: CardsList()),
        Row(
          textDirection: TextDirection.rtl,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
                height: 450,
                width: MediaQuery.of(context).size.width / 1.9,
                child: SalesChart()),

            Container(
              width:  MediaQuery.of(context).size.width / 4,
              height: 450,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey[300],
                        offset: Offset(0, 3),
                        blurRadius: 16
                    )
                  ]),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    CustomText(text: 'اكثر المشترين', size: 30,),
                      Container(
                        height: 450,
                        child: ListView(
                          children: [TopBuyerWidget(),
                            TopBuyerWidget(),
                            TopBuyerWidget(),
                            TopBuyerWidget(),
                            TopBuyerWidget(),
                            TopBuyerWidget(),
                            TopBuyerWidget(),
                            TopBuyerWidget(),],
                        ),
                      )
                  ],
                ),
              ),
            )

          ],
        ),
      ],
    );
  }
}