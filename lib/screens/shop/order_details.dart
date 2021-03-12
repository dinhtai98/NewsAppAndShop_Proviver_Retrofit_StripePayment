import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_demo/models/products/orderdetail.dart';

class OrderDetails extends StatefulWidget {
  static const routeName = '/orderDetail';
  @override
  _OrderDetailsState createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
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

  @override
  Widget build(BuildContext context) {
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
          title: Text("Order Details"),
        ),
        body: Container(
          height: 200,
          child: ListView.builder(
            itemBuilder: (context, index) {
              return Column(
                children: [
                  Text("${data[index].status}"),
                  Container(
                      height: 100,
                      child: ListView.builder(
                        itemBuilder: (context, index1) {
                          return Column(
                            children: [
                              Text("${data[index].cart[index1].product.name}"),
                              Text("${data[index].cart[index1].amount}"),
                            ],
                          );
                        },
                        itemCount: data[index].cart.length,
                      ))
                ],
              );
            },
            itemCount: data.length,
          ),
        ),
      );
    }
  }
}
