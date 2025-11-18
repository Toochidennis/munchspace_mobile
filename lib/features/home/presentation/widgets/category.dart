import 'package:flutter/material.dart';
import 'package:munchspace/core/theme/app_colors.dart';
import 'package:munchspace/core/utils/responsive.dart';

class Category extends StatelessWidget {
  const Category({
    super.key,
    required this.name,
    required this.image,
    required this.color,
  });

  final String name;
  final String image;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120.h,
      width: 110.w,
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          Container(
            height: 54.h,
            width: 110.w,
            decoration: BoxDecoration(
              color: color.withOpacity(0.10),
              borderRadius: BorderRadius.vertical(top: Radius.circular(12.r)),
            ),
          ),
          Positioned(
            top: 16.h,
            left: 0,
            right: 0,
            child: SizedBox(
              width: 110.w,
              height: 88.h,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(image, width: 54.sp),
                  8.sH,
                  SizedBox(
                    width: 105.w,
                    child: Text(
                      name,
                      maxLines: 2,
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textPrimary,
                        height: 1.2,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
