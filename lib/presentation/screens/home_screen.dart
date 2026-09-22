import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:logistic_tracking_ui/constants/string_const.dart';
import 'package:logistic_tracking_ui/core/app_colors.dart';
import 'package:logistic_tracking_ui/core/app_data.dart';
import 'package:logistic_tracking_ui/core/app_icons.dart';
import 'package:logistic_tracking_ui/core/app_textstyles.dart';
import 'package:logistic_tracking_ui/core/models/tracking_history_item.dart';
import 'package:logistic_tracking_ui/providers/home_provider.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildHeader(context),
            _buildTrackingHistory(context),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment(-0.6, -1),
          end: Alignment(0.8, 1),
          colors: [AppColors.gradientStart, AppColors.gradientEnd],
        ),
        borderRadius: .only(
          bottomLeft: .circular(30),
          bottomRight: .circular(30),
        ),
      ),
      child: SafeArea(
        child: Stack(
          children: [
            Padding(
              padding: const .symmetric(horizontal: 36.0, vertical: 10),
              child: Column(
                crossAxisAlignment: .start,
                spacing: 40,
                children: [
                  SvgPicture.asset(AppIcons.icMenu, width: 28, height: 16, colorFilter: .mode(AppColors.whiteColor, .srcIn),),
                  const SizedBox(height: 40,),
                  Column(
                    crossAxisAlignment: .start,
                    spacing: 8,
                    children: [
                      Text('${StringConst.helloPrefix}${AppData.userName}', style: AppTextStyles.greeting,),
                      SizedBox(
                        width: 221,
                        child: Text(StringConst.trackBelongings, style: AppTextStyles.heroTitle,),
                      ),
                    ],
                  ),
                  Column(
                    spacing: 18,
                    children: [
                      _buildSearchField(context),
                      Center(child: _buildTrackButton(context),),
                    ],
                  ),
                ],
              ),
            ),
            Positioned(
                top: 0,
                right: -110,
                child: Image.asset(AppIcons.searchIllustration, height: 260,))
          ],
        ),
      ),
    );
  }

  Widget _buildSearchField(BuildContext context, ) {
    return Container(
      height: 50,
      padding: .symmetric(horizontal: 18),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: .circular(14),
        border: .all(color: AppColors.borderColor, width: 1.14),
      ),
      child: Row(
        spacing: 16,
        children: [
          SvgPicture.asset(AppIcons.icSearch, colorFilter: .mode(AppColors.iconGreyColor, .srcIn),),
          Expanded(
            child: TextField(
              controller: context.read<HomeProvider>().orderNumController,
              keyboardType: .number,
              maxLength: 10,
              style: AppTextStyles.listTitle,
              decoration: InputDecoration(
                border: .none,
                counterText: '',
                isDense: true,
                hintText: StringConst.orderNumberHint,
                hintStyle: AppTextStyles.placeholder,
                contentPadding: .zero,
              ),
            ),
          ),
          SvgPicture.asset(AppIcons.icScan, colorFilter: .mode(AppColors.iconGreyColor, .srcIn),),
        ],
      ),
    );
  }

  Widget _buildTrackButton(BuildContext context) {
    return GestureDetector(
      onTap: () => context.read<HomeProvider>().onOrderItemTap(context, ),
      child: Container(
        padding: .symmetric(horizontal: 34, vertical: 11),
        decoration: BoxDecoration(
          color: AppColors.primaryDark,
          borderRadius: .circular(12),
        ),
        child: Row(
          mainAxisAlignment: .center,
          mainAxisSize: .min,
          spacing: 13,
          children: [
            Text(StringConst.trackNow, style: AppTextStyles.buttonLabel,),
            Icon(Icons.arrow_forward, color: Colors.white,)
          ],
        ),
      ),
    );
  }

  Widget _buildTrackingHistory(BuildContext context) {
    return Padding(
      padding: .symmetric(horizontal: 24, vertical: 36),
      child: Column(
        crossAxisAlignment: .start,
        spacing: 26,
        children: [
          Text(StringConst.trackingHistory, style: AppTextStyles.sectionTitle,),
          Column(
            spacing: 28,
            children: [
              for (var i = 0; i < AppData.trackingHistory.length; i++) ...[
                _buildHistoryTile(context,  AppData.trackingHistory[i]),
                if (i < AppData.trackingHistory.length - 1)
                  Divider(height: 1, thickness: 1, color: AppColors.dividerColor,),
              ],
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildHistoryTile(BuildContext context, TrackingHistoryItem item) {
    return GestureDetector(
      onTap: () => context.read<HomeProvider>().onOrderItemTap(context, orderID: item.orderId),
      behavior: .opaque,
      child: Row(
        children: [
          Expanded(
            child: Row(
              spacing: 18,
              children: [
                ClipOval(
                  child: Image.asset(item.logoPath, width: 46, height: 46, fit: .cover,),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: .start,
                    spacing: 2,
                    children: [
                      Text(item.companyName, style: AppTextStyles.listTitle, maxLines: 1, overflow: .ellipsis,),
                      Text(item.deliveredDateLabel, style: AppTextStyles.listSubtitle, maxLines: 1, overflow: .ellipsis,),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Icon(Icons.navigate_next_rounded, size: 25,)
        ],
      ),
    );
  }
}
