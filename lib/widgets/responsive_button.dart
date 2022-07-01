import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:myapp/misc/colors.dart';
import 'package:myapp/widgets/alert.dart';

import '../ar_files/image_object.dart';
import 'geopos.dart';
import '../pages/geoposition_waiting.dart';

class ResponsiveButton extends StatelessWidget {
  bool? isResponsive;
  double? width;
  ResponsiveButton({Key? key, this.width, this.isResponsive = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        width: width,
        height: 60,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: AppColors.mainColor,
        ),
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Image.asset(
            "img/right-arrow.png",
            width: 45,
          ),
        ]),
      ),
      onTap: () {
        // if (pos.lat < 60.0061 && pos.long < 30.29) {
        //   Alert().build(context);
        // } else {}
        Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => GeopositionWaiting()));
        
        
      },
    );
  }

  void setState(Null Function() param0) {}
}
