import 'package:cw_fashion/features/wallet/data/datasources/wallet_remote_datasources.dart';
import 'package:cw_fashion/features/wallet/data/models/wallet_model.dart';
import 'package:cw_fashion/features/wallet/data/models/wallet_transaction_model.dart';

class WalletRepository {
  final WalletRemoteDataSource walletRemoteDataSource;

  WalletRepository(this.walletRemoteDataSource);

  Future<WalletResponse> getWallet() async {
    return await walletRemoteDataSource.getWallet();
  }

  Future<WalletTransactionResponse> getTransactions({
    int page = 1,
    int limit = 20,
  }) async {
    return await walletRemoteDataSource.getTransactions(
      page: page,
      limit: limit,
    );
  }
}
