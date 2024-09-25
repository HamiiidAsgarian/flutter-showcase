import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart' show SizeExtension;
import 'package:flutter_showcase/core/constants/app_sizes.dart';
import 'package:flutter_showcase/core/theme/app_theme_extension.dart';

class OnboardingItem extends StatelessWidget {
  const OnboardingItem({
    required this.title,
    required this.message,
    required this.imagePath,
    super.key,
  });

  final String title;
  final String message;
  final String imagePath;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: Image.asset(
            imagePath,
            fit: BoxFit.fitHeight,
          ),
        ),
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                context.colorz.dark500.withOpacity(1),
                context.colorz.grey500.withOpacity(0.1),
              ],
            ),
          ),
        ),
        SafeArea(
          child: Padding(
            padding: EdgeInsetsDirectional.symmetric(
              horizontal: SizeR.r32,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TweenAnimationBuilder(
                  curve: Curves.easeInOut,
                  tween: Tween<double>(begin: 0, end: 1),
                  duration: const Duration(milliseconds: 700),
                  builder: (context, value, child) => Container(
                    padding: EdgeInsets.only(top: value * SizeR.r32),
                    child: Text(
                      title,
                      style: context.styles.h2.copyWith(
                        color: context.colorz.light500.withOpacity(value),
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                ),
                TweenAnimationBuilder(
                  tween: Tween<double>(begin: 0, end: 1),
                  duration: const Duration(seconds: 1),
                  builder: (context, value, child) => Container(
                    padding: EdgeInsets.only(top: value * SizeR.r12),
                    child: Text(
                      message,
                      style: context.styles.b1.copyWith(
                        color: context.colorz.light500.withOpacity(value),
                      ),
                      textAlign: TextAlign.justify,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class PaginationIndicator extends StatelessWidget {
  const PaginationIndicator({
    required this.totalPages,
    required this.pageIndex,
    super.key,
  });
  final int pageIndex;
  final int totalPages;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(totalPages, (index) {
          final isThisSelected = index == pageIndex;
          return AnimatedContainer(
            decoration: BoxDecoration(
              color: isThisSelected
                  ? context.colorz.primary500
                  : context.colorz.grey500,
              borderRadius: BorderRadius.circular(SizeR.r12),
            ),
            margin: EdgeInsets.symmetric(horizontal: SizeR.r4),
            width: isThisSelected ? 60.r : SizeR.r8,
            height: SizeR.r8,
            duration: const Duration(milliseconds: 400),
          );
        }),
      ),
    );
  }
}

class SwipeSwitch extends StatefulWidget {
  const SwipeSwitch({
    required this.buttonColor,
    required this.buttonLabel,
    required this.onSuccess,
    super.key,
    this.width = 200,
    this.height = 50,
  });
  final Color buttonColor;
  final Widget buttonLabel;
  final double width;
  final double height;
  final void Function() onSuccess;

  @override
  State<SwipeSwitch> createState() => _SwipeSwitchState();
}

class _SwipeSwitchState extends State<SwipeSwitch> {
  double x = 0;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final switchWidth = constraints.maxWidth;
          final buttonWidth = switchWidth * .5;

          return Container(
            decoration: BoxDecoration(
              color: const Color.fromRGBO(193, 193, 195, 1),
              borderRadius: BorderRadius.circular(10),
            ),
            height: widget.height,
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding:
                        const EdgeInsets.only(right: 16, top: 16, bottom: 16),
                    child: FittedBox(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(3, (index) {
                          return Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.black.withOpacity((index + 1) / 3),
                          );
                        }),
                      ),
                    ),
                  ),
                ),
                AnimatedPositioned(
                  left: x,
                  duration: const Duration(milliseconds: 100),
                  child: Draggable(
                    data: true,
                    feedback: const SizedBox(),
                    onDragUpdate: (details) => {
                      setState(() {
                        x = (x + details.delta.dx)
                            .clamp(0, switchWidth - buttonWidth);
                      }),
                    },
                    onDragEnd: (details) {
                      if (x >= switchWidth / 2) widget.onSuccess();

                      setState(() {
                        x = 0;
                      });
                    },
                    axis: Axis.horizontal,
                    child: Container(
                      decoration: BoxDecoration(
                        color: widget.buttonColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      width: buttonWidth,
                      height: widget.height,
                      child:
                          Center(child: FittedBox(child: widget.buttonLabel)),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
