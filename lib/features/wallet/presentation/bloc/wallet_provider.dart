import 'package:cw_fashion/features/wallet/data/models/wallet_transaction_model.dart';
import 'package:cw_fashion/features/wallet/data/repository/wallet_repository.dart';
import 'package:flutter/cupertino.dart';

import '../../data/models/wallet_model.dart';

class WalletProvider extends ChangeNotifier {
  final WalletRepository repository;

  WalletProvider(this.repository);

  bool isLoading = false;
  bool transactionLoading = false;

  Wallet? wallet;
  List<WalletTransaction> transactions = [];
  int page = 1;
  int totalPages = 1;

  //wallet balance
  Future<void> getWallet() async {
    isLoading = true;
    notifyListeners();

    try {
      final response = await repository.getWallet();

      wallet = response.wallet;
    } catch (e) {
      debugPrint(e.toString());
    }

    isLoading = false;
    notifyListeners();
  }

  /// Wallet Transactions
  Future<void> getTransactions({
    bool refresh = false,
  }) async {
    if (refresh) {
      page = 1;
      transactions.clear();
    }

    transactionLoading = true;
    notifyListeners();

    try {
      final response = await repository.getTransactions(
        page: page,
        limit: 20,
      );

      totalPages = response.pagination.totalPages;

      if (page == 1) {
        transactions = response.transactions;
      } else {
        transactions.addAll(response.transactions);
      }
    } catch (e) {
      debugPrint(e.toString());
    }

    transactionLoading = false;
    notifyListeners();
  }

  /// Pagination
  Future<void> loadMore() async {
    if (page >= totalPages) return;

    page++;

    await getTransactions();
  }

  /// Initial Call
  Future<void> loadWalletData() async {
    await Future.wait([
      getWallet(),
      getTransactions(refresh: true),
    ]);
  }
}
