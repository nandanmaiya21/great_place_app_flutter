import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'dart:io';

class ImageScreen extends StatelessWidget {
  static const String routeName = '/Image-screen';
  const ImageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    File image = ModalRoute.of(context)!.settings.arguments as File;
    return Scaffold(
      appBar: AppBar(),
      body: Image(image: FileImage(image)),
    );
  }
}
