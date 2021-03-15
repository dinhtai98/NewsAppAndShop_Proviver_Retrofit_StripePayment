import 'dart:convert';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:flutter_demo/models/products/department_product.dart';
import 'package:flutter_demo/models/products/product.dart';
import 'package:flutter_demo/provider/provider_shop/department_provider.dart';
import 'package:flutter_demo/screens/shop/description_products.dart';
import 'package:flutter_demo/screens/shop/list_order.dart';
import 'package:flutter_demo/screens/shop/order_details.dart';
import 'package:flutter_demo/style/theme.dart' as Style;
import 'package:flutter_demo/screens/shop/cart_shop.dart';
import 'package:flutter_demo/screens/shop/qr_scanner.dart';
import 'package:flutter_demo/provider/provider_shop/cart_products_provider.dart';
import 'package:flutter_demo/widgets/custom_page_route.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:flutter_demo/service/connectivity_service.dart';

class SourceScreen extends StatefulWidget {
  @override
  _SourceScreenState createState() => _SourceScreenState();
}

class _SourceScreenState extends State<SourceScreen> {
  // final GetProducts _getProducts = GetProducts();
  final formatter = new NumberFormat("###,###,###");

  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print("build list products");
    return FutureBuilder(
      future: DefaultAssetBundle.of(context)
          .loadString('assets/json/jsondepartment.json'),
      builder: (context, snapshot) {
        List<DepartmentProduct> data = parseJsonDepartment(snapshot.data);
        return data.isNotEmpty
            ? _buildListDepartmentProduct(data)
            : new Center(child: new CircularProgressIndicator());
      },
    );

