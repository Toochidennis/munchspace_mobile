import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:munchspace/core/common_widgets/custom_appbar.dart';
import 'package:munchspace/core/utils/responsive.dart';

import '../../../../core/data/regions/north_central.dart';
import '../../../../core/data/regions/north_east.dart';
import '../../../../core/data/regions/north_west.dart';
import '../../../../core/data/regions/south_east.dart';
import '../../../../core/data/regions/south_south.dart';
import '../../../../core/data/regions/south_west.dart';
import '../../../../core/theme/app_colors.dart';
import 'map_address_screen.dart';

class AddAddressManuallyScreen extends StatefulWidget {
  const AddAddressManuallyScreen({super.key});

  @override
  State<AddAddressManuallyScreen> createState() =>
      _AddAddressManuallyScreenState();
}

class _AddAddressManuallyScreenState extends State<AddAddressManuallyScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<LocationResult> _searchResults = [];
  Map<String, dynamic>? _allLocationsData;

  @override
  void initState() {
    super.initState();
    _loadLocationsData();
    _searchController.addListener(_onSearchChanged);
  }

  void _loadLocationsData() {
    try {
      final regions = <Map<String, dynamic>>[
        southWest,
        southSouth,
        southEast,
        northCentral,
        northWest,
        northEast,
      ];

      setState(() {
        _allLocationsData = {'regions': regions};
      });
    } catch (e) {
      // Silently handle error
    }
  }

  Future<void> _onSearchChanged() async {
    final query = _searchController.text.trim().toLowerCase();
    if (query.isEmpty) {
      setState(() {
        _searchResults = [];
      });
      return;
    }

    await Future.delayed(const Duration(milliseconds: 300));

    final results = await _searchLocations(query);
    setState(() {
      _searchResults = results;
    });
  }

  Future<List<LocationResult>> _searchLocations(String query) async {
    final results = <LocationResult>[];

    if (_allLocationsData == null) {
      return results;
    }

    final regions = _allLocationsData?['regions'] as List?;
    if (regions == null) {
      return results;
    }

    for (var regionData in regions) {
      final regionName = regionData['region'] as String? ?? 'Unknown';
      final states = regionData['states'] as List?;

      if (states != null) {
        for (var state in states) {
          final stateName = state['name'] as String?;
          final lgas = state['lgas'] as List?;

          if (lgas != null) {
            for (var lga in lgas) {
              final lgaName = lga['name'] as String?;
              final cities = lga['cities'] as List?;

              if (cities != null) {
                for (var city in cities) {
                  final cityName = city as String;

                  // Search in city
                  if (cityName.toLowerCase().contains(query)) {
                    results.add(
                      LocationResult(
                        title: cityName,
                        subtitle: lgaName ?? '',
                        fullAddress:
                            '$cityName, $lgaName, ${stateName ?? ''}, Nigeria',
                        state: stateName ?? '',
                        lga: lgaName ?? '',
                        city: cityName,
                      ),
                    );
                  }

                  // Search in LGA
                  if (lgaName != null &&
                      lgaName.toLowerCase().contains(query)) {
                    results.add(
                      LocationResult(
                        title: cityName,
                        subtitle: lgaName,
                        fullAddress:
                            '$cityName, $lgaName, ${stateName ?? ''}, Nigeria',
                        state: stateName ?? '',
                        lga: lgaName,
                        city: cityName,
                      ),
                    );
                  }
                }
              }
            }
          }

          // Search in state
          if (stateName != null && stateName.toLowerCase().contains(query)) {
            results.add(
              LocationResult(
                title: stateName,
                subtitle: regionName,
                fullAddress: '$stateName, Nigeria',
                state: stateName,
                lga: '',
                city: '',
              ),
            );
          }
        }
      }
    }

    log('Found ${results.length} results');

    // Remove duplicates and limit to 10 results
    final uniqueResults = <String, LocationResult>{};
    for (var result in results) {
      final key = '${result.title}_${result.subtitle}_${result.fullAddress}';
      if (!uniqueResults.containsKey(key)) {
        uniqueResults[key] = result;
      }
    }

    return uniqueResults.values.toList().take(10).toList();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: CustomAppbar(title: 'Add your address', backIcon: Icons.close),
      body: Column(
        children: [
          // Search bar section
          Container(
            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
            color: AppColors.background,
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(999.r),
                border: Border.all(color: AppColors.border),
              ),
              child: TextField(
                controller: _searchController,
                style: TextStyle(fontSize: 14.sp, color: AppColors.textPrimary),
                decoration: InputDecoration(
                  hintText: 'Search street, city, district...',
                  hintStyle: TextStyle(
                    fontSize: 14.sp,
                    color: AppColors.textSecondary,
                  ),
                  prefixIcon: Padding(
                    padding: EdgeInsets.all(12.w),
                    child: Icon(
                      Icons.search,
                      color: AppColors.textSecondary,
                      size: 20.w,
                    ),
                  ),
                  suffixIcon: _searchController.text.isNotEmpty
                      ? IconButton(
                          onPressed: () {
                            setState(() {
                              _searchController.clear();
                            });
                          },
                          icon: Icon(
                            Icons.close,
                            color: AppColors.textSecondary,
                            size: 20.w,
                          ),
                        )
                      : null,
                  border: InputBorder.none,
                  filled: false,
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 14.h,
                  ),
                ),
                onChanged: (value) {
                  setState(() {});
                },
              ),
            ),
          ),

          // Use current location option
          InkWell(
            onTap: () async {
              final result = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const MapAddressScreen(),
                ),
              );
              if (result != null) {
                if (!context.mounted) return;
                Navigator.pop(context, result);
              }
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
              color: AppColors.background,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'Use current location',
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      color: AppColors.orange,
                      decoration: TextDecoration.underline,
                      decorationColor: AppColors.orange,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Content area - search results
          Expanded(
            child: _searchController.text.isEmpty
                ? const SizedBox.shrink()
                : _searchResults.isEmpty
                ? GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const MapAddressScreen(),
                        ),
                      );
                    },
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 24.w,
                        vertical: 16.h,
                      ),
                      child: Align(
                        alignment: Alignment.topCenter,
                        child: Container(
                          decoration: BoxDecoration(
                            color: AppColors.red100,
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          padding: EdgeInsets.symmetric(
                            horizontal: 16.w,
                            vertical: 16.h,
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Expanded(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Can\'t find your Address?',
                                      style: TextStyle(
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w400,
                                        color: AppColors.textPrimary,
                                      ),
                                    ),
                                    8.sH,
                                    Text(
                                      'Use the map instead',
                                      style: TextStyle(
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w600,
                                        color: AppColors.orange,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              16.sW,
                              SizedBox(
                                width: 32.sp,
                                height: 32.sp,
                                child: SvgPicture.asset(
                                  'assets/svg/address/map.svg',
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
                : ListView.separated(
                    padding: EdgeInsets.symmetric(vertical: 8.h),
                    itemCount: _searchResults.length,
                    separatorBuilder: (context, index) =>
                        const Divider(height: 1, color: AppColors.border),
                    itemBuilder: (context, index) {
                      final result = _searchResults[index];
                      return ListTile(
                        title: Text(
                          result.title,
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        subtitle: Text(
                          result.subtitle,
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: AppColors.textSecondary,
                          ),
                        ),
                        onTap: () {
                          Navigator.pop(context, {
                            'address': result.fullAddress,
                            'latitude': 6.5244, // Mock lat
                            'longitude': 3.3792, // Mock long
                          });
                        },
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}

class LocationResult {
  final String title;
  final String subtitle;
  final String fullAddress;
  final String state;
  final String lga;
  final String city;

  LocationResult({
    required this.title,
    required this.subtitle,
    required this.fullAddress,
    required this.state,
    required this.lga,
    required this.city,
  });
}
