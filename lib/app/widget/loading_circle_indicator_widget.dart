import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';

class LoadingCircleIndicatorWidget extends StatelessWidget {
  final double sizeFactor;
  final Color iconColor;
  const LoadingCircleIndicatorWidget({
    this.sizeFactor = 0.2,
    this.iconColor = Colors.white,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: LayoutBuilder(
        builder: (context, constraints) =>
            SizedBox(
              width: constraints.maxWidth * sizeFactor,
              height: constraints.maxWidth * sizeFactor,
              child:  LoadingIndicator(
                indicatorType: Indicator.ballPulseSync,
                colors: [iconColor],
              ),
            ),
      ),
    );
  }
}