import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:munchspace/core/common_widgets/custom_appbar.dart';
import 'package:munchspace/core/utils/responsive.dart';

import '../../../../core/theme/app_colors.dart';

class MapAddressScreen extends StatefulWidget {
  const MapAddressScreen({super.key});

  @override
  State<MapAddressScreen> createState() => _MapAddressScreenState();
}

class _MapAddressScreenState extends State<MapAddressScreen> {
  GoogleMapController? mapController;
  LatLng? selectedLocation;
  String? selectedAddress;
  bool isLoading = true;
  String? errorMessage;

  LatLng _initialLocation = const LatLng(6.5244, 3.3792); // Default: Lagos

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
    // Add a timeout to prevent indefinite loading
    Future.delayed(const Duration(seconds: 15), () {
      if (mounted && isLoading) {
        setState(() {
          isLoading = false;
          errorMessage = 'Map loading timed out. Please try again.';
        });
      }
    });
  }

  @override
  void dispose() {
    if (mapController != null) {
      mapController!.dispose();
    }
    super.dispose();
  }

  Future<void> _getCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      setState(() {
        _initialLocation = LatLng(position.latitude, position.longitude);
        selectedLocation = _initialLocation;
        selectedAddress =
            '${position.latitude.toStringAsFixed(4)}, ${position.longitude.toStringAsFixed(4)}';
        isLoading = false;
      });

      // Move camera to user's location
      if (mounted && mapController != null) {
        mapController!.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(target: _initialLocation, zoom: 15),
          ),
        );
      }
    } catch (e) {
      setState(() {
        errorMessage = 'Could not get your location: $e';
        isLoading = false;
      });
    }
  }

  void _onMapCreated(GoogleMapController controller) {
    log('✅ Google Map Created Successfully');
    mapController = controller;
  }

  void _onMapTapped(LatLng location) {
    setState(() {
      selectedLocation = location;
      selectedAddress =
          '${location.latitude.toStringAsFixed(4)}, ${location.longitude.toStringAsFixed(4)}';
    });
  }

  void _useThisLocation() {
    if (selectedLocation != null) {
      Navigator.pop(context, {
        'latitude': selectedLocation!.latitude,
        'longitude': selectedLocation!.longitude,
        'address': selectedAddress,
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: CustomAppbar(
        title: 'Select Location',
      ),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(AppColors.orange),
              ),
            )
          : errorMessage != null
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.location_off,
                    size: 48.sp,
                    color: AppColors.red100,
                  ),
                  16.sH,
                  Text(
                    'Location Error',
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  8.sH,
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24.w),
                    child: Text(
                      errorMessage!,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ),
                ],
              ),
            )
          : Stack(
              children: [
                GoogleMap(
                  onMapCreated: _onMapCreated,
                  initialCameraPosition: CameraPosition(
                    target: _initialLocation,
                    zoom: 15,
                  ),
                  onTap: _onMapTapped,
                  myLocationEnabled: true,
                  myLocationButtonEnabled: true,
                  markers: selectedLocation != null
                      ? {
                          Marker(
                            markerId: const MarkerId('selected'),
                            position: selectedLocation!,
                            infoWindow: InfoWindow(
                              title: 'Selected Location',
                              snippet: selectedAddress,
                            ),
                          ),
                        }
                      : {},
                ),
                // Center crosshair
                Center(
                  child: Icon(
                    Icons.location_on,
                    color: AppColors.orange,
                    size: 32.sp,
                  ),
                ),
                // Bottom sheet with confirmation
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(24.r),
                        topRight: Radius.circular(24.r),
                      ),
                    ),
                    padding: EdgeInsets.all(24.w),
                    child: SafeArea(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Location Details',
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                              color: AppColors.textPrimary,
                            ),
                          ),
                          12.sH,
                          Container(
                            padding: EdgeInsets.all(12.w),
                            decoration: BoxDecoration(
                              color: AppColors.red100,
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                            child: Text(
                              selectedAddress ?? 'No location selected',
                              style: TextStyle(
                                fontSize: 14.sp,
                                color: AppColors.textPrimary,
                              ),
                            ),
                          ),
                          24.sH,
                          SizedBox(
                            width: double.infinity,
                            height: 52.h,
                            child: ElevatedButton(
                              onPressed: _useThisLocation,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.orange,
                                foregroundColor: AppColors.white,
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(999.r),
                                ),
                              ),
                              child: Text(
                                'Use this location',
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
