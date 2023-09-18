import 'dart:io';

import 'package:flutter/material.dart';

import 'package:face_camera/face_camera.dart';
import 'package:provider/provider.dart';

import '../../utils/routes/routeNames.dart';
import '../../viewModel/claimzViewModel.dart';
import 'claimzHistory/claimzHistory.dart';

class ConveyanceCamera extends StatefulWidget {
  final Map<String, dynamic> data;

  ConveyanceCamera(this.data);

  @override
  State<ConveyanceCamera> createState() => _ConveyanceCameraState();
}

class _ConveyanceCameraState extends State<ConveyanceCamera> {
  File? _capturedImage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: AppBar(
        //   title: const Text('FaceCapture example app'),
        // ),
        body: Builder(builder: (context) {
      if (_capturedImage != null) {
        return Center(
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Image.file(
                _capturedImage!,
                width: double.maxFinite,
                fit: BoxFit.fitWidth,
              ),
              ElevatedButton(
                  onPressed: () {
                    Provider.of<ClaimzViewModel>(context, listen: false)
                        .postSelfie(context, widget.data, _capturedImage!)
                        .then((value) {
                      Navigator.of(context).pop();
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ClaimzHistory()));
                    }
                            //  Navigator.of(context).pushNamed(
                            //                     RouteNames.claimzhistory)
                            );

                    setState(() => _capturedImage = null);
                  },
                  child: const Text(
                    'Proceed',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
                  ))
            ],
          ),
        );
      }
      return SmartFaceCamera(
          autoCapture: true,
          defaultCameraLens: CameraLens.front,
          onCapture: (File? image) {
            setState(() => _capturedImage = image);

            print('CAPTURED IMAGE: $_capturedImage');
          },
          onFaceDetected: (Face? face) {
            //Do something
          },
          messageBuilder: (context, face) {
            if (face == null) {
              return _message('Place your face in the camera');
            }
            if (!face.wellPositioned) {
              return _message('Center your face in the square');
            }
            return const SizedBox.shrink();
          });
    }));
  }

  Widget _message(String msg) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 55, vertical: 15),
        child: Text(msg,
            textAlign: TextAlign.center,
            style: const TextStyle(
                fontSize: 14, height: 1.5, fontWeight: FontWeight.w400)),
      );
}
