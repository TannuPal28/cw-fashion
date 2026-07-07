import 'package:cw_fashion/core/network/dio_client.dart';
import 'package:cw_fashion/features/my_orders/data/models/order_list_model.dart';

class MyOrdersRemoteDeatasource {
  final DioClient dioClient;

  MyOrdersRemoteDeatasource(this.dioClient);

  Future<OrderListModel> getOrders({
    required int page,
    required int limit,
    String? status,
  }) async {
    final query = {"page": page.toString(), "limit": limit.toString()};
    if (status != null) {
      query["status"] = status;
    }

    final response = await dioClient.get("/orders", queryParameters: query);

    return OrderListModel.fromJson(response.data);
  }
}
