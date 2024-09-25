import 'package:flutter/material.dart';
import 'package:flutter_showcase/core/constants/app_sizes.dart';
import 'package:flutter_showcase/core/theme/app_theme_extension.dart';

class ORdivider extends StatelessWidget {
  const ORdivider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(child: Divider()),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: SizeR.r12),
          child: Text(
            'or continuer with',
            style: context.styles.b1.copyWith(
              color: context.colorz.greyMain,
            ),
          ),
        ),
        const Expanded(child: Divider()),
      ],
    );
  }
}
