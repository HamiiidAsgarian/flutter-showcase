// ignore_for_file: lines_longer_than_80_chars

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart' show SizeExtension;
import 'package:flutter_showcase/core/constants/app_sizes.dart';
import 'package:flutter_showcase/core/theme/app_theme_extension.dart';
import 'package:flutter_showcase/gen/assets.gen.dart' as ass;
import 'package:flutter_showcase/l10n/ln10.dart';
import 'package:flutter_showcase/onboarding/presentation/state.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  late PageController pageController;

  @override
  void initState() {
    pageController = PageController();
    super.initState();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  List<Widget> pages(BuildContext cntx) {
    return <Widget>[
      OnboardingItem(
        title: cntx.l10n.onboardingTitle1,
        message: cntx.l10n.onboardingMessage3,
      ),
      OnboardingItem(
        title: cntx.l10n.onboardingTitle2,
        message: cntx.l10n.onboardingMessage3,
      ),
      OnboardingItem(
        title: cntx.l10n.onboardingTitle3,
        message: cntx.l10n.onboardingMessage3,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final pageItems = pages(context);
    //----
    return Scaffold(
      backgroundColor: context.colors.dark,
      body: Stack(
        children: [
          PageView(
            onPageChanged: (index) => onPageChanged(index, pageItems.length),
            controller: pageController,
            children: pageItems,
          ),
          SafeArea(
            child: Padding(
              padding: EdgeInsets.only(bottom: SizeR.r32),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    BlocBuilder<OnBoardingBloc, OnBoardingState>(
                      builder: (context, state) {
                        return PaginationIndicator(
                          pageIndex: state.pageIndex,
                          totalPages: pageItems.length,
                        );
                      },
                    ),
                    SizedBox(height: SizeR.r12),
                    SizedBox(
                      width: 200,
                      child: SwipeSwitch(
                        onSuccess: onSwipePage,
                        buttonColor: context.colors.primary1,
                        buttonLabel:
                            BlocBuilder<OnBoardingBloc, OnBoardingState>(
                          buildWhen: (previous, current) =>
                              previous.stage != current.stage,
                          builder: (context, state) {
                            print("zzzzz ${state.stage}");
                            return Text(
                              state.stage == Stage.messages
                                  ? context.l10n.next
                                  : context.l10n.proceed,
                              style: context.styles.b1,
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void onSwipePage() {
    pageController.nextPage(
      curve: Curves.easeInOut,
      duration: const Duration(milliseconds: 300),
    );
  }

  void onPageChanged(int pageIndex, int pagesLength) {
    final isTheLastPage = pageIndex == pagesLength - 1;
    context
        .read<OnBoardingBloc>()
        .add(ChangePage(newPageIndex: pageIndex, isTheLastPage: isTheLastPage));
  }
}

class OnboardingItem extends StatelessWidget {
  const OnboardingItem({
    required this.title,
    required this.message,
    super.key,
  });

  final String title;
  final String message;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: Image.asset(
            ass.Assets.images.cImage1.path,
            fit: BoxFit.fitHeight,
          ),
        ),
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
              horizontal: SizeR.r32,
              vertical: SizeR.r32,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: context.styles.h2.copyWith(
                    color: context.colors.light,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                SizedBox(height: SizeR.r12),
                Text(
                  message,
                  style:
                      context.styles.b1.copyWith(color: context.colors.light),
                  textAlign: TextAlign.justify,
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
                  ? context.colors.primary1
                  : context.colors.grey500,
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
  });
  final Color buttonColor;
  final Widget buttonLabel;
  final void Function() onSuccess;

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
                  feedback: const SizedBox(),
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
                      return const SizedBox();
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
