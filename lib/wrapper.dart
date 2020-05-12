import 'package:pinteratori/models/user.dart';
import 'package:pinteratori/screen/autentikasi/autentikasi.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pinteratori/screen/start/starting.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    
    final user = Provider.of<User>(context);
    
    if(user == null){
      return Autentikasi();
    } else {
      return MyHome();
    }
  }
}