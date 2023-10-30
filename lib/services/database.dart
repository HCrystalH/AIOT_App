import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService{

  final String uid;
  DatabaseService({required this.uid});
  // collection reference
  final CollectionReference userCollection = FirebaseFirestore.instance.collection('User');

  final db = FirebaseFirestore.instance;
  /*
    Function to update data
  */
  Future updateUserData (String username, String password) async{
    return await userCollection.doc(uid).set(
      {
        'username': username,
        'password': password,
      }
    );
  }

  //get User stream
  Stream<QuerySnapshot> get User{
    return userCollection.snapshots();
  }
}

