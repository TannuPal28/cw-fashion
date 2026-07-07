import 'package:flutter/material.dart';
import '../../data/models/order_list_model.dart';
import '../../data/repositories/my_orders_repositories.dart';

class OrderProvider extends ChangeNotifier {
  final MyOrdersRepositories repository;

  OrderProvider(this.repository);

  bool loading = false;

  OrderListModel? orderList;

  Future<void> getOrders({String? status}) async {
    loading = true;
    notifyListeners();

    try {
      orderList = await repository.getOrders(
        page: 1,
        limit: 10,
        status: status,
      );
    } finally {
      loading = false;
      notifyListeners();
    }
  }

}