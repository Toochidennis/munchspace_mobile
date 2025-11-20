import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:iconly/iconly.dart';
import 'package:munchspace/core/common_widgets/custom_appbar.dart';
import 'package:munchspace/core/utils/number_extensions.dart';
import 'package:munchspace/core/utils/responsive.dart';
import 'package:munchspace/features/home/models/addon.dart';
import 'package:munchspace/features/home/models/food.dart';
import 'package:munchspace/features/home/models/restaurant.dart';

import '../../../../core/theme/app_colors.dart';
import 'food_detail_screen.dart';
import 'search_screen.dart';

/// Restaurant detail screen - shown when tapping on a specific restaurant (KFC, Burger King, etc.)
class RestaurantDetailScreen extends StatefulWidget {
  final Restaurant restaurant;

  const RestaurantDetailScreen({super.key, required this.restaurant});

  @override
  State<RestaurantDetailScreen> createState() => _RestaurantDetailScreenState();
}

class _RestaurantDetailScreenState extends State<RestaurantDetailScreen> {
  String _selectedCategory = 'All';
  final List<String> _categories = ['All', 'Meal', 'Drinks'];

  @override
  Widget build(BuildContext context) {
    final List<Food> foodItems = [
      Food(
        name: 'Jollof rice and Chicken',
        description: 'Roundabout, Liver, Floater, etc.',
        image: 'assets/images/home/handpicked_0.jpg',
        price: 4000,
        rating: 4.7,
        extras: [
          Addon(name: 'Extra portion of rice', price: 1000),
          Addon(name: 'Extra Chicken', price: 1700),
          Addon(name: 'Plantain', price: 700),
          Addon(name: 'Coleslaw', price: 800),
        ],
        drinks: [
          Addon(name: 'Fanta', price: 700),
          Addon(name: 'Coke', price: 700),
          Addon(name: 'Bottle Water', price: 700),
        ],
      ),
      Food(
        name: 'Jollof rice and Chicken',
        description: 'Roundabout, Liver, Floater, etc.',
        image: 'assets/images/home/handpicked_1.jpg',
        price: 4000,
        rating: 4.7,
      ),
      Food(
        name: 'Jollof rice and Chicken',
        description: 'Roundabout, Liver, Floater, etc.',
        image: 'assets/images/home/handpicked_2.jpg',
        price: 4000,
        rating: 4.7,
      ),
      Food(
        name: 'Jollof rice and Chicken',
        description: 'Roundabout, Liver, Floater, etc.',
        image: 'assets/images/home/handpicked_3.jpg',
        price: 4000,
        rating: 4.7,
      ),
      Food(
        name: 'Jollof rice and Chicken',
        description: 'Roundabout, Liver, Floater, etc.',
        image: 'assets/images/home/handpicked_0.jpg',
        price: 4000,
        rating: 4.7,
      ),
      Food(
        name: 'Jollof rice and Chicken',
        description: 'Roundabout, Liver, Floater, etc.',
        image: 'assets/images/home/handpicked_1.jpg',
        price: 4000,
        rating: 4.7,
      ),
    ];

    return Scaffold(
      appBar: CustomAppbar(
        title: widget.restaurant.name,
        rightAction: GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const SearchScreen(),
              ),
            );
          },
          child: Container(
            width: 40.w,
            height: 40.h,
            decoration: BoxDecoration(
              color: AppColors.red100,
              shape: BoxShape.circle,
            ),
            child: Icon(
              IconlyLight.search,
              color: AppColors.black,
              size: 20.sp,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Restaurant info section
            Padding(
              padding: 16.padAll,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Rating and info
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          SvgPicture.asset(
                            'assets/svg/home/star.svg',
                            width: 12.sp,
                          ),
                          4.sW,
                          Text(
                            '4.7 (4,500 orders)',
                            style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w400,
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        'Opens until 08:00 PM',
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                  8.sH,
                  // Delivery info
                  Row(
                    children: [
                      Text(
                        '17-25 min prep time · ',
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textSecondary,
                        ),
                      ),
                      Text(
                        '₦850 delivery fee',
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textSecondary,
                        ).withCurrencyFont,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // Category tabs
            SizedBox(
              height: 36.h,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: _categories.length,
                separatorBuilder: (_, _) => 8.sW,
                padding: 16.padH,
                itemBuilder: (context, index) {
                  final category = _categories[index];
                  final isSelected = _selectedCategory == category;
                  return GestureDetector(
                    onTap: () {
                      setState(() => _selectedCategory = category);
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 16.w,
                        vertical: 8.h,
                      ),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? AppColors.orange
                            : AppColors.surface,
                        borderRadius: BorderRadius.circular(20.r),
                      ),
                      child: Text(
                        category,
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                          color: isSelected
                              ? Colors.white
                              : AppColors.textPrimary,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            16.sH,
            // Food items list
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
              child: Column(
                children: List.generate(
                  foodItems.length,
                  (index) => Padding(
                    padding: EdgeInsets.only(bottom: 24.h),
                    child: _buildFoodItemCard(foodItems[index]),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Build food item card
  Widget _buildFoodItemCard(Food item) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => FoodDetailScreen(food: item)),
        );
      },
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Food details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.name,
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
                ),
                6.sH,
                Text(
                  item.description,
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400,
                    color: AppColors.textSecondary,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                6.sH,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      item.price.toCurrency(),
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w700,
                        color: AppColors.textPrimary,
                      ).withCurrencyFont,
                    ),
                    Row(
                      children: [
                        SvgPicture.asset(
                          'assets/svg/home/star.svg',
                          width: 12.sp,
                        ),
                        2.sW,
                        Text(
                          item.rating.toString(),
                          style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w600,
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          12.sW,
          // Food image with add button
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8.r),
                child: Image.asset(
                  item.image,
                  width: 164.5.w,
                  height: 94.h,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                bottom: 4.h,
                right: 4.w,
                child: Container(
                  width: 40.sp,
                  height: 40.sp,
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Icons.add, color: Colors.black, size: 20.sp),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
