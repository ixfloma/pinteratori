import 'package:flutter/material.dart';
import 'package:pinteratori/models/requmod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:fluttertoast/fluttertoast.dart';

class DetailRequest extends StatefulWidget {
  final Requmod requmod;
  final String roleFilter;

  DetailRequest({Key key, @required this.requmod, @required this.roleFilter}) : super(key: key);

  @override
  _DetailRequestState createState() => _DetailRequestState();
}

class _DetailRequestState extends State<DetailRequest> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
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
                      (widget.roleFilter == 'menunggu') ?
                      Padding(
                        padding: EdgeInsets.only(top: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Container(
                              height: 40,
                              width: screenWidth * 0.4,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(width: 1, color: Colors.teal)
                              ),
                              child: Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  splashColor: Colors.teal,
                                  onTap: (){
                                    try{
                                      Firestore.instance.collection('request').document(widget.requmod.id).updateData({'status':'diterima'});
                                    } catch(err){
                                      print(err.toString());
                                    }
                                    print('Accepted');
                                    Fluttertoast.showToast(msg: 'Permohonan Diterima',
                                      gravity: ToastGravity.BOTTOM,
                                      backgroundColor: Colors.teal,
                                      textColor: Colors.white,
                                      toastLength: Toast.LENGTH_SHORT
                                    );
                                    Navigator.pop(context);
                                  },
                                  child: Center(
                                    child: Text('TERIMA',
                                      style: TextStyle(
                                        color: Colors.teal,
                                      )
                                    ),
                                  ),
                                ),
                              ),                              
                            ),
                            Container(
                              height: 40,
                              width: screenWidth * 0.4,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(width: 1, color: Colors.red[800])
                              ),
                              child: Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  splashColor: Colors.red[800],
                                  onTap: (){
                                    try{
                                      Firestore.instance.collection('request').document(widget.requmod.id).updateData({'status':'ditolak'});
                                    } catch(err){
                                      print(err.toString());
                                    }
                                    print('Denied');
                                    Fluttertoast.showToast(msg: 'Permohonan Ditolak',
                                      gravity: ToastGravity.BOTTOM,
                                      backgroundColor: Colors.red[800],
                                      textColor: Colors.white,
                                      toastLength: Toast.LENGTH_SHORT
                                    );
                                    Navigator.pop(context);
                                  },
                                  child: Center(
                                    child: Text('TOLAK',
                                      style: TextStyle(
                                        color: Colors.red[800],
                                      )
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ) : Container()
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