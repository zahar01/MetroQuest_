import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:myapp/misc/colors.dart';

import '../ar_files/image_object.dart';
import '../widgets/geopos.dart';
import '../widgets/geo_access.dart';
import 'augmented_images.dart';
import '../widgets/app_text.dart';

class GeopositionWaiting extends StatefulWidget {
  const GeopositionWaiting({Key? key}) : super(key: key);

  @override
  State<GeopositionWaiting> createState() => _GeopositionWaitingState();
}

class _GeopositionWaitingState extends State<GeopositionWaiting> {
  var location = getCurrentPosition();

  @override
  Widget build(BuildContext context) {
    choice(context);
    return Scaffold(
      body: Container(
        child: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Container(
              child: Center(
                  child: AppText(
                text: "Wait a bit, we are checking your geolocation",
                color: AppColors.bigTextColor,
              )),
            ),
            Container(
              child: Center(
                  child: Image(
                image: AssetImage("img/loading3.gif"),
              )),
            ),
          ]),
        ),
      ),
    );
  }
}

void choice(BuildContext context) async {
  var position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high);

  if ((position.latitude >= 60.0062 && position.latitude <= 60.0063) &&
      (position.longitude >= 30.293 && position.longitude <= 30.295)) {
    print(
        "______________________________\n\nlocation OK\n\n______________________________");

    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => geoAccess()));
  } else {
    Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => AugmentedImagesPage()));
  }
}
