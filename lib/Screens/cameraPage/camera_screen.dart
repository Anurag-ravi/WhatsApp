// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:whatsapp/Screens/cameraPage/camera_view.dart';
import 'package:whatsapp/Screens/cameraPage/video_view.dart';

List<CameraDescription> cameras = [];

class CameraScreen extends StatefulWidget {
  const CameraScreen({Key? key}) : super(key: key);

  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  late CameraController _cameraController;

  late Future<void> cameraValue;
  bool isRecording = false;
  bool flash = false;
  bool isFront = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _cameraController = CameraController(cameras[0], ResolutionPreset.high);
    cameraValue = _cameraController.initialize();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _cameraController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          FutureBuilder(
            future: cameraValue,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return CameraPreview(_cameraController);
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
          Positioned(
            bottom: 0.0,
            child: Container(
              color: Colors.black,
              width: width,
              child: Column(
                children: [
                  Row(
                    // mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(
                        onPressed: () {
                          setState(() {
                            flash = !flash;
                          });
                          flash
                              ? _cameraController.setFlashMode(FlashMode.always)
                              : _cameraController.setFlashMode(FlashMode.off);
                        },
                        icon: Icon(flash ? Icons.flash_on : Icons.flash_off),
                        color: Colors.white,
                        iconSize: 28,
                      ),
                      GestureDetector(
                        onLongPress: () async {
                          setState(() {
                            isRecording = true;
                          });
                          await _cameraController.startVideoRecording();
                        },
                        onLongPressUp: () async {
                          final video =
                              await _cameraController.stopVideoRecording();
                          setState(() {
                            isRecording = false;
                          });
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (builder) => VideoView(
                                        path: video.path,
                                      )));
                        },
                        onTap: () {
                          if (!isRecording) {
                            takePhoto(context);
                          }
                        },
                        child: isRecording
                            ? Icon(
                                Icons.radio_button_on,
                                color: Colors.red,
                                size: 80,
                              )
                            : Icon(
                                Icons.panorama_fish_eye,
                                color: Colors.white,
                                size: 70,
                              ),
                      ),
                      IconButton(
                        onPressed: () async {
                          setState(() {
                            isFront = !isFront;
                          });
                          int camerapos = isFront ? 0 : 1;
                          _cameraController = CameraController(
                              cameras[camerapos], ResolutionPreset.high);
                          cameraValue = _cameraController.initialize();
                        },
                        icon: Icon(Icons.flip_camera_ios),
                        color: Colors.white,
                        iconSize: 28,
                      )
                    ],
                  ),
                  Text(
                    "Hold for video, tap for photo",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  void takePhoto(BuildContext context) async {
    final img = await _cameraController.takePicture();
    Navigator.push(context,
        MaterialPageRoute(builder: (builder) => CameraView(path: img.path)));
  }
}
