import 'package:flutter/material.dart';
import 'package:myapp/widgets/app_large_text.dart';
import 'package:myapp/widgets/app_text.dart';
import 'package:myapp/widgets/responsive_button.dart';

import '../misc/colors.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  List images = [
    "welcome_1.png",
    "welcome_2.png",
    "welcome_3.png"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
          scrollDirection: Axis.vertical,
          itemCount: images.length,
          itemBuilder: (_, index) {
          return Container(
            width: double.maxFinite,
            height: double.maxFinite,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  "img/"+images[index]
                ),
                fit: BoxFit.cover,
              )
            ),
            child: Container(
              margin: const EdgeInsets.only(top: 70, left: 20, right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppLargeText(text: "Subway"),
                      AppText(text: "How to make fun", size: 30),
                      SizedBox(height: 20),
                      Container(
                        width: 250,
                        child: AppText(
                          text: "Taking the subway can give you a pleasure",
                          color: AppColors.textColor2,
                        ),
                      ),
                      SizedBox(height: 40),
                      ResponsiveButton(width: 95,)
                    ],
                  ),
                  Column(
                    children: List.generate(3, (indexDots) => Container(
                      margin: const EdgeInsets.only(bottom: 2),
                      width: 8,
                      height: index == indexDots ? 25 : 8,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: index == indexDots ? AppColors.mainColor : AppColors.mainColor.withOpacity(0.3),
                      ),
                    )),
                  )
                ],
              ),
            ),
          );
        }),
    );
  }
}
