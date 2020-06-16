import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pinteratori/screen/service/auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pinteratori/screen/start/edit_profile.dart';
import 'package:provider/provider.dart';
import 'package:pinteratori/models/user.dart';
class StatusPage extends StatelessWidget {
  final AuthService auth = new AuthService();
  Future<String> getCurrentUserId() async{
    final FirebaseUser user = await FirebaseAuth.instance.currentUser();
    final String uidx = user.uid;
    DocumentReference sp = Firestore.instance.collection('user').document(uidx);
    var data;
    await sp.get().then((datasnp){
      if(datasnp.exists){
        data = datasnp.data['email'];
        // print(data);
      }
    });
    // print(data);
    return data;
  }
  
  @override
  Widget build(BuildContext context) {
    final pengguna = Provider.of<User>(context);
    final Size screen = MediaQuery.of(context).size;
    final AuthService _auth = AuthService();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text('Profile', style: TextStyle(color: Colors.black),),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 15),
            child: Material(
              color: Colors.transparent,
              elevation: 0,
              shape: CircleBorder(),
              clipBehavior: Clip.hardEdge,
              child: Ink(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                ),
                child: InkWell(
                  onTap: () {
                    _auth.signOutGoogle();
                  },
                  splashColor: Colors.teal,
                  child: Center(
                    child: Icon(Icons.exit_to_app, color: Colors.black),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 15),
            child: Material(
              color: Colors.transparent,
              elevation: 0,
              shape: CircleBorder(),
              clipBehavior: Clip.hardEdge,
              child: Ink(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                ),
                child: InkWell(
                  onTap: () {
                    Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(
                      builder: (context) => EditProfile(),
                      fullscreenDialog: true,
                    ));
                  },
                  splashColor: Colors.teal,
                  child: Center(
                    child: Icon(Icons.create, color: Colors.black),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(top: (screen.height * 0.15) - 50, left: screen.width * 0.05, right: screen.width * 0.05),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                StreamBuilder(
                  stream: Firestore.instance.collection('user').document(pengguna.uid).snapshots(),
                  builder: (context, snapshot) {
                    if(!snapshot.hasData){
                      return Container(
                        child: Center(
                          child: Container(
                            height: 50,
                            width: 50,
                            child: CircularProgressIndicator(),
                          )
                        ),
                      );
                    } else {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            constraints: BoxConstraints(minHeight: (screen.height * 0.2) + 50 ),
                            child: Stack(
                              children:<Widget>[
                                Container(
                                  margin: EdgeInsets.only(top: 50),
                                  constraints: BoxConstraints(
                                    minHeight: screen.height * 0.2
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: Colors.lightBlue,
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.all(8),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: <Widget>[
                                        Container(
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: <Widget>[
                                              Flexible(
                                                child: Padding(
                                                  padding: const EdgeInsets.only(top: 50),
                                                  child: Text(
                                                    snapshot.data['displayName'], 
                                                    style: TextStyle(
                                                      fontSize: 20.0, 
                                                      color: Colors.white,
                                                      fontWeight: FontWeight.bold
                                                    )
                                                  ),
                                                )
                                              )
                                            ],
                                          ),
                                        ),
                                        Container(
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: <Widget>[
                                              Flexible(
                                                child: Padding(
                                                  padding: const EdgeInsets.only(top: 12.5),
                                                  child: Text(
                                                    snapshot.data['role'], 
                                                    style: TextStyle(
                                                      fontSize: 19.0, 
                                                      color: Colors.white,
                                                      fontWeight: FontWeight.w400
                                                    )
                                                  ),
                                                )
                                              )
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ),
                                Align(
                                  alignment: Alignment.topCenter,
                                  child: Container(
                                    width: 100,
                                    height: 100,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        fit: BoxFit.fill,
                                        image: NetworkImage('https://picsum.photos/100')
                                      ),
                                      shape: BoxShape.circle,
                                      border: Border.all(color: Colors.lightBlue, width: 5)
                                    ),
                                  ),
                                )
                              ]
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top:10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Colors.lightBlue,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 15),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: <Widget>[
                                        Container(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Center(
                                              child: Icon(Icons.school, size: 0.1 * screen.width, color: Colors.white),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(left:8),
                                          child: Container(
                                            constraints: BoxConstraints(minHeight: 50),
                                            child: IntrinsicWidth(
                                              child: Column(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: <Widget>[
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    children: <Widget>[
                                                      Text('NIM', 
                                                        style: TextStyle(
                                                          color: Colors.white, 
                                                          fontSize: 19,
                                                          fontWeight: FontWeight.w300
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    children: <Widget>[
                                                      Text(snapshot.data['nim'], 
                                                        style: TextStyle(
                                                          color: Colors.white, 
                                                          fontSize: 19,
                                                          fontWeight: FontWeight.w600
                                                        ),
                                                      ),
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(bottom:15),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: <Widget>[
                                        Container(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Center(
                                              child: Icon(Icons.mail, size: 0.1 * screen.width, color: Colors.white),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(left:8),
                                          child: Container(
                                            constraints: BoxConstraints(minHeight: 50),
                                            child: IntrinsicWidth(
                                              child: Column(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: <Widget>[
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    children: <Widget>[
                                                      Text('E-Mail', 
                                                        style: TextStyle(
                                                          color: Colors.white, 
                                                          fontSize: 19,
                                                          fontWeight: FontWeight.w300
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Container(
                                                    width: screen.width * 0.65,
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.start,
                                                      children: <Widget>[
                                                        Expanded(
                                                          child: Text(snapshot.data['email'],
                                                            style: TextStyle(
                                                              color: Colors.white, 
                                                              fontSize: 19,
                                                              fontWeight: FontWeight.w600
                                                            ),
                                                            overflow: TextOverflow.ellipsis,
                                                            maxLines: 1,
                                                          ),
                                                        ),                                    
                                                      ],
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(bottom:15),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: <Widget>[
                                        Container(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Center(
                                              child: Icon(Icons.group, size: 0.1 * screen.width, color: Colors.white,),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(left:8),
                                          child: Container(
                                            constraints: BoxConstraints(minHeight: 50),
                                            child: IntrinsicWidth(
                                              child: Column(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: <Widget>[
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    children: <Widget>[
                                                      Text('Organisasi', 
                                                        style: TextStyle(
                                                          color: Colors.white, 
                                                          fontSize: 19,
                                                          fontWeight: FontWeight.w300
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Container(
                                                    width: screen.width * 0.65,
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.start,
                                                      children: <Widget>[
                                                        Expanded(
                                                          child: Text(snapshot.data['organisasi'],
                                                            style: TextStyle(
                                                              color: Colors.white, 
                                                              fontSize: 19,
                                                              fontWeight: FontWeight.w600
                                                            ),
                                                            overflow: TextOverflow.ellipsis,
                                                            maxLines: 1,
                                                          ),
                                                        ),                                    
                                                      ],
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      );
                    }
                  }
                )
              ],
            ),
          ),
        )
      ),
    );
  }
}