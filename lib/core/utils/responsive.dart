import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Responsive extensions for easy usage throughout the app
/// These extensions provide shortcuts for common responsive patterns
///
/// Usage Examples:
/// - 16.w -> 16.0.w (responsive width)
/// - 20.h -> 20.0.h (responsive height)
/// - 14.sp -> 14.0.sp (responsive font size)
/// - 8.r -> 8.0.r (responsive radius)
/// - 10.sW -> SizedBox(width: 10.w) (responsive width SizedBox)
/// - 15.sH -> SizedBox(height: 15.h) (responsive height SizedBox)

/// Extension on integers for responsive design
extension ResponsiveInt on int {
  /// Get responsive width
  double get w => toDouble().w;

  /// Get responsive height
  double get h => toDouble().h;

  /// Get responsive font size
  double get sp => toDouble().sp;

  /// Get responsive radius
  double get r => toDouble().r;

  /// Get responsive minimum dimension
  double get dg => toDouble().dg;

  /// Get SizedBox with responsive width
  SizedBox get sW => SizedBox(width: w);

  /// Get SizedBox with responsive height
  SizedBox get sH => SizedBox(height: h);

  /// Get EdgeInsets.all with responsive value
  EdgeInsets get padAll => EdgeInsets.all(toDouble());

  /// Get EdgeInsets.symmetric with responsive horizontal value
  EdgeInsets get padH => EdgeInsets.symmetric(horizontal: w);

  /// Get EdgeInsets.symmetric with responsive vertical value
  EdgeInsets get padV => EdgeInsets.symmetric(vertical: h);

  /// Get EdgeInsets.only left with responsive value
  EdgeInsets get padL => EdgeInsets.only(left: w);

  /// Get EdgeInsets.only right with responsive value
  EdgeInsets get padR => EdgeInsets.only(right: w);

  /// Get EdgeInsets.only top with responsive value
  EdgeInsets get padT => EdgeInsets.only(top: h);

  /// Get EdgeInsets.only bottom with responsive value
  EdgeInsets get padB => EdgeInsets.only(bottom: h);

  /// Get BorderRadius.circular with responsive value
  BorderRadius get radius => BorderRadius.circular(r);

  /// Get Radius.circular with responsive value
  Radius get circularRadius => Radius.circular(r);
}

/// Extension on doubles for responsive design
extension ResponsiveDouble on double {
  /// Get responsive width
  double get w => ScreenUtil().setWidth(this);

  /// Get responsive height
  double get h => ScreenUtil().setHeight(this);

  /// Get responsive font size
  double get sp => ScreenUtil().setSp(this);

  /// Get responsive radius
  double get r => ScreenUtil().radius(this);

  /// Get responsive minimum dimension
  double get dg => ScreenUtil().diagonal(this);

  /// Get SizedBox with responsive width
  SizedBox get sW => SizedBox(width: w);

  /// Get SizedBox with responsive height
  SizedBox get sH => SizedBox(height: h);

  /// Get EdgeInsets.all with responsive value
  EdgeInsets get padAll => EdgeInsets.all(this);

  /// Get EdgeInsets.symmetric with responsive horizontal value
  EdgeInsets get padH => EdgeInsets.symmetric(horizontal: w);

  /// Get EdgeInsets.symmetric with responsive vertical value
  EdgeInsets get padV => EdgeInsets.symmetric(vertical: h);

  /// Get EdgeInsets.only left with responsive value
  EdgeInsets get padL => EdgeInsets.only(left: w);

  /// Get EdgeInsets.only right with responsive value
  EdgeInsets get padR => EdgeInsets.only(right: w);

  /// Get EdgeInsets.only top with responsive value
  EdgeInsets get padT => EdgeInsets.only(top: h);

  /// Get EdgeInsets.only bottom with responsive value
  EdgeInsets get padB => EdgeInsets.only(bottom: h);

  /// Get BorderRadius.circular with responsive value
  BorderRadius get radius => BorderRadius.circular(r);

