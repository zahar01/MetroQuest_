import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

import '../ar_files/image_object.dart';
getCurrentPosition() async {
  LocationPermission permission;
  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      return Future.error('Location permissions are denied');
    }
  }

  var position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high);

  print(position);
}
