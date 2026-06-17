import 'dart:async';

import 'package:cw_fashion/features/home/data/models/banners_model.dart';
import 'package:cw_fashion/features/home/data/models/brands_model.dart';
import 'package:cw_fashion/features/home/data/models/category_model.dart';
import 'package:cw_fashion/features/home/data/models/trending_model.dart';
import 'package:cw_fashion/features/home/data/repositories/home_repository.dart';
import 'package:flutter/cupertino.dart';

import '../../data/models/flash_model.dart';

class HomeProvider extends ChangeNotifier {
  final HomeRepository homeRepository;

  HomeProvider(this.homeRepository);

  bool bannerIsLoading = false;
  bool brandsIsLoading = false;
  bool categoryIsLoading = false;
  bool flashSaleIsLoading = false;
  bool trendingIsLoading = false;
  bool bestSellerIsLoading = false;
  bool newArrivalIsLoading = false;
  bool featuresIsLoading = false;

  List<BannerModel> banners = [];
  List<BrandModel> brands = [];
  List<CategoryModel> category = [];
  List<FlashSaleModel> flashSaleProducts = [];
  List<TrendingModel> trending = [];
  List<TrendingModel> bestSellers = [];
  List<TrendingModel> newArrivals = [];
  List<TrendingModel> features = [];

  Duration remainingTime = Duration.zero;
  Timer? countdownTimer;

  String get hours => remainingTime.inHours.toString().padLeft(2, '0');

  String get minutes =>
      (remainingTime.inMinutes % 60).toString().padLeft(2, '0');

  String get seconds =>
      (remainingTime.inSeconds % 60).toString().padLeft(2, '0');

  void startFlashSaleTimer(String endDate) {
    if (endDate.isEmpty) return;

    countdownTimer?.cancel();

    final endTime = DateTime.parse(endDate);
    countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      final difference = endTime.difference(DateTime.now());
      if (difference.isNegative) {
        remainingTime = Duration.zero;
        timer.cancel();
      } else {
        remainingTime = difference;
      }

      notifyListeners();
    });
  }

  Future<void> getBanners() async {
    try {
      bannerIsLoading = true;
      notifyListeners();

      banners = await homeRepository.getBanners();
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      bannerIsLoading = false;
      notifyListeners();
    }
  }

  Future<void> getBrands() async {
    try {
      brandsIsLoading = true;
      notifyListeners();

      brands = await homeRepository.getBrands();
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      brandsIsLoading = false;
      notifyListeners();
    }
  }

  Future<void> getCategory() async {
    try {
      categoryIsLoading = true;
      notifyListeners();

      category = await homeRepository.getCategories();
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      categoryIsLoading = false;
      notifyListeners();
    }
  }

  Future<void> getFlashSaleProducts() async {
    try {
      flashSaleIsLoading = true;
      notifyListeners();

      flashSaleProducts = await homeRepository.getFlashSale();

      if (flashSaleProducts.isNotEmpty &&
          flashSaleProducts.first.flashSaleEnd.isNotEmpty) {
        startFlashSaleTimer(
          flashSaleProducts.first.flashSaleEnd,
        );
      }
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      flashSaleIsLoading = false;
      notifyListeners();
    }
  }

  @override
  void dispose() {
    countdownTimer?.cancel();
    super.dispose();
  }

  Future<void> getTrending() async{
    try{
      trendingIsLoading= true;
      notifyListeners();

      trending= await homeRepository.getTrending();
    }
    catch (e) {
      debugPrint(e.toString());
    } finally {
      trendingIsLoading = false;
      notifyListeners();
    }
  }

  Future<void> getNewArrivals() async{
    try{
      newArrivalIsLoading= true;
      notifyListeners();

      newArrivals= await homeRepository.getNewArrivals();
    }
    catch (e) {
      debugPrint(e.toString());
    } finally {
      newArrivalIsLoading = false;
      notifyListeners();
    }
  }
  Future<void> getBestSellers() async{
    try{
      bestSellerIsLoading= true;
      notifyListeners();

      bestSellers= await homeRepository.getBestSellers();
    }
    catch (e) {
      debugPrint(e.toString());
    } finally {
      bestSellerIsLoading = false;
      notifyListeners();
    }
  }

  Future<void> getFeatures() async{
    try{
      featuresIsLoading= true;
      notifyListeners();

      features= await homeRepository.getFeatures();
    }
    catch (e) {
      debugPrint(e.toString());
    } finally {
      featuresIsLoading = false;
      notifyListeners();
    }
  }
}
