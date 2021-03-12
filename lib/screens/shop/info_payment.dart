import 'package:flutter/material.dart';
import 'package:flutter_demo/models/products/cart.dart';
import 'package:stripe_payment/stripe_payment.dart';
import 'dart:io';

import 'package:flutter_demo/provider/provider_shop/cart_products_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_demo/screens/shop/order_details.dart';

class InFoAcountPayment extends StatefulWidget {
  final List<Cart> c;
  final String payment;

  const InFoAcountPayment({Key key, this.c, this.payment}) : super(key: key);
  @override
  _InFoAcountPaymentState createState() => _InFoAcountPaymentState();
}

class _InFoAcountPaymentState extends State<InFoAcountPayment> {
  TextEditingController txtEmail, txtSDT;

  Token _paymentToken;
  PaymentMethod _paymentMethod;
  String _error;
  final String _currentSecret = null; //set this yourself, e.g using curl
  PaymentIntentResult _paymentIntent;
  Source _source;

  ScrollController _controller = ScrollController();

  final CreditCard testCard = CreditCard(
    number: '4000002760003184',
    expMonth: 12,
    expYear: 21,
  );

  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  @override
  initState() {
    txtEmail = TextEditingController();
    txtSDT = TextEditingController();
    super.initState();

    StripePayment.setOptions(StripeOptions(
        publishableKey: "pk_test_aSaULNS8cJU6Tvo20VAXy6rp",
        merchantId: "Test",
        androidPayMode: 'test'));
  }

  void setError(dynamic error) {
    print(error);
    _scaffoldKey.currentState
        .showSnackBar(SnackBar(content: Text(error.toString())));
    setState(() {
      _error = error.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    final TextField _txtemail = TextField(
      controller: txtEmail,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
          hintText: 'Email',
          hintStyle: TextStyle(
              color: Colors.grey.withOpacity(.8),
              fontStyle: FontStyle.italic,
              fontSize: 20),
          contentPadding: EdgeInsets.all(10),
          border: InputBorder.none),
      autocorrect: false,
    );
    final TextField _txtsdt = TextField(
      controller: txtSDT,
      keyboardType: TextInputType.phone,
      decoration: InputDecoration(
          hintText: 'Phone number',
          hintStyle: TextStyle(
              color: Colors.grey.withOpacity(.8),
              fontStyle: FontStyle.italic,
              fontSize: 20),
          contentPadding: EdgeInsets.all(10),
          border: InputBorder.none),
      autocorrect: false,
    );
    return Scaffold(
      key: _scaffoldKey,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Container(
                  decoration: BoxDecoration(
                      border:
                          Border(bottom: BorderSide(color: Colors.grey[300]))),
                  child: _txtemail),
              Container(
                decoration: BoxDecoration(
                    border:
                        Border(bottom: BorderSide(color: Colors.grey[300]))),
                child: _txtsdt,
              ),
              SizedBox(
                height: 10,
              ),
              FlatButton(
                color: Color(0xFFC767E7),
                child: Text(
                  "Payment",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                onPressed: () {
                  if (txtEmail.text == "" || txtSDT.text == "") {
                    _scaffoldKey.currentState.showSnackBar(SnackBar(
                        content: Text('You have not entered the information')));
                  } else {
                    if (widget.payment == "Payment Card") {
                      StripePayment.paymentRequestWithCardForm(
                              CardFormPaymentRequest())
                          .then((paymentMethod) {
                        // _scaffoldKey.currentState.showSnackBar(
                        //     SnackBar(content: Text('Payment success')));
                        print("$txtEmail, $txtSDT");
                        setState(() {
                          _paymentMethod = paymentMethod;
                          print(widget.c);
                        });

                        Provider.of<CartsProvider>(context, listen: false)
                            .clearProductInCart();
                        Navigator.of(context).pushNamed(
                          OrderDetails.routeName,
                        );
                        // Navigator.of(context)
                        //     .popUntil((route) => route.isFirst);
                      }).catchError(setError);
                    } else {
                      if (Platform.isIOS) {
                        _controller.jumpTo(450);
                      }
                      StripePayment.paymentRequestWithNativePay(
                        androidPayOptions: AndroidPayPaymentRequest(
                          totalPrice: "1.20",
                          currencyCode: "EUR",
                        ),
                        applePayOptions: ApplePayPaymentOptions(
                          countryCode: 'DE',
                          currencyCode: 'EUR',
                          items: [
                            ApplePayItem(
                              label: 'Test',
                              amount: '13',
                            )
                          ],
                        ),
                      ).then((token) {
                        if (token != null) {
                          setState(() {
                            _paymentToken = token;
                            print(widget.c);
                          });
                          Provider.of<CartsProvider>(context, listen: false)
                              .clearProductInCart();
                          _scaffoldKey.currentState.showSnackBar(SnackBar(
                              content: Text('Received Payment success')));
                          // Navigator.of(context)
                          //     .popUntil((route) => route.isFirst);
                          Navigator.of(context).pushNamed(
                            OrderDetails.routeName,
                          );
                        } else {
                          _scaffoldKey.currentState.showSnackBar(SnackBar(
                              content: Text('Received Payment failure')));
                        }
                      }).catchError(setError);
                    }
                  }
                },
              )
            ]),
          ),
        ),
      ),
    );
  }
}
