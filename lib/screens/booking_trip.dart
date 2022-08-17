import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tip_trip/constant.dart';
import 'package:tip_trip/screens/check_out.dart';
import 'package:tip_trip/widgets/snac.dart';

class BookingTrip extends StatefulWidget {
  static const id = 'BookingTrip';

  DocumentSnapshot detailTrip;
  BookingTrip({this.detailTrip});

  @override
  _BookingTripState createState() => _BookingTripState();
}

class _BookingTripState extends State<BookingTrip> {
  final nameController = TextEditingController();
  final nationalIdController = TextEditingController();
  final numberController = TextEditingController();
  final personsController = TextEditingController();
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    nameController.dispose();
    nationalIdController.dispose();
    numberController.dispose();
    personsController.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    nameController.clear();
    nationalIdController.clear();
    numberController.clear();
    personsController.clear();
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Booking Trip'),
        backgroundColor: Colors.lightBlue[900],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(60.0)),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your name';
                            }
                            return null;
                          },
                          keyboardType: TextInputType.name,
                          controller: nameController,
                          decoration: InputDecoration(
                            fillColor: Colors.white,
                            filled: true,
                            suffixIcon: Icon(Icons.person),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                                borderRadius: BorderRadius.circular(25)),
                            labelText: ' Enter Your Name',
                            //hintStyle: TextStyle(fontSize: 20)
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your national id';
                            }
                            return null;
                          },
                          keyboardType: TextInputType.number,
                          controller: nationalIdController,
                          decoration: InputDecoration(
                            fillColor: Colors.white,
                            filled: true,
                            suffixIcon: Icon(Icons.assignment_ind_outlined),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                                borderRadius: BorderRadius.circular(25)),
                            labelText: ' EnterYour National Id',
                            //hintStyle: TextStyle(fontSize: 20)
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          keyboardType: TextInputType.phone,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your phone';
                            }
                            return null;
                          },
                          controller: numberController,
                          decoration: InputDecoration(
                            fillColor: Colors.white,
                            filled: true,
                            suffixIcon: Icon(Icons.phone),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                                borderRadius: BorderRadius.circular(25)),
                            labelText: ' Enter Your Phone',
                            //hintStyle: TextStyle(fontSize: 20)
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter number of persone';
                            }
                            return null;
                          },
                          controller: personsController,
                          decoration: InputDecoration(
                            fillColor: Colors.white,
                            filled: true,
                            suffixIcon: Icon(Icons.person),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                                borderRadius: BorderRadius.circular(25)),
                            labelText: ' Enter Number Of Persons',
                            //hintStyle: TextStyle(fontSize: 20)
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 25,
              ),
              Row(
                children: [
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    'Trip Name -',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: Text(
                      widget.detailTrip.data()['name'],
                      style: TextStyle(
                        color: Colors.grey[700],
                        fontSize: 17,
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    'Days -',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: Text(
                      widget.detailTrip.data()['days'],
                      style: TextStyle(
                          color: Colors.grey[700],
                          fontSize: 17,
                          height: 1.2,
                          letterSpacing: .5),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    'Price - ',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: Text('${widget.detailTrip.data()['price']} \$',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.grey[700],
                            fontSize: 17,
                            height: 1.2,
                            letterSpacing: .5)),
                  )
                ],
              ),
              SizedBox(
                height: 40,
              ),
              Center(
                  child: InkWell(
                child: Container(
                  height: 40,
                  width: 140,
                  color: Colors.lightBlue[900],
                  child: Center(
                      child: Text(
                    'Submit',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 20),
                  )),
                ),
                onTap: () {
                  if (_formKey.currentState.validate()) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return CheckOut(
                            detailTrip: widget.detailTrip,
                            name: nameController.text,
                            phone: numberController.text,
                            nationalId: nationalIdController.text,
                            number: personsController.text,
                          );
                        },
                      ),
                    );
                  }
                },
              ))
            ],
          ),
        ),
      ),
    );
  }
}
