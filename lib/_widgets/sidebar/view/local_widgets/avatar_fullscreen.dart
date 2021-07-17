import 'dart:io';

import 'package:flutter/material.dart';

class AvatarFullScreen extends StatelessWidget {
  final File image;

  const AvatarFullScreen({
    Key? key,
    required this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: GestureDetector(
        onVerticalDragDown: (_) => Navigator.of(context).pop(),
        child: Center(
          child: Image.file(
            image,
            key: UniqueKey(),
            fit: BoxFit.fitWidth,
            width: double.infinity,
            // height: double.infinity,
            alignment: Alignment.center,
          ),
        ),
      ),
    );
  }
}
