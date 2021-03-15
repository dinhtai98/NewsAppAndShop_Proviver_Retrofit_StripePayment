import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_demo/models/products/orderdetail.dart';
import 'package:flutter_demo/screens/shop/order_details.dart';

class ListOrder extends StatefulWidget {
  static const routeName = '/listOrder';

  @override
  _ListOrderState createState() => _ListOrderState();
}

class _ListOrderState extends State<ListOrder> {
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
            ? _buildListOrder(data)
            : new Center(child: new CircularProgressIndicator());
      },
    );
  }

  Widget _buildListOrder(List<OrderDetail> data) {
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
          title: Text("List Order Details"),
        ),
        body: Container(
          height: double.infinity,
          child: ListView.builder(
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  Navigator.of(context).pushNamed(OrderDetails.routeName,
                      arguments: IDOrderDetailArguments(order: data[index]));
                },
                child: Card(
                  color: Colors.grey[100],
                  margin: EdgeInsets.all(10),
                  child: Container(
                      child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Text(
                          "Order #${data[index].idorder}",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        Text("${data[index].status}"),
                      ],
                    ),
                  )),
                  elevation: 5,
                ),
              );
            },
            itemCount: data.length,
          ),
        ),
      );
    }
  }
}
