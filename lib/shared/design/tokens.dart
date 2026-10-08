import 'package:flutter/material.dart';

import '../aplication/configs/app_colors.dart';

abstract final class AppSpacing {
  static const double xxs = 4;
  static const double xs = 8;
  static const double sm = 12;
  static const double md = 16;
  static const double lg = 20;
  static const double xl = 24;
  static const double xxl = 32;
  static const double xxxl = 40;

  static const double page = 24;
  static const EdgeInsets pagePadding = EdgeInsets.all(page);
  static const EdgeInsets cardPadding = EdgeInsets.all(lg);
}

abstract final class AppRadius {
  static const double xs = 6;
  static const double sm = 8;
  static const double md = 10;
  static const double lg = 14;
  static const double xl = 18;

  static const BorderRadius chip = BorderRadius.all(Radius.circular(xs));
  static const BorderRadius control = BorderRadius.all(Radius.circular(md));
  static const BorderRadius card = BorderRadius.all(Radius.circular(xl));
  static const BorderRadius dialog = BorderRadius.all(Radius.circular(22));
}

abstract final class AppSizes {
  static const double controlHeight = 44;
  static const double controlHeightSm = 36;
  static const double tableHeaderHeight = 44;
  static const double tableRowHeight = 52;

  static const double iconSm = 16;
  static const double icon = 20;
  static const double iconLg = 24;

  static const double sidebarWidth = 248;
  static const double topBarHeight = 64;
  static const double sidePanelWidth = 520;
  static const double sidePanelWidthWide = 720;
  static const double searchWidth = 320;
}

abstract final class AppText {
  static const _family = 'Onest';
  static const _tabular = [FontFeature.tabularFigures()];

  static const display = TextStyle(
    fontFamily: _family,
    fontSize: 28,
    height: 1.2,
    fontWeight: FontWeight.w700,
    letterSpacing: -0.6,
    color: AppColors.ink,
    fontFeatures: _tabular,
  );

  static const h1 = TextStyle(
    fontFamily: _family,
    fontSize: 22,
    height: 1.25,
    fontWeight: FontWeight.w700,
    letterSpacing: -0.4,
    color: AppColors.ink,
  );

  static const h2 = TextStyle(
    fontFamily: _family,
    fontSize: 18,
    height: 1.3,
    fontWeight: FontWeight.w700,
    letterSpacing: -0.3,
    color: AppColors.ink,
  );

  static const h3 = TextStyle(
    fontFamily: _family,
    fontSize: 16,
    height: 1.35,
    fontWeight: FontWeight.w600,
    letterSpacing: -0.2,
    color: AppColors.ink,
  );

  static const body = TextStyle(
    fontFamily: _family,
    fontSize: 14,
    height: 1.5,
    fontWeight: FontWeight.w400,
    color: AppColors.ink,
    fontFeatures: _tabular,
  );

  static const bodyMedium = TextStyle(
    fontFamily: _family,
    fontSize: 14,
    height: 1.5,
    fontWeight: FontWeight.w500,
    color: AppColors.ink,
    fontFeatures: _tabular,
  );

  static const bodyStrong = TextStyle(
    fontFamily: _family,
    fontSize: 14,
    height: 1.5,
    fontWeight: FontWeight.w600,
    color: AppColors.ink,
    fontFeatures: _tabular,
  );

  static const small = TextStyle(
    fontFamily: _family,
    fontSize: 13,
    height: 1.45,
    fontWeight: FontWeight.w400,
    color: AppColors.textSecondary,
    fontFeatures: _tabular,
  );

  static const label = TextStyle(
    fontFamily: _family,
    fontSize: 13,
    height: 1.4,
    fontWeight: FontWeight.w500,
    color: AppColors.ink,
  );

  static const caption = TextStyle(
    fontFamily: _family,
    fontSize: 12,
    height: 1.4,
    fontWeight: FontWeight.w500,
    color: AppColors.textSecondary,
    fontFeatures: _tabular,
  );
}

/// Telefon / planshet chegarasi
abstract final class AppBreakpoints {
  static const double mobile = 700;
}

extension AppResponsive on BuildContext {
  /// Ekran telefon o'lchamidami (eni 700px dan kichik)
  bool get isMobile => MediaQuery.sizeOf(this).width < AppBreakpoints.mobile;

  /// Sahifa chetidagi bo'shliq: telefonda kichikroq
  double get pageGutter => isMobile ? AppSpacing.sm : AppSpacing.page;
}
