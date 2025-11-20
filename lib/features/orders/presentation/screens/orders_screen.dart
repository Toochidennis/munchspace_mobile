import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:munchspace/core/common_widgets/custom_appbar.dart';
import 'package:munchspace/core/theme/app_colors.dart';
import 'package:munchspace/core/utils/number_extensions.dart';
import 'package:munchspace/core/utils/responsive.dart';
import 'package:munchspace/features/orders/models/cart.dart';
import 'package:munchspace/features/orders/models/order.dart';
import 'package:munchspace/features/orders/presentation/screens/checkout_screen.dart';
import 'package:munchspace/features/orders/presentation/widgets/completed_order_card.dart';
import 'package:munchspace/features/orders/presentation/widgets/in_progress_order_card.dart';

class OrdersScreen extends StatefulWidget {
  final VoidCallback? onBackPressed;

  const OrdersScreen({super.key, this.onBackPressed});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  String selectedTab = 'Cart';
  final List<String> tabs = ['Cart', 'In Progress', 'Completed'];

  // Dummy cart data
  final bool hasItems = true;

  late final List<CartRestaurant> cartRestaurants = [
    CartRestaurant(
      id: '1',
      name: 'Sebotomo Food Canteen-Ijora',
      itemCount: 4,
      items: [
        CartItem(
          id: '1',
          name: 'Jollof Rice and Chicken',
          price: 4000,
          image: 'assets/images/home/handpicked_0.jpg',
          quantity: 1,
        ),
        CartItem(
          id: '2',
          name: 'Jollof Rice and Chicken',
          price: 4000,
          image: 'assets/images/home/handpicked_0.jpg',
          quantity: 2,
        ),
      ],
    ),
    CartRestaurant(
      id: '2',
      name: 'Sebotomo Food Canteen-Ijora',
      itemCount: 4,
      items: [
        CartItem(
          id: '3',
          name: 'Jollof Rice and Chicken',
          price: 4000,
          image: 'assets/images/home/handpicked_0.jpg',
          quantity: 1,
        ),
        CartItem(
          id: '4',
          name: 'Jollof Rice and Chicken',
          price: 4000,
          image: 'assets/images/home/handpicked_0.jpg',
          quantity: 1,
        ),
      ],
    ),
  ];

  // Dummy in-progress orders
  final List<Order> inProgressOrders = [
    Order(
      id: 'ORDERAS10675899',
      status: 'Ongoing',
      storeName: 'Sabotimo Food Canteen - Ijora',
      code: '75B2F',
      progress: 0.3,
      placedAt: DateTime.now().subtract(const Duration(minutes: 20)),
      items: [
        OrderItem(name: 'Fried Rice and Chicken', price: 5900, quantity: 1),
        OrderItem(name: 'Jollof Rice and Chicken', price: 4900, quantity: 1),
      ],
      timeline: [
        OrderTimelineStep(
          title: 'Order placed',
          time: DateTime.now().subtract(const Duration(minutes: 20)),
          description: 'Cancel this order',
          isCompleted: true,
        ),
        OrderTimelineStep(
          title: 'Pending Confirmation',
          time: DateTime.now().subtract(const Duration(minutes: 18)),
          isCompleted: false,
          isCurrent: true,
        ),
        OrderTimelineStep(
          title: 'Waiting to be Picked',
          time: DateTime.now().subtract(const Duration(minutes: 15)),
        ),
        OrderTimelineStep(
          title: 'Out for delivery',
          time: DateTime.now().subtract(const Duration(minutes: 10)),
        ),
        OrderTimelineStep(
          title: 'Delivered',
          time: DateTime.now().subtract(const Duration(minutes: 5)),
        ),
      ],
      deliveryFee: 3000,
      paymentMethod: 'Pay Online',
    ),
    Order(
      id: 'ORDERAS10675899',
      status: 'Ongoing',
      storeName: 'Sabotimo Food Canteen - Ijora',
      code: '75B2F',
      progress: 0.3,
      placedAt: DateTime.now().subtract(const Duration(minutes: 20)),
      items: [
        OrderItem(name: 'Fried Rice and Chicken', price: 5900, quantity: 1),
        OrderItem(name: 'Jollof Rice and Chicken', price: 4900, quantity: 1),
      ],
      timeline: [
        OrderTimelineStep(
          title: 'Order placed',
          time: DateTime.now().subtract(const Duration(minutes: 20)),
          description: 'Cancel this order',
          isCompleted: true,
        ),
        OrderTimelineStep(
          title: 'Pending Confirmation',
          time: DateTime.now().subtract(const Duration(minutes: 18)),
          isCompleted: false,
          isCurrent: true,
        ),
        OrderTimelineStep(
          title: 'Waiting to be Picked',
          time: DateTime.now().subtract(const Duration(minutes: 15)),
        ),
        OrderTimelineStep(
          title: 'Out for delivery',
          time: DateTime.now().subtract(const Duration(minutes: 10)),
        ),
        OrderTimelineStep(
          title: 'Delivered',
          time: DateTime.now().subtract(const Duration(minutes: 5)),
        ),
      ],
      deliveryFee: 3000,
      paymentMethod: 'Pay Online',
    ),
  ];

