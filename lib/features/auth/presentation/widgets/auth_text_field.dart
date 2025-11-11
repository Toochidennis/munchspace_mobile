import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/responsive.dart';

/// Reusable text field for auth forms
class AuthTextField extends StatefulWidget {
  final String label;
  final String? hintText;
  final TextInputType keyboardType;
  final bool obscureText;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final IconData? prefixIcon;
  final bool isPassword;

  const AuthTextField({
    super.key,
    required this.label,
    this.hintText,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.controller,
    this.validator,
    this.prefixIcon,
    this.isPassword = false,
  });

  @override
  State<AuthTextField> createState() => _AuthTextFieldState();
}

class _AuthTextFieldState extends State<AuthTextField> {
  late bool _obscureText;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.obscureText;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          controller: widget.controller,
          keyboardType: widget.keyboardType,
          obscureText: _obscureText,
          validator: widget.validator,
          decoration: InputDecoration(
            hintText: widget.hintText ?? 'Enter ${widget.label.toLowerCase()}',
            hintStyle: TextStyle(
              color: AppColors.textSecondary.withValues(alpha: 0.6),
              fontSize: 14.sp,
            ),
            filled: true,
            fillColor: AppColors.surface,
            prefixIcon: widget.prefixIcon != null
                ? Icon(
                    widget.prefixIcon,
                    color: AppColors.textSecondary,
                    size: 20.sp,
                  )
                : null,
            suffixIcon: widget.isPassword
                ? GestureDetector(
                    onTap: () => setState(() => _obscureText = !_obscureText),
                    child: Icon(
                      _obscureText ? Icons.visibility_off : Icons.visibility,
                      color: AppColors.textSecondary,
                      size: 20.sp,
                    ),
                  )
                : null,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide(color: AppColors.border),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide(color: AppColors.border),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide(color: AppColors.green, width: 2),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide(color: AppColors.red),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide(color: AppColors.red, width: 2),
            ),
            contentPadding: EdgeInsets.symmetric(
              horizontal: 16.w,
              vertical: 16.h,
            ),
            constraints: BoxConstraints(minHeight: 52.h),
          ),
          style: TextStyle(color: AppColors.textPrimary, fontSize: 14.sp),
        ),
      ],
    );
  }
}
