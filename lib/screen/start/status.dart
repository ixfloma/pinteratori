import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pinteratori/screen/service/auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:pinteratori/models/user.dart';

class StatusPage extends StatelessWidget {
  final AuthService auth = new AuthService();
  Future<String> getCurrentUserId() async{
    final FirebaseUser user = await FirebaseAuth.instance.currentUser();
    final String uidx = user.uid;
    DocumentReference sp = Firestore.instance.collection('user').document(uidx);
    var data;
    await sp.get().then((datasnp){
      if(datasnp.exists){
        data = datasnp.data['email'];
        print(data);
      }
    });
    // print(data);
    return data;
  }
  
  @override
  Widget build(BuildContext context) {
    final pengguna = Provider.of<User>(context);
    return Center(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            FutureBuilder(
              future: getCurrentUserId(),
              builder: (context, sp){
                if(!sp.hasData){
                  return new Text('Loading');
                } else {                  
                  return new Text(sp.data);
                }
              }
            ),
            StreamBuilder(
              stream: Firestore.instance.collection('user').document(pengguna.uid).snapshots(),
              builder: (context, sp){
                if(!sp.hasData){
                  return new Text('Loading');
                } else {
                  return new Text(sp.data['email']);
                }
              },
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Container(
                  child: FlatButton(
                    child: Text('logoutx'),
                    onPressed: () async {
                      await auth.signOutGoogle();
                      print(getCurrentUserId());
                    },
                  ),
                )
              ],
            )
          ],
        ),
    );
  }
}