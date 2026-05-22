import 'package:mini_pos/src/module/product_detail/binding.dart';
import 'package:mini_pos/src/module/product_detail/view.dart';
import 'package:mini_pos/src/module/search/binding.dart';
import 'package:mini_pos/src/module/search/view.dart';

import '../core/utils/get_page.dart';
import '../src/module/home/binding.dart';
import '../src/module/home/view.dart';
import '../src/module/splash/binding.dart';
import '../src/module/splash/view.dart';

class AppRoute {
  AppRoute._();

  static const splash = '/';
  static const home = '/home';
  static const search = '/search';
  static const productDetail = "/product_detail";

  static final pages = [
    customGetPage(
      name: splash,
      page: () => SplashPage(),
      binding: SplashBinding(),
    ),

    customGetPage(name: home, page: () => HomePage(), binding: HomeBinding()),
    customGetPage(
      name: search,
      page: () => SearchPage(),
      binding: SearchBinding(),
    ),
    customGetPage(
      name: productDetail,
      page: () => ProductDetailPage(),
      binding: ProductDetailBinding(),
    ),
  ];
}