  /// Get Radius.circular with responsive value
  Radius get circularRadius => Radius.circular(r);
}

/// Extension for creating responsive EdgeInsets
extension ResponsiveEdgeInsets on EdgeInsets {
  /// Create responsive EdgeInsets from LTRB values
  static EdgeInsets responsive({
    double left = 0,
    double top = 0,
    double right = 0,
    double bottom = 0,
  }) {
    return EdgeInsets.only(
      left: left.w,
      top: top.h,
      right: right.w,
      bottom: bottom.h,
    );
  }

  /// Create responsive symmetric EdgeInsets
  static EdgeInsets symmetricResponsive({
    double horizontal = 0,
    double vertical = 0,
  }) {
    return EdgeInsets.symmetric(horizontal: horizontal.w, vertical: vertical.h);
  }

  /// Create responsive all EdgeInsets
  static EdgeInsets allResponsive(double value) {
    return EdgeInsets.all(value.w);
  }
}

/// Extension for creating responsive BorderRadius
extension ResponsiveBorderRadius on BorderRadius {
  /// Create responsive BorderRadius.all
  static BorderRadius allResponsive(double radius) {
    return BorderRadius.all(Radius.circular(radius.r));
  }

  /// Create responsive BorderRadius.only
  static BorderRadius onlyResponsive({
    double topLeft = 0,
    double topRight = 0,
    double bottomLeft = 0,
    double bottomRight = 0,
  }) {
    return BorderRadius.only(
      topLeft: Radius.circular(topLeft.r),
      topRight: Radius.circular(topRight.r),
      bottomLeft: Radius.circular(bottomLeft.r),
      bottomRight: Radius.circular(bottomRight.r),
    );
  }

  /// Create responsive BorderRadius for top corners only
  static BorderRadius topResponsive(double radius) {
    return BorderRadius.vertical(top: Radius.circular(radius.r));
  }

  /// Create responsive BorderRadius for bottom corners only
  static BorderRadius bottomResponsive(double radius) {
    return BorderRadius.vertical(bottom: Radius.circular(radius.r));
  }

  /// Create responsive BorderRadius for left corners only
  static BorderRadius leftResponsive(double radius) {
    return BorderRadius.horizontal(left: Radius.circular(radius.r));
  }

  /// Create responsive BorderRadius for right corners only
  static BorderRadius rightResponsive(double radius) {
    return BorderRadius.horizontal(right: Radius.circular(radius.r));
  }
}

/// Extension for responsive sizing helper methods
extension ResponsiveSizing on BuildContext {
  /// Get screen width
  double get screenWidth => ScreenUtil().screenWidth;

  /// Get screen height
  double get screenHeight => ScreenUtil().screenHeight;

  /// Get status bar height
  double get statusBarHeight => ScreenUtil().statusBarHeight;

  /// Get bottom bar height
  double get bottomBarHeight => ScreenUtil().bottomBarHeight;

  /// Check if screen is mobile size
  bool get isMobile => screenWidth < 600;

  /// Check if screen is tablet size
  bool get isTablet => screenWidth >= 600 && screenWidth < 1024;

  /// Check if screen is desktop size
  bool get isDesktop => screenWidth >= 1024;

  /// Get responsive percentage width
  double widthPercent(double percent) => screenWidth * (percent / 100);

  /// Get responsive percentage height
  double heightPercent(double percent) => screenHeight * (percent / 100);
}

/// Extension for responsive layout helpers
extension ResponsiveLayout on Widget {
  /// Add responsive padding to widget
  Widget paddingResponsive({
    double? all,
    double? horizontal,
    double? vertical,
    double? left,
    double? top,
    double? right,
    double? bottom,
  }) {
    EdgeInsets padding;

    if (all != null) {
      padding = EdgeInsets.all(all.w);
    } else {
      padding = EdgeInsets.only(
        left: (left ?? horizontal ?? 0).w,
        top: (top ?? vertical ?? 0).h,
        right: (right ?? horizontal ?? 0).w,
        bottom: (bottom ?? vertical ?? 0).h,
      );
    }

    return Padding(padding: padding, child: this);
  }

