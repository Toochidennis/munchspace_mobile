import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:munchspace/core/theme/app_colors.dart';
import 'package:munchspace/core/utils/responsive.dart';
import 'package:munchspace/features/orders/models/order.dart';
import 'package:munchspace/features/orders/presentation/widgets/order_details_modal.dart';

class InProgressOrderCard extends StatelessWidget {
  final Order order;

  const InProgressOrderCard({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
          decoration: BoxDecoration(
            color: AppColors.red50,
            borderRadius: ResponsiveBorderRadius.topResponsive(16),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text(
                    order.id,
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: AppColors.textSecondary,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  8.sW,
                  GestureDetector(
                    onTap: () {
                      Clipboard.setData(ClipboardData(text: order.id));
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Order ID copied')),
                      );
                    },
                    child: Icon(
                      Icons.copy,
                      size: 14.sp,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: AppColors.info.withOpacity(0.2),
                  borderRadius: 4.radius,
                ),
                child: Text(
                  order.status,
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: AppColors.info,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
        // Content
        Container(
          padding: 16.padAll,
          decoration: BoxDecoration(
            color: AppColors.background,
            borderRadius: ResponsiveBorderRadius.bottomResponsive(16),
            border: Border.all(color: AppColors.red50, width: 2.sp),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Store Info
              Row(
                children: [
                  SvgPicture.asset(
                    'assets/svg/orders/restaurant.svg',
                    width: 20.sp,
                    colorFilter: const ColorFilter.mode(
                      AppColors.textPrimary,
                      BlendMode.srcIn,
                    ),
                  ),
                  12.sW,
                  Expanded(
                    child: Text(
                      order.storeName,
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textPrimary,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              16.sH,
              // Share Code
              Text(
                'Share this code with your rider',
                style: TextStyle(
                  fontSize: 12.sp,
                  color: AppColors.textSecondary,
                ),
              ),
              12.sH,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: order.code.split('').map((char) {
                  return Container(
                    width: 40.w,
                    height: 40.w,
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: 8.radius,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Center(
                      child: Text(
                        char,
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
              16.sH,
              // Progress Bar
              Row(
                children: List.generate(5, (index) {
                  // Calculate if this segment should be active
                  // 5 segments, so each is 0.2
                  final isActive = order.progress > (index * 0.2);
                  return Expanded(
                    child: Container(
                      height: 6.h,
                      margin: EdgeInsets.only(right: index == 4 ? 0 : 8.w),
                      decoration: BoxDecoration(
                        color: isActive ? AppColors.orange : AppColors.red100,
                        borderRadius: 999.radius,
                      ),
                    ),
                  );
                }),
              ),
              16.sH,
              // Footer
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${_formatTime(order.placedAt)} - Order Placed',
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: AppColors.textSecondary,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        backgroundColor: Colors.transparent,
                        builder: (context) => OrderDetailsModal(order: order),
                      );
                    },
                    child: Text(
                      'View details',
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: AppColors.blue,
                        fontWeight: FontWeight.w600,
                        decoration: TextDecoration.underline,
                        decorationColor: AppColors.blue,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  String _formatTime(DateTime time) {
    final hour = time.hour > 12 ? time.hour - 12 : time.hour;
    final period = time.hour >= 12 ? 'pm' : 'am';
    final minute = time.minute.toString().padLeft(2, '0');
    return '$hour:$minute$period';
  }
}
