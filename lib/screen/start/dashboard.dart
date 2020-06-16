import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:pinteratori/models/user.dart';
import 'package:pinteratori/models/requmod.dart';
import './detailrequ.dart';
import './tambah_request.dart';
import './request.dart';
import 'package:fluttertoast/fluttertoast.dart';
class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    final pengguna = Provider.of<User>(context);
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              height: size.height / 3,
              decoration: BoxDecoration(
                color: Colors.blue[600]
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: 10, bottom: 30),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            DateFormat.yMMMMEEEEd().format(DateTime.now())
                            ,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20
                            ),
                          )
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            Material(
                              shape: CircleBorder(),
                              clipBehavior: Clip.hardEdge,
                              elevation: 0,
                              color: Colors.transparent,
                              child: Ink(
                                height: 50,
                                width: 50,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.teal,
                                ),
                                child: StreamBuilder(
                                  stream: Firestore.instance.collection('user').document(pengguna.uid).snapshots(),
                                  builder: (context, sp){
                                    if(!sp.hasData){
                                      return InkResponse(
                                        highlightShape: BoxShape.circle,
                                        containedInkWell: true,
                                        splashColor: Colors.white,
                                        onTap: (){
                                          Fluttertoast.showToast(msg: 'Tunggu',
                                            gravity: ToastGravity.BOTTOM,
                                            backgroundColor: Colors.red,
                                            textColor: Colors.white,
                                            toastLength: Toast.LENGTH_SHORT
                                          );
                                        },
                                        child: Icon(Icons.add, size: 40, color: Colors.white,),
                                      );
                                    } else {
                                      if(sp.data['displayName'] == '' ||
                                          sp.data['nim'] == '' ||
                                          sp.data['organisasi'] == ''){
                                        return InkResponse(
                                          highlightShape: BoxShape.circle,
                                          containedInkWell: true,
                                          splashColor: Colors.white,
                                          onTap: (){
                                            Fluttertoast.showToast(msg: 'Harap melengkapi profil terlebih dahulu',
                                              gravity: ToastGravity.BOTTOM,
                                              backgroundColor: Colors.red,
                                              textColor: Colors.white,
                                              toastLength: Toast.LENGTH_SHORT
                                            );
                                          },
                                          child: Icon(Icons.add, size: 40, color: Colors.white,),
                                        );
                                      } else {
                                        return InkResponse(
                                          highlightShape: BoxShape.circle,
                                          containedInkWell: true,
                                          splashColor: Colors.white,
                                          onTap: (){
                                            Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(
                                              builder: (context) => RequestRuangan(),
                                              fullscreenDialog: true,
                                            ));
                                          },
                                          child: Icon(Icons.add, size: 40, color: Colors.white,),
                                        );
                                      }
                                    }
                                  },
                                )
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text('Request Baru',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15
                                    ),
                                  )
                                ],
                                ),
                            )
                          ],
                        ),
                        Column(
                          children: <Widget>[
                            Material(
                              shape: CircleBorder(),
                              clipBehavior: Clip.hardEdge,
                              elevation: 0,
                              color: Colors.transparent,
                              child: Ink(
                                height: 50,
                                width: 50,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.teal,
                                ),
                                child: InkResponse(
                                  highlightShape: BoxShape.circle,
                                  containedInkWell: true,
                                  splashColor: Colors.white,
                                  onTap: (){
                                    Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(
                                      builder: (context) => RequestPage(),
                                      fullscreenDialog: true,
                                    ));
                                  },
                                  child: Icon(Icons.list, size: 35, color: Colors.white,),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text('Daftar Request',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15
                                    ),
                                  )
                                ],
                                ),
                            )
                          ],
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text('Recent Request',
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.black45
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
              child: StreamBuilder(
                stream: getRequ(pengguna.uid, ((size.height/2) / 100).floor()),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot){
                  if(!snapshot.hasData){
                    return Container(
                      height: 0,
                      width: 0,
                    );
                  } else {
                    if(snapshot.data.documents.length > 0){
                      var docs = snapshot.data.documents;
                      var i = -1;
                      return Padding(
                        padding: const EdgeInsets.only(top: 0),
                        child: Column(
                          children: docs.map<Widget>((data) => listRecent(context, data, i+=1, docs.length, pengguna.uid, size.width)).toList(),
                        ),
                      );
                    } else {
                      return Container(
                        height: 0,
                        width: 0,
                      );
                    }
                  }
                },
              ),
            )
          ],
        ),      
      ),
    );
  }

  listRecent(context, DocumentSnapshot data, index, docLength, String uid, double screenWidth){
    Requmod requ = new Requmod.fromSnapshot(data);
    Icon status = Icon(Icons.access_time, color: Colors.deepOrange, size: 40);
    if(requ.status == 'diterima'){
      status = Icon(Icons.check, color: Colors.lightGreenAccent, size: 40,);
    } else
    if(requ.status == 'ditolak'){
      status = Icon(Icons.clear, color: Colors.red[900], size: 40);
    }

    return Container(
      height: 70,
      margin: EdgeInsets.symmetric(horizontal:10, vertical: 0),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.black54, width: 1)),
        color: Colors.white,
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
          splashColor: Colors.grey,
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
                                        color: Colors.black,
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
                              Text('Status: '+requ.status, style: TextStyle(color: Colors.black)),
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
                    Text(requ.kelasTuju, style: TextStyle(color: Colors.black, fontSize: 40))
                  ],
                ),
              )
            ],
          ),
        ),

      ),
    );
  }

  Stream<QuerySnapshot> getRequ(String uid, int length){
    return Firestore.instance.collection('request').where('createdBy', isEqualTo: uid).orderBy('createdAt', descending: true).limit(length).snapshots();
  }

  int getLength(double height){
    int length = ((height * 2 / 3) - 40).round();
    return length;
  }
}