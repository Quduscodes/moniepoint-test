

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:moniepoint/core/extensions/string.dart';
import 'package:moniepoint/core/extensions/theme.dart';
import 'package:moniepoint/core/themes/colors.dart';
import 'package:moniepoint/features/search/presentation/screens/view.dart';
import 'package:websafe_svg/websafe_svg.dart';

class SearchPopupButton extends StatelessWidget {
  const SearchPopupButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      padding: EdgeInsets.zero,
      position: PopupMenuPosition.over,
      itemBuilder: (context) {
        return [
          PopupMenuItem(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                WebsafeSvg.asset(
                  "security".svg,
                  fit: BoxFit.scaleDown,
                  width: 30.0.w,
                  height: 30.0.h,
                  colorFilter: ColorFilter.mode(
                    ColorConst.grey,
                    BlendMode.srcIn,
                  ),
                ),
                10.0.horizontalSpace,
                Text(
                  "Cospy Areas",
                  style: context.textTheme.bodyMedium!.copyWith(
                    color: ColorConst.grey,
                  ),
                )
              ],
            ),
          ),
          PopupMenuItem(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                WebsafeSvg.asset(
                  "wallet".svg,
                  colorFilter: ColorFilter.mode(
                    ColorConst.grey,
                    BlendMode.srcIn,
                  ),
                ),
                10.0.horizontalSpace,
                Text(
                  "Price",
                  style: context.textTheme.bodyMedium!.copyWith(
                    color: ColorConst.grey,
                  ),
                )
              ],
            ),
          ),
          PopupMenuItem(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                WebsafeSvg.asset(
                  "layer".svg,
                  colorFilter: ColorFilter.mode(
                    ColorConst.grey,
                    BlendMode.srcIn,
                  ),
                ),
                10.0.horizontalSpace,
                Text(
                  "Without any layers",
                  style: context.textTheme.bodyMedium!.copyWith(
                    color: ColorConst.grey,
                  ),
                )
              ],
            ),
          ),
        ];
      },
      icon: SearchIconButtons(
        color: ColorConst.black2.withOpacity(0.5),
        asset: "layer".svg,
        iconColor: ColorConst.black,
      ).animate(delay: 900.milliseconds).scale(delay: 200.milliseconds),
    );
  }
}
