import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pinteratori/models/user.dart';
import 'package:pinteratori/models/requmod.dart';
import 'package:pinteratori/screen/start/tambah_request.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pinteratori/screen/start/detailrequ.dart';

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
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Request', style: TextStyle(color: Colors.black),),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: FlatButton(
          onPressed: (){
            Navigator.pop(context);
          },
          child: Icon(Icons.keyboard_backspace, color: Colors.black,),
        ),
      ),
      body: SafeArea(
        top: false,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              StreamBuilder(
                stream: getRequ(pengguna.uid),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot){
                  if(!snapshot.hasData){
                    return Container(
                      child: Center(
                        child: Text('//Loading...//', style: TextStyle(color: Colors.black, fontSize: 20),),
                      ),
                    );
                  } else {
                    if(snapshot.data.documents.length > 0){
                      var docs = snapshot.data.documents;
                      var i = -1;
                      docs.forEach((d){
                          this.plusAnimateController.add(AnimationController(duration: new Duration(milliseconds: 150), vsync: this));
                      });

                      return Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: Column(
                          children: docs.map<Widget>((data) => listRequ(context, data, i+=1, docs.length, pengguna.uid, screenWidth)).toList(),
                        ),
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
            ],
          ),
        ),
      )
    );
  }

  listRequ(context, DocumentSnapshot data, index, docLength, String uid, double screenWidth){
    Requmod requ = Requmod.fromSnapshot(data);
    Color background = Colors.orangeAccent;
    Icon status = Icon(Icons.access_time, color: Colors.deepOrange, size: 40);
    if(requ.status == 'diterima'){
      background = Colors.green;
      status = Icon(Icons.check, color: Colors.lightGreenAccent, size: 40,);
    } else
    if(requ.status == 'ditolak'){
      background = Colors.redAccent;
      status = Icon(Icons.clear, color: Colors.red[900], size: 40);
    }
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      height: 70,
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(
                builder: (context) => DetailRequest(requmod: requ,),
                fullscreenDialog: true,
              ));
          },
          splashColor: Colors.white,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 8, right: 8),
                    child: //Text(requ.kelasTuju, style: TextStyle(fontSize: 40, color: Colors.white),),
                    Center(
                      child: Container(
                        height: 50,
                        margin: EdgeInsets.symmetric(vertical: 10),
                        child: status,
                      ),
                    )
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0,8,0,8),
                    child: IntrinsicWidth(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Flexible(
                            child: Container(
                              width: screenWidth * 0.5,
                              child: Row(
                                children: <Widget>[
                                  Expanded(
                                    child: Text(requ.pemohon,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 17),
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                    ),
                                  ),                                    
                                ],
                              ),
                            ),
                          ),
                          Row(
                            children: <Widget>[
                              Text('Status: '+requ.status, style: TextStyle(color: Colors.white)),
                            ],
                          )
                        ],
                      ),
                    )
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(0, 0, 8, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Text(requ.kelasTuju, style: TextStyle(color: Colors.white, fontSize: 40))
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Stream<QuerySnapshot> getRequ(String uid){
    return Firestore.instance.collection('request').where('createdBy', isEqualTo: uid).orderBy('createdAt', descending: true).snapshots();
  }
}