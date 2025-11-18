import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:munchspace/core/utils/responsive.dart';

import '../../../../core/theme/app_colors.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _selectedTab = 'All';

  final List<String> _tabs = ['All', 'MunchSpaces', 'Shops', 'Pharmacies'];

  final List<Map<String, String>> _recentSearches = [
    {'title': 'Fried Rice'},
    {'title': 'Rice'},
    {'title': 'Crispy Rice'},
    {'title': 'Jollof Rice'},
    {'title': 'Jollof Rice'},
  ];

  final List<Map<String, String>> _munchspaces = [
    {
      'name': 'The Good Rice Bowls',
      'description': 'Healthy Bowl',
      'image': 'assets/images/home/handpicked_0.jpg',
    },
    {
      'name': 'Mr Monsters Korean Rice',
      'description': 'Kessler Light',
      'image': 'assets/images/home/handpicked_1.jpg',
    },
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surfaceContainer,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80.h),
        child: SafeArea(
          child: Container(
            height: 72.h,
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    width: 40.w,
                    height: 40.h,
                    decoration: BoxDecoration(
                      color: AppColors.red100,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.arrow_back,
                      color: AppColors.textPrimary,
                      size: 20.sp,
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    'Search',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ),
                SizedBox(width: 40.w),
              ],
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.all(16.w),
              child: Container(
                height: 48.h,
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(999.r),
                  border: Border.all(color: AppColors.border, width: 1.w),
                ),
                child: TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: 'Food, drinks, groceries etc',
                    hintStyle: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                      color: AppColors.textSecondary,
                    ),
                    filled: false,
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 16.w,
                      vertical: 12.h,
                    ),
                    prefixIcon: Padding(
                      padding: EdgeInsets.only(left: 12.w, right: 8.w),
                      child: Icon(
                        IconlyLight.search,
                        color: AppColors.textSecondary,
                        size: 20.sp,
                      ),
                    ),
                  ),
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                    color: AppColors.textPrimary,
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: SizedBox(
                height: 40.h,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: _tabs.length,
                  separatorBuilder: (_, __) => 8.sW,
                  itemBuilder: (context, index) {
                    final tab = _tabs[index];
                    final isSelected = _selectedTab == tab;
                    return GestureDetector(
                      onTap: () {
                        setState(() => _selectedTab = tab);
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
                        child: Center(
                          child: Text(
                            tab,
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                              color: isSelected
                                  ? AppColors.white
                                  : AppColors.textPrimary,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            16.sH,
            if (_selectedTab == 'All')
              _buildAllContent()
            else if (_selectedTab == 'MunchSpaces')
              _buildMunchspacesContent()
            else
              Padding(
                padding: EdgeInsets.all(16.w),
                child: Text(
                  '$_selectedTab coming soon',
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: AppColors.textSecondary,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildAllContent() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ..._munchspaces.map((space) {
            return Padding(
              padding: EdgeInsets.only(bottom: 16.h),
              child: _buildMunchspaceItem(space),
            );
          }),
          ..._recentSearches.map((search) {
            return Padding(
              padding: EdgeInsets.only(bottom: 12.h),
              child: _buildRecentSearchItem(search),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildMunchspacesContent() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        children: _munchspaces.map((space) {
          return Padding(
            padding: EdgeInsets.only(bottom: 16.h),
            child: _buildMunchspaceItem(space),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildMunchspaceItem(Map<String, String> space) {
    return Row(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(18.r),
          child: Image.asset(
            space['image']!,
            width: 36.w,
            height: 36.h,
            fit: BoxFit.cover,
          ),
        ),
        12.sW,
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                space['name']!,
                style: TextStyle(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                ),
              ),
              4.sH,
              Text(
                space['description']!,
                style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w400,
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildRecentSearchItem(Map<String, String> search) {
    return Row(
      children: [
        Container(
          width: 36.w,
          height: 36.h,
          decoration: BoxDecoration(
            color: AppColors.disabledContainer,
            shape: BoxShape.circle,
          ),
          alignment: Alignment.center,
          child: Icon(
            IconlyLight.search,
            color: AppColors.textSecondary,
            size: 18.sp,
          ),
        ),
        12.sW,
        Text(
          search['title']!,
          style: TextStyle(
            fontSize: 13.sp,
            fontWeight: FontWeight.w500,
            color: AppColors.black,
          ),
        ),
      ],
    );
  }
}
