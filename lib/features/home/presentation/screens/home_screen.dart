import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:munchspace/core/utils/number_extensions.dart';
import 'package:munchspace/features/home/models/restaurant.dart';
import 'package:munchspace/features/home/presentation/screens/nearby_munchspaces_screen.dart';
import 'package:munchspace/features/home/presentation/screens/restaurant_detail_screen.dart';
import 'package:munchspace/features/home/presentation/screens/search_screen.dart';
import 'package:munchspace/features/home/presentation/widgets/category.dart';
import 'package:munchspace/features/orders/presentation/screens/orders_screen.dart';
import 'package:munchspace/features/profile/presentation/screens/profile_screen.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/responsive.dart';
import '../../../address/presentation/screens/add_address_screen.dart';
import '../../../notification/presentation/screens/notification_screen.dart';
import '../../models/food_tile.dart';

/// Home screen for food delivery app
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedBottomIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedBottomIndex,
        children: [
          // Home tab
          SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // Header with location, delivery fee, and time
                  _buildHeader(),
                  20.sH,
                  // Categories
                  _buildCategories(),
                  20.sH,
                  // "Explore nearby MunchSpaces" section
                  _buildSectionHeader(
                    'Explore nearby MunchSpaces',
                    page: const NearbyMunchspacesScreen(),
                  ),
                  12.sH,
                  _buildExploreMunchSpaces(),
                  20.sH,
                  // "Handpicked for you" section
                  _buildSectionHeader(
                    'Handpicked for you',
                    page: const NearbyMunchspacesScreen(),
                  ),
                  12.sH,
                  _buildFeaturedFoods(),
                  20.sH,
                  _buildSectionHeader(
                    'Sweet Sensation - Ogba',
                    page: const NearbyMunchspacesScreen(),
                  ),
                  12.sH,
                  _buildSweetSensation(),
                  20.sH,
                  _buildSectionHeader(
                    'Oven Pick-up - Abule egba',
                    page: const NearbyMunchspacesScreen(),
                  ),
                  12.sH,
                  _buildOvenPickup(),
                  20.sH,
                ],
              ),
            ),
          ),
          // Search tab
          SearchScreen(
            onBackPressed: () => setState(() => _selectedBottomIndex = 0),
          ),
          // Orders tab
          OrdersScreen(
            onBackPressed: () => setState(() => _selectedBottomIndex = 0),
          ),
          // Profile tab
          ProfileScreen(
            onBackPressed: () => setState(() => _selectedBottomIndex = 0),
          ),
        ],
      ),
      bottomNavigationBar: _buildBottomNavBar(),
    );
  }

  /// Header with location, delivery info, and discounts
  Widget _buildHeader() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Avatar and location row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Avatar
              Container(
                width: 44.w,
                height: 44.h,
                decoration: BoxDecoration(
                  color: AppColors.red100,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: SvgPicture.asset(
                    'assets/svg/home/avatar.svg',
                    width: 24.w,
                    height: 24.h,
                  ),
                ),
              ),
              // Location dropdown
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AddAddressScreen(),
                    ),
                  );
                },
                child: Container(
                  color: Colors.transparent,
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        'assets/svg/home/location.svg',
                        width: 16.w,
                        height: 16.h,
                      ),
                      6.sW,
                      Text(
                        'Ifako-Ijaye,...',
                        style: TextStyle(
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w500,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      4.sW,
                      Icon(
                        Icons.expand_more,
                        size: 18.sp,
                        color: AppColors.textSecondary,
                      ),
                    ],
                  ),
                ),
              ),
              // Notification badge
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const NotificationScreen(),
                    ),
                  );
                },
                child: Stack(
                  children: [
                    Container(
                      width: 40.w,
                      height: 40.h,
                      decoration: BoxDecoration(
                        color: AppColors.red100,
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: SvgPicture.asset(
                          'assets/svg/home/notification.svg',
                          width: 20.w,
                          height: 20.h,
                        ),
                      ),
                    ),
                    Positioned(
                      top: 4.h,
                      right: 4.w,
                      child: Container(
                        width: 16.w,
                        height: 16.h,
                        decoration: const BoxDecoration(
                          color: AppColors.red,
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Text(
                            '3',
                            style: TextStyle(
                              fontSize: 9.sp,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          20.sH,
          // Info chips row - horizontal scrollable
          SizedBox(
            height: 36.h,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                _buildHeaderChip('Delivery fee', isDropdown: true),
                8.sW,
                _buildHeaderChip('Under 30 mins'),
                8.sW,
                _buildHeaderChip('Discounts'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Header chip widget
  Widget _buildHeaderChip(String title, {bool isDropdown = false}) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(99.r),
      ),
      child: Row(
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 14.sp,
              color: AppColors.textSecondary,
              fontWeight: FontWeight.w500,
            ),
          ),
          8.sW,
          if (isDropdown)
            Icon(
              Icons.expand_more,
              size: 16.sp,
              color: AppColors.textSecondary,
            ),
        ],
      ),
    );
  }

  /// Category pills
  Widget _buildCategories() {
    final categories = [
      Category(
        name: 'MunchSpaces',
        image: 'assets/images/home/munchspaces.png',
        color: Color(0xFFEF2424),
      ),
      Category(
        name: 'Shops',
        image: 'assets/images/home/shops.png',
        color: Color(0xFF4624EF),
      ),
      Category(
        name: 'Pharmacies',
        image: 'assets/images/home/pharmacies.png',
        color: Color(0xFF3FEF24),
      ),
      Category(
        name: 'Local Markets',
        image: 'assets/images/home/local_markets.png',
        color: Color(0xFFEF24BC),
      ),
    ];

    return SizedBox(
      height: 120.h,
      child: ListView.separated(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        separatorBuilder: (_, _) => 12.sW,
        itemBuilder: (context, index) {
          return categories[index];
        },
      ),
    );
  }

  /// Section header with "See all" link
  Widget _buildSectionHeader(String title, {required Widget page}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w700,
              color: AppColors.textPrimary,
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => page),
              );
            },
            child: Container(
              height: 30.sp,
              width: 30.sp,
              decoration: BoxDecoration(
                color: AppColors.black.withOpacity(.04),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.arrow_forward,
                size: 16.sp,
                color: AppColors.textSecondary,
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Restaurant grid
  Widget _buildExploreMunchSpaces() {
    final restaurants = [
      Restaurant(
        name: 'Burger King - Ikeja',
        image: 'assets/images/home/burger_king.png',
      ),
      Restaurant(
        name: 'Chicken Republic - Ogba',
        image: 'assets/images/home/chicken_republic.png',
      ),
      Restaurant(
        name: 'Dodo Pizza - Ikeja',
        image: 'assets/images/home/dodo_pizza.jpg',
      ),
      Restaurant(name: 'KFC - Ikeja', image: 'assets/images/home/kfc.png'),
    ];

    return SizedBox(
      height: 130.h,
      child: ListView.separated(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        scrollDirection: Axis.horizontal,
        itemCount: restaurants.length,
        separatorBuilder: (_, _) => 16.sW,
        itemBuilder: (context, index) {
          return _buildRestaurantCard(restaurants[index]);
        },
      ),
    );
  }

  /// Restaurant card with image
  Widget _buildRestaurantCard(Restaurant restaurant) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                RestaurantDetailScreen(restaurant: restaurant),
          ),
        );
      },
      child: SizedBox(
        width: 90.w,
        child: Column(
          children: [
            CircleAvatar(
              radius: 32.sp,
              backgroundImage: AssetImage(restaurant.image),
            ),
            10.sH,
            Text(
              restaurant.name,
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSweetSensation() {
    final foods = [
      FoodTile(
        name: 'Ono Hawaiian BBQ - Ijora',
        image: 'assets/images/home/sweet_sensation_0.jpg',
        deliveryTime: "30-50 mins",
        rating: 4.7,
        price: 4000,
      ),
      FoodTile(
        name: 'Ono Hawaiian BBQ - Ijora',
        image: 'assets/images/home/sweet_sensation_1.jpg',
        deliveryTime: "30-50 mins",
        rating: 4.7,
        price: 4000,
      ),
    ];

    return SizedBox(
      height: 210.h,
      child: ListView.separated(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        scrollDirection: Axis.horizontal,
        itemCount: foods.length,
        separatorBuilder: (_, _) => 20.sW,
        itemBuilder: (context, index) {
          return _buildFoodCard(foods[index], width: 190);
        },
      ),
    );
  }

  Widget _buildOvenPickup() {
    final foods = [
      FoodTile(
        name: 'Ono Hawaiian BBQ - Ijora',
        image: 'assets/images/home/oven_pickup_0.jpg',
        deliveryTime: "30-50 mins",
        rating: 4.7,
        price: 4000,
      ),
      FoodTile(
        name: 'Ono Hawaiian BBQ - Ijora',
        image: 'assets/images/home/oven_pickup_1.jpg',
        deliveryTime: "30-50 mins",
        rating: 4.7,
        price: 4000,
      ),
    ];

    return SizedBox(
      height: 210.h,
      child: ListView.separated(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        scrollDirection: Axis.horizontal,
        itemCount: foods.length,
        separatorBuilder: (_, _) => 20.sW,
        itemBuilder: (context, index) {
          return _buildFoodCard(foods[index], width: 190);
        },
      ),
    );
  }

  /// Featured foods section
  Widget _buildFeaturedFoods() {
    final foods = [
      FoodTile(
        name: 'Ono Hawaiian BBQ - Ijora',
        image: 'assets/images/home/handpicked_0.jpg',
        deliveryTime: "30-50 mins",
        rating: 4.7,
        price: 4000,
        discount: 40,
        showAddBtn: false,
      ),
      FoodTile(
        name: 'Ono Hawaiian BBQ - Ijora',
        image: 'assets/images/home/handpicked_1.jpg',
        deliveryTime: "30-50 mins",
        rating: 4.7,
        price: 4000,
        showAddBtn: false,
      ),
    ];

    return SizedBox(
      height: 210.h,
      child: ListView.separated(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        scrollDirection: Axis.horizontal,
        itemCount: foods.length,
        separatorBuilder: (_, _) => 20.sW,
        itemBuilder: (context, index) {
          return _buildFoodCard(foods[index]);
        },
      ),
    );
  }

  /// Food card
  Widget _buildFoodCard(FoodTile food, {int width = 250}) {
    return SizedBox(
      height: 210.h,
      width: width.w,
      child: Column(
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12.r),
                child: Image.asset(
                  food.image,
                  width: 250.w,
                  height: 120.h,
                  fit: BoxFit.cover,
                ),
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
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
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
            children: [
              Text(
                food.price.toCurrency(),
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ).withCurrencyFont,
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

  /// Bottom navigation bar
  Widget _buildBottomNavBar() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: AppColors.border, width: 1)),
      ),
      child: BottomNavigationBar(
        currentIndex: _selectedBottomIndex,
        onTap: (index) => setState(() => _selectedBottomIndex = index),
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        selectedItemColor: AppColors.orange,
        unselectedItemColor: AppColors.textSecondary,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        items: [
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/svg/nav_bar/home.svg',
              width: 18.sp,
              height: 18.sp,
              colorFilter: ColorFilter.mode(
                _selectedBottomIndex == 0
                    ? AppColors.orange
                    : AppColors.textSecondary,
                BlendMode.srcIn,
              ),
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/svg/nav_bar/search.svg',
              width: 18.sp,
              height: 18.sp,
              colorFilter: ColorFilter.mode(
                _selectedBottomIndex == 1
                    ? AppColors.orange
                    : AppColors.textSecondary,
                BlendMode.srcIn,
              ),
            ),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/svg/nav_bar/orders.svg',
              width: 18.sp,
              height: 18.sp,
              colorFilter: ColorFilter.mode(
                _selectedBottomIndex == 2
                    ? AppColors.orange
                    : AppColors.textSecondary,
                BlendMode.srcIn,
              ),
            ),
            label: 'Orders',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/svg/nav_bar/profile.svg',
              width: 18.sp,
              height: 18.sp,
              colorFilter: ColorFilter.mode(
                _selectedBottomIndex == 3
                    ? AppColors.orange
                    : AppColors.textSecondary,
                BlendMode.srcIn,
              ),
            ),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
