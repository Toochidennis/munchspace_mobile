import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:munchspace/core/theme/app_colors.dart';
import 'package:munchspace/core/utils/responsive.dart';
import 'package:munchspace/features/profile/presentation/widgets/profile_appbar.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: ProfileAppBar(),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionHeader('Personal'),
            12.sH,
            Container(
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: 12.radius,
                boxShadow: [
                  BoxShadow(
                    color: AppColors.shadow.withOpacity(0.05),
                    blurRadius: 10,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: GestureDetector(
                onTap: () {},
                child: Row(
                  children: [
                    SvgPicture.asset(
                      'assets/svg/nav_bar/profile.svg',
                      width: 16.sp,
                      colorFilter: const ColorFilter.mode(
                        AppColors.textPrimary,
                        BlendMode.srcIn,
                      ),
                    ),
                    16.sW,
                    Expanded(
                      child: Text(
                        'Profile Details',
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ),
                    Icon(
                      Icons.arrow_forward_ios,
                      size: 16.sp,
                      color: AppColors.textTertiary,
                    ),
                  ],
                ),
              ),
            ),
            32.sH,
            _buildSectionHeader('More'),
            12.sH,
            Container(
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: 12.radius,
                boxShadow: [
                  BoxShadow(
                    color: AppColors.shadow.withOpacity(0.05),
                    blurRadius: 10,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                children: [
                  _buildOptionTile(
                    icon: 'assets/svg/profile/orders.svg',
                    title: 'Orders',
                    onTap: () {},
                    showDivider: true,
                  ),
                  _buildOptionTile(
                    icon: 'assets/svg/profile/help.svg',
                    title: 'Get Help',
                    onTap: () {},
                    showDivider: true,
                  ),
                  _buildOptionTile(
                    icon: 'assets/svg/profile/review.svg',
                    title: 'Submit a Review',
                    onTap: () {},
                    showDivider: true,
                  ),
                  _buildOptionTile(
                    icon: 'assets/svg/profile/logout.svg',
                    title: 'Logout',
                    onTap: () {},
                    showDivider: true,
                  ),
                  _buildOptionTile(
                    icon: 'assets/svg/profile/delete.svg',
                    title: 'Delete account',
                    isDestructive: true,
                    onTap: () {},
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 14.sp,
        color: AppColors.textSecondary,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  Widget _buildOptionTile({
    required String icon,
    required String title,
    required VoidCallback onTap,
    bool isDestructive = false,
    bool showDivider = false,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(16.w),
            child: Row(
              children: [
                SvgPicture.asset(
                  icon,
                  width: 16.sp,
                  colorFilter: ColorFilter.mode(
                    isDestructive ? AppColors.red : AppColors.textPrimary,
                    BlendMode.srcIn,
                  ),
                ),
                16.sW,
                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      color: isDestructive
                          ? AppColors.red
                          : AppColors.textPrimary,
                    ),
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  size: 16.sp,
                  color: isDestructive ? AppColors.red : AppColors.textTertiary,
                ),
              ],
            ),
          ),
          if (showDivider)
            Divider(
              height: 1,
              thickness: 1,
              color: AppColors.border,
              indent: 16.w,
              endIndent: 16.w,
            ),
        ],
      ),
    );
  }
}
