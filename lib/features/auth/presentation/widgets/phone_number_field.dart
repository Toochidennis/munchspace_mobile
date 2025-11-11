import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/responsive.dart';

/// Phone number input field with country code selector
class PhoneNumberField extends StatefulWidget {
  final String label;
  final String? hintText;
  final TextEditingController? controller;
  final String? Function(String?)? validator;

  const PhoneNumberField({
    super.key,
    required this.label,
    this.hintText,
    this.controller,
    this.validator,
  });

  @override
  State<PhoneNumberField> createState() => _PhoneNumberFieldState();
}

class _PhoneNumberFieldState extends State<PhoneNumberField> {
  String _selectedCountryCode = '+234';
  final List<String> _countryCodes = [
    '+234', // Nigeria
    '+1', // USA
    '+44', // UK
    '+91', // India
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Label
        Padding(
          padding: EdgeInsets.only(bottom: 8.h),
          child: Row(
            children: [
              Text(
                widget.label,
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColors.textSecondary,
                ),
              ),
              Text(
                ' *',
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColors.red,
                ),
              ),
            ],
          ),
        ),
        // Input field with country code dropdown
        Container(
          height: 52.h,
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.border),
            borderRadius: BorderRadius.circular(12.r),
            color: AppColors.surface,
          ),
          child: Row(
            children: [
              // Country code dropdown
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w),
                child: DropdownButton<String>(
                  value: _selectedCountryCode,
                  items: _countryCodes.map((code) {
                    return DropdownMenuItem(
                      value: code,
                      child: Text(
                        code,
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: AppColors.textPrimary,
                        ),
                      ),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() => _selectedCountryCode = value ?? '+234');
                  },
                  underline: SizedBox.shrink(),
                  isDense: true,
                  isExpanded: false,
                ),
              ),
              // Phone number input
              Expanded(
                child: TextFormField(
                  controller: widget.controller,
                  keyboardType: TextInputType.phone,
                  validator: widget.validator,
                  decoration: InputDecoration(
                    hintText: widget.hintText ?? 'Enter phone number',
                    hintStyle: TextStyle(
                      color: AppColors.textSecondary.withValues(alpha: 0.6),
                      fontSize: 14.sp,
                    ),
                    border: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    focusedErrorBorder: InputBorder.none,
                    filled: true,
                    fillColor: Colors.transparent,
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 12.w,
                      vertical: 0,
                    ),
                  ),
                  style: TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: 14.sp,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