    // _getProducts.getProducts(
    //     context, (data) => _buildHotNewsWidget(data));
  }

  List<DepartmentProduct> parseJsonDepartment(String response) {
    if (response == null) {
      return [];
    }
    final parsed =
        json.decode(response.toString()).cast<Map<String, dynamic>>();
    return parsed
        .map<DepartmentProduct>((json) => new DepartmentProduct.fromJson(json))
        .toList();
  }

  List<Product> parseJson(String response) {
    if (response == null) {
      return [];
    }
    final parsed =
        json.decode(response.toString()).cast<Map<String, dynamic>>();
    return parsed.map<Product>((json) => new Product.fromJson(json)).toList();
  }

  showSnackBar(String t) {
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text(t),
      duration: Duration(milliseconds: 500),
    ));
  }

  Widget _buildListDepartmentProduct(List<DepartmentProduct> data) {
    if (data.length == 0) {
      return Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              "No more product",
              style: TextStyle(color: Colors.black45),
            ),
          ],
        ),
      );
    } else {
      return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Center(child: Text("Shop")),
          actions: [
            IconButton(
              icon: Icon(Icons.card_travel_sharp),
              onPressed: () {
                // scan
                // Navigator.push(context,
                //     CupertinoPageRoute(builder: (context) => QRViewScanner()));
                Navigator.of(context).pushNamed(
                  ListOrder.routeName,
                );
              },
            ),
            IconButton(
              icon: Icon(Icons.qr_code_scanner),
              onPressed: () {
                // scan
                // Navigator.push(context,
                //     CupertinoPageRoute(builder: (context) => QRViewScanner()));
                Navigator.of(context).pushNamed(
                  QRViewScanner.routeName,
                );
              },
            ),
            Padding(
              padding: const EdgeInsets.only(top: 3.0),
              child: Stack(children: [
                Consumer<CartsProvider>(builder: (context, cartProvider, _) {
                  return Positioned(
                    top: 7,
                    right: 5,
                    child: cartProvider.getCountListProducts() > 0
                        ? Text(
                            cartProvider.getCountListProducts().toString(),
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 15),
                          )
                        : Text(""),
                  );
                }),
                IconButton(
                  icon: Icon(
                    Icons.shopping_cart,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    // Navigator.push(
                    //     context, BouncyPageRoute(widget: CartShop()));

                    Navigator.of(context).pushNamed(
                      CartShop.routeName,
                    );
                  },
                ),
              ]),
            ),
          ],
        ),
        body: Consumer<DepartmentProvider>(
            builder: (context, departmentProvider, _) {
          return Column(
            children: [
              Container(
                height: 50,
                padding: EdgeInsets.all(10),
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 5, bottom: 5),
                      child: GestureDetector(
                        onTap: () {
                          departmentProvider
                              .onChangedNameDepartment(data[index].id);
                          departmentProvider.getDataForDepartment();
                        },
                        child: Container(
                          width: 100.0,
                          decoration: departmentProvider.getNameDepartment() ==
                                  data[index].id
                              ? BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      Color(0xff374ABE),
                                      Color(0xff64B6FF)
                                    ],
                                    begin: Alignment.centerLeft,
                                    end: Alignment.centerRight,
                                  ),
                                  borderRadius: BorderRadius.circular(30.0),
                                  boxShadow: [
                                      BoxShadow(
                                          color: Colors.grey,
                                          offset: Offset(1, 3))
                                    ])
                              : BoxDecoration(
                                  color: Colors.grey[200],
                                  border: Border.all(color: Colors.grey[200]),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(30.0)),
                                  boxShadow: [
                                      BoxShadow(
                                          color: Colors.grey,
                                          offset: Offset(1, 3))
                                    ]),
                          child: Center(
                            child: departmentProvider.getNameDepartment() ==
                                    data[index].id
                                ? Text("${data[index].name}",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15.0))
                                : Text("${data[index].name}",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15.0)),
                          ),
                        ),
                      ),
                    );
                  },
                  itemCount: data.length,
                ),
              ),
              departmentProvider.getListData().length != 0
                  ? _buildListProduct(departmentProvider.getListData())
                  : FutureBuilder(
                      future: DefaultAssetBundle.of(context)
                          .loadString('assets/json/json.json'),
                      builder: (context, snapshot) {
                        List<Product> data = parseJson(snapshot.data);
                        return data.isNotEmpty
                            ? _buildListProduct(data)
                            : new Center(
                                child: new CircularProgressIndicator());
                      },
                    ),
            ],
          );
        }),
      );
    }
  }

  Widget _buildListProduct(List<Product> data) {
    if (data.length == 0) {
      return Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              "No more product",
              style: TextStyle(color: Colors.black45),
            ),
          ],
        ),
      );
    } else
      return Container(
        height: MediaQuery.of(context).size.height - 190,
        padding: EdgeInsets.all(5.0),
        child: new GridView.builder(
          // physics: NeverScrollableScrollPhysics(),
          itemCount: data.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, childAspectRatio: 0.85),
          itemBuilder: (context, index) {
            return Padding(
                padding: const EdgeInsets.only(left: 5.0, right: 5.0),
                child: Consumer<CartsProvider>(
                    builder: (context, cartProvider, _) {
                  return GestureDetector(
                    onTap: () {
                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (context) => DescriptionProduct(
                      //               product: data[index],
                      //             )));
                      Navigator.of(context).pushNamed(
                        DescriptionProduct.routeName,
                        arguments: DescriptionProductScreenArguments(
                          product: data[index],
                        ),
                      );
                      cartProvider.getAmountAndTotalMoney(data[index]);
                    },
                    child: Container(
                      width: 220.0,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(5.0)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey[100],
                            blurRadius: 5.0,
                            spreadRadius: 1.0,
                            offset: Offset(
                              1.0,
                              1.0,
                            ),
                          )
                        ],
                      ),
                      child: Stack(children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            Hero(
                              tag: data[index].id,
                              child: AspectRatio(
                                aspectRatio: 16 / 9,
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(5.0),
                                          topRight: Radius.circular(5.0)),
                                      image: DecorationImage(
                                          image: data[index].urlImage == null
                                              ? AssetImage(
                                                  "assets/img/placeholder.png")
                                              : Provider.of<ConnectivityStatus>(
                                                          context) !=
                                                      ConnectivityStatus.Offline
                                                  ? NetworkImage(
                                                      data[index].urlImage)
                                                  : AssetImage(
                                                      "assets/img/placeholder.png"),
                                          fit: BoxFit.contain)),
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(
                                  left: 10.0,
                                  right: 10.0,
                                  top: 15.0,
                                  bottom: 15.0),
                              child: Text(
                                data[index].name,
                                textAlign: TextAlign.center,
                                maxLines: 2,
                                style: TextStyle(height: 1.3, fontSize: 15.0),
                              ),
                            ),
                            Stack(
                              alignment: Alignment.center,
                              children: <Widget>[
                                Container(
                                  padding:
                                      EdgeInsets.only(left: 10.0, right: 10.0),
                                  width: 180,
                                  height: 1.0,
                                  color: Colors.black12,
                                ),
                                Container(
                                  width: 30,
                                  height: 3.0,
                                  color: Style.Colors.mainColor,
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "${formatter.format(int.parse(data[index].price))} đ",
                                    style: TextStyle(
                                        color: Style.Colors.mainColor,
                                        fontSize: 12.0),
                                  ),
                                  // Text(
                                  //   data[index].department,
                                  //   style: TextStyle(
                                  //       color: Style.Colors.mainColor,
                                  //       fontSize: 12.0),
                                  // ),
                                ],
                              ),
                            )
                          ],
                        ),
                        Consumer<CartsProvider>(
                            builder: (context, cartProvider, _) {
                          return Positioned(
                            top: 2,
                            right: 2,
                            child: IconButton(
                              color: Colors.red,
                              icon: Icon(
                                Icons.add_shopping_cart,
                              ),
                              onPressed: () {
                                showSnackBar(
                                    "Added ${data[index].name} to cart");
                                cartProvider.addProductToCart(data[index], 1);
                              },
                            ),
                          );
                        }),
                      ]),
                    ),
                  );
                }));
          },
        ),
      );
  }
}
