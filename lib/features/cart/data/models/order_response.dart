import '../../../../core/utils/utility.dart';

class OrderResponse {
  final bool success;
  final OrderModel order;

  OrderResponse({
    required this.success,
    required this.order,
  });

  factory OrderResponse.fromJson(Map<String, dynamic> json) {
    return OrderResponse(
      success: json["success"] ?? false,
      order: OrderModel.fromJson(json["order"]),
    );
  }
}

class OrderModel {
  final String id;
  final String orderNumber;
  final String status;
  final String createdAt;

  final List<OrderItem> items;

  final ShippingAddress shippingAddress;
  final BillingAddress billingAddress;

  final Payment payment;

  final double subtotal;
  final double shippingCharge;
  final double discount;
  final double total;

  OrderModel({
    required this.id,
    required this.orderNumber,
    required this.status,
    required this.createdAt,
    required this.items,
    required this.shippingAddress,
    required this.billingAddress,
    required this.payment,
    required this.subtotal,
    required this.shippingCharge,
    required this.discount,
    required this.total,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      id: json["_id"] ?? "",
      orderNumber: json["orderNumber"] ?? "",
      status: json["status"] ?? "",
      createdAt: json["createdAt"] ?? "",

      items: (json["items"] as List? ?? [])
          .map((e) => OrderItem.fromJson(e))
          .toList(),

      shippingAddress:
      ShippingAddress.fromJson(json["shippingAddress"] ?? {}),

      billingAddress:
      BillingAddress.fromJson(json["billingAddress"] ?? {}),

      payment: Payment.fromJson(json["payment"] ?? {}),

      subtotal: (json["subtotal"] ?? 0).toDouble(),
      shippingCharge: (json["shippingCharge"] ?? 0).toDouble(),
      discount: (json["discount"] ?? 0).toDouble(),
      total: (json["total"] ?? 0).toDouble(),
    );
  }
}

class OrderItem {
  final String id;
  final String product;
  final String variant;
  final String vendor;

  final String name;
  final String image;
  final String sku;
  final String color;
  final String size;

  final double mrp;
  final double price;

  final int quantity;

  final double totalPrice;
  final double finalPrice;

  final String status;

  final bool isReturnable;

  OrderItem({
    required this.id,
    required this.product,
    required this.variant,
    required this.vendor,
    required this.name,
    required this.image,
    required this.sku,
    required this.color,
    required this.size,
    required this.mrp,
    required this.price,
    required this.quantity,
    required this.totalPrice,
    required this.finalPrice,
    required this.status,
    required this.isReturnable,
  });

  factory OrderItem.fromJson(Map<String, dynamic> json) {
    return OrderItem(
      id: json["_id"] ?? "",

      product: parseId(json["product"]),

      variant: parseId(json["variant"]),

      vendor: parseId(json["vendor"]),

      name: json["name"] ?? "",

      image: json["image"] ?? "",

      sku: json["sku"] ?? "",

      color: json["color"] ?? "",

      size: json["size"] ?? "",

      mrp: (json["mrp"] ?? 0).toDouble(),

      price: (json["price"] ?? 0).toDouble(),

      quantity: json["quantity"] ?? 0,

      totalPrice: (json["totalPrice"] ?? 0).toDouble(),

      finalPrice: (json["finalPrice"] ?? 0).toDouble(),

      status: json["status"] ?? "",

      isReturnable: json["isReturnable"] ?? false,
    );
  }
}

class ShippingAddress {
  final String fullName;
  final String phone;
  final String addressLine1;
  final String addressLine2;
  final String landmark;
  final String city;
  final String state;
  final String pincode;
  final String country;

  ShippingAddress({
    required this.fullName,
    required this.phone,
    required this.addressLine1,
    required this.addressLine2,
    required this.landmark,
    required this.city,
    required this.state,
    required this.pincode,
    required this.country,
  });

  factory ShippingAddress.fromJson(Map<String, dynamic> json) {
    return ShippingAddress(
      fullName: json["fullName"] ?? "",
      phone: json["phone"] ?? "",
      addressLine1: json["addressLine1"] ?? "",
      addressLine2: json["addressLine2"] ?? "",
      landmark: json["landmark"] ?? "",
      city: json["city"] ?? "",
      state: json["state"] ?? "",
      pincode: json["pincode"] ?? "",
      country: json["country"] ?? "",
    );
  }
}

class BillingAddress {
  final String fullName;
  final String phone;
  final String addressLine1;
  final String addressLine2;
  final String city;
  final String state;
  final String pincode;
  final String country;

  BillingAddress({
    required this.fullName,
    required this.phone,
    required this.addressLine1,
    required this.addressLine2,
    required this.city,
    required this.state,
    required this.pincode,
    required this.country,
  });

  factory BillingAddress.fromJson(Map<String, dynamic> json) {
    return BillingAddress(
      fullName: json["fullName"] ?? "",
      phone: json["phone"] ?? "",
      addressLine1: json["addressLine1"] ?? "",
      addressLine2: json["addressLine2"] ?? "",
      city: json["city"] ?? "",
      state: json["state"] ?? "",
      pincode: json["pincode"] ?? "",
      country: json["country"] ?? "",
    );
  }
}

class Payment {
  final String method;
  final String status;
  final String? transactionId;
  final double refundAmount;

  Payment({
    required this.method,
    required this.status,
    this.transactionId,
    required this.refundAmount,
  });

  factory Payment.fromJson(Map<String, dynamic> json) {
    return Payment(
      method: json["method"] ?? "",
      status: json["status"] ?? "",
      transactionId: json["transactionId"],
      refundAmount: (json["refundAmount"] ?? 0).toDouble(),
    );
  }

}

extension OrderDate on OrderModel {
  String get placedDate {
    final date = DateTime.parse(createdAt);

    const months = [
      "",
      "Jan",
      "Feb",
      "Mar",
      "Apr",
      "May",
      "Jun",
      "Jul",
      "Aug",
      "Sep",
      "Oct",
      "Nov",
      "Dec"
    ];

    return "${date.day} ${months[date.month]} ${date.year}";
  }
}