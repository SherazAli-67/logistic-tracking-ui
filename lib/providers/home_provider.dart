import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

import '../core/app_data.dart';
import '../routing/router.dart';

class HomeProvider extends ChangeNotifier{
  final TextEditingController orderNumController = .new();

  @override
  void dispose() {
    super.dispose();
    orderNumController.dispose();
  }


  void onOrderItemTap(BuildContext context, {String? orderID}) {
    String orderId = orderID ?? orderNumController.text.trim();
    final id = (orderId.isEmpty) ? AppData.sampleOrder.orderId : orderId;
    context.push(NamedRoutes.order.pathFor(id));
  }
}