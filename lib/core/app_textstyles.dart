import 'package:flutter/material.dart';
import 'package:logistic_tracking_ui/constants/string_const.dart';
import 'package:logistic_tracking_ui/core/app_colors.dart';

class AppTextStyles {
  static const greeting = TextStyle(
    fontFamily: StringConst.appFontFamily,
    fontWeight: FontWeight.w500,
    fontSize: 18,
    letterSpacing: 0.54,
    color: AppColors.textPrimary,
  );

  static const heroTitle = TextStyle(
    fontFamily: StringConst.appFontFamily,
    fontWeight: FontWeight.w700,
    fontSize: 35,
    height: 1.3,
    letterSpacing: 1.05,
    color: AppColors.textPrimary,
  );

  static const sectionTitle = TextStyle(
    fontFamily: StringConst.appFontFamily,
    fontWeight: FontWeight.w600,
    fontSize: 20,
    letterSpacing: 0.6,
    color: AppColors.textPrimary,
  );

  static const orderTitle = TextStyle(
    fontFamily: StringConst.appFontFamily,
    fontWeight: FontWeight.w600,
    fontSize: 20,
    letterSpacing: 0.6,
    color: AppColors.textPrimary,
  );

  static const buttonLabel = TextStyle(
    fontFamily: StringConst.appFontFamily,
    fontWeight: FontWeight.w600,
    fontSize: 16,
    letterSpacing: 0.48,
    color: AppColors.whiteColor,
  );

  static const listTitle = TextStyle(
    fontFamily: StringConst.appFontFamily,
    fontWeight: FontWeight.w500,
    fontSize: 16,
    letterSpacing: 0.48,
    color: AppColors.textPrimary,
  );

  static const listSubtitle = TextStyle(
    fontFamily: StringConst.appFontFamily,
    fontWeight: FontWeight.w400,
    fontSize: 14,
    letterSpacing: 0.42,
    color: AppColors.textMuted,
  );

  static const placeholder = TextStyle(
    fontFamily: StringConst.appFontFamily,
    fontWeight: FontWeight.w400,
    fontSize: 14,
    letterSpacing: 0.42,
    color: AppColors.textMuted,
  );

  static const courierName = TextStyle(
    fontFamily: StringConst.appFontFamily,
    fontWeight: FontWeight.w500,
    fontSize: 20,
    letterSpacing: 0.6,
    color: AppColors.whiteColor,
  );

  static const etaLabel = TextStyle(
    fontFamily: StringConst.appFontFamily,
    fontWeight: FontWeight.w500,
    fontSize: 16,
    letterSpacing: 0.48,
    color: AppColors.textPrimary,
  );

  static const etaDate = TextStyle(
    fontFamily: StringConst.appFontFamily,
    fontWeight: FontWeight.w600,
    fontSize: 20,
    letterSpacing: 0.6,
    color: AppColors.textPrimary,
  );

  static const locationLabel = TextStyle(
    fontFamily: StringConst.appFontFamily,
    fontWeight: FontWeight.w400,
    fontSize: 16,
    letterSpacing: 0.48,
    color: AppColors.textMuted,
  );

  static const shipperName = TextStyle(
    fontFamily: StringConst.appFontFamily,
    fontWeight: FontWeight.w500,
    fontSize: 18,
    letterSpacing: 0.54,
    color: AppColors.textPrimary,
  );

  static const amount = TextStyle(
    fontFamily: StringConst.appFontFamily,
    fontWeight: FontWeight.w700,
    fontSize: 16,
    letterSpacing: 0.48,
    color: AppColors.textPrimary,
  );

  static const mapChip = TextStyle(
    fontFamily: StringConst.appFontFamily,
    fontWeight: FontWeight.w400,
    fontSize: 12,
    letterSpacing: 0.36,
    color: AppColors.textSecondary,
  );

  static const mapCity = TextStyle(
    fontFamily: StringConst.appFontFamily,
    fontWeight: FontWeight.w400,
    fontSize: 10,
    letterSpacing: 0.3,
    color: AppColors.textMapLabel,
  );
}
