import 'package:flutter/material.dart';
import '../models/onboarding_model.dart';

class OnBoardingScreenWidget extends StatelessWidget {
  const OnBoardingScreenWidget({
    super.key,
    required this.model,
  });

  final OnBoardingModel model;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(30.0),
      color: model.bgColor,
      child:
          Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
        Image(
          image: AssetImage(model.image),
          height: model.height * 0.5,
        ),
        Column(
          children: [
            Text(
              model.title,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Text(
              model.subtitle,
              style: Theme.of(context).textTheme.titleSmall,
            ),
          ],
        ),
        Text(
          model.counterText,
          style: Theme.of(context).textTheme.titleSmall,
          textAlign: TextAlign.center,
        ),
        const SizedBox(
          height: 90.0,
        )
      ]),
    );
  }
}
