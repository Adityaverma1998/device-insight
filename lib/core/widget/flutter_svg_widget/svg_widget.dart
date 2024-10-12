import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SvgWidget extends StatelessWidget {
  final String path;
  final String label;
  final double percentage;
  final bool network;
  final BoxFit? fit;

  const SvgWidget({
    Key? key,
    required this.path,
    required this.label,
    this.network = false,
    this.percentage = 0.1,
    this.fit = BoxFit.scaleDown,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //getting screen size
    var size = MediaQuery.of(context).size;

    //calculating container width
    double imageSize;
    if (MediaQuery.of(context).orientation == Orientation.portrait) {
      imageSize = (size.width * this.percentage);
    } else {
      imageSize = (size.height * this.percentage);
    }

    return this.network
        ? SvgPicture.network(
            this.path,
            semanticsLabel: this.label,
            height: 40,
            fit: fit as BoxFit,
          )
        : SvgPicture.asset(
            this.path,
            semanticsLabel: this.label,
            height: imageSize,
            fit: fit as BoxFit,
          );
  }
}
