import 'package:flutter/material.dart';
import 'package:munchspace/core/theme/app_colors.dart';
import 'package:munchspace/core/utils/number_extensions.dart';
import 'package:munchspace/core/utils/responsive.dart';
import 'package:munchspace/features/home/models/addon.dart';

/// Horizontal divider line
class DividerLine extends StatelessWidget {
  const DividerLine({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(height: 1.h, color: const Color(0xFFEEEEEE));
  }
}

/// Section header with optional badge label
class SectionHeader extends StatelessWidget {
  final String title;
  final String? badgeLabel;

  const SectionHeader({super.key, required this.title, this.badgeLabel});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimary,
          ),
        ),
        if (badgeLabel != null)
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(999.r),
              color: AppColors.red50,
            ),
            child: Text(
              badgeLabel!,
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.w400,
                color: AppColors.textSecondary,
              ),
            ),
          ),
      ],
    );
  }
}

/// Addon item row with checkbox, name/price, and optional quantity stepper
class AddonItemRow extends StatelessWidget {
  final Addon addon;
  final VoidCallback onCheckboxChange;
  final VoidCallback? onDecrement;
  final VoidCallback? onIncrement;
  final bool showStepper;
  final bool enableStepper;

  const AddonItemRow({
    super.key,
    required this.addon,
    required this.onCheckboxChange,
    this.onDecrement,
    this.onIncrement,
    this.showStepper = false,
    this.enableStepper = true,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onCheckboxChange,
      child: Row(
        children: [
          Checkbox(
            value: addon.selected,
            onChanged: (_) => onCheckboxChange(),
            activeColor: AppColors.orange,
            side: BorderSide(color: AppColors.textSecondary),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4.r),
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  addon.name,
                  style: TextStyle(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w500,
                    color: AppColors.textPrimary,
                  ),
                ),
                4.sH,
                Text(
                  addon.price.toCurrency(),
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColors.orange,
                  ).withCurrencyFont,
                ),
              ],
            ),
          ),
          if (showStepper) ...[
            12.sW,
            QuantityStepper(
              quantity: addon.quantity,
              onDecrement: onDecrement,
              onIncrement: onIncrement,
              isEnabled: enableStepper && addon.selected,
            ),
          ],
        ],
      ),
    );
  }
}

/// Circular quantity stepper widget
class QuantityStepper extends StatelessWidget {
  final int quantity;
  final VoidCallback? onDecrement;
  final VoidCallback? onIncrement;
  final bool isEnabled;

  const QuantityStepper({
    super.key,
    required this.quantity,
    this.onDecrement,
    this.onIncrement,
    this.isEnabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: isEnabled ? 1.0 : 0.5,
      child: Container(
        height: 42.h,
        padding: 4.padAll,
        decoration: BoxDecoration(
          color: const Color(0xFFF5F5F5),
          borderRadius: BorderRadius.circular(99.r),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            GestureDetector(
              onTap: isEnabled ? onDecrement : null,
              child: Container(
                width: 40.w,
                height: 40.h,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                alignment: Alignment.center,
                child: Icon(
                  Icons.remove,
                  size: 20.sp,
                  color: AppColors.textPrimary,
                ),
              ),
            ),
            SizedBox(width: 12.w),
            Text(
              quantity.toString(),
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 14.sp,
                color: AppColors.textPrimary,
              ),
            ),
            SizedBox(width: 12.w),
            GestureDetector(
              onTap: isEnabled ? onIncrement : null,
              child: Container(
                width: 40.w,
                height: 40.h,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                alignment: Alignment.center,
                child: Icon(
                  Icons.add,
                  size: 20.sp,
                  color: AppColors.textPrimary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
