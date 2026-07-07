class WalletResponse {
  final bool success;
  final Wallet wallet;

  WalletResponse({
    required this.success,
    required this.wallet,
  });

  factory WalletResponse.fromJson(Map<String, dynamic> json) {
    return WalletResponse(
      success: json["success"] ?? false,
      wallet: Wallet.fromJson(json["wallet"] ?? {}),
    );
  }
}

class Wallet {
  final String id;
  final double balance;
  final double totalCredited;
  final double totalDebited;
  final double totalReferralEarnings;
  final double totalCashback;
  final bool isActive;
  final double withdrawalMinimum;
  final String createdAt;
  final String updatedAt;

  Wallet({
    required this.id,
    required this.balance,
    required this.totalCredited,
    required this.totalDebited,
    required this.totalReferralEarnings,
    required this.totalCashback,
    required this.isActive,
    required this.withdrawalMinimum,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Wallet.fromJson(Map<String, dynamic> json) {
    return Wallet(
      id: json["_id"] ?? "",
      balance: (json["balance"] ?? 0).toDouble(),
      totalCredited: (json["totalCredited"] ?? 0).toDouble(),
      totalDebited: (json["totalDebited"] ?? 0).toDouble(),
      totalReferralEarnings:
      (json["totalReferralEarnings"] ?? 0).toDouble(),
      totalCashback: (json["totalCashback"] ?? 0).toDouble(),
      isActive: json["isActive"] ?? false,
      withdrawalMinimum:
      (json["withdrawalMinimum"] ?? 0).toDouble(),
      createdAt: json["createdAt"] ?? "",
      updatedAt: json["updatedAt"] ?? "",
    );
  }
}