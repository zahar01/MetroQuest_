import 'package:flutter/material.dart';
import 'package:arcore_flutter_plugin/arcore_flutter_plugin.dart';
import 'package:flutter/services.dart';
import 'package:vector_math/vector_math_64.dart' as vector;

class ImageObjectScreen extends StatefulWidget {
  @override
  _ImageObjectScreenState createState() => _ImageObjectScreenState();
}

class _ImageObjectScreenState extends State<ImageObjectScreen> {
  ArCoreController? arCoreController;
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Metro quest'),
        ),
        body: ArCoreView(
          onArCoreViewCreated: _onArCoreViewCreated,
          enableTapRecognizer: true,
        ),
      ),
    );
  }

  void _onArCoreViewCreated(ArCoreController controller) {
    arCoreController = controller;
    arCoreController?.onPlaneTap = _handleOnPlaneTap;
  }

  Future _addImage(ArCoreHitTestResult hit) async {
    
    final bytes = (await rootBundle.load('img/hehe.jpg')).buffer.asUint8List();

    final photo = ArCoreNode(
      image: ArCoreImage(bytes: bytes, width: 300, height: 300),
      position: hit.pose.translation + vector.Vector3(0.0, 0.0, 0.0),
      rotation: hit.pose.rotation + vector.Vector4(0.0, 0.0, 0.0, 0.0),
    );

    arCoreController?.addArCoreNodeWithAnchor(photo);
  }

  void _handleOnPlaneTap(List<ArCoreHitTestResult> hits) {
    final hit = hits.first;
    _addImage(hit);
  }

  @override
  void dispose() {
    arCoreController?.dispose();
    super.dispose();
  }
}
