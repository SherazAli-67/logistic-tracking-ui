import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:logistic_tracking_ui/constants/string_const.dart';
import 'package:logistic_tracking_ui/core/app_colors.dart';
import 'package:logistic_tracking_ui/core/app_data.dart';
import 'package:logistic_tracking_ui/core/app_icons.dart';
import 'package:logistic_tracking_ui/core/app_textstyles.dart';
import 'package:logistic_tracking_ui/core/models/order_details.dart';
import 'package:logistic_tracking_ui/presentation/widgets/fade_slide_in.dart';

class OrderDetailsScreen extends StatefulWidget {
  const OrderDetailsScreen({super.key, required this.orderId});

  final String orderId;

  @override
  State<OrderDetailsScreen> createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> with TickerProviderStateMixin {
  late final AnimationController _entrance;
  late final AnimationController _pulse;
  late final Animation<double> _routeProgress;

  @override
  void initState() {
    super.initState();
    _entrance = AnimationController(vsync: this, duration: const Duration(milliseconds: 1000),)..forward();
    _pulse = AnimationController(vsync: this, duration: const Duration(milliseconds: 1600),)..repeat(reverse: true);
    _routeProgress = CurvedAnimation(parent: _entrance, curve: Interval(0.15, 0.55, curve: Curves.easeInOut),);
  }

  @override
  void dispose() {
    _entrance.dispose();
    _pulse.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final order = AppData.orderById(widget.orderId);
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: Stack(
        children: [
          Positioned.fill(
            child: FadeTransition(
              opacity: CurvedAnimation(parent: _entrance, curve: Interval(0.00, 0.30, curve: Curves.easeOut),),
              child: Image.asset(order.mapAssetPath, fit: .cover,),
            ),
          ),
          Positioned.fill(child: _buildMapOverlays(context, order),),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: FadeSlideIn(
              animation: _entrance,
              begin: 0.20,
              end: 0.45,
              offset: Offset.zero,
              child: _buildAppBar(context, order),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: FadeSlideIn(
              animation: _entrance,
              begin: 0.40,
              end: 0.75,
              offset: Offset(0, 0.25),
              child: _buildBottomPanel(context, order),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAppBar(BuildContext context, OrderDetails order) {
    return SafeArea(
      bottom: false,
      child: Padding(
        padding: .symmetric(horizontal: 24, vertical: 12),
        child: Row(
          children: [
            GestureDetector(
              onTap: () => context.pop(),
              behavior: .opaque,
              child: Icon(Icons.arrow_back_ios_new_rounded, size: 20, color: AppColors.textPrimary,),
            ),
            Expanded(
              child: Text(
                '${StringConst.orderPrefix}${order.orderId}',
                style: AppTextStyles.orderTitle,
                textAlign: .center,
              ),
            ),
            const SizedBox(width: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildMapOverlays(BuildContext context, OrderDetails order) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final w = constraints.maxWidth;
        final h = constraints.maxHeight;
        return Stack(
          children: [
            Positioned(
              left: w * 0.16,
              top: h * 0.12,
              width: w * 0.62,
              height: h * 0.38,
              child: AnimatedBuilder(
                animation: _routeProgress,
                builder: (context, _) => CustomPaint(painter: _RoutePainter(progress: _routeProgress.value),),
              ),
            ),
            Positioned(
              left: w * 0.10,
              top: h * 0.095,
              child: _buildScaleFade(
                begin: 0.35,
                end: 0.55,
                child: _buildDestinationAddressChip(order.origin),
              ),
            ),
            Positioned(
              left: w * 0.14,
              top: h * 0.132,
              child: _buildScaleFade(
                begin: 0.35,
                end: 0.55,
                child: _buildPulsingPin(SvgPicture.asset(AppIcons.icDestinationPin),),
              ),
            ),
            Positioned(
              left: w * 0.625,
              top: h * 0.35,
              child: _buildScaleFade(
                begin: 0.45,
                end: 0.65,
                child: SvgPicture.asset(AppIcons.icCourierPin),
              ),
            ),
            Positioned(
              left: w * 0.685,
              top: h * 0.465,
              child: _buildScaleFade(
                begin: 0.55,
                end: 0.75,
                child: _buildPulsingPin(SvgPicture.asset(AppIcons.icOriginDot),),
              ),
            ),
            Positioned(
              left: w * 0.62,
              top: h * 0.49,
              child: _buildScaleFade(
                begin: 0.55,
                end: 0.75,
                child: _buildDestinationAddressChip(order.destination),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildScaleFade({required double begin, required double end, required Widget child}) {
    final curved = CurvedAnimation(parent: _entrance, curve: Interval(begin, end, curve: Curves.easeOutBack),);
    return FadeTransition(
      opacity: curved,
      child: ScaleTransition(
        scale: Tween<double>(begin: 0.6, end: 1).animate(curved),
        child: child,
      ),
    );
  }

  Widget _buildPulsingPin(Widget child) {
    return AnimatedBuilder(
      animation: _pulse,
      builder: (context, child) {
        final t = Curves.easeInOut.transform(_pulse.value);
        return Opacity(
          opacity: 0.75 + 0.25 * t,
          child: Transform.scale(scale: 0.94 + 0.06 * t, child: child,),
        );
      },
      child: child,
    );
  }

  Widget _buildDestinationAddressChip(String label) {
    return Container(
      padding: .symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: .circular(28),
        border: .all(color: AppColors.mapLabelBorder),
        boxShadow: [
          BoxShadow(
            color: AppColors.blackColor.withValues(alpha: 0.05),
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Text(label, style: AppTextStyles.mapChip,),
    );
  }

  Widget _buildBottomPanel(BuildContext context, OrderDetails order) {
    final bottomInset = MediaQuery.paddingOf(context).bottom;
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment(-0.8, -0.2),
          end: Alignment(0.6, 1),
          colors: [AppColors.navyDark, AppColors.navyMid],
        ),
        borderRadius: .vertical(top: .circular(30)),
        boxShadow: [
          BoxShadow(
            color: AppColors.blackColor.withValues(alpha: 0.05),
            blurRadius: 17,
            offset: Offset(0, -4),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: .min,
        children: [
          _buildCourierHeader(order),
          Container(
            width: double.infinity,
            padding: .fromLTRB(36, 28, 36, bottomInset + 24),
            decoration: BoxDecoration(
              color: AppColors.whiteColor,
              borderRadius: .only(topLeft: .circular(30), topRight: .circular(30)),
            ),
            child: Column(
              crossAxisAlignment: .start,
              spacing: 18,
              children: [
                _buildEtaSection(order),
                Divider(height: 1, thickness: 1, color: AppColors.dividerColor,),
                _buildShipperRow(order),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCourierHeader(OrderDetails order) {
    return Padding(
      padding: .fromLTRB(24, 18, 24, 18),
      child: Row(
        children: [
          Expanded(
            child: Row(
              spacing: 16,
              children: [
                ClipOval(
                  child: Image.asset(order.courierLogoPath, width: 46, height: 46, fit: .cover,),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: .start,
                    spacing: 5,
                    children: [
                      Text(order.courierName, style: AppTextStyles.courierName, maxLines: 1, overflow: .ellipsis,),
                      _buildRatingStars(order.rating),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Row(
            spacing: 16,
            children: [
              _buildActionButton(AppIcons.icChat),
              _buildActionButton(AppIcons.icCall),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRatingStars(double rating) {
    return Row(
      spacing: 2,
      children: [
        for (var i = 0; i < 5; i++)
          FadeTransition(
            opacity: CurvedAnimation(
              parent: _entrance,
              curve: Interval((0.65 + i * 0.05).clamp(0.0, 0.95), (0.75 + i * 0.05).clamp(0.0, 1.0), curve: Curves.easeOut,),
            ),
            child: Icon(
              Icons.star_rounded,
              size: 14,
              color: i < rating ? AppColors.starYellow : AppColors.iconGreyColor,
            ),
          ),
      ],
    );
  }

  Widget _buildActionButton(String icon) {
    return Container(
      padding: .all(10),
      decoration: BoxDecoration(
        color: AppColors.chatButtonBg,
        shape: .circle,
      ),
      child: SvgPicture.asset(icon, width: 22, height: 22, colorFilter: .mode(AppColors.whiteColor, .srcIn),),
    );
  }

  Widget _buildEtaSection(OrderDetails order) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: .start,
        spacing: 16,
        children: [
          Column(
            children: [
              _buildPeachIcon(Icons.access_time_rounded),
              Expanded(
                child: Container(
                  width: 1.5,
                  margin: .symmetric(vertical: 6),
                  child: CustomPaint(painter: _DashedLinePainter(),),
                ),
              ),
              Icon(Icons.change_history_rounded, size: 16, color: AppColors.primaryDark,),
            ],
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: .start,
              children: [
                Text(StringConst.estimatedDeliveryDate, style: AppTextStyles.etaLabel,),
                const SizedBox(height: 8),
                Text(order.etaDate, style: AppTextStyles.etaDate,),
                const SizedBox(height: 18),
                Text(order.origin, style: AppTextStyles.locationLabel,),
                const SizedBox(height: 18),
                Text(order.destination, style: AppTextStyles.locationLabel,),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildShipperRow(OrderDetails order) {
    return Row(
      crossAxisAlignment: .start,
      spacing: 18,
      children: [
        _buildPeachIcon(Icons.star_outline_rounded, size: 30),
        Expanded(
          child: Column(
            crossAxisAlignment: .start,
            spacing: 6,
            children: [
              Text(order.shipperName, style: AppTextStyles.shipperName, maxLines: 1, overflow: .ellipsis,),
              Text(order.amount, style: AppTextStyles.amount,),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPeachIcon(IconData icon, {double size = 34}) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: AppColors.primaryColor,
        borderRadius: .circular(size / 2),
      ),
      alignment: .center,
      child: Icon(icon, size: size * 0.5, color: AppColors.whiteColor,),
    );
  }
}

class _RoutePainter extends CustomPainter {
  const _RoutePainter({required this.progress});

  final double progress;

  @override
  void paint(Canvas canvas, Size size) {
    if (progress <= 0) return;
    final paint = Paint()
      ..color = const Color(0xFF8B6B2E)
      ..strokeWidth = 2.4
      ..style = .stroke
      ..strokeCap = .round;
    final path = Path()
      ..moveTo(size.width * 0.08, size.height * 0.08)
      ..cubicTo(
        size.width * 0.55,
        size.height * 0.05,
        size.width * 0.95,
        size.height * 0.45,
        size.width * 0.88,
        size.height * 0.92,
      );
    for (final metric in path.computeMetrics()) {
      final visibleLength = metric.length * progress.clamp(0.0, 1.0);
      var distance = 0.0;
      while (distance < visibleLength) {
        final end = (distance + 7).clamp(0.0, visibleLength);
        canvas.drawPath(metric.extractPath(distance, end), paint);
        distance += 13;
      }
    }
  }

  @override
  bool shouldRepaint(covariant _RoutePainter oldDelegate) => oldDelegate.progress != progress;
}

class _DashedLinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.primaryColor
      ..strokeWidth = 1.5
      ..style = .stroke
      ..strokeCap = .round;
    var y = 0.0;
    while (y < size.height) {
      canvas.drawLine(Offset(size.width / 2, y), Offset(size.width / 2, (y + 5).clamp(0, size.height)), paint);
      y += 10;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
