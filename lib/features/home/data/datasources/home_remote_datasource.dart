import 'dart:convert';

import 'package:cw_fashion/core/network/api_constants.dart';
import 'package:cw_fashion/core/network/dio_client.dart';
import 'package:cw_fashion/features/home/data/models/banners_model.dart';
import 'package:cw_fashion/features/home/data/models/category_model.dart';
import 'package:cw_fashion/features/home/data/models/trending_model.dart';
import 'package:dio/dio.dart';

import '../models/brands_model.dart';
import '../models/flash_model.dart';

class HomeRemoteDatasource {
  final DioClient dioClient;

  HomeRemoteDatasource(this.dioClient);

  Future<List<BannerModel>> getBanners() async {
    try {
      final response = await dioClient.get(ApiConstants.banners);

      final List banners = response.data['banners'];

      return banners.map((e) => BannerModel.fromJson(e)).toList();
    } on DioException catch (e) {
      throw Exception(e.message);
    }
  }

  Future<List<BrandModel>> getBrands() async {
    try {
      final response = await dioClient.get(ApiConstants.brands);

      final List brands = response.data['brands'];

      return brands.map((e) => BrandModel.fromJson(e)).toList();
    } on DioException catch (e) {
      throw Exception(e.message);
    }
  }

  Future<List<CategoryModel>> getCategories() async {
    try {
      final response = await dioClient.get(ApiConstants.categories);
      final List categories = response.data['categories'];
      return categories.map((e) => CategoryModel.fromJson(e)).toList();
    } on DioException catch (e) {
      throw Exception(e.message);
    }
  }

  Future<List<FlashSaleModel>> getFlashSaleProducts() async {
    try {
      final response = await dioClient.get(ApiConstants.flashSale);

      final List products = response.data['products'];

      return products.map((e) => FlashSaleModel.fromJson(e)).toList();
    } on DioException catch (e) {
      throw Exception(e.message);
    }
  }

  Future<List<TrendingModel>> getTrendingList() async {
    try {
      final response = await dioClient.get(ApiConstants.trending);

      final List products = response.data['products'];

      return products.map((e) => TrendingModel.fromJson(e)).toList();
    } on DioException catch (e) {
      throw Exception(e.message);
    }
  }
  Future<List<TrendingModel>> getNewArrivals() async {
    try {
      final response = await dioClient.get(ApiConstants.newArrivals);

      final List products = response.data['products'];

      return products.map((e) => TrendingModel.fromJson(e)).toList();
    } on DioException catch (e) {
      throw Exception(e.message);
    }
  }
  Future<List<TrendingModel>> getBestSellers() async {
    try {
      final response = await dioClient.get(ApiConstants.bestSellers);

      final List products = response.data['products'];

      return products.map((e) => TrendingModel.fromJson(e)).toList();
    } on DioException catch (e) {
      throw Exception(e.message);
    }
  }

  Future<List<TrendingModel>> getFeatures() async {
    try {
      final response = await dioClient.get(ApiConstants.featured);

      final List products = response.data['products'];

      return products.map((e) => TrendingModel.fromJson(e)).toList();
    } on DioException catch (e) {
      throw Exception(e.message);
    }
  }
}
