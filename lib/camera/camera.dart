import 'package:camera/camera.dart';
import 'package:firstapptwo/camera/cameraCapture.dart';
import 'package:firstapptwo/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CameraApp extends StatefulWidget {
  const CameraApp({super.key});

  @override
  State<CameraApp> createState() => _CameraAppState();
}

class _CameraAppState extends State<CameraApp> {
  late CameraController _controller;

  @override
  void initState() {
    super.initState();
    _controller = CameraController(cameras[1], ResolutionPreset.max);
    _controller
        .initialize()
        .then((_) => {if (!mounted) {}, setState(() {})})
        .catchError((e) {
      if (e is CameraException) {
        switch (e.code) {
          case 'CameraAccessDenied':
            print('Access denied');
            break;
          default:
            print(e.description);
            break;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        Center(
          child: Container(
            margin: EdgeInsets.all(20.00),
            height: double.infinity,
            child: CameraPreview(_controller),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: RawMaterialButton(
            onPressed: () async {
              if (!_controller.value.isInitialized) {
                return null;
              }
              if (!_controller.value.isTakingPicture) {
                return null;
              }
              try {
                await _controller.setFlashMode(FlashMode.auto);
                XFile file = await _controller.takePicture();
                Navigator.push(context, MaterialPageRoute(
                    builder: (context) => ImagePreview(file)));
                print('enters here');

                    }
                    on CameraException catch (e)
                {
                  print('error : $e');
                  return null;
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
