import 'package:cw_fashion/features/wishlist/data/datasources/wishlist_remove_datasources.dart';
import 'package:cw_fashion/features/wishlist/data/models/wishlist_model.dart';

class WishlistRepository {
  final WishlistRemoveDatasources wishlistRemoveDatasources;
  WishlistRepository(this.wishlistRemoveDatasources);

  Future<WishlistResponse> getWishlist(){
    return wishlistRemoveDatasources.getWishlist();
  }

  Future<void> removeWishlist(String id) {
    return wishlistRemoveDatasources.removeWishlist(id);
  }
}