import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_demo/models/products/cart.dart';
import 'package:flutter_demo/models/products/orderdetail.dart';
import 'package:intl/intl.dart';

class IDOrderDetailArguments {
  OrderDetail order;
  // String idproduct;
  IDOrderDetailArguments({this.order});
}

class OrderDetails extends StatefulWidget {
  static const routeName = '/orderDetail';
  final IDOrderDetailArguments arguments;
  const OrderDetails({Key key, @required this.arguments}) : super(key: key);
  @override
  @override
  _OrderDetailsState createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
  final formatter = new NumberFormat("###,###,###");
  List<OrderDetail> parseJson(String response) {
    if (response == null) {
      return [];
    }
    final parsed =
        json.decode(response.toString()).cast<Map<String, dynamic>>();
    return parsed
        .map<OrderDetail>((json) => new OrderDetail.fromJson(json))
        .toList();
  }

  bool drop;
  @override
  void initState() {
    drop = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print("order details build");
    return FutureBuilder(
      future: DefaultAssetBundle.of(context)
          .loadString('assets/json/orderdetails.json'),
      builder: (context, snapshot) {
        List<OrderDetail> data = parseJson(snapshot.data);
        return data.isNotEmpty
            ? _buildListProduct(data)
            : new Center(child: new CircularProgressIndicator());
      },
    );
  }

  int getTotal(List<Cart> data) {
    int sum = 0;
    for (var x in data) {
      sum += (int.parse(x.product.price) * x.amount);
    }
    return sum;
  }

  Widget _buildListProduct(List<OrderDetail> data) {
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
          appBar: AppBar(
            title: Text("Order #${widget.arguments.order.idorder}"),
          ),
          body: Column(
            children: [
              Card(
                margin: EdgeInsets.all(10),
                child: Column(
                  children: [
                    Text(
                      widget.arguments.order.receiver,
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        children: [
                          Icon(
                            Icons.phone,
                            color: Colors.blue,
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Text(
                            "${widget.arguments.order.phonenumber}",
                            style: TextStyle(fontSize: 17),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        children: [
                          Icon(
                            Icons.mail,
                            color: Colors.blue,
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Text(
                            "${widget.arguments.order.mail}",
                            style: TextStyle(fontSize: 17),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        children: [
                          Icon(
                            Icons.location_on,
                            color: Colors.blue,
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Text(
                            "${widget.arguments.order.address}",
                            style: TextStyle(fontSize: 17),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                elevation: 5,
              ),
              Card(
                margin: EdgeInsets.all(10),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            drop = !drop;
                          });
                        },
                        child: Row(
                          children: [
                            Column(
                              children: [
                                Text(
                                  "Total payment",
                                  style: TextStyle(fontSize: 17),
                                ),
                                Text(
                                  "${widget.arguments.order.cart.length} item",
                                  style: TextStyle(fontSize: 17),
                                )
                              ],
                            ),
                            Spacer(),
                            Text(
                              "${formatter.format(getTotal(widget.arguments.order.cart))} đ",
                              style: TextStyle(fontSize: 17),
                            ),
                            drop
                                ? Icon(Icons.remove)
                                : Icon(Icons.keyboard_arrow_down_sharp),
                          ],
                        ),
                      ),
                      drop
                          ? Container(
                              height: 100,
                              child: ListView.builder(
                                itemBuilder: (_, index) {
                                  return Card(
                                    color: Colors.grey[100],
                                    margin: EdgeInsets.all(8),
                                    child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Row(children: [
                                        Text(widget.arguments.order.cart[index]
                                            .product.name),
                                        Spacer(),
                                        Text(
                                            "${widget.arguments.order.cart[index].amount}")
                                      ]),
                                    ),
                                    elevation: 5,
                                  );
                                },
                                itemCount: widget.arguments.order.cart.length,
                              ))
                          : Container()
                    ],
                  ),
                ),
              ),
              Card(
                margin: EdgeInsets.all(10),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    children: [
                      Icon(
                        Icons.payment,
                        color: Colors.blue,
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Text(
                        "Payment",
                        style: TextStyle(fontSize: 17),
                      ),
                      Spacer(),
                      Text(widget.arguments.order.typeofpayment),
                    ],
                  ),
                ),
              ),
              Card(
                margin: EdgeInsets.all(10),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    children: [
                      Icon(
                        Icons.payment,
                        color: Colors.blue,
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Text(
                        "Order status",
                        style: TextStyle(fontSize: 17),
                      ),
                      Spacer(),
                      Text(widget.arguments.order.status),
                    ],
                  ),
                ),
              ),
              Card(
                margin: EdgeInsets.all(10),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.notes_sharp,
                            color: Colors.blue,
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Text(
                            "Order note",
                            style: TextStyle(fontSize: 17),
                          ),
                        ],
                      ),
                      Text(widget.arguments.order.ordernote),
                    ],
                  ),
                ),
              ),
              Spacer(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    RaisedButton(
                        onPressed: () {
                          //todo
                        },
                        child: Text("Cancel order")),
                    RaisedButton(
                        onPressed: () {
                          //to do
                        },
                        child: Text("Contact shop")),
                  ],
                ),
              )
            ],
          ));
    }
  }
}
