import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:moniepoint/core/constants/bottom_bar.dart';
import 'package:moniepoint/core/extensions/context.dart';
import 'package:moniepoint/core/themes/colors.dart';
import 'package:websafe_svg/websafe_svg.dart';

class CustomBottomAppbarView extends StatefulWidget {
  const CustomBottomAppbarView({Key? key}) : super(key: key);

  @override
  State<CustomBottomAppbarView> createState() => _CustomBottomAppbarViewState();
}

class _CustomBottomAppbarViewState extends State<CustomBottomAppbarView>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  late PageController pageController;
  int currentPage = 2;

  @override
  void initState() {
    pageController = PageController(initialPage: 2);
    tabController = TabController(length: 5, vsync: this);
    tabController.animation?.addListener(
      () {
        final value = tabController.animation!.value.round();
        if (value != currentPage && mounted) {
          changePage(value);
        }
      },
    );
    super.initState();
  }

  void changePage(int newPage) {
    setState(() {
      currentPage = newPage;
    });
  }

  @override
  void dispose() {
    tabController.dispose();
    pageController.dispose();
    super.dispose();
  }

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
        //statusBarColor: Colors.transparent,
      ),
      child: Scaffold(
        body: SafeArea(
          top: false,
          bottom: false,
          child: Stack(
            children: [
              PageView.builder(
                itemCount: bottomAppBarIcons.length,
                controller: pageController,
                onPageChanged: (value) {
                  setState(() {
                    currentPage = value;
                  });
                },
                itemBuilder: ((context, index) {
                  return bottomAppBarWidgets[index];
                }),
              ),
              Positioned(
                bottom: 20.0.h,
                left: 40.0.w,
                right: 40.0.w,
                child: Container(
                  width: context.screenWidth,
                  decoration: BoxDecoration(
                    color: ColorConst.black1,
                    borderRadius: BorderRadius.circular(100.r),
                  ),
                  padding:
                      EdgeInsets.symmetric(horizontal: 2.0.w, vertical: 10.0.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: List.generate(
                      bottomAppBarIcons.length,
                      (index) => GestureDetector(
                        onTap: () {
                          setState(() {
                            currentPage = index;
                          });
                          pageController.animateToPage(index,
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeInOutQuad);
                        },
                        child: AnimatedContainer(
                          duration: const Duration(
                              milliseconds: 300), // Adjust duration as needed
                          curve: Curves.easeInOut, // Adjust curve as needed
                          decoration: BoxDecoration(
                            color: currentPage == index
                                ? ColorConst.primary
                                : ColorConst.black,
                            shape: BoxShape.circle,
                          ),
                          height: currentPage == index ? 65.0.h : 50.0.h,
                          width: currentPage == index ? 65.0.w : 50.0.w,
                          child: Center(
                            child: SizedBox(
                              height: 30.0.h,
                              width: 30.0.w,
                              child: WebsafeSvg.asset(
                                bottomAppBarIcons[index],
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      ),
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
