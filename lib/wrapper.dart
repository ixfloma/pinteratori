import 'package:pinteratori/models/user.dart';
import 'package:pinteratori/screen/autentikasi/autentikasi.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pinteratori/screen/service/auth.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    
    final user = Provider.of<User>(context);
    final AuthService _auth = AuthService();
    
    if(user == null){
      return Autentikasi();
    } else {
      return Scaffold(
        body: SafeArea(
          child: Column(
            children: <Widget>[
              StreamBuilder(
                stream: Firestore.instance.collection('user').document(user.uid).snapshots(),
                builder: (context, snapshot){
                  if(!snapshot.hasData){
                    return new Text('Loading');
                  } else {
                    return new Text(snapshot.data['email']);
                  }
                },
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Container(
                    child: FlatButton(
                      child: Text('logout'),
                      onPressed: () async {
                        await _auth.signOutGoogle();
                        print(user.uid);
                      },
                    ),
                  )
                ],
              )
            ],
          )
        ),
      );
    }
  }
}