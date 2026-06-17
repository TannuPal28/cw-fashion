import 'package:cw_fashion/core/network/dio_client.dart';
import 'package:cw_fashion/features/home/data/datasources/home_remote_datasource.dart';
import 'package:cw_fashion/features/home/data/repositories/home_repository.dart';
import 'package:cw_fashion/features/home/presentation/bloc/home_provider.dart';
import 'package:cw_fashion/features/home/presentation/pages/home_page.dart';
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
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: const HomePage(),
      ),
    );
  }
}
