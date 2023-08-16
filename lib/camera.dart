import 'package:camera/camera.dart';
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
    _controller = CameraController(cameras[0], ResolutionPreset.max);
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
        Container(
          height: double.infinity,
          child: CameraPreview(_controller),
        ),
        RawMaterialButton(
            onPressed: () async {
              if(!_controller.value.isInitialized){
                return null;
              }
              if (!_controller.value.isTakingPicture){
                return null;
              }
            },
          child: Text('Take photo'),

        )
      ],
      ),

    );
  }
}
