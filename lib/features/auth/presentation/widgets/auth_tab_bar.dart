import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/responsive.dart';

/// Custom auth tab bar widget with Log in and Sign up tabs
class AuthTabBar extends StatelessWidget {
  final int currentTabIndex;
  final VoidCallback onLoginTap;
  final VoidCallback onSignUpTap;

  const AuthTabBar({
    super.key,
    required this.currentTabIndex,
    required this.onLoginTap,
    required this.onSignUpTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Left Tab - Log in
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.surfaceContainer,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(99.r),
                bottomLeft: Radius.circular(99.r),
              ),
            ),
            child: GestureDetector(
              onTap: onLoginTap,
              child: Container(
                margin: 4.padAll,
                decoration: BoxDecoration(
                  color: currentTabIndex == 0
                      ? AppColors.white
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(99.r),
                ),
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: 16.h,
                      horizontal: 20.w,
                    ),
                    child: Text(
                      'Log in',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                        color: currentTabIndex == 0
                            ? AppColors.orange
                            : AppColors.textSecondary,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        // Right Tab - Sign up
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.surfaceContainer,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(99.r),
                bottomRight: Radius.circular(99.r),
              ),
            ),
            child: GestureDetector(
              onTap: onSignUpTap,
              child: Container(
                margin: 4.padAll,
                decoration: BoxDecoration(
                  color: currentTabIndex == 1
                      ? AppColors.white
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(99.r),
                ),
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: 16.h,
                      horizontal: 20.w,
                    ),
                    child: Text(
                      'Sign up',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                        color: currentTabIndex == 1
                            ? AppColors.textPrimary
                            : AppColors.textSecondary,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
