import 'package:flutter/material.dart';

class FormHeaderWidget extends StatelessWidget {
  const FormHeaderWidget(
      {required this.image,
      required this.title,
      required this.subtitle,
      this.imageHeight = 0.6,
      this.heightBetween,
      this.textAlign,
      this.crossAxisAlignment = CrossAxisAlignment.start,
      super.key});

  final String image, title, subtitle;
  final double imageHeight;
  final double? heightBetween;
  final CrossAxisAlignment crossAxisAlignment;
  final TextAlign? textAlign;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Column(crossAxisAlignment: crossAxisAlignment, children: [
      Image(
        image: AssetImage(image),
        height: size.height * imageHeight,
      ),
      SizedBox(
        height: heightBetween,
      ),
      Text(
        title,
        textAlign: textAlign,
        style: Theme.of(context).textTheme.titleMedium,
      ),
      Text(
        subtitle,
        textAlign: textAlign,
        style: Theme.of(context).textTheme.bodyMedium,
      ),
    ]);
  }
}
