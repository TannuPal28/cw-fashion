import 'package:cw_fashion/core/network/dio_client.dart';
import 'package:cw_fashion/features/all_products/data/datasources/product_detail_remote_datasource.dart';
import 'package:cw_fashion/features/all_products/data/datasources/search_remote_datasource.dart';
import 'package:cw_fashion/features/all_products/data/repositories/product_detail_repository.dart';
import 'package:cw_fashion/features/all_products/data/repositories/search_repository.dart';
import 'package:cw_fashion/features/all_products/presentation/bloc/product_detail_provider.dart';
import 'package:cw_fashion/features/all_products/presentation/bloc/search_provider.dart';
import 'package:cw_fashion/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:cw_fashion/features/auth/data/repository/auth_repository.dart';
import 'package:cw_fashion/features/auth/presentation/bloc/auth_provider.dart';
import 'package:cw_fashion/features/home/data/datasources/home_remote_datasource.dart';
import 'package:cw_fashion/features/home/data/repositories/home_repository.dart';
import 'package:cw_fashion/features/home/presentation/bloc/home_provider.dart';
import 'package:cw_fashion/features/home/presentation/pages/home_page.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) =>
              HomeProvider(HomeRepository(HomeRemoteDatasource(DioClient())))
                ..getBanners()
                ..getBrands()
                ..getCategory()
                ..getFlashSaleProducts()
                ..getTrending()
                ..getBestSellers()
                ..getNewArrivals()
                ..getFeatures(),
        ),
        ChangeNotifierProvider(
          create: (_) => SearchProvider(
            SearchRepository(SearchRemoteDatasource(DioClient())),
          ),
        ),
        ChangeNotifierProvider(
          create: (_) =>
              AuthProvider(AuthRepository(AuthRemoteDatasource(DioClient()))),
        ),

        ChangeNotifierProvider(
          create: (_) => ProductDetailProvider(
            ProductDetailRepository(ProductDetailRemoteDatasource(DioClient())),
          ),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: const HomePage(),
      ),
    );
  }
}
