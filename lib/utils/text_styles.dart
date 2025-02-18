import 'package:flutter/material.dart';
import 'package:hotelbooking/utils/themes.dart';

class TextStyles {
  final BuildContext context;

  TextStyles(this.context);

  TextStyle getTitleStyle() {
    return Theme.of(context).textTheme.headline6?.copyWith(
              fontSize: 24,
              color: AppTheme.primaryTextColor,
            ) ??
        TextStyle(
          fontSize: 24,
          color: AppTheme.primaryTextColor,
        );
  }

  TextStyle getDescriptionStyle() {
    return Theme.of(context).textTheme.bodyText1?.copyWith(
              color: AppTheme.secondaryTextColor,
            ) ??
        TextStyle(color: AppTheme.secondaryTextColor);
  }

  TextStyle getRegularStyle() {
    return Theme.of(context).textTheme.bodyText1?.copyWith(
              fontSize: 16,
              color: AppTheme.primaryTextColor,
            ) ??
        TextStyle(fontSize: 16, color: AppTheme.primaryTextColor);
  }

  TextStyle getBoldStyle() {
    return Theme.of(context).textTheme.subtitle1?.copyWith(
              fontSize: 14,
              color: AppTheme.primaryTextColor,
            ) ??
        TextStyle(fontSize: 14, color: AppTheme.primaryTextColor);
  }
}

extension on TextTheme {
  get bodyText1 => null;
  get subtitle1 => null;
  get headline6 => null;
}
