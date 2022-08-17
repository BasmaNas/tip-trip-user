import 'package:flutter/material.dart';

import 'package:tip_trip/constant.dart';
import 'package:tip_trip/screens/OrderHistoryData.dart';

class OrderHistory extends StatefulWidget {
  static const id = 'OrderHistory';

  @override
  _OrderHistoryState createState() => _OrderHistoryState();
}

class _OrderHistoryState extends State<OrderHistory> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        centerTitle: true,
        title: Text('Order History'),
        backgroundColor: Colors.lightBlue[900],

      ),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 15,horizontal: 10),
        child: StreamBuilder(
            stream:usersCollection
                .doc(userId).collection('orders trip').snapshots() ,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Text('error');
              }
              if (snapshot.hasData) {
                return ListView.builder(
                    itemCount: snapshot.data.docs.length,
                    itemBuilder: (context, i) {
                      return Column(
                        children: [
                          Container(
                            padding: EdgeInsets.all(10),
                            margin: EdgeInsets.only(right: 10,left: 10),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.blue[50]
                            ),
                            child: GestureDetector(
                              child
                                  : Container(
                                width: double.infinity,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [

                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(snapshot.data.docs[i].id,
                                          style: TextStyle(
                                              fontSize: 22,
                                              fontWeight: FontWeight.bold
                                          ),),
                                      ],
                                    ),
                                    // Row(mainAxisAlignment: MainAxisAlignment.center,
                                    //   children: [
                                    //
                                    //   ],
                                    // )
                                  ],
                                ),
                              ),
                              onTap: (){ Navigator.of(context)
                                  .push(MaterialPageRoute(builder: (_) {
                                return OrderTripData(orderDetail: snapshot.data.docs[i],
                                   );
                              }));},
                            ),
                          ),
                          SizedBox(width: 200,
                            child: Divider(
                              thickness: 2,
                              color: Colors.black,
                            ),),
                        ],
                      );


                    }

                );

              }

              return Center(child: CircularProgressIndicator());

            }

        ),
      ),
    );
  }
}
