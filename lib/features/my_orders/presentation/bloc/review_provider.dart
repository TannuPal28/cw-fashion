import 'dart:io';

import 'package:cw_fashion/features/my_orders/data/repositories/review_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';

import '../../../cart/data/models/my_review_response.dart';
import '../../data/models/review_request.dart';
import '../../data/models/upload_response.dart';

class ReviewProvider extends ChangeNotifier {
  final ReviewRepository reviewRepository;

  ReviewProvider(this.reviewRepository);

  final ImagePicker _picker = ImagePicker();
  bool isLoading = false;
  bool uploadingImage = false;
  bool uploadingVideo = false;
  double rating = 5;
  bool anonymous = false;
  final titleController = TextEditingController();
  final commentController = TextEditingController();
  List<File> imageFiles = [];
  File? videoFile;

  List<UploadedFile> uploadedImages = [];
  List<UploadedFile> uploadedVideos = [];

  List<MyReview> reviews = [];

  bool loading = false;
  bool loadMoreLoading = false;

  int currentPage = 1;
  int totalPages = 1;

  bool hasMore = true;

  void setRating(double value) {
    rating = value;
    notifyListeners();
  }

  void toggleAnonymous(bool value) {
    anonymous = value;
    notifyListeners();
  }

  //pick images
  Future<void> pickImages() async {
    final result = await _picker.pickMultiImage(imageQuality: 80);
    if (result.isEmpty) return;
    imageFiles = result.map((e) => File(e.path)).toList();
    notifyListeners();
    uploadingImage = true;
    notifyListeners();

    try {
      uploadedImages = await reviewRepository.uploadFiles(imageFiles);
    } finally {
      uploadingImage = false;
      notifyListeners();
    }
  }

  //pick video

  Future<void> pickVideos() async {
    final file = await _picker.pickVideo(source: ImageSource.gallery);
    if (file == null) return;
    videoFile = File(file.path);
    notifyListeners();
    uploadingVideo = true;
    notifyListeners();
    try {
      uploadedVideos = await reviewRepository.uploadFiles([videoFile!]);
    } finally {
      uploadingVideo = false;
      notifyListeners();
    }
  }

  //remove image
  void removeImage(int index) {
    imageFiles.removeAt(index);
    uploadedImages.removeAt(index);
    notifyListeners();
  }

  //remove video
  void removeVideo() {
    videoFile = null;
    uploadedVideos.clear();
    notifyListeners();
  }

  //Submit review
  Future<bool> submitReview({
    required String productId,
    required String vendorId,
    required String orderId,
    required String orderItemId,
  }) async {
    if (titleController.text.trim().isEmpty) {
      return false;
    }

    if (commentController.text.trim().isEmpty) {
      return false;
    }

    isLoading = true;
    notifyListeners();

    try {
      await reviewRepository.submitReview(
        ReviewRequest(
          productId: productId,
          vendorId: vendorId,
          orderId: orderId,
          orderItemId: orderItemId,
          rating: rating.toInt(),
          title: titleController.text.trim(),
          comment: commentController.text.trim(),
          images: uploadedImages.map((e) => e.url).toList(),
          videos: uploadedVideos.map((e) => e.url).toList(),
          isAnonymous: anonymous,
        ),
      );

      clear();

      return true;
    } catch (e) {
      return false;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  void clear() {
    rating = 5;

    anonymous = false;

    imageFiles.clear();

    uploadedImages.clear();

    videoFile = null;

    uploadedVideos.clear();

    titleController.clear();

    commentController.clear();

    notifyListeners();
  }

  @override
  void dispose() {
    titleController.dispose();
    commentController.dispose();
    super.dispose();
  }

  List<MyReview> myReviews = [];

  bool reviewLoading = false;

  Future<void> getMyReviews(String orderId) async {
    reviewLoading = true;
    notifyListeners();

    try {
      myReviews = await reviewRepository.getMyReviews(orderId);
    } finally {
      reviewLoading = false;
      notifyListeners();
    }
  }

  bool isReviewed(String orderItemId) {
    return myReviews.any((e) => e.orderItem == orderItemId);
  }

  MyReview? getReview(String orderItemId) {
    try {
      return myReviews.firstWhere(
            (e) => e.orderItem == orderItemId,
      );
    } catch (_) {
      return null;
    }
  }

  Future<void> getAllReviews() async {
    loading = true;

    currentPage = 1;
    hasMore = true;

    notifyListeners();

    try {
      final response =
      await reviewRepository.getAllReviews(page: currentPage);

      reviews = response.reviews;

      print("reviews length = ${reviews.length}");

      totalPages = response.pagination.totalPages;

      hasMore = currentPage < totalPages;
    } finally {
      loading = false;
      notifyListeners();
    }
  }

  Future<void> loadMoreReviews() async {
    if (loadMoreLoading || !hasMore) return;

    loadMoreLoading = true;
    notifyListeners();

    try {
      currentPage++;

      final response =
      await reviewRepository.getAllReviews(page: currentPage);

      reviews.addAll(response.reviews);

      totalPages = response.pagination.totalPages;

      hasMore = currentPage < totalPages;
    } finally {
      loadMoreLoading = false;
      notifyListeners();
    }
  }

  Future<void> refreshReviews() async {
    currentPage = 1;
    hasMore = true;

    await getAllReviews();
  }

  void loadReviewForEdit(MyReview review) {
    clear();

    rating = review.rating.toDouble();

    titleController.text = review.title;

    commentController.text = review.comment;

    anonymous = review.isAnonymous;

    uploadedImages = review.images
        .map(
          (e) => UploadedFile(
        url: e,
        publicId: "",
        originalName: "",
        size: 0,
        mimeType: "",
      ),
    )
        .toList();

    uploadedVideos = review.videos
        .map(
          (e) => UploadedFile(
        url: e,
        publicId: "",
        originalName: "",
        size: 0,
        mimeType: "",
      ),
    )
        .toList();

    notifyListeners();
  }

  Future<bool> updateReview({
    required String reviewId,
  }) async {
    if (titleController.text.trim().isEmpty) return false;

    if (commentController.text.trim().isEmpty) return false;

    isLoading = true;
    notifyListeners();

    try {
      await reviewRepository.updateReview(
        reviewId: reviewId,
        request: ReviewRequest(
          productId: "",
          vendorId: "",
          orderId: "",
          orderItemId: "",
          rating: rating.toInt(),
          title: titleController.text.trim(),
          comment: commentController.text.trim(),
          images: uploadedImages.map((e) => e.url).toList(),
          videos: uploadedVideos.map((e) => e.url).toList(),
          isAnonymous: anonymous,
        ),
      );

      await getAllReviews();

      clear();

      return true;
    } catch (e) {
      return false;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  void removeUploadedImage(int index) {
    uploadedImages.removeAt(index);
    notifyListeners();
  }

  void removeUploadedVideo(int index) {
    uploadedVideos.removeAt(index);
    notifyListeners();
  }

  Future<bool> deleteReview(String reviewId) async {
    isLoading = true;
    notifyListeners();

    try {
      await reviewRepository.deleteReview(reviewId);

      reviews.removeWhere((e) => e.id == reviewId);

      notifyListeners();

      return true;
    } catch (e) {
      return false;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
