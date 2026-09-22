import 'package:logistic_tracking_ui/core/app_icons.dart';
import 'package:logistic_tracking_ui/core/models/order_details.dart';
import 'package:logistic_tracking_ui/core/models/tracking_history_item.dart';

class AppData {
  static const userName = 'Sheraz';

  static const trackingHistory = <TrackingHistoryItem>[
    TrackingHistoryItem(
      orderId: 'MK1023',
      companyName: 'Marky Logistics',
      deliveredDateLabel: 'Delivered on 23 March 2021',
      logoPath: AppIcons.markyLogo,
    ),
    TrackingHistoryItem(
      orderId: 'TY0902',
      companyName: 'Tyme technologies',
      deliveredDateLabel: 'Delivered on 09 February 2021',
      logoPath: AppIcons.tymeLogo,
    ),
    TrackingHistoryItem(
      orderId: 'GR0902',
      companyName: 'Grand technologies',
      deliveredDateLabel: 'Delivered on 09 February 2021',
      logoPath: AppIcons.grandLogo,
    ),
  ];

  static const sampleOrder = OrderDetails(
    orderId: 'TX8778',
    courierName: 'Pkart Logistics',
    courierLogoPath: AppIcons.pkartCourierLogo,
    rating: 4,
    origin: 'Mirod Road',
    destination: 'Bellaire Town',
    etaDate: '12 May 2022',
    shipperName: 'Clark Technologies',
    amount: 'INR 28,000',
    mapAssetPath: AppIcons.mapBackground,
  );

  static const orders = <OrderDetails>[sampleOrder];

  static OrderDetails orderById(String orderId) {
    for (final order in orders) {
      if (order.orderId == orderId) return order;
    }
    return sampleOrder;
  }
}
