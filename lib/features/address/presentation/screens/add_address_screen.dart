import 'dart:developer' as developer;
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:munchspace/core/utils/responsive.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import '../../../../core/theme/app_colors.dart';
import 'add_address_manually_screen.dart';
import 'map_address_screen.dart';

class AddAddressScreen extends StatefulWidget {
  const AddAddressScreen({super.key});

  @override
  State<AddAddressScreen> createState() => _AddAddressScreenState();
}

class _AddAddressScreenState extends State<AddAddressScreen> {
  Future<void> _requestLocationPermission() async {
    log('🔵 Button tapped - _requestLocationPermission called');
    developer.log('Starting location permission request');

    // First check current permission status
    LocationPermission status = await Geolocator.checkPermission();
    developer.log('Current permission status: $status');
    log('📍 Current status: $status');

    if (status == LocationPermission.denied) {
      developer.log('Permission denied, requesting...');
      // Request permission
      status = await Geolocator.requestPermission();
      developer.log('Permission request result: $status');
    }

    if (status == LocationPermission.denied) {
      developer.log('Permission still denied after request');
      if (mounted) {
        showTopSnackBar(
          Overlay.of(context),
          const CustomSnackBar.error(
            message: 'Location permission is required',
          ),
        );
      }
    } else if (status == LocationPermission.deniedForever) {
      developer.log('Permission denied forever');
      if (mounted) {
        if (mounted) {
          showTopSnackBar(
            Overlay.of(context),
            const CustomSnackBar.error(
              message:
                  'Location permission is permanently denied. Please enable it in settings.',
            ),
          );
        }
      }
    } else if (status == LocationPermission.whileInUse ||
        status == LocationPermission.always) {
      developer.log('Permission granted, navigating to map');
      // Permission granted, navigate to map screen
      if (mounted) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const MapAddressScreen()),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            children: [
              // Spacer to center content vertically
              const Spacer(flex: 2),

              // Location Icon
              SvgPicture.asset(
                'assets/svg/address/location_icon.svg',
                width: 64.w,
              ),

              40.sH,

              // Title
              Text(
                'Add your address',
                style: TextStyle(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                ),
              ),

              8.sH,

              // Description
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Text(
                  'Let\'s find MunchSpaces near you. Add your address to see what\'s available around your area.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                    color: AppColors.textSecondary,
                    height: 1.5,
                  ),
                ),
              ),

              24.sH,

              // Use current location button
              OutlinedButton.icon(
                onPressed: _requestLocationPermission,
                icon: SvgPicture.asset(
                  'assets/svg/address/location.svg',
                  width: 20.w,
                  height: 20.h,
                ),
                label: Text(
                  'Use current location',
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppColors.textPrimary,
                  side: const BorderSide(color: AppColors.border),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(999.r),
                  ),
                  padding: EdgeInsets.symmetric(
                    horizontal: 24.w,
                    vertical: 14.h,
                  ),
                  minimumSize: Size(double.infinity, 52.h),
                ),
              ),

              16.sH,

              // Add address manually button
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AddAddressManuallyScreen(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.orange,
                  foregroundColor: AppColors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(999.r),
                  ),
                  padding: EdgeInsets.symmetric(
                    horizontal: 24.w,
                    vertical: 14.h,
                  ),
                  minimumSize: Size(double.infinity, 52.h),
                ),
                child: Text(
                  'Add address manually',
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),

              // Spacer to push content up
              const Spacer(flex: 3),
            ],
          ),
        ),
      ),
    );
  }
}
