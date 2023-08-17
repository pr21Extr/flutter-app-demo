import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:provider/provider.dart';
import 'cameraCapture.dart';

class CameraProvider with ChangeNotifier {
  late CameraController _controller;

  CameraController get cameraController => _controller;

  Future<void> initializeCamera() async {
    final cameras = await availableCameras();
    _controller = CameraController(cameras[1], ResolutionPreset.max);
    await _controller.initialize();
    notifyListeners();
  }
}
class CameraApp extends StatefulWidget {
  const CameraApp({Key? key}) : super(key: key);

  @override
  State<CameraApp> createState() => _CameraAppState();
}

class _CameraAppState extends State<CameraApp> {
  @override
  void initState() {
    super.initState();
    Provider.of<CameraProvider>(context, listen: false).initializeCamera();
  }

  @override
  Widget build(BuildContext context) {
    final cameraProvider = Provider.of<CameraProvider>(context);

    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: Container(
              margin: EdgeInsets.all(20.00),
              height: double.infinity,
              child: CameraPreview(cameraProvider.cameraController),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: RawMaterialButton(
              onPressed: () async {
                try {
                  await cameraProvider.cameraController.setFlashMode(FlashMode.auto);
                  XFile file = await cameraProvider.cameraController.takePicture();
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ImagePreview(file)),
                  );
                } on CameraException catch (e) {
                  print('error: $e');
                }
              },
              child: Text('Take photo'),
            ),
          )
        ],
      ),
    );
  }
}