  // Dummy completed orders
  final List<Order> completedOrders = [
    Order(
      id: 'ORDERAS10675899',
      status: 'Completed',
      storeName: 'Sabotimo Food Canteen - Ijora',
      code: '75B2F',
      progress: 1.0,
      placedAt: DateTime.now().subtract(const Duration(days: 1)),
      items: [
        OrderItem(name: 'Fried Rice and Chicken', price: 5900, quantity: 1),
        OrderItem(name: 'Jollof Rice and Chicken', price: 4900, quantity: 1),
      ],
      timeline: [
        OrderTimelineStep(
          title: 'Order placed',
          time: DateTime.now().subtract(const Duration(days: 1, minutes: 60)),
          isCompleted: true,
        ),
        OrderTimelineStep(
          title: 'Pending Confirmation',
          time: DateTime.now().subtract(const Duration(days: 1, minutes: 50)),
          isCompleted: true,
        ),
        OrderTimelineStep(
          title: 'Waiting to be Picked',
          time: DateTime.now().subtract(const Duration(days: 1, minutes: 40)),
          isCompleted: true,
        ),
        OrderTimelineStep(
          title: 'Out for delivery',
          time: DateTime.now().subtract(const Duration(days: 1, minutes: 20)),
          isCompleted: true,
        ),
        OrderTimelineStep(
          title: 'Delivered',
          time: DateTime.now().subtract(const Duration(days: 1)),
          isCompleted: true,
          isCurrent: true,
        ),
      ],
      deliveryFee: 3000,
      paymentMethod: 'Pay Online',
    ),
    Order(
      id: 'ORDERAS10675899',
      status: 'Completed',
      storeName: 'Sabotimo Food Canteen - Ijora',
      code: '75B2F',
      progress: 1.0,
      placedAt: DateTime.now().subtract(const Duration(days: 2)),
      items: [
        OrderItem(name: 'Fried Rice and Chicken', price: 5900, quantity: 1),
        OrderItem(name: 'Jollof Rice and Chicken', price: 4900, quantity: 1),
      ],
      timeline: [
        OrderTimelineStep(
          title: 'Order placed',
          time: DateTime.now().subtract(const Duration(days: 2, minutes: 60)),
          isCompleted: true,
        ),
        OrderTimelineStep(
          title: 'Pending Confirmation',
          time: DateTime.now().subtract(const Duration(days: 2, minutes: 50)),
          isCompleted: true,
        ),
        OrderTimelineStep(
          title: 'Waiting to be Picked',
          time: DateTime.now().subtract(const Duration(days: 2, minutes: 40)),
          isCompleted: true,
        ),
        OrderTimelineStep(
          title: 'Out for delivery',
          time: DateTime.now().subtract(const Duration(days: 2, minutes: 20)),
          isCompleted: true,
        ),
        OrderTimelineStep(
          title: 'Delivered',
          time: DateTime.now().subtract(const Duration(days: 2)),
          isCompleted: true,
          isCurrent: true,
        ),
      ],
      deliveryFee: 3000,
      paymentMethod: 'Pay Online',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: CustomAppbar(
        title: 'Orders',
        onBackPressed: widget.onBackPressed,
      ),
      body: Column(
        children: [
          // Tab Bar
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: tabs.map((tab) {
                final isSelected = selectedTab == tab;
                return Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedTab = tab;
                      });
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 16.w,
                        vertical: 8.h,
                      ),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? AppColors.orange
                            : AppColors.background,
                        borderRadius: 999.radius,
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        tab,
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                          color: isSelected
                              ? AppColors.white
                              : AppColors.textPrimary,
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
          // Content
          Expanded(
            child: selectedTab == 'Cart'
                ? (hasItems ? _buildCartContent() : _buildEmptyState())
                : selectedTab == 'In Progress'
                ? (inProgressOrders.isNotEmpty
                      ? _buildInProgressContent()
                      : _buildEmptyState())
                : selectedTab == 'Completed'
                ? (completedOrders.isNotEmpty
                      ? _buildCompletedContent()
                      : _buildEmptyState())
                : _buildEmptyState(),
          ),
        ],
      ),
    );
  }

  /// Build empty cart state
  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Empty cart icon
          Container(
            width: 120.w,
            height: 120.h,
            decoration: BoxDecoration(
              color: AppColors.red100,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Icon(
                Icons.shopping_cart_outlined,
                size: 60.sp,
                color: AppColors.textSecondary,
              ),
            ),
          ),
          24.sH,
          // Empty state title
          Text(
            'Your cart is empty.',
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary,
            ),
          ),
          12.sH,
          // Empty state description
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Text(
              'Add items from a restaurant or store to start a new cart.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14.sp,
                color: AppColors.textSecondary,
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Build cart with items
  Widget _buildCartContent() {
    return Column(
      children: [
        // Cart items list
        Expanded(
          child: ListView.builder(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
            itemCount: cartRestaurants.length,
            itemBuilder: (context, restaurantIndex) {
              final restaurant = cartRestaurants[restaurantIndex];
              return _buildRestaurantSection(restaurant);
            },
          ),
        ),
        // Bottom action buttons
        Container(
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            color: AppColors.white,
            border: Border(top: BorderSide(color: AppColors.border, width: 1)),
          ),
          child: Row(
            children: [
              // Clear cart button
              Expanded(
                child: GestureDetector(
                  onTap: () {},
                  child: Container(
                    height: 52.h,
                    decoration: BoxDecoration(
                      color: AppColors.red50,
                      borderRadius: 30.radius,
                    ),
                    child: Center(
                      child: Text(
                        'Clear cart',
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                          color: AppColors.orange,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              16.sW,
              // Proceed button
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            CheckoutScreen(cartRestaurants: cartRestaurants),
                      ),
                    );
                  },
                  child: Container(
                    height: 52.h,
                    decoration: BoxDecoration(
                      color: AppColors.orange,
                      borderRadius: 30.radius,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Proceed',
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                            color: AppColors.white,
                          ),
                        ),
                        8.sW,
                        Icon(
                          Icons.arrow_forward,
                          color: AppColors.white,
                          size: 20.sp,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  /// Build restaurant section with its items
  Widget _buildRestaurantSection(CartRestaurant restaurant) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Restaurant header
        Container(
          padding: 16.padH + 12.padV,
          decoration: BoxDecoration(
            color: AppColors.red100,
            borderRadius: ResponsiveBorderRadius.topResponsive(16),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  SvgPicture.asset(
                    'assets/svg/orders/restaurant.svg',
                    width: 20.sp,
                  ),
                  12.sW,
                  Text(
                    restaurant.name,
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  12.sW,
                  Container(
                    width: 20.sp,
                    height: 20.sp,
                    decoration: BoxDecoration(
                      color: AppColors.red200,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        "4",
                        style: TextStyle(
                          color: AppColors.textPrimary,
                          fontSize: 14.sp,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Icon(Icons.keyboard_arrow_down),
            ],
          ),
        ),
        Container(
          padding: 16.padAll,
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.red100, width: 2.sp),
            borderRadius: ResponsiveBorderRadius.bottomResponsive(16),
          ),
          child: ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: restaurant.items.length,
            separatorBuilder: (context, index) => 12.sH,
            itemBuilder: (context, index) {
              final item = restaurant.items[index];
              return _buildCartItemTile(item);
            },
          ),
        ),

        16.sH,
      ],
    );
  }

  /// Build individual cart item tile
  Widget _buildCartItemTile(CartItem item) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            // Item image
            Container(
              width: 60.sp,
              height: 60.sp,
              decoration: BoxDecoration(
                borderRadius: 8.radius,
                color: AppColors.red100,
              ),
              child: ClipRRect(
                borderRadius: 8.radius,
                child: Image.asset(item.image, fit: BoxFit.cover),
              ),
            ),
            12.sW,
            // Item details
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
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  4.sH,
                  Text(
                    item.price.toCurrency(),
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600,
                      color: AppColors.orange,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        8.sH,
        // Edit order link and quantity controls
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Edit order link
            GestureDetector(
              onTap: () {},
              child: Text(
                'Edit order',
                style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textSecondary,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
            // Quantity controls
            SizedBox(
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      width: 32.sp,
                      height: 32.sp,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Center(
                        child: Icon(
                          Icons.remove,
                          size: 16.sp,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: 30.w,
                    alignment: Alignment.center,
                    child: Text(
                      item.quantity.toString(),
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      width: 32.sp,
                      height: 32.sp,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Center(
                        child: Icon(
                          Icons.add,
                          size: 16.sp,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  /// Build in-progress orders list
  Widget _buildInProgressContent() {
    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      itemCount: inProgressOrders.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: EdgeInsets.only(bottom: 16.h),
          child: InProgressOrderCard(order: inProgressOrders[index]),
        );
      },
    );
  }

  Widget _buildCompletedContent() {
    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      itemCount: completedOrders.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: EdgeInsets.only(bottom: 16.h),
          child: CompletedOrderCard(order: completedOrders[index]),
        );
      },
    );
  }
}
