import 'package:flutter/cupertino.dart';
import 'package:flutter_showcase/core/constants/app_sizes.dart';
import 'package:flutter_showcase/core/theme/app_theme_extension.dart';

class MyMainButton extends StatelessWidget {
  const MyMainButton({
    required this.text,
    required this.onPressed,
    super.key,
  });
  final String text;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: CupertinoButton(
        borderRadius: BorderRadius.circular(SizeR.r16),
        color: context.colors.primary500,
        onPressed: onPressed,
        child: Text(
          text,
          style:
              context.styles.b1.copyWith(color: context.colors.backgroundWhite),
        ),
      ),
    );
  }
}