  /// Add responsive margin to widget
  Widget marginResponsive({
    double? all,
    double? horizontal,
    double? vertical,
    double? left,
    double? top,
    double? right,
    double? bottom,
  }) {
    EdgeInsets margin;

    if (all != null) {
      margin = EdgeInsets.all(all.w);
    } else {
      margin = EdgeInsets.only(
        left: (left ?? horizontal ?? 0).w,
        top: (top ?? vertical ?? 0).h,
        right: (right ?? horizontal ?? 0).w,
        bottom: (bottom ?? vertical ?? 0).h,
      );
    }

    return Container(margin: margin, child: this);
  }

  /// Wrap widget with responsive SizedBox
  Widget sizedResponsive({double? width, double? height}) {
    return SizedBox(width: width?.w, height: height?.h, child: this);
  }

  /// Center widget with responsive constraints
  Widget centerResponsive({double? width, double? height}) {
    return Center(
      child: SizedBox(width: width?.w, height: height?.h, child: this),
    );
  }
}

/// Common responsive spacing constants
class ResponsiveSpacing {
  ResponsiveSpacing._();

  // Spacing values
  static double get xs => 4.w;
  static double get sm => 8.w;
  static double get md => 16.w;
  static double get lg => 24.w;
  static double get xl => 32.w;
  static double get xxl => 40.w;

  // Height spacing values
  static double get xsH => 4.h;
  static double get smH => 8.h;
  static double get mdH => 16.h;
  static double get lgH => 24.h;
  static double get xlH => 32.h;
  static double get xxlH => 40.h;

  // SizedBox helpers
  static SizedBox get xsSizedBox => SizedBox(width: xs, height: xs);
  static SizedBox get smSizedBox => SizedBox(width: sm, height: sm);
  static SizedBox get mdSizedBox => SizedBox(width: md, height: md);
  static SizedBox get lgSizedBox => SizedBox(width: lg, height: lg);
  static SizedBox get xlSizedBox => SizedBox(width: xl, height: xl);

  // Width SizedBoxes
  static SizedBox get xsWidthBox => SizedBox(width: xs);
  static SizedBox get smWidthBox => SizedBox(width: sm);
  static SizedBox get mdWidthBox => SizedBox(width: md);
  static SizedBox get lgWidthBox => SizedBox(width: lg);
  static SizedBox get xlWidthBox => SizedBox(width: xl);

  // Height SizedBoxes
  static SizedBox get xsHeightBox => SizedBox(height: xsH);
  static SizedBox get smHeightBox => SizedBox(height: smH);
  static SizedBox get mdHeightBox => SizedBox(height: mdH);
  static SizedBox get lgHeightBox => SizedBox(height: lgH);
  static SizedBox get xlHeightBox => SizedBox(height: xlH);
}

/// Common responsive dimensions
class ResponsiveDimensions {
  ResponsiveDimensions._();

  // Icon sizes
  static double get iconXS => 12.w;
  static double get iconSM => 16.w;
  static double get iconMD => 24.w;
  static double get iconLG => 32.w;
  static double get iconXL => 48.w;

  // Button heights
  static double get buttonSM => 32.h;
  static double get buttonMD => 40.h;
  static double get buttonLG => 48.h;
  static double get buttonXL => 56.h;

  // Card dimensions
  static double get cardRadius => 12.r;
  static double get cardElevation => 2.w;
  static double get cardPadding => 16.w;

  // Avatar sizes
  static double get avatarSM => 32.w;
  static double get avatarMD => 40.w;
  static double get avatarLG => 48.w;
  static double get avatarXL => 64.w;

  // Input field dimensions
  static double get inputHeight => 48.h;
  static double get inputRadius => 8.r;
  static double get inputPadding => 16.w;
}
