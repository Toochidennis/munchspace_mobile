import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/responsive.dart';
import '../../../home/presentation/screens/home_screen.dart';
import '../widgets/auth_appbar.dart';

/// Confirm account screen for PIN verification
class ConfirmAccountScreen extends StatefulWidget {
  final String email;

  const ConfirmAccountScreen({super.key, required this.email});

  @override
  State<ConfirmAccountScreen> createState() => _ConfirmAccountScreenState();
}

class _ConfirmAccountScreenState extends State<ConfirmAccountScreen> {
  final _pinController = TextEditingController();

  @override
  void dispose() {
    _pinController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 56.w,
      height: 56.h,
      textStyle: TextStyle(
        fontSize: 24.sp,
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimary,
      ),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: AppColors.border, width: 1.5),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: AppColors.orange, width: 2),
    );

    final submittedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: AppColors.border, width: 1.5),
    );

    return Scaffold(
      appBar: AuthAppBar(title: 'Confirm your account'),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
        child: SizedBox(
          height: MediaQuery.of(context).size.height - 200.h,
          child: Column(
            children: [
              48.sH,
              // Description text
              Text(
                'Enter the 6-digit PIN code sent to your email\naddress ${widget.email}.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: 14.sp,
                  height: 1.5,
                ),
              ),
              40.sH,
              // PIN input with Pinput
              Pinput(
                controller: _pinController,
                length: 6,
                defaultPinTheme: defaultPinTheme,
                focusedPinTheme: focusedPinTheme,
                submittedPinTheme: submittedPinTheme,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                keyboardType: TextInputType.number,
                pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
                onCompleted: (pin) {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => const HomeScreen()),
                  );
                },
              ),
              Spacer(),
              // Continue button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    final pin = _pinController.text;
                    if (pin.length == 6) {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) => const HomeScreen(),
                        ),
                      );
                    }
                  },
                  child: Text(
                    'Continue',
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              20.sH,
              // Request new code link
              GestureDetector(
                onTap: () {
                  showTopSnackBar(
                    Overlay.of(context),
                    const CustomSnackBar.success(
                      message: 'New code sent to your email',
                    ),
                  );
                },
                child: Text(
                  'Request new code',
                  style: TextStyle(
                    color: AppColors.orange,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              20.sH,
            ],
          ),
        ),
      ),
    );
  }
}
