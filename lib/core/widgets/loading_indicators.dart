import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:visual_notes/core/styles/app_images.dart';
import 'package:visual_notes/core/styles/sizes.dart';

class LoadingIndicators {
  LoadingIndicators._();

  static final instance = LoadingIndicators._();

  Widget smallLoadingAnimation(
    BuildContext context, {
    double? height,
    double? width,
  }) {
    return Center(
      key: const Key('smallLoadingAnimation'),
      child: Container(
        color: Colors.transparent,
        child: Lottie.asset(
          AppImages.loadingIndicator,
          height: height ?? Sizes.loadingAnimationDefaultHeight,
          width: width ?? Sizes.loadingAnimationDefaultWidth,
        ),
      ),
    );
  }
}
