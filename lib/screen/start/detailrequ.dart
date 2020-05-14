import 'package:flutter/material.dart';
import 'package:pinteratori/models/requmod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class DetailRequest extends StatefulWidget {
  final Requmod requmod;

  DetailRequest({Key key, @required this.requmod}) : super(key: key);

  @override
  _DetailRequestState createState() => _DetailRequestState();
}

class _DetailRequestState extends State<DetailRequest> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: FlatButton(
          onPressed: (){
            Navigator.pop(context);
          },
          child: Icon(Icons.keyboard_backspace, color: Colors.teal,),
        ),
        title: Text('Detail', style: TextStyle(color: Colors.teal),),
      ),
      body: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: SingleChildScrollView(
            child: StreamBuilder(
              stream: Firestore.instance.collection('request').document(widget.requmod.id).snapshots(),
              builder: (context, sp) {
                if(!sp.hasData){
                  return Container(
                    child: Center(
                      child: Text('//Loading...//', style: TextStyle(color: Colors.teal, fontSize: 20),),
                    ),
                  );
                } else {
                  final DateTime dt = sp.data['createdAt'].toDate();
                  final format = DateFormat.yMMMMEEEEd();
                  return Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: Column(
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Text('NAMA PEMINJAM', style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold, color: Colors.black26)),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top:10),
                              child: Container(
                                child: Row(
                                  children: <Widget>[
                                    Flexible(
                                      child: Text(sp.data['pemohon'], style: TextStyle(fontSize: 20.0)))
                                  ],
                                ),
                              ),
                            ),
                          ],
                        )
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: Column(
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Text('TANGGAL MULAI', style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold, color: Colors.black26)),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top:10),
                              child: Container(
                                child: Row(
                                  children: <Widget>[
                                    Flexible(
                                      child: Text(sp.data['tglPinjam'], style: TextStyle(fontSize: 20.0)))
                                  ],
                                ),
                              ),
                            ),
                          ],
                        )
                      ),
                      Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: Column(
                            children: <Widget>[
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Text('TANGGAL SELESAI', style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold, color: Colors.black26)),
                                ],
                              ),
                            Padding(
                              padding: const EdgeInsets.only(top:10),
                              child: Container(
                                child: Row(
                                  children: <Widget>[
                                    Flexible(
                                      child: Text(sp.data['tglSelesai'], style: TextStyle(fontSize: 20.0)))
                                  ],
                                ),
                              ),
                            ),
                          ],
                        )
                      ),
                      Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: Column(
                            children: <Widget>[
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Text('WAKTU MULAI', style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold, color: Colors.black26)),
                                ],
                              ),
                            Padding(
                              padding: const EdgeInsets.only(top:10),
                              child: Container(
                                child: Row(
                                  children: <Widget>[
                                    Flexible(
                                      child: Text(sp.data['waktuMulai'], style: TextStyle(fontSize: 20.0)))
                                  ],
                                ),
                              ),
                            ),
                          ],
                        )
                      ),
                      Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: Column(
                            children: <Widget>[
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Text('WAKTU SELESAI', style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold, color: Colors.black26)),
                                ],
                              ),
                            Padding(
                              padding: const EdgeInsets.only(top:10),
                              child: Container(
                                child: Row(
                                  children: <Widget>[
                                    Flexible(
                                      child: Text(sp.data['waktuSelesai'], style: TextStyle(fontSize: 20.0)))
                                  ],
                                ),
                              ),
                            ),
                          ],
                        )
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: Column(
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Text('KELAS YANG DIPINJAM', style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold, color: Colors.black26)),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top:10),
                              child: Container(
                                child: Row(
                                  children: <Widget>[
                                    Flexible(
                                      child: Text('FIKLAB-'+sp.data['kelasTuju'], style: TextStyle(fontSize: 20.0)))
                                  ],
                                ),
                              ),
                            ),
                          ],
                        )
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: Column(
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Text('STATUS', style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold, color: Colors.black26)),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top:10),
                              child: Container(
                                child: Row(
                                  children: <Widget>[
                                    Flexible(
                                      child: Text(sp.data['status'], style: TextStyle(fontSize: 20.0)))
                                  ],
                                ),
                              ),
                            ),
                          ],
                        )
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: Column(
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Text('TANGGAL DIBUAT', style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold, color: Colors.black26)),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top:10),
                              child: Container(
                                child: Row(
                                  children: <Widget>[
                                    Flexible(
                                      child: Text(format.format(dt), style: TextStyle(fontSize: 20.0)))
                                  ],
                                ),
                              ),
                            ),
                          ],
                        )
                      ),
                    ],
                  ); 
                }
              }
            ),
          ),
        )
      )
    );
  }
}