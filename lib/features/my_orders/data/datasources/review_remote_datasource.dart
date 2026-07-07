import 'dart:io';

import 'package:cw_fashion/core/network/dio_client.dart';
import 'package:cw_fashion/features/my_orders/data/models/upload_response.dart';
import 'package:dio/dio.dart';

import '../../../cart/data/models/my_review_response.dart';
import '../models/review_request.dart';
import '../models/review_response.dart';

class ReviewRemoteDatasource {
  final DioClient dioClient;

  ReviewRemoteDatasource(this.dioClient);

  Future<List<UploadedFile>> uploadFiles(List<File> files) async {
    FormData formData = FormData();
    for (File file in files) {
      formData.files.add(
        MapEntry(
          "files",
          await MultipartFile.fromFile(
            file.path,
            filename: file.path.split("/").last,
          ),
        ),
      );
    }
    final response= await dioClient.dio.post("/upload",data: formData);
    return UploadResponse.fromJson(response.data).files;
  }

  Future<Review> submitReview(
      ReviewRequest request) async {
    final response = await dioClient.dio.post(
      "/reviews",
      data: request.toJson(),
    );

    return ReviewResponse.fromJson(response.data).review;
  }

  Future<List<MyReview>> getMyReviews(String orderId) async {
    final response = await dioClient.get(
      "/reviews/my",
      queryParameters: {
        "orderId": orderId,
        "limit": 50,
      },
    );

    return (response.data["reviews"] as List)
        .map((e) => MyReview.fromJson(e))
        .toList();
  }
}
