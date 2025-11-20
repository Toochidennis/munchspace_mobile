import 'package:flutter/material.dart';
import 'package:munchspace/core/theme/app_colors.dart';
import 'package:munchspace/core/utils/responsive.dart';

/// Custom AppBar widget used across the app for consistent styling
/// Supports a title, optional right action button, and customizable back button icon
/// The back button pops by default, but you can provide a custom onBackPressed callback
class CustomAppbar extends PreferredSize {
  CustomAppbar({
    super.key,
    required String title,
    Widget? rightAction,
    IconData backIcon = Icons.arrow_back,
    VoidCallback? onBackPressed,
  }) : super(
         preferredSize: Size.fromHeight(80.h),
         child: Builder(
           builder: (context) => SafeArea(
             child: Container(
               height: 72.h,
               padding: EdgeInsets.symmetric(horizontal: 16.w),
               child: Row(
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 children: [
                   // Back button
                   GestureDetector(
                     onTap: onBackPressed ?? () => Navigator.pop(context),
                     child: Container(
                       width: 40.w,
                       height: 40.h,
                       decoration: BoxDecoration(
                         color: AppColors.red100,
                         shape: BoxShape.circle,
                       ),
                       child: Icon(
                         backIcon,
                         color: AppColors.textPrimary,
                         size: 20.sp,
                       ),
                     ),
                   ),
                   // Title
                   Expanded(
                     child: Text(
                       title,
                       textAlign: TextAlign.center,
                       style: TextStyle(
                         fontSize: 16.sp,
                         fontWeight: FontWeight.w600,
                         color: AppColors.textPrimary,
                       ),
                     ),
                   ),
                   // Right action or spacer
                   rightAction ?? SizedBox(width: 40.w),
                 ],
               ),
             ),
           ),
         ),
       );
}
