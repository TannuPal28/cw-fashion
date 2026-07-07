import 'package:cw_fashion/core/network/dio_client.dart';

import '../models/wallet_model.dart';
import '../models/wallet_transaction_model.dart';

class WalletRemoteDataSource {
  final DioClient apiClient;

  WalletRemoteDataSource(this.apiClient);

  Future<WalletResponse> getWallet() async {
    final response = await apiClient.get("/wallet");

    return WalletResponse.fromJson(response.data);
  }

  Future<WalletTransactionResponse> getTransactions({
    int page = 1,
    int limit = 20,
  }) async {
    final response = await apiClient.get(
      "/wallet/transactions",
      queryParameters: {
        "page": page,
        "limit": limit,
      },
    );

    return WalletTransactionResponse.fromJson(response.data);
  }}