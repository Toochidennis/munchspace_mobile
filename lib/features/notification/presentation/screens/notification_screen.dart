import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:munchspace/core/common_widgets/custom_appbar.dart';
import 'package:munchspace/core/utils/responsive.dart';

import '../../../../core/theme/app_colors.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  String selectedTab = 'All';

  final List<String> tabs = ['All', 'Orders', 'Promotions', 'Updates'];

  final List<NotificationItem> notifications = [
    NotificationItem(
      icon: 'assets/svg/notification/parcel.svg',
      title: 'Order on the way',
      description:
          'Your order from Jollof Palace is on its way. Sit tight, your meals almost there!',
      time: '2 min ago',
      isNew: true,
    ),
    NotificationItem(
      icon: 'assets/svg/notification/discount.svg',
      title: 'Weekend breakfast deal',
      description:
          'Get 20% off all breakfast meals this weekend. Don\'t miss out!',
      time: '12 min ago',
      isNew: true,
    ),
    NotificationItem(
      icon: 'assets/svg/notification/discount.svg',
      title: 'Free drink offer',
      description:
          'Add any meal above ₦3,000 and get a free bottled drink today only.',
      time: '40 min ago',
      isNew: true,
    ),
    NotificationItem(
      icon: 'assets/svg/notification/bell.svg',
      title: 'New restaurants available',
      description:
          'We\'ve added new spots in your area. Explore fresh meals near you on MunchSpace.',
      time: '40 min ago',
      isNew: true,
    ),
    NotificationItem(
      icon: 'assets/svg/notification/discount.svg',
      title: 'Lower delivery fees',
      description: 'Enjoy reduced delivery charges on orders this week.',
      time: '50 min ago',
      isNew: false,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: CustomAppbar(
        title: 'Notifications',
      ),
      body: Column(
        children: [
          // Tab Bar
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: tabs.map((tab) {
                  final isSelected = selectedTab == tab;
                  return Padding(
                    padding: EdgeInsets.only(right: 8.w),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedTab = tab;
                        });
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 16.w,
                          vertical: 8.h,
                        ),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? AppColors.orange
                              : AppColors.white,
                          borderRadius: BorderRadius.circular(999.r),
                        ),
                        child: Text(
                          tab,
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                            color: isSelected
                                ? AppColors.white
                                : AppColors.textPrimary,
                          ),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
          // Notifications List
          Expanded(
            child: ListView.separated(
              padding: 16.padH + 16.padB,
              itemCount: notifications.length,
              separatorBuilder: (context, index) => 16.sH,
              itemBuilder: (context, index) {
                final notification = notifications[index];
                return Container(
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(16.r),
                    border: Border.all(color: AppColors.border),
                  ),
                  child: Column(
                    children: [
                      // Top section with icon, title, time, and new indicator
                      Padding(
                        padding: 16.padH + 16.padT,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            // Icon container
                            Container(
                              width: 28.sp,
                              height: 28.sp,
                              decoration: BoxDecoration(
                                color: AppColors.background,
                                shape: BoxShape.circle,
                              ),
                              child: Center(
                                child: SvgPicture.asset(
                                  notification.icon,
                                  width: 15.w,
                                ),
                              ),
                            ),
                            12.sW,
                            // Title and time row
                            Text(
                              notification.title,
                              style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w600,
                                color: AppColors.textPrimary,
                              ),
                            ),
                            Spacer(),
                            Text(
                              notification.time,
                              style: TextStyle(
                                fontSize: 12.sp,
                                color: AppColors.textSecondary,
                              ),
                            ),
                            8.sW,
                            if (notification.isNew)
                              Container(
                                width: 8.w,
                                height: 8.h,
                                decoration: const BoxDecoration(
                                  color: AppColors.red,
                                  shape: BoxShape.circle,
                                ),
                              ),
                          ],
                        ),
                      ),
                      // Divider
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 15.h),
                        child: Divider(
                          color: AppColors.background,
                          height: 1.h,
                        ),
                      ),
                      // Description with padding
                      Padding(
                        padding: 16.padH + 16.padB,
                        child: Text(
                          notification.description,
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: AppColors.textSecondary,
                            height: 1.4,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class NotificationItem {
  final String icon;
  final String title;
  final String description;
  final String time;
  final bool isNew;

  NotificationItem({
    required this.icon,
    required this.title,
    required this.description,
    required this.time,
    required this.isNew,
  });
}
