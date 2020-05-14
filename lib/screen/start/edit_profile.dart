import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:pinteratori/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class EditProfile extends StatefulWidget {
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  TextEditingController displaynameCtrl = TextEditingController(text:'');
    TextEditingController nimCtrl = TextEditingController(text:'');
    TextEditingController organisasiCtrl = TextEditingController(text:'');
    String email, role;
    bool isNotValidForm = true;
    bool isInit = true;

    Column buildField({
      @required String labelName,
      @required String placeholder,
      Widget prefix,
      double fontSize = 14.0,
      TextInputType keyboardType = TextInputType.text,
      onChanged,
      controller = null
    }){
      return Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(bottom: 5.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Text(labelName,
                  style: TextStyle(
                    fontSize: 14.0,
                    color: Colors.black26,
                    fontWeight: FontWeight.bold
                  ),
                ),
              ],
            ),
          ),
          TextField(
            controller: controller,
            decoration: InputDecoration(
              hintText: placeholder,
              prefix: prefix,
              contentPadding: EdgeInsets.only(top: 10.0, bottom: 10.0, left: 1.0),
              border: null,
            ),
            style: TextStyle(fontSize: 20, color: Colors.black),
            keyboardType: keyboardType,
            autocorrect: false,
            onChanged: (text) {
              setState(() {
                isNotValidForm = (
                  displaynameCtrl.text == '' ||
                  nimCtrl.text == '' ||
                  organisasiCtrl.text == ''
                ) ? true : false;
              });
            },
          ),
        ],
      );
    }
  void sendData(String uid, String email, String role){
    var data = {
      'displayName': displaynameCtrl.text,
      'email': email,
      'nim': nimCtrl.text,
      'organisasi': organisasiCtrl.text,
      'role': role,
      'uid': uid
    };
    Firestore.instance.collection('user').document(uid).updateData(data);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final pengguna = Provider.of<User>(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text('Edit', style: TextStyle(color: Colors.teal)),
        leading: Material(
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
                Navigator.pop(context);
              },
              splashColor: Colors.teal,
              child: Center(
                child: Icon(Icons.keyboard_backspace, color: Colors.teal),
              ),
            ),
          ),
        ),
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
                    if(isNotValidForm){
                      Fluttertoast.showToast(msg: 'Harap mengisi semua data!',
                        gravity: ToastGravity.BOTTOM,
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                        toastLength: Toast.LENGTH_SHORT
                      );
                    } else {
                      sendData(pengguna.uid, email, role);
                    }
                  },
                  splashColor: Colors.teal,
                  child: Center(
                    child: Icon(Icons.check, color: Colors.teal),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: StreamBuilder(
            stream: Firestore.instance.collection('user').document(pengguna.uid).snapshots(),
            builder: (context, snapshot){
              if(!snapshot.hasData){
                return Container(
                  child: Center(
                    child: Text('//Loading...//', style: TextStyle(color: Colors.black, fontSize: 20),),
                  ),
                );
              } else {
                if(isNotValidForm && isInit){
                  if(snapshot.data['nim'] != ''){
                  nimCtrl.value = nimCtrl.value.copyWith(text:snapshot.data['nim']);
                  // nimCtrl.text = snapshot.data['nim'];
                  }
                  if(snapshot.data['displayName'] != ''){
                    displaynameCtrl.text = snapshot.data['displayName'];
                  }
                  if(snapshot.data['organisasi'] != ''){
                    organisasiCtrl.text = snapshot.data['organisasi'];
                  }  
                  if(snapshot.data['nim'] != '' &&
                    snapshot.data['displayName'] != '' &&
                    snapshot.data['organisasi'] != ''){
                    isNotValidForm = false;
                    isInit = false;
                  }
                }
                email = snapshot.data['email'];
                role = snapshot.data['role'];
                return Padding(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(top: 35),
                        child: buildField(labelName: 'NAMA MAHASISWA', placeholder: 'Nama', controller: displaynameCtrl)
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 35),
                        child: Column(
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Text('EMAIL', style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold, color: Colors.black26)),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top:5),
                              child: Container(
                                constraints: BoxConstraints(minHeight: 30),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.max,
                                  children: <Widget>[
                                    Text(snapshot.data['email'], style: TextStyle(fontSize: 20.0)),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        )
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 35),
                        child: buildField(labelName: 'NIM MAHASISWA', placeholder: 'NIM', controller: nimCtrl)
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 35),
                        child: buildField(labelName: 'ORGANISASI MAHASISWA', placeholder: 'Organisasi UPNVJ', controller: organisasiCtrl)
                      ),
                    ],
                  ),
                );
              }
            }
          ),
        )
      ),
    );
  }
}