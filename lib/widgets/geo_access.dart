import 'dart:async';

import 'package:arcore_flutter_plugin/arcore_flutter_plugin.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:myapp/pages/augmented_images.dart';
import 'package:vector_math/vector_math_64.dart' as vector;

class geoAccess extends StatefulWidget {
  @override
  _geoAccess createState() => _geoAccess();
}

class _geoAccess extends State<geoAccess> {
  ArCoreController? arCoreController;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Ты на том месте!'),
        ),
        body: ArCoreView(
          onArCoreViewCreated: _onArCoreViewCreated,
        ),
      ),
    );
  }

  void _onArCoreViewCreated(ArCoreController controller) async {
    arCoreController = controller;
    _addSphere();
    Timer(
        const Duration(seconds: 7),
        () => Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => AugmentedImagesPage())));
    // Timer(const Duration(seconds: 6), () => );

    Timer(const Duration(seconds: 7), () => dispose());
  }

  Future _addSphere() async {
    final ByteData textureBytes = await rootBundle.load('assets/earth.jpg');

    final material = ArCoreMaterial(
        color: Color.fromARGB(120, 66, 134, 244),
        textureBytes: textureBytes.buffer.asUint8List());
    final sphere = ArCoreSphere(
      materials: [material],
      radius: 0.1,
    );
    final node = ArCoreNode(
      shape: sphere,
      position: vector.Vector3(0, 0, -1.5),
    );
    arCoreController?.addArCoreNode(node);
  }

  @override
  void dispose() {
    arCoreController?.dispose();
    super.dispose();
  }
}
