import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:arcore_flutter_plugin/arcore_flutter_plugin.dart';
import 'package:geolocator/geolocator.dart';
import 'package:myapp/widgets/geopos.dart';
import 'package:vector_math/vector_math_64.dart' as vector;

class AugmentedImagesPage extends StatefulWidget {
  @override
  _AugmentedImagesPageState createState() =>
      _AugmentedImagesPageState();
}

class _AugmentedImagesPageState
    extends State<AugmentedImagesPage> {
  ArCoreController? arCoreController;
  Map<String, ArCoreAugmentedImage> augmentedImagesMap = Map();
  Map<String, Uint8List> bytesMap = Map();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Ищем маркер'),
        ),
        body: ArCoreView(
          onArCoreViewCreated: _onArCoreViewCreated,
          type: ArCoreViewType.AUGMENTEDIMAGES,
        ),
      ),
    );
  }

  void _onArCoreViewCreated(ArCoreController controller) async {
    arCoreController = controller;
    arCoreController?.onTrackingImage = _handleOnTrackingImage;
    loadMultipleImage();
  }

  loadMultipleImage() async {
    final ByteData bytes1 =
        await rootBundle.load('assets/earth_augmented_image.jpg');
    final ByteData bytes2 = await rootBundle.load('assets/prova_texture.png');
    final ByteData bytes3 = await rootBundle.load('assets/umano_digitale.png');
    bytesMap["earth_augmented_image"] = bytes1.buffer.asUint8List();
    bytesMap["prova_texture"] = bytes2.buffer.asUint8List();
    bytesMap["umano_digitale"] = bytes3.buffer.asUint8List();

    arCoreController?.loadMultipleAugmentedImage(bytesMap: bytesMap);
  }

  _handleOnTrackingImage(ArCoreAugmentedImage augmentedImage) {
    File('log.txt').create(recursive: true);
    if (!augmentedImagesMap.containsKey(augmentedImage.name)) {
      augmentedImagesMap[augmentedImage.name] = augmentedImage;
      switch (augmentedImage.name) {
        case "earth_augmented_image":
          _addImage(augmentedImage);
          writeAndCheckFile("step1");
          break;
        case "prova_texture":
          _addImage(augmentedImage);
          writeAndCheckFile("step2");
          break;
        case "umano_digitale":
          _addImage(augmentedImage);
          writeAndCheckFile("step3");
          break;
      }
    }
    
  }

  @override
  void dispose() {
    arCoreController?.dispose();
    super.dispose();
  }

  Future _addImage(ArCoreAugmentedImage augmentedImage) async {
    final bytes = (await rootBundle.load('img/step1.jpg')).buffer.asUint8List();

    final photo = ArCoreNode(
        image: ArCoreImage(bytes: bytes, width: 300, height: 300),
        position: vector.Vector3(0, 0, 0));

    arCoreController?.addArCoreNodeToAugmentedImage(
        photo, augmentedImage.index);
  }

  void writeAndCheckFile(String message) async {
    var file = File('log.txt');
    List messages = file.readAsLinesSync();

    if (!messages.contains(message)) {
      file.writeAsString(message);
    }
  }
}

void readNote() {
  File('log.txt').readAsString().then((String contents) {
    print(contents);
  });
}
