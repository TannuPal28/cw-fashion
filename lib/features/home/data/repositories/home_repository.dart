import 'package:cw_fashion/features/home/data/datasources/home_remote_datasource.dart';
import 'package:cw_fashion/features/home/data/models/banners_model.dart';
import 'package:cw_fashion/features/home/data/models/brands_model.dart';
import 'package:cw_fashion/features/home/data/models/category_model.dart';
import 'package:cw_fashion/features/home/data/models/flash_model.dart';
import 'package:cw_fashion/features/home/data/models/trending_model.dart';

class HomeRepository {
  final HomeRemoteDatasource homeRemoteDatasource;

  HomeRepository(this.homeRemoteDatasource);

  Future<List<BannerModel>> getBanners() async{
    return await homeRemoteDatasource.getBanners();
  }

  Future<List<BrandModel>> getBrands() async{
    return await homeRemoteDatasource.getBrands();
  }

  Future<List<CategoryModel>> getCategories() async{
    return await homeRemoteDatasource.getCategories();
  }

  Future<List<FlashSaleModel>> getFlashSale() async{
    return await homeRemoteDatasource.getFlashSaleProducts();
  }

  Future<List<TrendingModel>> getTrending() async{
    return await homeRemoteDatasource.getTrendingList();
  }

  Future<List<TrendingModel>> getNewArrivals() async{
    return await homeRemoteDatasource.getNewArrivals();
  }

  Future<List<TrendingModel>> getBestSellers() async{
    return await homeRemoteDatasource.getBestSellers();
  }

  Future<List<TrendingModel>> getFeatures() async{
    return await homeRemoteDatasource.getFeatures();
  }
}