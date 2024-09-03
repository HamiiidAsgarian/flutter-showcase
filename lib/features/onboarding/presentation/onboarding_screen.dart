// ignore_for_file: lines_longer_than_80_chars

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_showcase/core/constants/app_sizes.dart';
import 'package:flutter_showcase/core/theme/app_theme_extension.dart';
import 'package:flutter_showcase/features/onboarding/presentation/onboarding_bloc.dart';
import 'package:flutter_showcase/features/onboarding/presentation/widgets/onboarding_widgets.dart';
import 'package:flutter_showcase/gen/assets.gen.dart' as ass;
import 'package:flutter_showcase/l10n/ln10.dart';

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
        imagePath: ass.Assets.images.cImage1.path,
      ),
      OnboardingItem(
        title: cntx.l10n.onboardingTitle3,
        message: cntx.l10n.onboardingMessage3,
        imagePath: ass.Assets.images.cImage3.path,
      ),
      OnboardingItem(
        title: cntx.l10n.onboardingTitle2,
        message: cntx.l10n.onboardingMessage3,
        imagePath: ass.Assets.images.cImage2.path,
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
                    SwipeSwitch(
                      onSuccess: onSwipePage,
                      buttonColor: context.colors.primary1,
                      buttonLabel: BlocBuilder<OnBoardingBloc, OnBoardingState>(
                        buildWhen: (previous, current) =>
                            previous.stage != current.stage,
                        builder: (context, state) {
                          return Text(
                            state.stage == Stage.messages
                                ? context.l10n.next
                                : context.l10n.proceed,
                            style: context.styles.b1,
                          );
                        },
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
