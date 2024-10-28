import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:moniepoint/core/extensions/context.dart';
import 'package:moniepoint/core/extensions/string.dart';
import 'package:moniepoint/core/extensions/theme.dart';
import 'package:moniepoint/core/themes/colors.dart';
import 'package:websafe_svg/websafe_svg.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        // For Android.
        // Use [light] for white status bar and [dark] for black status bar.
        statusBarIconBrightness: Brightness.dark,
        // For iOS.
        // Use [dark] for white status bar and [light] for black status bar.
        statusBarBrightness: Brightness.light,
        statusBarColor: Colors.white,
      ),
      child: Scaffold(
        body: SafeArea(
          top: false,
          bottom: false,
          child: Container(
            height: context.screenHeight,
            width: context.screenWidth,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.bottomRight,
                colors: [
                  ColorConst.primary.withOpacity(0.025),
                  ColorConst.primary.withOpacity(0.2),
                  ColorConst.primary.withOpacity(0.6),
                  ColorConst.primary.withOpacity(0.8),
                  ColorConst.primary.withOpacity(1)
                ],
              ),
            ),
            child: SafeArea(
              top: true,
              bottom: false,
              child: Stack(
                children: [
                  SizedBox(
                    height: context.screenHeight,
                    width: context.screenWidth,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const HomeTopWidget(),
                        12.0.verticalSpace,
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 15.0.w),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Hi, Qudus",
                                style: context.textTheme.bodyLarge!
                                    .copyWith(color: ColorConst.grey),
                              ),
                              5.0.verticalSpace,
                              Text(
                                "Lets select your perfect place",
                                style: context.textTheme.displaySmall!
                                    .copyWith(color: ColorConst.black),
                              ),
                            ],
                          )
                              .animate(delay: 1200.milliseconds)
                              .scale(delay: 200.milliseconds),
                        ),
                        50.0.verticalSpace,
                        const HomeViewButtons(),
                      ],
                    ),
                  ),
                  const HomeViewSheet()
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class HomeViewSheet extends StatefulWidget {
  const HomeViewSheet({
    super.key,
  });

  @override
  State<HomeViewSheet> createState() => _HomeViewSheetState();
}

