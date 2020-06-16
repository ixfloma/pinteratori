import 'package:pinteratori/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pinteratori/screen/autentikasi/autentikasi.dart';
import 'package:flutter/material.dart';
import 'package:pinteratori/screen/start/orang_dalam.dart';
import 'package:provider/provider.dart';
import 'package:pinteratori/screen/start/starting.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    
    final user = Provider.of<User>(context);

    if(user == null){
      return Autentikasi();
    } else {
      return FutureBuilder(
        future: Firestore.instance.collection('user').document(user.uid).get(),
        builder: (context, sp){
          if(!sp.hasData){
            return Scaffold(
              backgroundColor: Colors.white,
              body: Center(
                child: Container(
                  height: 50,
                  width: 50,
                  child: CircularProgressIndicator(),
                )
              ),
            );
          } else {
            if(sp.data['role'] == 'Mahasiswa'){
              return MyHome();
            } else {
              return AdminLab();
            }
          }
        }
      );
    }
  }
}