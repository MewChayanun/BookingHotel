import 'package:flutter/material.dart';
import 'package:hotelbooking/utils/text_styles.dart';
import 'package:hotelbooking/utils/themes.dart';

class CommonSearchBar extends StatelessWidget {
  final String? text;
  final TextEditingController? textEditingController;
  final bool enabled, ishsow;
  final double height;
  final IconData? iconData;

  const CommonSearchBar({
    super.key,
    this.text,
    this.enabled = false,
    this.height = 48,
    this.iconData,
    this.ishsow = true,
    this.textEditingController,
  });
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, right: 16.0),
      child: SizedBox(
        height: height,
        child: Center(
          child: Row(
            children: <Widget>[
              ishsow == true
                  ? Icon(
                    iconData,
                    size: 18,
                    color: Theme.of(context).primaryColor,
                  )
                  : SizedBox(),
              ishsow == true ? SizedBox(width: 8) : SizedBox(),
              Expanded(
                child: TextField(
                  controller: textEditingController,
                  maxLines: 1,
                  enabled: enabled,
                  onChanged: (String txt) {},
                  cursorColor: Theme.of(context).primaryColor,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(0),
                    errorText: null,
                    border: InputBorder.none,
                    hintText: text,
                    hintStyle: TextStyles(
                      context,
                    ).getDescriptionStyle().copyWith(
                      color: AppTheme.secondaryTextColor,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
