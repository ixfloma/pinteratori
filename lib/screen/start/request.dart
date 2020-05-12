import 'package:flutter/material.dart';
import 'package:pinteratori/models/user.dart';
import 'package:pinteratori/models/requmod.dart';
import 'package:pinteratori/screen/start/tambah_request.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RequestPage extends StatefulWidget {
  @override
  _RequestPageState createState() => _RequestPageState();
}

class _RequestPageState extends State<RequestPage> with TickerProviderStateMixin{
  List<AnimationController> plusAnimateController = [];

  List<AnimationController> plusOutAnimateController = [];

  @override
  Widget build(BuildContext context) {
    final pengguna = Provider.of<User>(context);
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          FlatButton(
            onPressed: (){
              Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(
                builder: (context) => RequestRuangan(),
                fullscreenDialog: true,
              ));
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
      body: SafeArea(
        top: false,
        child: SingleChildScrollView(
          child: StreamBuilder(
            stream: getRequ(pengguna.uid),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot){
              if(!snapshot.hasData){
                return Container(
                  child: Center(
                    child: Text('Loading...')
                  ),
                );
              } else {
                print('sslength: '+snapshot.data.documents.length.toString());
                if(snapshot.data.documents.length > 0){
                  var docs = snapshot.data.documents;
                  var i = -1;
                  docs.forEach((d){
                      this.plusAnimateController.add(AnimationController(duration: new Duration(milliseconds: 150), vsync: this));
                  });

                  return Column(
                    children: docs.map<Widget>((data) => listRequ(context, data, i+=1, docs.length, pengguna.uid)).toList(),
                  );
                } else {
                  return Container(
                    child: Center(
                      child: Text('//Kosong//')
                    ),
                  );
                }
              }
            }),
        ),
      )
    );
  }

  listRequ(context, DocumentSnapshot data, index, docLength, String uid){
    Requmod requ = Requmod.fromSnapshot(data);
    Color background = Colors.orange;
    if(requ.status == 'diterima'){
      background = Colors.green;
    } else
    if(requ.status == 'ditolak'){
      background = Colors.red;
    }
    return Container(
      decoration: BoxDecoration(
        color: background,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(requ.kelasTuju, style: TextStyle(fontSize: 40, color: Colors.white),),
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(requ.pemohon, style: TextStyle(color: Colors.white),),
                Text(requ.status, style: TextStyle(color: Colors.white))
              ],
            )
          )
        ],
      ),
    );
  }

  Stream<QuerySnapshot> getRequ(String uid){
    return Firestore.instance.collection('request').where('createdBy', isEqualTo: uid).orderBy('createdAt', descending: true).snapshots();
  }
}