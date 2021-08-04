import 'package:flutter/material.dart';

class GradientBox extends StatelessWidget {
  const GradientBox({
    Key? key,
    required this.colors,
    this.begin = Alignment.topLeft,
    this.end = Alignment.bottomRight,
  }) : super(key: key);

  final AlignmentGeometry begin;
  final AlignmentGeometry end;
  final List<Color> colors;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      child: const SizedBox.expand(),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: colors,
          begin: begin,
          end: end,
          stops: const [0, 1],
        ),
      ),
    );
  }
}
