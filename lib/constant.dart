import 'package:cloud_firestore/cloud_firestore.dart';

CollectionReference usersCollection = FirebaseFirestore.instance.collection('users');

CollectionReference adminsCollection = FirebaseFirestore.instance.collection('admins');

CollectionReference tripsCollection = FirebaseFirestore.instance.
collection('trips');

String name , phone  , image , userId , userEmail ;




