import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:moniepoint/core/extensions/context.dart';
import 'package:moniepoint/core/extensions/string.dart';
import 'package:moniepoint/core/extensions/theme.dart';
import 'package:moniepoint/core/themes/colors.dart';
import 'package:moniepoint/features/search/presentation/widgets/search_popup.dart';
import 'package:websafe_svg/websafe_svg.dart';

class SearchView extends StatelessWidget {
  const SearchView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        // For Android.
        // Use [light] for white status bar and [dark] for black status bar.
        statusBarIconBrightness: Brightness.light,
        // For iOS.
        // Use [dark] for white status bar and [light] for black status bar.
        statusBarBrightness: Brightness.dark,
        statusBarColor: ColorConst.black,
      ),
      child: Scaffold(
        body: SafeArea(
          top: false,
          bottom: false,
          child: Container(
            height: context.screenHeight,
            width: context.screenWidth,
            decoration: BoxDecoration(
              color: ColorConst.black,
              image: DecorationImage(
                  image: AssetImage(
                    "google_map".png,
                  ),
                  fit: BoxFit.cover),
            ),
            //color: ColorConst.black,
            child: SafeArea(
              top: true,
              bottom: false,
              child: Stack(
                children: [
                  const SearchTopWidget(),
                  Positioned(
                    bottom: 150.0.h,
                    left: 30.0.w,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SearchPopupButton(),
                        20.0.verticalSpace,
                        SearchIconButtons(
                          color: ColorConst.black2.withOpacity(0.5),
                          asset: "send".svg,
                          iconColor: ColorConst.black,
                          onTap: () {},
                        )
                            .animate(delay: 1200.milliseconds)
                            .scale(delay: 200.milliseconds),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}


class SearchTopWidget extends StatelessWidget {
  const SearchTopWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 20.0.h,
      left: 30.0.w,
      right: 30.0.w,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Flexible(
            child: const CustomTextFieldWidget()
                .animate(delay: 500.milliseconds)
                .scale(delay: 200.milliseconds),
          ),
          20.horizontalSpace,
          const SearchIconButtons(
            boxShadow: true,
          ).animate(delay: 700.milliseconds).scale(delay: 200.milliseconds),
        ],
      ),
    );
  }
}

class SearchIconButtons extends StatelessWidget {
  final Color? color;
  final String? asset;
  final void Function()? onTap;
  final Color? iconColor;
  final bool? boxShadow;
  const SearchIconButtons(
      {super.key,
      this.color,
      this.asset,
      this.onTap,
      this.iconColor,
      this.boxShadow});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50.0.w,
      height: 50.0.h,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color ?? ColorConst.white,
        boxShadow: boxShadow == true
            ? [
                BoxShadow(
                  color: ColorConst.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 10,
                  offset: const Offset(
                    0,
                    5,
                  ),
                ),
              ]
            : null,
      ),
      child: GestureDetector(
        onTap: onTap,
        child: Center(
          child: WebsafeSvg.asset(
            asset ?? "settings".svg,
            colorFilter: iconColor != null
                ? ColorFilter.mode(
                    ColorConst.grey,
                    BlendMode.srcIn,
                  )
                : null,
          ),
        ),
      ),
    );
  }
}

class CustomTextFieldWidget extends StatelessWidget {
  const CustomTextFieldWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: context.textTheme.bodySmall!.copyWith(
        color: ColorConst.black,
      ),
      decoration: InputDecoration(
        fillColor: ColorConst.white,
        filled: true,
        contentPadding: EdgeInsets.symmetric(horizontal: 3.h),
        prefixIcon: SizedBox(
          height: 5.0.h,
          width: 5.0.w,
          child: WebsafeSvg.asset(
            "search_outline".svg,
            fit: BoxFit.scaleDown,
          ),
        ),
        hintText: "Search",
        hintStyle: context.textTheme.bodySmall!.copyWith(
          color: ColorConst.black,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(50.0.r),
          borderSide: const BorderSide(
            color: ColorConst.white,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(50.0.r),
          borderSide: const BorderSide(
            color: ColorConst.white,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(50.0.r),
          borderSide: const BorderSide(
            color: ColorConst.white,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(50.0.r),
          borderSide: const BorderSide(
            color: ColorConst.white,
          ),
        ),
      ),
    );
  }
}
