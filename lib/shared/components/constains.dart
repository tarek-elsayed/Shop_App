import 'package:shop/modules/shop_app/login/login_screen.dart';
import 'package:shop/shared/components/components.dart';
import 'package:shop/shared/network/local/cache_helper.dart';

void signOut(context) {
  CacheHelper.removeData(
    key: "token",
  ).then((value) {
    if (value) {
      navigateAndFinish(context, ShopLoginScreen());
    }
  });
}

String token = '';
