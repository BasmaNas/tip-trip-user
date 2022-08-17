import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tip_trip/constant.dart';
import 'package:tip_trip/payment/checkout.dart';
import 'package:tip_trip/payment/payment_card.dart';
import 'package:tip_trip/widgets/snac.dart';

class CheckOut extends StatefulWidget {
  static const id = 'CheckOut';
DocumentSnapshot detailTrip ;
String name , nationalId , phone , number ;
  CheckOut({this.detailTrip,this.number,this.phone,this.nationalId,this.name});
  @override
  _CheckOutState createState() => _CheckOutState();
}

class _CheckOutState extends State<CheckOut> {
  String cardNumber = '';
  // String cardHolderName = '';
  String expiryDateMonth = '';
  String expiryDateYear = '';
//  String cvv = '';
  bool showBack = false;

  FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _focusNode.addListener(() {
      setState(() {
        _focusNode.hasFocus ? showBack = true : showBack = false;
      });
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Payment'),
        backgroundColor: Colors.lightBlue[900],
      ),
      body: SingleChildScrollView(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 40,
            ),
            //  CreditCard(
            //    cardNumber: cardNumber,
            //    cardExpiry: expiryDate,
            // //   cardHolderName: cardHolderName,
            //   // cvv: cvv,
            //
            //    //showBackSide: showBack,
            //    frontBackground: CardBackgrounds.black,
            //    backBackground: CardBackgrounds.white,
            //   // showShadow: true,
            //  ),
            SizedBox(
              height: 40,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.symmetric(
                    horizontal: 20,
                  ),
                  child: TextFormField(
                    decoration: InputDecoration(hintText: 'Card Number'),
                    // maxLength: 19,
                    onChanged: (value) {
                      setState(() {
                        cardNumber = value;
                      });
                    },
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(
                    horizontal: 20,
                  ),
                  child: TextFormField(
                    decoration: InputDecoration(hintText: 'Card Expiry Month'),
                    onChanged: (value) {
                      setState(() {
                        expiryDateMonth = value;
                      });
                    },
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(
                    horizontal: 20,
                  ),
                  child: TextFormField(
                    decoration: InputDecoration(hintText: 'Card Expiry Year'),
                    // maxLength: 5,
                    onChanged: (value) {
                      setState(() {
                        expiryDateYear = value;
                      });
                    },
                  ),
                ),
                SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                Colors.lightBlue[900])),
                        onPressed: () async {
                          PaymentCard card = PaymentCard(
                              number: cardNumber,
                              expiry_month: '12',
                              expiry_year: '20${expiryDateYear}');

                          checkout payment = checkout();

                          var resultPayment =
                              await payment.makePayment(card, ((widget.detailTrip.data()['price'])*100).toInt());


                          var resultCard = await payment.getToken(card);
                          resultCard == 'card invalid!!'
                              ? ScaffoldMessenger.of(context)
                                  .showSnackBar(snac(resultCard))
                              : null;





                       if(resultPayment.toString() == 'payment Succed')   {
                            var now = new DateTime.now();
                            var formatter = new DateFormat('yyyy-MM-dd  hh:mm');
                            String formattedDatehour = formatter.format(now);

                            await usersCollection
                                .doc(userId)
                                .collection('orders trip')
                                .doc(formattedDatehour)
                                .set({
                              'name': widget.name,
                              'national id': widget.nationalId,
                              'phone': widget.phone,
                              'trip name': widget.detailTrip.data()['name'],
                              'trip price': widget.detailTrip.data()['price'],
                              'days': widget.detailTrip.data()['days'],
                              'email': userEmail,
                              'time': FieldValue.serverTimestamp(),
                              'total price':
                                  (widget.detailTrip.data()['price']) *
                                      double.parse(widget.number),
                              'no of person': widget.number,
                              'id': userId,
                            });

                            await adminsCollection
                                .doc(widget.detailTrip.data()['id'])
                                .collection('orders trip')
                                .doc(formattedDatehour)
                                .set({
                              'name': widget.name,
                              'national id': widget.nationalId,
                              'phone': widget.phone,
                              'trip name': widget.detailTrip.data()['name'],
                              'trip price': widget.detailTrip.data()['price'],
                              'days': widget.detailTrip.data()['days'],
                              'email': userEmail,
                              'time': FieldValue.serverTimestamp(),
                              'total price':
                                  (widget.detailTrip.data()['price']) *
                                      double.parse(widget.number),
                              'no of person': widget.number,
                              'id': userId,
                            }).then((value) {
                              setState(() {
                                Navigator.pop(context);
                                // ScaffoldMessenger.of(context)
                                //     .showSnackBar(snac('Data is Uploaded'));
                              });
                            });
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snac(resultPayment.toString()));                          }
                        },
                        child: Text('pay')),
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
