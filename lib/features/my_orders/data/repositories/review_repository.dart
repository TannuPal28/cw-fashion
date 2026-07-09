import 'dart:io';

import 'package:cw_fashion/features/my_orders/data/datasources/review_remote_datasource.dart';

import '../../../cart/data/models/my_review_response.dart';
import '../models/review_request.dart';
import '../models/review_response.dart';
import '../models/upload_response.dart';

class ReviewRepository {
  final ReviewRemoteDatasource  remoteDatasource;

  ReviewRepository(this.remoteDatasource);

  Future<List<UploadedFile>> uploadFiles(
      List<File> files) {
    return remoteDatasource.uploadFiles(files);
  }

  Future<Review> submitReview(
      ReviewRequest request) {
    return remoteDatasource.submitReview(request);
  }

  Future<List<MyReview>> getMyReviews(String orderId) {
    return remoteDatasource.getMyReviews(orderId);
  }

  Future<MyReviewResponse> getAllReviews({
    int page = 1,
  }) {
    return remoteDatasource.getAllReviews(page: page);
  }

  Future<Review> updateReview({
    required String reviewId,
    required ReviewRequest request,
  }) {
    return remoteDatasource.updateReview(
      reviewId: reviewId,
      request: request,
    );
  }
  Future<void> deleteReview(String reviewId) {
    return remoteDatasource.deleteReview(reviewId);
  }
}