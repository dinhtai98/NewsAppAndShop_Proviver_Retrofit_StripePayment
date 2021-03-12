import 'package:flutter/material.dart';
import 'package:flutter_demo/models/products/product.dart';
import 'package:flutter_demo/widgets/custom_page_route.dart';

import 'package:intl/intl.dart';
import 'package:flutter_demo/style/theme.dart' as Style;
import 'package:provider/provider.dart';
import 'package:flutter_demo/provider/provider_shop/cart_products_provider.dart';
import 'package:flutter_demo/screens/shop/cart_shop.dart';
import 'package:flutter_demo/service/search_data_product_form_json.dart';

class DescriptionProductScreenArguments {
  Product product;
  // String idproduct;
  DescriptionProductScreenArguments({this.product});
}

class DescriptionProduct extends StatefulWidget {
  static const routeName = '/descriptionProduct';
  // final Product product;
  final DescriptionProductScreenArguments arguments;
  const DescriptionProduct({Key key, @required this.arguments})
      : super(key: key);
  @override
  _DescriptionProductState createState() => _DescriptionProductState();
}

class _DescriptionProductState extends State<DescriptionProduct> {
  // final Product product;
  // _DescriptionProductState(this.product);

  // Product p;
  // @override
  // void initState() {
  //   super.initState();
  //   // kiểm tra validation để chuyển page cho đúng từng notification

  //   // p = widget.arguments.product;
  //   // if(widget.arguments.idproduct != null){
  //   //   print(widget.arguments.idproduct);
  //   // }
  //   // else{
  //   //   print(null);
  //   // }
  //   if (widget.arguments.idproduct != null) {
  //     // như này thì có thể chuyển bình thường
  //     // làm sao để có thể get đươnc idproduct để chuyển page được
  //     Future.delayed(Duration.zero, () async {
  //       await ServiceSearchDataProduct.getDataUseID(widget.arguments.idproduct)
  //           .then((value) {
  //         p = value;

  //         print(p.id);
  //       });
  //     });
  //   } else {
  //     p = widget.arguments.product;
  //   }
  // }

  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  final formatter = new NumberFormat("###,###,###");
  @override
  Widget build(BuildContext context) {
    print("build description product");
    return Scaffold(
      key: _scaffoldKey,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(40.0),
        child: AppBar(
          iconTheme: IconThemeData(
            color: Colors.white,
          ),
          centerTitle: false,
          elevation: 0.0,
          backgroundColor: Style.Colors.mainColor,
          title: new Text(
            "",
          ),
          actions: [
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
                    // Navigator.push(context,
                    //     MaterialPageRoute(builder: (context) => CartShop()));
                    Navigator.push(
                        context, BouncyPageRoute(widget: CartShop()));
                  },
                ),
              ]),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.only(left: 15.0, right: 15.0, bottom: 15.0),
            color: Style.Colors.mainColor,
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: [
                Hero(
                  tag: widget.arguments.product.id,
                  child: SizedBox(
                      height: 280.0,
                      width: 280.0,
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(width: 2.0, color: Colors.white),
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                image: NetworkImage(
                                    "${widget.arguments.product.urlImage}"),
                                fit: BoxFit.cover)),
                      )),
                ),
                SizedBox(
                  height: 5.0,
                ),
                Text(
                  widget.arguments.product.name,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 5.0,
                ),
              ],
            ),
          ),
          Text(
            widget.arguments.product.description,
            style: TextStyle(
              color: Colors.black,
              fontSize: 12.0,
            ),
          ),
          Spacer(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Consumer<CartsProvider>(builder: (context, cartProvider, _) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    width: 50,
                    child: RaisedButton(
                      padding: EdgeInsets.all(5),
                      elevation: 3,
                      color: Style.Colors.grey,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                        // side: BorderSide(color: Style.Colors.mainColor)
                      ),
                      textColor: Style.Colors.textButton,
                      child: Icon(Icons.remove),
                      onPressed: () {
                        if (cartProvider.getAmount() > 0) {
                          cartProvider.decreAmountProductInCart(
                              widget.arguments.product);
                          // _scaffoldKey.currentState.showSnackBar(SnackBar(
                          //   content: Text(
                          //       "You have reduced the number of ${product.name}"),
                          //   duration: Duration(milliseconds: 500),
                          // ));
                        }
                      },
                    ),
                  ),
                  Text(
                    "Amount: ${cartProvider.getAmount()} ", //Total Money: ${formatter.format(cartProvider.getTotalProductMeney())}đ \n
                    textAlign: TextAlign.center,
                    maxLines: 2,
                  ),
                  Container(
                    width: 50,
                    child: RaisedButton(
                      padding: EdgeInsets.all(5),
                      elevation: 3,
                      color: Style.Colors.grey,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                        // side: BorderSide(color: Style.Colors.mainColor)
                      ),
                      textColor: Style.Colors.textButton,
                      child: Icon(Icons.add),
                      onPressed: () {
                        // cartProvider.increAmount(int.parse(product.price));
                        cartProvider.addProductToCart(
                            widget.arguments.product, 1);
                        // _scaffoldKey.currentState.showSnackBar(SnackBar(
                        //     content: Text(
                        //         "You have increased the number of ${product.name}"),
                        //     duration: Duration(milliseconds: 500)));
                      },
                    ),
                  ),
                ],
              );
            }),
          ),
        ],
      ),
    );
  }
}
