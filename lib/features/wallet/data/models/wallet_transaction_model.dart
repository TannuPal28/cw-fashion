class WalletTransactionResponse {
  final bool success;
  final List<WalletTransaction> transactions;
  final WalletPagination pagination;

  WalletTransactionResponse({
    required this.success,
    required this.transactions,
    required this.pagination,
  });

  factory WalletTransactionResponse.fromJson(
      Map<String, dynamic> json) {
    return WalletTransactionResponse(
      success: json["success"] ?? false,
      transactions: (json["transactions"] as List? ?? [])
          .map((e) => WalletTransaction.fromJson(e))
          .toList(),
      pagination:
      WalletPagination.fromJson(json["pagination"] ?? {}),
    );
  }
}

class WalletTransaction {
  final String id;
  final String type;
  final double amount;
  final double balanceBefore;
  final double balanceAfter;
  final String category;
  final String description;
  final String status;
  final String createdAt;

  WalletTransaction({
    required this.id,
    required this.type,
    required this.amount,
    required this.balanceBefore,
    required this.balanceAfter,
    required this.category,
    required this.description,
    required this.status,
    required this.createdAt,
  });

  factory WalletTransaction.fromJson(
      Map<String, dynamic> json) {
    return WalletTransaction(
      id: json["_id"] ?? "",
      type: json["type"] ?? "",
      amount: (json["amount"] ?? 0).toDouble(),
      balanceBefore:
      (json["balanceBefore"] ?? 0).toDouble(),
      balanceAfter:
      (json["balanceAfter"] ?? 0).toDouble(),
      category: json["category"] ?? "",
      description: json["description"] ?? "",
      status: json["status"] ?? "",
      createdAt: json["createdAt"] ?? "",
    );
  }
}

class WalletPagination {
  final int page;
  final int limit;
  final int total;
  final int totalPages;

  WalletPagination({
    required this.page,
    required this.limit,
    required this.total,
    required this.totalPages,
  });

  factory WalletPagination.fromJson(
      Map<String, dynamic> json) {
    return WalletPagination(
      page: json["page"] ?? 1,
      limit: json["limit"] ?? 20,
      total: json["total"] ?? 0,
      totalPages: json["totalPages"] ?? 1,
    );
  }
}