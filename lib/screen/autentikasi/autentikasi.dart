import 'package:flutter/material.dart';
import 'package:pinteratori/screen/autentikasi/sign_in.dart';

class Autentikasi extends StatefulWidget {
  @override
  _AutentikasiState createState() => _AutentikasiState();
}

class _AutentikasiState extends State<Autentikasi> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: SignIn(),
    );
  }
}