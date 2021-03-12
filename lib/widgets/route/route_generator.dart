import 'package:flutter/material.dart';
import 'package:flutter_demo/models/article.dart';
import 'package:flutter_demo/models/products/product.dart';
import 'package:flutter_demo/models/source.dart';
import 'package:flutter_demo/screens/main_screen.dart';
import 'package:flutter_demo/screens/news_detail.dart';
import 'package:flutter_demo/screens/shop/cart_shop.dart';
import 'package:flutter_demo/screens/shop/description_products.dart';
import 'package:flutter_demo/screens/shop/qr_scanner.dart';
import 'package:flutter_demo/screens/source_detail.dart';
import 'package:flutter_demo/widgets/custom_page_route.dart';
import 'package:flutter_demo/screens/shop/order_details.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // Getting arguments passed in while calling Navigator.pushNamed
    final args = settings.arguments;
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => MainScreen());
      case DetailNews.routeName:
        if (args is ArticleModel) {
          return MaterialPageRoute(
            builder: (_) => DetailNews(
              article: args,
            ),
          );
        }
        return _errorRoute();

      case SourceDetail.routeName:
        if (args is SourceModel) {
          return MaterialPageRoute(
            builder: (_) => SourceDetail(
              source: args,
            ),
          );
        }
        return _errorRoute();
      case QRViewScanner.routeName:
        return MaterialPageRoute(builder: (_) => QRViewScanner());
      case CartShop.routeName:
        return BouncyPageRoute(widget: CartShop());
      case OrderDetails.routeName:
        return BouncyPageRoute(widget: OrderDetails());
      case DescriptionProduct.routeName:
        return MaterialPageRoute(
          builder: (_) => DescriptionProduct(arguments: settings.arguments,),
          settings: settings,
        );
        return _errorRoute();

      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Error'),
        ),
        body: Center(
          child: Text('ERROR'),
        ),
      );
    });
  }
}
