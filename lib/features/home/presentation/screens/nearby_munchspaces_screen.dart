import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:munchspace/core/utils/responsive.dart';
import 'package:munchspace/features/home/models/food_tile.dart';

import '../../../../core/theme/app_colors.dart';

/// Detailed foods screen for Explore nearby MunchSpaces
class NearbyMunchspacesScreen extends StatefulWidget {
  const NearbyMunchspacesScreen({super.key});

  @override
  State<NearbyMunchspacesScreen> createState() =>
      _NearbyMunchspacesScreenState();
}

class _NearbyMunchspacesScreenState extends State<NearbyMunchspacesScreen> {
  @override
  Widget build(BuildContext context) {
    List foodTiles = [
      FoodTile(
        name: 'Ono Hawaiian BBQ - Ijora',
        image: 'assets/images/home/handpicked_0.jpg',
        deliveryTime: "30-50 mins",
        rating: 4.7,
        price: 4000,
        discount: 10,
        showAddBtn: false,
      ),
      FoodTile(
        name: 'Ono Hawaiian BBQ - Ijora',
        image: 'assets/images/home/handpicked_1.jpg',
        deliveryTime: "30-50 mins",
        rating: 4.7,
        price: 4000,
        discount: 40,
        showAddBtn: false,
      ),
      FoodTile(
        name: 'Ono Hawaiian BBQ - Ijora',
        image: 'assets/images/home/handpicked_2.jpg',
        deliveryTime: "30-50 mins",
        rating: 4.7,
        price: 4000,
        showAddBtn: false,
      ),
      FoodTile(
        name: 'Ono Hawaiian BBQ - Ijora',
        image: 'assets/images/home/handpicked_3.jpg',
        deliveryTime: "30-50 mins",
        rating: 4.7,
        price: 4000,
        isPreorder: true,
        showAddBtn: false,
      ),
    ];
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            // App bar with back button and title
            SliverAppBar(
              pinned: true,
              elevation: 0,
              backgroundColor: Colors.white,
              leading: GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Container(
                  width: 40.sp,
                  height: 40.sp,
                  margin: 8.padAll,
                  decoration: BoxDecoration(
                    color:  AppColors.red100,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.arrow_back,
                    color: AppColors.textPrimary,
                    size: 20.sp,
                  ),
                ),
              ),
              title: Text(
                'Nearby MunchSpaces',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                ),
              ),
              centerTitle: false,
            ),
            // Foods list
            SliverPadding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate((context, index) {
                  return Padding(
                    padding: EdgeInsets.only(bottom: 16.h),
                    child: _buildFoodItem(foodTiles[index]),
                  );
                }, childCount: foodTiles.length),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Build individual food item
  Widget _buildFoodItem(FoodTile food) {
    return SizedBox(
      height: 210.h,
      width: double.infinity,
      child: Column(
        children: [
          Stack(
            children: [
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12.r),
                    child: Image.asset(
                      food.image,
                      width: double.infinity,
                      height: 150.h,
                      fit: BoxFit.cover,
                    ),
                  ),
                  if (food.isPreorder)
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12.r),
                      child: Container(
                        width: double.infinity,
                        height: 150.h,
                        color: AppColors.black.withOpacity(0.6),
                      ),
                    ),
                ],
              ),
              if (food.discount != null)
                Positioned(
                  top: 12.h,
                  right: 12.w,
                  child: Container(
                    width: 142.w,
                    height: 32.h,
                    decoration: BoxDecoration(
                      color: AppColors.red100,
                      borderRadius: BorderRadius.circular(999.r),
                    ),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset("assets/svg/home/discount.svg"),
                          7.5.sW,
                          Text(
                            "Up to ${food.discount}% off",
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                              color: AppColors.orange,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              if (food.isPreorder)
                Positioned(
                  top: 12.h,
                  right: 12.w,
                  child: Container(
                    // width: 142.w,
                    // height: 32.h,
                    padding: 14.padH + 8.padV,
                    decoration: BoxDecoration(
                      color: AppColors.red100,
                      borderRadius: BorderRadius.circular(999.r),
                    ),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset("assets/svg/home/preorder.svg"),
                          7.5.sW,
                          Text(
                            "Pre-order",
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                              color: AppColors.orange,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

              if (food.isPreorder)
                Positioned(
                  bottom: 12.h,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: Text(
                      "Closed now · Opens Mon 9:00 AM",
                      style: TextStyle(color: AppColors.white, fontSize: 14.sp),
                    ),
                  ),
                ),

              if (food.showAddBtn)
                Positioned(
                  bottom: 8.h,
                  right: 8.w,
                  child: Container(
                    height: 30.sp,
                    width: 30.sp,
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(Icons.add, color: AppColors.black, size: 20.sp),
                  ),
                ),
            ],
          ),
          12.sH,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                food.name,
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
              Icon(
                Icons.favorite_outline,
                size: 18.sp,
                color: AppColors.textSecondary,
              ),
            ],
          ),
          6.sH,

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text(
                    food.deliveryTime,
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: AppColors.textSecondary,
                    ),
                  ),
                  8.sW,
                  SvgPicture.asset(
                    'assets/svg/home/fast_delivery.svg',
                    width: 20.sp,
                  ),
                ],
              ),
              Row(
                children: [
                  SvgPicture.asset('assets/svg/home/star.svg', width: 14.sp),
                  4.sW,
                  Text(
                    food.rating.toString(),
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
