class OrderDetails {
  final String orderId;
  final String courierName;
  final String courierLogoPath;
  final double rating;
  final String origin;
  final String destination;
  final String etaDate;
  final String shipperName;
  final String amount;
  final String mapAssetPath;

  const OrderDetails({
    required this.orderId,
    required this.courierName,
    required this.courierLogoPath,
    required this.rating,
    required this.origin,
    required this.destination,
    required this.etaDate,
    required this.shipperName,
    required this.amount,
    required this.mapAssetPath,
  });
}
