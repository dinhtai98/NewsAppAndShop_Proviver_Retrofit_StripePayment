import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:flutter_demo/provider/provider_shop/cart_products_provider.dart';
import 'dart:io';
import 'package:flutter_demo/screens/shop/info_payment.dart';
import 'package:flutter_demo/style/theme.dart' as Style;

class CartShop extends StatefulWidget {
  
  static const routeName = '/cartShop';
  @override
  _CartShopState createState() => _CartShopState();
}

class _CartShopState extends State<CartShop> {
  final formatter = new NumberFormat("###,###,###");
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    print("build cart shop");
    return Consumer<CartsProvider>(builder: (context, cartProduct, _) {
      return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text("Cart"),
        ),
        body: cartProduct.getListProducts().length > 0
            ? SingleChildScrollView(
                child: Column(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height - 150,
                    child: ListView.builder(
                      itemCount: cartProduct.getListProducts().length,
                      itemBuilder: (context, index) {
                        return Card(
                          child: Row(
                              // crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Image(
                                  width: 90,
                                  height: 90,
                                  image: NetworkImage(
                                      "${cartProduct.getListProducts()[index].product.urlImage}"),
                                ),
                                Column(
                                  children: [
                                    Container(
                                      width: 200,
                                      child: Text(
                                        '${cartProduct.getListProducts()[index].product.name}',
                                        textAlign: TextAlign.center,
                                        maxLines: 2,
                                      ),
                                    ),
                                    Text(
                                      'Amount: ${cartProduct.getListProducts()[index].amount}, \nTotal Money: ${formatter.format(cartProduct.getListProducts()[index].amount * int.parse(cartProduct.getListProducts()[index].product.price))} đ',
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    Container(
                                      width: 50,
                                      child: RaisedButton(
                                        padding: EdgeInsets.all(5),
                                        elevation: 3,
                                        color: Style.Colors.grey,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(18.0),
                                          // side: BorderSide(color: Style.Colors.mainColor)
                                        ),
                                        textColor: Style.Colors.textButton,
                                        child: Icon(Icons.add),
                                        onPressed: () {
                                          _scaffoldKey.currentState
                                              .showSnackBar(SnackBar(
                                            content: Text(
                                                'increase amount ${cartProduct.getListProducts()[index].product.name}'),
                                            duration:
                                                Duration(milliseconds: 300),
                                          ));
                                          cartProduct.increAmountProductInCart(
                                              cartProduct
                                                  .getListProducts()[index]);
                                        },
                                      ),
                                    ),
                                    Container(
                                      width: 50,
                                      child: RaisedButton(
                                        padding: EdgeInsets.all(5),
                                        elevation: 3,
                                        color: Style.Colors.grey,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(18.0),
                                          // side: BorderSide(color: Style.Colors.mainColor)
                                        ),
                                        textColor: Style.Colors.textButton,
                                        child: Icon(Icons.remove),
                                        onPressed: () {
                                          _scaffoldKey.currentState
                                              .showSnackBar(SnackBar(
                                            content: Text(
                                                'decrease amount ${cartProduct.getListProducts()[index].product.name}'),
                                            duration:
                                                Duration(milliseconds: 300),
                                          ));
                                          cartProduct.decreAmountProductInCart(
                                              cartProduct
                                                  .getListProducts()[index]
                                                  .product);
                                        },
                                      ),
                                    )
                                  ],
                                )
                              ]),
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        FlatButton(
                          // color: Colors.purple[100],
                          onPressed: () {
                            cartProduct.totalMoney();
                            print(cartProduct.getTotalMoneyInCart());
                            cartProduct.getListProducts().length > 0
                                ? Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => InFoAcountPayment(
                                            payment: "Payment Card",
                                            c: cartProduct.getListProducts())))
                                : _scaffoldKey.currentState
                                    .showSnackBar(SnackBar(
                                    content: Text('The cart is empty'),
                                  ));
                          },
                          child: Container(
                            width: 100,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey),
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.grey, offset: Offset(1, 3))
                                ]),
                            child: Image.network(
                              "https://free-now.com/fileadmin/_processed_/2/0/csm_free-now-payment-2_a5d4aa84d8.png",
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                        // Spacer(),
                        FlatButton(
                          onPressed: () {
                            cartProduct.totalMoney();
                            print(cartProduct.getTotalMoneyInCart());
                            cartProduct.getListProducts().length > 0
                                ? Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => InFoAcountPayment(
                                            payment: "Payment Native",
                                            c: cartProduct.getListProducts())))
                                : _scaffoldKey.currentState
                                    .showSnackBar(SnackBar(
                                    content: Text('The cart is empty'),
                                  ));
                          },
                          child: Platform.isIOS
                              ? Container(
                                  width: 80,
                                  height: 50,
                                  decoration: BoxDecoration(
                                      border: Border.all(color: Colors.grey),
                                      boxShadow: [
                                        BoxShadow(
                                            color: Colors.grey,
                                            offset: Offset(1, 3))
                                      ]),
                                  child: Image.network(
                                    "https://logodownload.org/wp-content/uploads/2019/09/apple-pay-logo-0.png",
                                    fit: BoxFit.fill,
                                  ),
                                )
                              : Container(
                                  width: 80,
                                  height: 50,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(color: Colors.grey),
                                      boxShadow: [
                                        BoxShadow(
                                            color: Colors.grey,
                                            offset: Offset(1, 3))
                                      ]),
                                  child: Image.network(
                                    "https://logodownload.org/wp-content/uploads/2019/09/google-pay-logo-0.png",
                                    fit: BoxFit.fill,
                                  ),
                                ),
                        )
                      ],
                    ),
                  )
                ],
              ))
            : Center(
                child: Text(
                  "The cart is empty",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 19),
                ),
              ),
      );
    });
  }
}
