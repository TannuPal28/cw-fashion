class OrderListModel {
  final bool success;
  final List<OrderItem> orders;
  final Pagination pagination;

  OrderListModel({
    required this.success,
    required this.orders,
    required this.pagination,
  });

  factory OrderListModel.fromJson(Map<String, dynamic> json) {
    return OrderListModel(
      success: json["success"] ?? false,
      orders: (json["orders"] as List? ?? [])
          .map((e) => OrderItem.fromJson(e))
          .toList(),
      pagination: Pagination.fromJson(json["pagination"] ?? {}),
    );
  }
}

class Pagination {
  final int page;
  final int limit;
  final int totalPages;
  final int totalOrders;
  final bool hasNextPage;
  final bool hasPrevPage;

  Pagination({
    required this.page,
    required this.limit,
    required this.totalPages,
    required this.totalOrders,
    required this.hasNextPage,
    required this.hasPrevPage,
  });

  factory Pagination.fromJson(Map<String, dynamic> json) {
    return Pagination(
      page: json["page"] ?? 1,
      limit: json["limit"] ?? 10,
      totalPages: json["totalPages"] ?? 1,
      totalOrders: json["totalOrders"] ?? 0,
      hasNextPage: json["hasNextPage"] ?? false,
      hasPrevPage: json["hasPrevPage"] ?? false,
    );
  }
}

class OrderItem {
  final String id;
  final String orderNumber;
  final String status;
  final String createdAt;
  final double total;
  final int totalItems;
  final Payment payment;
  final List<OrderProduct> items;

  OrderItem({
    required this.id,
    required this.orderNumber,
    required this.status,
    required this.createdAt,
    required this.total,
    required this.totalItems,
    required this.payment,
    required this.items,
  });

  factory OrderItem.fromJson(Map<String, dynamic> json) {
    return OrderItem(
      id: json["_id"] ?? "",
      orderNumber: json["orderNumber"] ?? "",
      status: json["status"] ?? "",
      createdAt: json["createdAt"] ?? "",
      total: (json["total"] ?? 0).toDouble(),
      totalItems: json["totalItems"] ?? 0,
      payment: Payment.fromJson(json["payment"] ?? {}),
      items: (json["items"] as List? ?? [])
          .map((e) => OrderProduct.fromJson(e))
          .toList(),
    );
  }
}

class Payment {
  final String method;
  final String status;

  Payment({
    required this.method,
    required this.status,
  });

  factory Payment.fromJson(Map<String, dynamic> json) {
    return Payment(
      method: json["method"] ?? "",
      status: json["status"] ?? "",
    );
  }
}

class OrderProduct {
  final String id;
  final String name;
  final String image;
  final String color;
  final String size;
  final int quantity;
  final double price;
  final double finalPrice;
  final String status;

  OrderProduct({
    required this.id,
    required this.name,
    required this.image,
    required this.color,
    required this.size,
    required this.quantity,
    required this.price,
    required this.finalPrice,
    required this.status,
  });

  factory OrderProduct.fromJson(Map<String, dynamic> json) {
    return OrderProduct(
      id: json["_id"] ?? "",
      name: json["name"] ?? "",
      image: json["image"] ?? "",
      color: json["color"] ?? "",
      size: json["size"] ?? "",
      quantity: json["quantity"] ?? 0,
      price: (json["price"] ?? 0).toDouble(),
      finalPrice: (json["finalPrice"] ?? 0).toDouble(),
      status: json["status"] ?? "",
    );
  }
}