class _HomeViewSheetState extends State<HomeViewSheet>
    with SingleTickerProviderStateMixin {
  final double maxScrollHeight = 0.82;
  final double minScrollHeight = 0.4;

  // Declare an animation controller
  late final AnimationController _animController;

// This variable will be responsible for rotation the arrow icon
  late final Animation<double> _rotationAnim;

// Initialize the DraggableScrollableController.
// This will be used to get and control the state of the sheet
  final dragController = DraggableScrollableController();

  void animateDragOnTap(double height) {
    // Use dragController to control the sheet positioning.
    dragController.animateTo(
      height,
      duration: const Duration(milliseconds: 300),
      curve: Curves.ease,
    );
  }

  void toggleDragSheet() {
    // Depending on the position of the sheet we can expand or
    // contract it accordingly.
    if (dragController.size == maxScrollHeight) {
      animateDragOnTap(minScrollHeight);
    } else {
      animateDragOnTap(maxScrollHeight);
    }
  }

  @override
  void initState() {
    super.initState();

    // Initialize the animation controller
    _animController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    // Create a custom animation that interpolates between 0 and 0.5
    // based on scroll position
    _rotationAnim =
        Tween<double>(begin: 0.0, end: 0.5).animate(_animController);
  }

// Dispose the controllers to prevent memory leaks
  @override
  void dispose() {
    _animController.dispose();
    dragController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      controller: dragController,
      initialChildSize: minScrollHeight,
      minChildSize: minScrollHeight,
      maxChildSize: maxScrollHeight,
      snap: true,
      snapAnimationDuration: const Duration(milliseconds: 150),
      builder: (context, scrollController) {
        dragController.addListener(() {
          final newSize = dragController.size;

          // This code calculates a scroll position ratio based on the
          // current size of a draggable scrollable sheet, indicating how far
          // it is between its minimum and maximum possible heights, and
          // ensures this ratio stays within the range of 0 to 1.
          final scrollPosition = ((newSize - minScrollHeight) /
                  (maxScrollHeight - minScrollHeight))
              .clamp(0.0, 1.0);

          // Drive the animation based on scroll position
          _animController.animateTo(scrollPosition, duration: Duration.zero);
        });
        return Container(
          width: context.screenWidth,
          decoration: BoxDecoration(
            color: ColorConst.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30.0.r),
              topRight: Radius.circular(30.0.r),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: SingleChildScrollView(
              controller: scrollController,
              physics: const BouncingScrollPhysics(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: context.screenWidth,
                    height: 200.0.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0.r),
                      color: ColorConst.black1,
                      image: DecorationImage(
                        image: AssetImage("home_horizontal".jpeg),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(
                          left: 10.0.w, right: 10.0.w, bottom: 10.0.h),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TweenAnimationBuilder(
                              tween: Tween<double>(begin: 0.0, end: 1.0),
                              duration: const Duration(seconds: 1),
                              builder: (context, value, child) {
                                return ClipRRect(
                                  borderRadius: BorderRadius.circular(10.0.r),
                                  child: BackdropFilter(
                                    filter:
                                        ImageFilter.blur(sigmaX: 6, sigmaY: 6),
                                    child: Container(
                                      width: MediaQuery.of(context).size.width *
                                          value,
                                      clipBehavior: Clip.antiAlias,
                                      decoration: BoxDecoration(
                                        color:
                                            ColorConst.white.withOpacity(0.5),
                                        borderRadius:
                                            BorderRadius.circular(40.0.r),
                                      ),
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 4.0.h, horizontal: 5.0.w),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            SizedBox(
                                              width: 40.0.w,
                                            ),
                                            Flexible(
                                              child: Text(
                                                "GLodkova, 25, str",
                                                maxLines: 1,
                                                overflow: TextOverflow.clip,
                                                style: context
                                                    .textTheme.bodyMedium!
                                                    .copyWith(
                                                  color: ColorConst.black,
                                                ),
                                              ),
                                            ),
                                            Container(
                                              width: 40.0.w,
                                              height: 40.0.h,
                                              decoration: BoxDecoration(
                                                color: ColorConst.white,
                                                shape: BoxShape.circle,
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: ColorConst.grey
                                                        .withOpacity(0.5),
                                                    spreadRadius: 5,
                                                    blurRadius: 10,
                                                    offset: const Offset(
                                                      0,
                                                      5,
                                                    ), // changes position of shadow
                                                  ),
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              }),
                        ],
                      ),
                    ),
                  ),
                  10.0.verticalSpace,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Container(
                          width: context.screenWidth,
                          height: 300.0.h,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.0.r),
                            color: ColorConst.black1,
                            image: DecorationImage(
                              image: AssetImage("vertical_home_1".jpeg),
                              fit: BoxFit.cover,
                            ),
                          ),
                          child: Padding(
                            padding: EdgeInsets.only(
                                left: 10.0.w, right: 10.0.w, bottom: 10.0.h),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TweenAnimationBuilder(
                                  tween: Tween<double>(begin: 0.0, end: 1.0),
                                  duration: const Duration(seconds: 1),
                                  builder: (context, value, child) {
                                    return ClipRRect(
                                      borderRadius:
                                          BorderRadius.circular(10.0.r),
                                      child: BackdropFilter(
                                        filter: ImageFilter.blur(
                                            sigmaX: 6, sigmaY: 6),
                                        child: Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              value,
                                          clipBehavior: Clip.antiAlias,
                                          decoration: BoxDecoration(
                                            color: ColorConst.white
                                                .withOpacity(0.5),
                                            borderRadius:
                                                BorderRadius.circular(40.0.r),
                                          ),
                                          child: Padding(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 4.0.h,
                                                horizontal: 5.0.w),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                SizedBox(
                                                  width: 10.0.w,
                                                ),
                                                Flexible(
                                                  child: Text(
                                                    "GLodkova,",
                                                    maxLines: 1,
                                                    overflow: TextOverflow.clip,
                                                    style: context
                                                        .textTheme.bodyMedium!
                                                        .copyWith(
                                                      color: ColorConst.black,
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  width: 40.0.w,
                                                  height: 40.0.h,
                                                  decoration: BoxDecoration(
                                                    color: ColorConst.white,
                                                    shape: BoxShape.circle,
                                                    boxShadow: [
                                                      BoxShadow(
                                                        color: ColorConst.grey
                                                            .withOpacity(0.5),
                                                        spreadRadius: 5,
                                                        blurRadius: 10,
                                                        offset: const Offset(
                                                          0,
                                                          5,
                                                        ), // changes position of shadow
                                                      ),
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      10.0.horizontalSpace,
                      Expanded(
                        child: Container(
                          width: context.screenWidth,
                          height: 300.0.h,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.0.r),
                            color: ColorConst.black1,
                            image: DecorationImage(
                              image: AssetImage("vertical_home_2".jpeg),
                              fit: BoxFit.cover,
                            ),
                          ),
                          child: Padding(
                            padding: EdgeInsets.only(
                                left: 10.0.w, right: 10.0.w, bottom: 10.0.h),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TweenAnimationBuilder(
                                    tween: Tween<double>(begin: 0.0, end: 1.0),
                                    duration: const Duration(seconds: 1),
                                    builder: (context, value, child) {
                                      return ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(10.0.r),
                                        child: BackdropFilter(
                                          filter: ImageFilter.blur(
                                              sigmaX: 6, sigmaY: 6),
                                          child: Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                value,
                                            clipBehavior: Clip.antiAlias,
                                            decoration: BoxDecoration(
                                              color: ColorConst.white
                                                  .withOpacity(0.5),
                                              borderRadius:
                                                  BorderRadius.circular(40.0.r),
                                            ),
                                            child: Padding(
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 4.0.h,
                                                  horizontal: 5.0.w),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  SizedBox(
                                                    width: 10.0.w,
                                                  ),
                                                  Flexible(
                                                    child: Text(
                                                      "GLodkova,",
                                                      maxLines: 1,
                                                      overflow:
                                                          TextOverflow.clip,
                                                      style: context
                                                          .textTheme.bodyMedium!
                                                          .copyWith(
                                                        color: ColorConst.black,
                                                      ),
                                                    ),
                                                  ),
                                                  Container(
                                                    width: 40.0.w,
                                                    height: 40.0.h,
                                                    decoration: BoxDecoration(
                                                      color: ColorConst.white,
                                                      shape: BoxShape.circle,
                                                      boxShadow: [
                                                        BoxShadow(
                                                          color: ColorConst.grey
                                                              .withOpacity(0.5),
                                                          spreadRadius: 5,
                                                          blurRadius: 10,
                                                          offset: const Offset(
                                                            0,
                                                            5,
                                                          ), // changes position of shadow
                                                        ),
                                                      ],
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    }),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class HomeViewButtons extends StatefulWidget {
  const HomeViewButtons({
    super.key,
  });

  @override
  State<HomeViewButtons> createState() => _HomeViewButtonsState();
}

class _HomeViewButtonsState extends State<HomeViewButtons>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;
  //late final AnimationController _animationRentController;
  late Animation<double> _animationBuyNumbers;
  late Animation<double> _animationRentNumbers;

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));
    _animationBuyNumbers =
        Tween<double>(begin: 0.0, end: 1034.0).animate(_animationController);

    _animationRentNumbers =
        Tween<double>(begin: 0.0, end: 2212.0).animate(_animationController);
    Future.delayed(
        const Duration(
          milliseconds: 1600,
        ), () {
      _animationController.reset();
      _animationController.forward();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.0.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Container(
              height: 200.0.h,
              width: 200.0.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: ColorConst.primary,
                boxShadow: [
                  BoxShadow(
                    color: ColorConst.white.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: const Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  25.0.verticalSpace,
                  Text(
                    "Buy",
                    style: context.textTheme.bodyMedium!.copyWith(
                      color: ColorConst.white,
                    ),
                  ),
                  20.0.verticalSpace,
                  AnimatedBuilder(
                    builder: (context, child) {
                      return Text(
                        _animationBuyNumbers.value.toInt().toString(),
                        style: context.textTheme.displayMedium!.copyWith(
                          color: ColorConst.white,
                        ),
                      );
                    },
                    animation: _animationController,
                  ),
                  5.0.verticalSpace,
                  Text(
                    "Offers",
                    style: context.textTheme.bodySmall!.copyWith(
                      color: ColorConst.white,
                    ),
                  ),
                ],
              ),
            ).animate(delay: 1400.milliseconds).scale(delay: 200.milliseconds),
          ),
          15.0.horizontalSpace,
          Expanded(
            child: Container(
              height: 200.0.h,
              width: 200.0.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0.r),
                color: ColorConst.white,
                boxShadow: [
                  BoxShadow(
                    color: ColorConst.white.withOpacity(0.5),

                    blurRadius: 7,
                    offset: const Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  25.0.verticalSpace,
                  Text(
                    "Rent",
                    style: context.textTheme.bodyMedium!.copyWith(
                      color: ColorConst.grey,
                    ),
                  ),
                  20.0.verticalSpace,
                  AnimatedBuilder(
                    builder: (context, child) {
                      return Text(
                        _animationRentNumbers.value.toInt().toString(),
                        style: context.textTheme.displayMedium!.copyWith(
                          color: ColorConst.grey,
                        ),
                      );
                    },
                    animation: _animationController,
                  ),
                  5.0.verticalSpace,
                  Text(
                    "Offers",
                    style: context.textTheme.bodySmall!.copyWith(
                      color: ColorConst.grey,
                    ),
                  ),
                ],
              ),
            ).animate(delay: 1600.milliseconds).scale(delay: 200.milliseconds),
          ),
        ],
      ),
    );
  }
}

class HomeTopWidget extends StatelessWidget {
  const HomeTopWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.0.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
              color: ColorConst.white,
              borderRadius: BorderRadius.circular(10.0.r),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0.w, vertical: 8.0.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  WebsafeSvg.asset(
                    "location".svg,
                    colorFilter: ColorFilter.mode(
                      ColorConst.grey,
                      BlendMode.srcIn,
                    ),
                  ),
                  5.0.horizontalSpace,
                  Text(
                    "Saint Petersburg",
                    style: context.textTheme.bodySmall!.copyWith(
                      color: ColorConst.grey,
                    ),
                  ),
                ],
              ),
            ),
          ).animate(delay: 700.milliseconds).scale(delay: 200.milliseconds),
          Container(
            height: 50.0.h,
            width: 50.0.w,
            decoration: const BoxDecoration(
              color: ColorConst.white,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: WebsafeSvg.asset(
                "user".svg,
                height: 30.0.h,
                width: 30.0.w,
                fit: BoxFit.scaleDown,
                colorFilter: ColorFilter.mode(
                  ColorConst.grey,
                  BlendMode.srcIn,
                ),
              ),
            ),
          ).animate(delay: 900.milliseconds).scale(delay: 200.milliseconds),
        ],
      ),
    );
  }
}
