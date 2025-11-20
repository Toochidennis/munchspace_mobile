import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:munchspace/core/theme/app_colors.dart';
import 'package:munchspace/core/utils/number_extensions.dart';
import 'package:munchspace/core/utils/responsive.dart';
import 'package:munchspace/features/orders/models/order.dart';

class OrderDetailsModal extends StatelessWidget {
  final Order order;

  const OrderDetailsModal({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: ResponsiveBorderRadius.topResponsive(24),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Header
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Order - ${order.id}',
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
                ),
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    padding: 8.padAll,
                    decoration: BoxDecoration(
                      color: AppColors.background,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.close,
                      size: 20.sp,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Divider(height: 1, color: AppColors.border),

          // Scrollable Content
          Flexible(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
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
                          'Order from ${order.storeName}',
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
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
                    children: order.code.split('').map((char) {
                      return Container(
                        width: 40.w,
                        height: 40.w,
                        margin: EdgeInsets.only(right: 8.w),
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: 8.radius,
                          border: Border.all(color: AppColors.border),
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
                      final isActive = order.progress > (index * 0.2);
                      return Expanded(
                        child: Container(
                          height: 6.h,
                          margin: EdgeInsets.only(right: index == 4 ? 0 : 8.w),
                          decoration: BoxDecoration(
                            color: isActive
                                ? AppColors.orange
                                : AppColors.red100,
                            borderRadius: 999.radius,
                          ),
                        ),
                      );
                    }),
                  ),
                  16.sH,

                  Text(
                    '${_formatTime(order.placedAt)} - Order Placed',
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: AppColors.textSecondary,
                    ),
                  ),
                  24.sH,

                  // Timeline
                  _buildExpandableSection(
                    title: 'Timeline',
                    content: _buildTimeline(),
                  ),
                  // 16.sH,

                  // Order Details
                  _buildExpandableSection(
                    title: 'Order details',
                    content: _buildOrderDetails(),
                  ),
                  32.sH,
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExpandableSection({
    required String title,
    required Widget content,
  }) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(color: AppColors.border),
          bottom: BorderSide(color: AppColors.border),
        ),
      ),
      child: Theme(
        data: ThemeData().copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          title: Text(
            title,
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
              color: AppColors.textPrimary,
            ),
          ),
          childrenPadding: EdgeInsets.zero,
          tilePadding: EdgeInsets.zero,
          children: [content],
        ),
      ),
    );
  }

  Widget _buildTimeline() {
    return Padding(
      padding: EdgeInsets.only(bottom: 16.h),
      child: Column(
        children: order.timeline.asMap().entries.map((entry) {
          final index = entry.key;
          final step = entry.value;
          final isLast = index == order.timeline.length - 1;

          return IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Timeline line and dot
                Column(
                  children: [
                    Container(
                      width: 12.sp,
                      height: 12.sp,
                      decoration: BoxDecoration(
                        color: step.isCompleted || step.isCurrent
                            ? AppColors.orange
                            : AppColors.disabled,
                        shape: BoxShape.circle,
                      ),
                    ),
                    if (!isLast)
                      Expanded(
                        child: Container(
                          width: 2.sp,
                          color: step.isCompleted
                              ? AppColors.orange
                              : AppColors.disabled.withOpacity(0.3),
                        ),
                      ),
                  ],
                ),
                16.sW,
                // Content
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(bottom: isLast ? 0 : 24.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          step.title,
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                            color: step.isCompleted || step.isCurrent
                                ? AppColors.textPrimary
                                : AppColors.textTertiary,
                          ),
                        ),
                        4.sH,
                        Text(
                          _formatDateTime(step.time),
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: AppColors.textTertiary,
                          ),
                        ),
                        if (step.description != null) ...[
                          4.sH,
                          Text(
                            step.description!,
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: AppColors.red,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildOrderDetails() {
    final subtotal = order.items.fold(
      0.0,
      (sum, item) => sum + (item.price * item.quantity),
    );
    final total = subtotal + order.deliveryFee;

    return Padding(
      padding: EdgeInsets.only(bottom: 16.h),
      child: Column(
        children: [
          ...order.items.map(
            (item) => Padding(
              padding: EdgeInsets.only(bottom: 12.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    item.name,
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  Text(
                    item.price.toCurrency(),
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Divider(color: AppColors.border),
          12.sH,
          _buildPriceRow('Subtotal', subtotal),
          8.sH,
          _buildPriceRow('Delivery Fee', order.deliveryFee),
          12.sH,
          Divider(color: AppColors.border),
          12.sH,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total',
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                ),
              ),
              Text(
                total.toCurrency(),
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                ),
              ),
            ],
          ),
          16.sH,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Payment Method',
                style: TextStyle(fontSize: 14.sp, color: AppColors.textPrimary),
              ),
              Text(
                order.paymentMethod,
                style: TextStyle(fontSize: 14.sp, color: AppColors.textPrimary),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPriceRow(String label, double amount) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 14.sp, color: AppColors.textPrimary),
        ),
        Text(
          amount.toCurrency(),
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
            color: AppColors.textPrimary,
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

  String _formatDateTime(DateTime time) {
    // Format: 18th OCT, 2024, 11:03AM
    // Simplified for now
    final day = time.day;
    final month = _getMonthName(time.month);
    final year = time.year;
    final timeStr = _formatTime(time).toUpperCase();
    return '${day}th $month, $year. $timeStr';
  }

  String _getMonthName(int month) {
    const months = [
      'JAN',
      'FEB',
      'MAR',
      'APR',
      'MAY',
      'JUN',
      'JUL',
      'AUG',
      'SEP',
      'OCT',
      'NOV',
      'DEC',
    ];
    return months[month - 1];
  }
}
