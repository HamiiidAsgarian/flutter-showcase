import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_showcase/core/constants/app_sizes.dart';
import 'package:flutter_showcase/core/theme/app_theme_extension.dart';

class LoginOption extends StatelessWidget {
  const LoginOption({
    super.key,
    this.icon,
  });

  const LoginOption.facebook({
    Key? key,
  }) : this(key: key, icon: const Icon(Icons.facebook, color: Colors.blue));
  const LoginOption.google({
    Key? key,
  }) : this(
          key: key,
          icon: const Icon(
            Icons.tiktok,
            color: Color.fromARGB(255, 68, 0, 255),
          ),
        );
  const LoginOption.appke({
    Key? key,
  }) : this(key: key, icon: const Icon(Icons.apple, color: Colors.black));
  final Icon? icon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: SizeR.r12),
      child: TextButton(
        onPressed: () {},
        style: TextButton.styleFrom(
          padding: EdgeInsets.zero,
          minimumSize: Size(70.r, 50.r),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(SizeR.r8),
            side: BorderSide(width: 1.r, color: context.colorz.greyMain),
          ),
          backgroundColor: context.colorz.backgroundWhite,
          shadowColor: context.colorz.dark500.withOpacity(.2),
          elevation: 2,
        ),
        child: icon ?? const SizedBox(),
      ),
    );
  }
}
