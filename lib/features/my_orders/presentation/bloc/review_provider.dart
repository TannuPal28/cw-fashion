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
}
