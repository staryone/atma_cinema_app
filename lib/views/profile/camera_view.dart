import 'dart:io';

import 'package:atma_cinema/utils/constants.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class CameraView extends StatefulWidget {
  const CameraView({Key? key}) : super(key: key);

  @override
  State<CameraView> createState() => _CameraViewState();
}

class _CameraViewState extends State<CameraView> {
  late CameraController _cameraController;
  bool _isCameraInitialized = false;
  String? _capturedImagePath;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    try {
      final cameras = await availableCameras();
      final camera = cameras.first;

      _cameraController = CameraController(
        camera,
        ResolutionPreset.high,
      );

      await _cameraController.initialize();
      setState(() {
        _isCameraInitialized = true;
      });
    } catch (e) {
      print("Error initializing camera: $e");
      setState(() {
        _isCameraInitialized = false;
      });
    }
  }

  @override
  void dispose() {
    _cameraController.dispose();
    super.dispose();
  }

  Future<void> _takePicture() async {
    if (!_isCameraInitialized) return;

    try {
      final image = await _cameraController.takePicture();
      setState(() {
        _capturedImagePath = image.path;
      });
    } catch (e) {
      print("Error taking picture: $e");
    }
  }

  void _onDone() {
    if (_capturedImagePath != null) {
      Navigator.pop(context, _capturedImagePath);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: colorPrimary,
        foregroundColor: Colors.white,
        centerTitle: true,
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 0.0),
            child: Center(
              child: const Text(
                'Cancel',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ),
        title: const Text('Photo'),
        actions: [
          TextButton(
            onPressed: _capturedImagePath != null ? _onDone : null,
            child: const Text(
              'Done',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
      body: _isCameraInitialized
          ? Column(
              children: [
                Container(
                  width: 500,
                  height: 500,
                  child: ClipRRect(
                    child: _capturedImagePath == null
                        ? AspectRatio(
                            aspectRatio: 1,
                            child: CameraPreview(_cameraController),
                          )
                        : Image.file(
                            File(_capturedImagePath!),
                            fit: BoxFit.cover,
                          ),
                  ),
                ),
                Expanded(
                  child: Container(
                    alignment: Alignment.center,
                    color: Colors.white,
                    child: GestureDetector(
                      onTap: _capturedImagePath == null ? _takePicture : null,
                      child: Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          shape: BoxShape.circle,
                          border: Border.all(color: colorPrimary, width: 15),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            )
          : const Center(child: CircularProgressIndicator()),
    );
  }
}
