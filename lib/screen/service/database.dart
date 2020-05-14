import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});

  final CollectionReference penggunaCollection = Firestore.instance.collection('user');

  Future updateUserData(String email, String uid) async {
    return await penggunaCollection.document(this.uid).setData({
      'displayName': '',
      'email': email,
      'uid': uid,
      'nim': '',
      'role': 'Mahasiswa',
      'organisasi': ''
    });
  }

}