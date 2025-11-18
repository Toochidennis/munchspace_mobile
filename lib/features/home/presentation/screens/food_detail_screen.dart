import 'package:flutter/material.dart';
import 'package:munchspace/core/utils/number_extensions.dart';
import 'package:munchspace/core/utils/responsive.dart';
import 'package:munchspace/features/home/models/addon.dart';
import 'package:munchspace/features/home/models/food.dart';
import 'package:munchspace/features/home/presentation/widgets/food_detail_widgets.dart';

import '../../../../core/theme/app_colors.dart';

/// Food detail screen - shown when tapping on a food item
class FoodDetailScreen extends StatefulWidget {
  final Food food;

  const FoodDetailScreen({super.key, required this.food});

  @override
  State<FoodDetailScreen> createState() => _FoodDetailScreenState();
}

class _FoodDetailScreenState extends State<FoodDetailScreen> {
  int _quantity = 1;
  late List<Addon> _extras;
  late List<Addon> _drinks;

  @override
  void initState() {
    super.initState();
    // Make local mutable copies so we can toggle `selected` without modifying the original Food
    _extras = widget.food.extras
        .map((e) => Addon(name: e.name, price: e.price, selected: e.selected))
        .toList();
    _drinks = widget.food.drinks
        .map((d) => Addon(name: d.name, price: d.price, selected: d.selected))
        .toList();
  }

  int _getSelectedExtrasPrice() {
    return _extras
        .where((e) => e.selected)
        .fold(0, (sum, e) => sum + e.price * e.quantity);
  }

  int _getSelectedDrinksPrice() {
    return _drinks
        .where((d) => d.selected)
        .fold(0, (sum, d) => sum + d.price * d.quantity);
  }

  int _getTotalPrice() {
    final basePrice = widget.food.price * _quantity;
    final extrasPrice = _getSelectedExtrasPrice();
    final drinksPrice = _getSelectedDrinksPrice();
    return basePrice + extrasPrice + drinksPrice;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top image with close button overlapping
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(12.r),
                    bottomRight: Radius.circular(12.r),
                  ),
                  child: Image.asset(
                    widget.food.image,
                    width: double.infinity,
                    height: 160.h,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  top: 12.h,
                  right: 12.w,
                  child: GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      width: 36.w,
                      height: 36.h,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.close,
                        size: 18.sp,
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            // Card-like content container (overlaps image a bit)
            Transform.translate(
              offset: Offset(0, -20.h),
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12.r),
                    topRight: Radius.circular(12.r),
                  ),
                ),
                child: Padding(
                  padding: 16.padH + 18.padT,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Food name
                      Text(
                        widget.food.name,
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      4.sH,
                      // Food description
                      Text(
                        widget.food.description,
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w400,
                          color: AppColors.textSecondary,
                        ),
                      ),
                      8.sH,
                      // Price
                      Container(
                        width: 79.w,
                        height: 30.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(999.r),
                          color: AppColors.red50,
                        ),
                        child: Center(
                          child: Text(
                            widget.food.price.toCurrency(),
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                              color: AppColors.orange,
                            ).withCurrencyFont,
                          ),
                        ),
                      ),
                      20.sH,
                      // Divider
                      DividerLine(),
                    ],
                  ),
                ),
              ),
            ),
            // Extras/Add-ons section
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SectionHeader(
                    title: 'Extras / Add-ons',
                    badgeLabel: 'Optional',
                  ),
                  12.sH,
                  ..._extras.asMap().entries.map((entry) {
                    final extra = entry.value;
                    return Column(
                      children: [
                        AddonItemRow(
                          addon: extra,
                          onCheckboxChange: () {
                            setState(() {
                              extra.selected = !extra.selected;
                            });
                          },
                          onDecrement: () {
                            if (extra.quantity > 1) {
                              setState(() => extra.quantity--);
                            }
                          },
                          onIncrement: () {
                            setState(() => extra.quantity++);
                          },
                          showStepper: true,
                          enableStepper: true,
                        ),
                        if (entry.key < _extras.length - 1) 8.sH,
                      ],
                    );
                  }),
                  20.sH,
                  // Divider
                  DividerLine(),
                  20.sH,
                ],
              ),
            ),
            // Drinks section
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SectionHeader(title: 'Drinks', badgeLabel: 'Optional'),
                  12.sH,
                  ..._drinks.asMap().entries.map((entry) {
                    final drink = entry.value;
                    return Column(
                      children: [
                        AddonItemRow(
                          addon: drink,
                          onCheckboxChange: () {
                            setState(() {
                              drink.selected = !drink.selected;
                            });
                          },
                          showStepper: false,
                        ),
                        if (entry.key < _drinks.length - 1) 8.sH,
                      ],
                    );
                  }),
                  20.sH,
                  // Divider
                  DividerLine(),
                  20.sH,
                ],
              ),
            ),
            // Quantity section
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Quantity',
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  12.sH,
                  SimpleQuantityStepper(
                    quantity: _quantity,
                    onDecrement: () => setState(() => _quantity--),
                    onIncrement: () => setState(() => _quantity++),
                  ),
                  24.sH,
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(16.w),
        child: GestureDetector(
          onTap: () {
            // Handle add to cart
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  'Added ${_quantity}x ${widget.food.name} to cart',
                ),
                duration: const Duration(seconds: 2),
              ),
            );
          },
          child: Container(
            height: 48.h,
            decoration: BoxDecoration(
              color: AppColors.orange,
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Center(
              child: Text(
                'Add to cart · ${_getTotalPrice().toCurrency()}',
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ).withCurrencyFont,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
