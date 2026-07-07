import 'package:cw_fashion/features/my_orders/data/datasources/my_orders_remote_deatasource.dart';

import '../models/order_list_model.dart';

class MyOrdersRepositories {
  MyOrdersRemoteDeatasource myOrdersRemoteDeatasource;

  MyOrdersRepositories(this.myOrdersRemoteDeatasource);

  Future<OrderListModel> getOrders({
    required int page,
    required int limit,
    String? status,
  }) {
    return myOrdersRemoteDeatasource.getOrders(page: page, limit: limit, status: status);
  }
}
