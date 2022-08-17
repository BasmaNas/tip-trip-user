import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:tip_trip/screens/OrderHistoryData.dart';
import 'package:tip_trip/screens/TripDetails.dart';
import 'package:tip_trip/screens/booking_trip.dart';
import 'package:tip_trip/screens/check_out.dart';
import 'package:tip_trip/screens/log_in.dart';
import 'package:tip_trip/screens/orders.dart';
import 'package:tip_trip/screens/profile.dart';
import 'package:tip_trip/screens/register.dart';
import 'package:tip_trip/screens/reset_pass.dart';
import 'package:tip_trip/screens/trips.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
 primarySwatch: Colors.blue,
      ),
      home:  Login(),
        routes: {
          Login.id : (context) =>Login(),
          Register.id : (context) =>Register(),
          Trips.id : (context) =>Trips(),
          TripDetails.id : (context) =>TripDetails(),
          Profile.id : (context) =>Profile(),
          ResetPassword.id : (context) =>ResetPassword(),
          BookingTrip.id : (context) =>BookingTrip(),
          OrderHistory.id : (context) =>OrderHistory(),
          OrderTripData.id : (context) =>OrderTripData(),
          CheckOut.id : (context) =>CheckOut(),

        }
    );
  }
}
