import 'package:flutter/material.dart';
import 'package:study_buddy/constants/image_strings.dart';
import '../constants/text_strings.dart';

class LoginHeaderWidget extends StatelessWidget {
  final Size size;

  const LoginHeaderWidget({
    super.key,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image(
          image: const AssetImage(tLoginImage),
          height: size.height * 0.25,
        ),
        Text(
          tLoginTitle,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        Text(
          tLoginSubTitle,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ],
    );
  }
}
