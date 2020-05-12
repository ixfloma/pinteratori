import 'package:flutter/material.dart';
import 'package:pinteratori/models/user.dart';
import 'package:provider/provider.dart';

class RequestPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final pengguna = Provider.of<User>(context);
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          FlatButton(
            onPressed: (){
              print('New Request');
            },
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(Icons.create),
                  Text('Request')
                ],
              )
            )
          )
        ],
      ),
      body: Center(
        child: Text('Page Request of'+pengguna.uid),
      ),
    );
  }
}