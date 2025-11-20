import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:munchspace/core/common_widgets/custom_appbar.dart';
import 'package:munchspace/core/theme/app_colors.dart';
import 'package:munchspace/core/utils/number_extensions.dart';
import 'package:munchspace/core/utils/responsive.dart';
import 'package:munchspace/features/orders/models/cart.dart';

class CheckoutScreen extends StatefulWidget {
  final List<CartRestaurant> cartRestaurants;

  const CheckoutScreen({super.key, required this.cartRestaurants});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  // Dummy Add-ons data
  final List<Map<String, dynamic>> addOns = [
    {
      'name': 'Chilled Zobo',
      'price': 300,
      'image':
          'assets/images/home/handpicked_0.jpg', // Using existing asset as placeholder
    },
    {
      'name': 'Pet Coca-cola',
      'price': 600,
      'image': 'assets/images/home/handpicked_0.jpg',
    },
    {
      'name': 'Bottle Water',
      'price': 300,
      'image': 'assets/images/home/handpicked_0.jpg',
    },
  ];

  int _currentStep = 1;
  String _selectedPaymentMethod = 'Card';

  final List<Map<String, dynamic>> _paymentMethods = [
    {'name': 'Card', 'icon': 'assets/images/orders/card.png'},
    {'name': 'Bank Transfer', 'icon': 'assets/images/orders/bank.png'},
    {'name': 'Cash on Delivery', 'icon': 'assets/images/orders/money.png'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: CustomAppbar(
        title: 'Checkout',
        onBackPressed: () {
          if (_currentStep == 2) {
            setState(() => _currentStep = 1);
          } else {
            Navigator.pop(context);
          }
        },
      ),
      body: Column(
        children: [
          // Progress Bar
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    height: 8.h,
                    decoration: BoxDecoration(
                      color: AppColors.orange,
                      borderRadius: 999.radius,
                    ),
                  ),
                ),
                8.sW,
                Expanded(
                  child: Container(
                    height: 8.h,
                    decoration: BoxDecoration(
                      color: _currentStep == 2
                          ? AppColors.orange
                          : AppColors.orange.withOpacity(0.2),
                      borderRadius: 999.radius,
                    ),
                  ),
                ),
                12.sW,
                Text(
                  '$_currentStep/2',
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),

          // Content
          Expanded(child: _currentStep == 1 ? _buildStep1() : _buildStep2()),

          // Footer
          Container(
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: AppColors.white,
              border: Border(
                top: BorderSide(color: AppColors.border, width: 1),
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                GestureDetector(
                  onTap: () {
                    if (_currentStep == 1) {
                      setState(() => _currentStep = 2);
                    } else {
                      // Place Order
                    }
                  },
                  child: Container(
                    width: double.infinity,
                    height: 52.h,
                    decoration: BoxDecoration(
                      color: AppColors.orange,
                      borderRadius: 30.radius,
                    ),
                    child: Center(
                      child: Text(
                        _currentStep == 1
                            ? 'Procced to Payment'
                            : 'Place Order',
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                          color: AppColors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                16.sH,
                Text.rich(
                  TextSpan(
                    text:
                        'By Continuing, it means you have read and accept our\n',
                    style: TextStyle(
                      fontSize: 10.sp,
                      color: AppColors.textSecondary,
                      height: 1.5,
                    ),
                    children: [
                      TextSpan(
                        text: 'Terms of Services',
                        style: TextStyle(
                          color: AppColors.orange,
                          decoration: TextDecoration.underline,
                          decorationColor: AppColors.orange,
                        ),
                      ),
                      TextSpan(text: ' and '),
                      TextSpan(
                        text: 'Privacy Policy',
                        style: TextStyle(
                          color: AppColors.orange,
                          decoration: TextDecoration.underline,
                          decorationColor: AppColors.orange,
                        ),
                      ),
                    ],
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStep1() {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Cart Items
          ...widget.cartRestaurants.map(
            (restaurant) => _buildRestaurantSection(restaurant),
          ),

          24.sH,

          // Add-ons Header
          Text(
            'Add-ons for your order',
            style: TextStyle(
              fontSize: 14.sp,
              color: AppColors.textPrimary,
              fontWeight: FontWeight.w500,
            ),
          ),
          16.sH,

          // Add-ons List
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: addOns.map((item) => _buildAddOnCard(item)).toList(),
            ),
          ),

          32.sH,
        ],
      ),
    );
  }

  Widget _buildStep2() {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Address
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SvgPicture.asset('assets/svg/orders/address.svg', width: 24.sp),
              12.sW,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Plot 14, Okooba, menchi, Lagos',
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    4.sH,
                    Text(
                      'Delivery Address',
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          24.sH,

          // Note for Rider
          GestureDetector(
            onTap: () =>
                _showAddNoteBottomSheet(context, 'Add a note for Rider'),
            child: Row(
              children: [
                SvgPicture.asset('assets/svg/orders/rider.svg', width: 24.sp),
                12.sW,
                Text(
                  'Add note for rider',
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Spacer(),
                Icon(Icons.add, size: 20.sp, color: AppColors.textPrimary),
              ],
            ),
          ),
          24.sH,

          // Info Box
          Container(
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: AppColors.blue.withOpacity(0.1),
              border: Border(
                left: BorderSide(color: AppColors.blue, width: 4.w),
              ),
            ),
            child: Text(
              'The recipient will need a PIN to confirm the delivery.',
              style: TextStyle(
                fontSize: 12.sp,
                color: AppColors.textPrimary,
                height: 1.5,
              ),
            ),
          ),
          24.sH,

          // Order Summary
          Theme(
            data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
            child: ExpansionTile(
              title: Text(
                'Order Summary',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                ),
              ),
              tilePadding: EdgeInsets.zero,
              children: [
                _buildSummaryRow('Fried Rice and Chicken', '5,900'),
                _buildSummaryRow('Fried Rice and Chicken', '5,900'),
                _buildSummaryRow('Jollof Rice and Chicken', '4,900'),
              ],
            ),
          ),

          // Payment Summary
          Theme(
            data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
            child: ExpansionTile(
              title: Text(
                'Payment Summary',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                ),
              ),
              tilePadding: EdgeInsets.zero,
              initiallyExpanded: true,
              children: [
                _buildSummaryRow('Subtotal (3 items)', '8,900'),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () => _showPromoCodeDialog(context),
                        child: Text(
                          'Apply Promo Code',
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: AppColors.blue,
                            decoration: TextDecoration.underline,
                            decorationColor: AppColors.blue,
                          ),
                        ),
                      ),
                      Text(
                        '₦ 0',
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ],
                  ),
                ),
                _buildSummaryRow('Delivery Fee', '3,000'),
                Divider(height: 24.h),
                _buildSummaryRow('Total', '11,900', isTotal: true),
              ],
            ),
          ),
          24.sH,

          // Payment Method
          Text(
            'Select Payment Method',
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary,
            ),
          ),
          16.sH,
          ..._paymentMethods.map((method) => _buildPaymentMethodOption(method)),
          32.sH,
        ],
      ),
    );
  }

  void _showPromoCodeDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        bool isSuccess = false;
        final controller = TextEditingController();

        return StatefulBuilder(
          builder: (context, setState) {
            return Dialog(
              shape: RoundedRectangleBorder(borderRadius: 16.radius),
              child: Padding(
                padding: 24.padAll,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Apply Promo Code',
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w700,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    8.sH,
                    Text(
                      'Are you sure you want to logout your account?',
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: AppColors.textSecondary,
                      ),
                    ),
                    16.sH,
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: 8.radius,
                        border: Border.all(
                          color: isSuccess ? Colors.green : AppColors.border,
                        ),
                      ),
                      child: TextField(
                        controller: controller,
                        decoration: InputDecoration(
                          hintText: isSuccess
                              ? 'MUNCHSPACE50'
                              : 'Enter code here',
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 16.w,
                            vertical: 12.h,
                          ),
                        ),
                        onChanged: (value) {
                          if (isSuccess) setState(() => isSuccess = false);
                        },
                      ),
                    ),
                    if (isSuccess) ...[
                      8.sH,
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 12.w,
                          vertical: 8.h,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.green.withOpacity(0.1),
                          borderRadius: 4.radius,
                        ),
                        child: Text(
                          'Success! This code gives you ₦1,500 off.',
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: Colors.green,
                          ),
                        ),
                      ),
                    ],
                    24.sH,
                    Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () => Navigator.pop(context),
                            child: Container(
                              height: 48.h,
                              decoration: BoxDecoration(
                                color: AppColors.background,
                                borderRadius: 24.radius,
                              ),
                              child: Center(
                                child: Text(
                                  'Cancel',
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.textPrimary,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        12.sW,
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                isSuccess = true;
                                controller.text = 'MUNCHSPACE50';
                              });
                            },
                            child: Container(
                              height: 48.h,
                              decoration: BoxDecoration(
                                color: AppColors.orange,
                                borderRadius: 24.radius,
                              ),
                              child: Center(
                                child: Text(
                                  'Apply discount',
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  void _showAddNoteBottomSheet(BuildContext context, String title) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.6,
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        padding: EdgeInsets.all(24.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
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
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    padding: EdgeInsets.all(4.w),
                    decoration: BoxDecoration(
                      color: AppColors.background,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(Icons.close, size: 20.sp),
                  ),
                ),
              ],
            ),
            24.sH,
            Expanded(
              child: Container(
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  borderRadius: 12.radius,
                  border: Border.all(color: AppColors.border),
                ),
                child: TextField(
                  maxLines: null,
                  decoration: InputDecoration(
                    hintText: title.contains('Restaurant')
                        ? 'Add a note for the restaurant (e.g., special requests)'
                        : 'Add a note for the rider (e.g., directions or instructions)',
                    border: InputBorder.none,
                    filled: false,
                    hintStyle: TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 14.sp,
                    ),
                  ),
                ),
              ),
            ),
            24.sH,
            GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Container(
                width: double.infinity,
                height: 52.h,
                decoration: BoxDecoration(
                  color: AppColors.orange,
                  borderRadius: 30.radius,
                ),
                child: Center(
                  child: Text(
                    'Add Note',
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      color: AppColors.white,
                    ),
                  ),
                ),
              ),
            ),
            MediaQuery.of(context).viewInsets.bottom.sH,
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryRow(String label, String amount, {bool isTotal = false}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 14.sp,
              color: AppColors.textPrimary,
              fontWeight: isTotal ? FontWeight.w600 : FontWeight.normal,
            ),
          ),
          Text(
            '₦ $amount',
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentMethodOption(Map<String, dynamic> method) {
    final isSelected = _selectedPaymentMethod == method['name'];
    return GestureDetector(
      onTap: () => setState(() => _selectedPaymentMethod = method['name']),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 12.h),
        color: Colors.transparent,
        child: Row(
          children: [
            Image.asset(method['icon'], width: 24.sp, height: 24.sp),
            12.sW,
            Text(
              method['name'],
              style: TextStyle(
                fontSize: 14.sp,
                color: AppColors.textPrimary,
                fontWeight: FontWeight.w500,
              ),
            ),
            Spacer(),
            Container(
              width: 20.sp,
              height: 20.sp,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected
                      ? AppColors.orange
                      : AppColors.textSecondary,
                  width: 2,
                ),
              ),
              child: isSelected
                  ? Center(
                      child: Container(
                        width: 10.sp,
                        height: 10.sp,
                        decoration: BoxDecoration(
                          color: AppColors.orange,
                          shape: BoxShape.circle,
                        ),
                      ),
                    )
                  : null,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRestaurantSection(CartRestaurant restaurant) {
    return Column(
      children: [
        // Header
        Container(
          padding: 16.padH + 12.padV,
          decoration: BoxDecoration(
            color: AppColors.red100,
            borderRadius: ResponsiveBorderRadius.topResponsive(16),
          ),
          child: Row(
            children: [
              SvgPicture.asset(
                'assets/svg/orders/restaurant.svg',
                width: 20.sp,
              ),
              12.sW,
              Expanded(
                child: Text(
                  restaurant.name,
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Container(
                width: 20.sp,
                height: 20.sp,
                decoration: BoxDecoration(
                  color: AppColors.red200,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    restaurant.itemCount.toString(),
                    style: TextStyle(
                      color: AppColors.textPrimary,
                      fontSize: 14.sp,
                    ),
                  ),
                ),
              ),
              12.sW,
              Icon(Icons.keyboard_arrow_down, size: 24.sp),
            ],
          ),
        ),

        // Items
        Container(
          padding: 16.padAll,
          decoration: BoxDecoration(
            color: AppColors.background,
            border: Border.symmetric(
              vertical: BorderSide(color: AppColors.red100, width: 2.sp),
            ),
          ),
          child: Column(
            children: restaurant.items
                .map((item) => _buildCartItem(item))
                .toList(),
          ),
        ),

        // Add Note
        GestureDetector(
          onTap: () =>
              _showAddNoteBottomSheet(context, 'Add a note for Restaurant'),
          child: Container(
            padding: 16.padAll,
            decoration: BoxDecoration(
              color: AppColors.red100,
              borderRadius: ResponsiveBorderRadius.bottomResponsive(16),
            ),
            child: Row(
              children: [
                SvgPicture.asset(
                  'assets/svg/orders/note.svg',
                  width: 20.sp,
                  colorFilter: ColorFilter.mode(
                    AppColors.textPrimary,
                    BlendMode.srcIn,
                  ),
                ),
                12.sW,
                Text(
                  'Add note for the restaurant',
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Spacer(),
                Icon(Icons.add, size: 20.sp, color: AppColors.textPrimary),
              ],
            ),
          ),
        ),
        16.sH,
      ],
    );
  }

  Widget _buildCartItem(CartItem item) {
    return Padding(
      padding: EdgeInsets.only(bottom: 16.h),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image
              ClipRRect(
                borderRadius: 8.radius,
                child: Image.asset(
                  item.image,
                  width: 48.sp,
                  height: 48.sp,
                  fit: BoxFit.cover,
                ),
              ),
              12.sW,
              // Details
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
                    4.sH,
                    Text(
                      item.price.toCurrency(),
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColors.orange,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          12.sH,
          // Controls
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Edit order',
                style: TextStyle(
                  fontSize: 12.sp,
                  decoration: TextDecoration.underline,
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Row(
                children: [
                  // Remove Button
                  Container(
                    padding: EdgeInsets.all(6.w),
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 4,
                        ),
                      ],
                    ),
                    child: Icon(
                      Icons.remove,
                      size: 16.sp,
                      color: AppColors.red,
                    ),
                  ),
                  16.sW,
                  // Quantity
                  Text(
                    item.quantity.toString(),
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  16.sW,
                  // Add Button
                  Container(
                    padding: EdgeInsets.all(6.w),
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 4,
                        ),
                      ],
                    ),
                    child: Icon(
                      Icons.add,
                      size: 16.sp,
                      color: AppColors.textPrimary,
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

  Widget _buildAddOnCard(Map<String, dynamic> item) {
    return Container(
      width: 120.w,
      height: 150.h,
      margin: EdgeInsets.only(right: 12.w),
      padding: EdgeInsets.all(8.w),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: 12.radius,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image
          Center(
            child: Image.asset(
              item['image'],
              height: 80.h,
              fit: BoxFit.contain,
            ),
          ),
          8.sH,
          Expanded(
            child: Text(
              item['name'],
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          4.sH,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '₦ ${item['price']}',
                style: TextStyle(
                  fontSize: 12.sp,
                  color: AppColors.textSecondary,
                ),
              ),
              Container(
                padding: EdgeInsets.all(4.w),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 4,
                    ),
                  ],
                ),
                child: Icon(Icons.add, size: 16.sp),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
