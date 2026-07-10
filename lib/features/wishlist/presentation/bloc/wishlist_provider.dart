import 'package:flutter/cupertino.dart';

import '../../data/models/wishlist_model.dart';
import '../../data/repository/wishlist_repository.dart';

class WishlistProvider extends ChangeNotifier {

  final WishlistRepository repository;

  WishlistProvider(this.repository);

  bool loading = false;

  List<WishlistProduct> wishlist = [];
  int get wishlistCount => wishlist.length;

  Future<void> getWishlist() async {

    loading = true;
    notifyListeners();

    final response = await repository.getWishlist();

    wishlist = response.wishlist;


    loading = false;

    notifyListeners();
  }

  Future<void> remove(String id) async {

    await repository.removeWishlist(id);

    wishlist.removeWhere((e) => e.id == id);

    notifyListeners();
  }

  Future<void> clearAll() async {

    for (final item in List.of(wishlist)) {
      await repository.removeWishlist(item.id);
    }

    wishlist.clear();

    notifyListeners();
  }
}