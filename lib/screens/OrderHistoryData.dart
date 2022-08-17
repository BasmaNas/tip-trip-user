import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tip_trip/constant.dart';
import 'package:tip_trip/widgets/detail_order.dart';

class OrderTripData extends StatefulWidget {
  static const id = 'OrderTripData';

  DocumentSnapshot orderDetail;
OrderTripData({this.orderDetail});
  @override
  _OrderTripDataState createState() => _OrderTripDataState();
}

class _OrderTripDataState extends State<OrderTripData> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlue[900],
          actions: [IconButton(onPressed: ()async{
            await usersCollection
                .doc(userId).collection('orders trip').doc(widget.orderDetail.id).delete().then((value) {
              Navigator.pop(context);

            });

          }, icon: Icon(Icons.delete, color: Colors.white,))]
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                color: Colors.lightBlue[100]
            ),
            child:Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(

                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    DesignDetail(keyData: 'Name Of Trip', value: widget.orderDetail.data()['trip name'],),
                    DesignDetail(keyData: 'Days', value: widget.orderDetail.data()['days'],),
                    DesignDetail(keyData: 'Time Of Order', value: widget.orderDetail.id,),
                    DesignDetail(keyData: 'No. OF Persons', value: widget.orderDetail.data()['no of person'],),
                    DesignDetail(keyData: 'Phone', value: widget.orderDetail.data()['phone'],),
                    DesignDetail(keyData: 'Trip Price', value: widget.orderDetail.data()['trip price'].toString(),),
                    DesignDetail(keyData: 'Date Of Trip',
                      value: widget.orderDetail.data()['date trip'].toString()=='null'? "Not Determined Yet ":widget.orderDetail.data()['date trip'].toString(),),
                    // Padding(padding: EdgeInsets.symmetric(vertical: 8),
                    // child: Row(
                    //   children: [
                    //     Text('Name Of Trip -',
                    //     style: TextStyle(
                    //       fontWeight: FontWeight.bold,
                    //       fontSize: 20
                    //     ),),
                    //
                    //   ],
                    // ),),
                    // Row(mainAxisAlignment: MainAxisAlignment.center,
                    //   children: [
                    //     Text('Name Of Trip -',
                    //       style: TextStyle(
                    //           fontSize: 18
                    //       ),),
                    //   ],
                    // )
                  ],
                ),
              ),
            ) ,
          ),
        ),
      ),

    );
  }
}
