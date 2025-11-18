import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/responsive.dart';

/// Reusable auth appbar widget using PreferredSize
class AuthAppBar extends PreferredSize {
  final String title;
  final bool showBackButton;

  AuthAppBar({super.key, required this.title, this.showBackButton = true})
    : super(
        preferredSize: Size.fromHeight(120.h),
        child: _AuthAppBarContent(title: title, showBackButton: showBackButton),
      );
}

class _AuthAppBarContent extends StatelessWidget {
  final String title;
  final bool showBackButton;

  const _AuthAppBarContent({required this.title, required this.showBackButton});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80.h,
      margin: 40.padB,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // Image at the bottom hanging below
          Positioned(
            bottom: -40.h,
            left: 0,
            right: 0,
            child: Image.asset(
              'assets/images/appbar_bottom.png',
              width: 1.sw,
              fit: BoxFit.cover,
            ),
          ),
          // Content on top
          Container(
            color: AppColors.red100,
            child: SafeArea(
              child: Container(
                height: 56.h,
                color: AppColors.red100,
                padding: 20.padH,
                child: Row(
                  children: [
                    if (showBackButton)
                      GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Container(
                          width: ResponsiveDimensions.buttonMD,
                          height: ResponsiveDimensions.buttonMD,
                          decoration: BoxDecoration(
                            color: AppColors.white.withValues(alpha: 0.9),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.arrow_back,
                            size: ResponsiveDimensions.iconSM,
                            color: AppColors.textPrimary,
                          ),
                        ),
                      ),
                    Spacer(),
                    Text(
                      title,
                      style: TextStyle(
                        color: AppColors.black,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    Spacer(),
                    if (showBackButton)
                      SizedBox(width: ResponsiveDimensions.buttonMD),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
