import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:munchspace/core/theme/app_colors.dart';
import 'package:munchspace/core/utils/responsive.dart';

class ProfileAppBar extends PreferredSize {
  ProfileAppBar({super.key})
    : super(
        preferredSize: Size.fromHeight(250.h),
        child: const _ProfileAppBarContent(),
      );
}

class _ProfileAppBarContent extends StatelessWidget {
  const _ProfileAppBarContent();

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.topCenter,
      children: [
        Container(height: 250.h, color: AppColors.red100),
        // Bottom Curve Image - positioned to overflow below
        Positioned(
          bottom: -10.h, // Extend below the appbar
          left: 0,
          right: 0,
          child: Image.asset(
            'assets/images/appbar_bottom.png',
            fit: BoxFit.fill,
            width: 1.sw,
            height: 60.h,
          ),
        ),
        // Content
        SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              10.sH,
              Text(
                'My Profile',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                ),
              ),
              24.sH,
              // Avatar
              Stack(
                children: [
                  Container(
                    width: 80.sp,
                    height: 80.sp,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.white.withOpacity(0.5),
                    ),
                    padding: 16.padAll,
                    child: SvgPicture.asset(
                      'assets/svg/home/avatar.svg',
                      width: 40.sp,
                      height: 40.sp,
                    ),
                  ),
                  Positioned(
                    right: 0,
                    bottom: 0,
                    child: Container(
                      padding: 4.padAll,
                      decoration: BoxDecoration(
                        color: AppColors.green,
                        shape: BoxShape.circle,
                        border: Border.all(color: AppColors.white, width: 2),
                      ),
                      child: Icon(
                        Icons.add,
                        color: AppColors.white,
                        size: 16.sp,
                      ),
                    ),
                  ),
                ],
              ),
              16.sH,
              Text(
                'James Adegoke',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
              ),
              4.sH,
              Text(
                'jamesadegoke23@gmail.com',
                style: TextStyle(
                  fontSize: 12.sp,
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
