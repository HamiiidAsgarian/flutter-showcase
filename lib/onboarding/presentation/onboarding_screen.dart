// ignore_for_file: lines_longer_than_80_chars

import 'package:flutter/material.dart';
import 'package:flutter_showcase/core/constants/app_sizes.dart';
import 'package:flutter_showcase/core/constants/app_text_styles.dart';
import 'package:flutter_showcase/core/utils/text_style_adaptor.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const url = 'https://fakeimg.pl/1920x1080/';
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(child: Image.network(url, fit: BoxFit.fitHeight)),
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color.fromARGB(131, 0, 0, 0),
                  Color.fromARGB(38, 255, 255, 255),
                ],
              ),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: EdgeInsetsDirectional.symmetric(
                horizontal: SizeR.s32,
                vertical: SizeR.s32,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Location and destination',
                    style: AppTextStyles.h1,
                  ),
                  SizedBox(height: SizeR.s32),
                  Text(
                    'Your destination is on your fingerprint just open the app and choose where you want to go ',
                    style: TextStyleAdapter.h1(context),
                  ),
                  SizedBox(height: SizeR.s32),
                  const PaginationIndicator(),
                  SizedBox(
                    width: 200,
                    child: SwipeSwitch(
                      onSuccess: () {
                        print('success');
                      },
                      buttonColor: Theme.of(context).primaryColor,
                      buttonLabel: Text(
                        'Next',
                        style: TextStyleAdapter.h3(context),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class PaginationIndicator extends StatelessWidget {
  const PaginationIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(color: Colors.red);
  }
}

class SwipeSwitch extends StatefulWidget {
  const SwipeSwitch(
      {required this.buttonColor,
      required this.buttonLabel,
      required VoidCallback this.onSuccess,
      super.key});
  final Color buttonColor;
  final Widget buttonLabel;
  final Function onSuccess;

  @override
  State<SwipeSwitch> createState() => _SwipeSwitchState();
}

class _SwipeSwitchState extends State<SwipeSwitch> {
  double x = 0;

  double switchButtonHeight = 50;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final switchWidth = constraints.maxWidth;
        final buttonWidth = switchWidth * .6;
        final buttonDropWidth = switchWidth * .4;

        return Container(
          decoration: BoxDecoration(
            color: const Color.fromRGBO(193, 193, 195, 1),
            borderRadius: BorderRadius.circular(10),
          ),
          height: switchButtonHeight,
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
                  feedback: const SizedBox(
                      // color: Colors.green,
                      // width: buttonWidth,
                      // height: switchButtonHeight,
                      ),
                  onDragUpdate: (details) => {
                    setState(() {
                      x = (x + details.delta.dx)
                          .clamp(0, switchWidth - buttonWidth);
                    }),
                  },
                  onDragEnd: (details) {
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
                    height: switchButtonHeight,
                    child: Center(child: FittedBox(child: widget.buttonLabel)),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                //This is eligibale space for drapping the button
                child: SizedBox(
                  width: buttonDropWidth,
                  height: switchButtonHeight,
                  child: DragTarget(
                    onAcceptWithDetails: (e) => widget.onSuccess(),
                    builder: (
                      BuildContext context,
                      List<Object?> _,
                      List<dynamic> __,
                    ) {
                      return SizedBox();
                    },
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
