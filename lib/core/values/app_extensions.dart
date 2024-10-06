import 'package:flutter/material.dart';

extension NumX on num {
  SizedBox get gapV => SizedBox(height: toDouble());
  SizedBox get gapH => SizedBox(width: toDouble());
}

extension WidgetX on Widget {
  DecoratedBox get bordered => DecoratedBox(
        decoration: BoxDecoration(
          border: Border.all(
            width: 2.0,
            color: Colors.red,
          ),
        ),
        child: this,
      );
}
