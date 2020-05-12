import 'package:flutter/material.dart';
import 'dart:async';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:pinteratori/models/user.dart';
import 'package:fluttertoast/fluttertoast.dart';
class RequestRuangan extends StatefulWidget {
  @override
  _RequestRuanganState createState() => _RequestRuanganState();
}

class _RequestRuanganState extends State<RequestRuangan> {
  TextEditingController requestorCtrl = TextEditingController(text:'');
  DateTime startDate = new DateTime.now();
  DateTime endDate = new DateTime.now();
  TimeOfDay endTime = new TimeOfDay.now();
  TimeOfDay startTime = new TimeOfDay.now();
  bool isNotValidForm = true;
  RoomModel selected;
  List<RoomModel> dataKelas = <RoomModel>[
    new RoomModel(isSelected: true, roomNumber: '301'),
    new RoomModel(isSelected: true, roomNumber: '302'),
    new RoomModel(isSelected: true, roomNumber: '303'),
    new RoomModel(isSelected: true, roomNumber: '304'),
    new RoomModel(isSelected: true, roomNumber: '401'),
    new RoomModel(isSelected: true, roomNumber: '403'),
    new RoomModel(isSelected: true, roomNumber: '402'),
  ];
  @override
  void initState(){
    super.initState();
    // dataKelas.add(new RoomModel(isSelected: true, roomNumber: '301'));
    // dataKelas.add(new RoomModel(isSelected: false, roomNumber: '302'));
    // dataKelas.add(new RoomModel(isSelected: false, roomNumber: '303'));
    // dataKelas.add(new RoomModel(isSelected: false, roomNumber: '304'));
    // dataKelas.add(new RoomModel(isSelected: false, roomNumber: '401'));
    // dataKelas.add(new RoomModel(isSelected: false, roomNumber: '402'));
    // dataKelas.add(new RoomModel(isSelected: false, roomNumber: '403'));
  }

  Future<Null> _selectDate(BuildContext context, String kapan) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: startDate,
      firstDate: startDate,
      lastDate: startDate.add(
        new Duration(days: 365)
        )
      );
    
    if(picked != null && picked != startDate){
      print('Date selected: '+picked.toString());
      setState(() {
        if(kapan == 'start'){
          startDate = picked;
        } else
        if(kapan == 'end'){
          endDate = picked;
        }
      });
    }
  }

  Future<Null> _selectTime(BuildContext context, String kapan) async {
    final TimeOfDay picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay(hour: 8, minute: 0)
    );
    
    if(picked != null && picked != startTime){
      print('Time selected: '+picked.toString());
      setState(() {
        if(kapan == 'start'){
          startTime = picked;
        } else
        if(kapan == 'end'){
          endTime = picked;
        }
        
      });
    }
  }

  sendData(String uid){
    var uuid = new Uuid();
    String id = uuid.v4();
    List pemohon = requestorCtrl.text.split(' ');
    String tglPinjam = new DateFormat.yMMMMEEEEd().format(startDate);
    String tglSelesai = new DateFormat.yMMMMEEEEd().format(endDate);
    var data = {
      'id': id,
      'pemohon': requestorCtrl.text,
      'kelasTuju': selected.roomNumber,
      'tglPinjam': tglPinjam,
      'tglSelesai': tglSelesai,
      'waktuMulai': startTime.hour.toString()+':'+startTime.minute.toString(),
      'waktuSelesai': endTime.hour.toString()+':'+endTime.minute.toString(),
      'status': 'menunggu',
      'createdAt':Timestamp.now(),
      'createdBy': uid,
      'label': pemohon
    };

    Firestore.instance.collection('request').document(id).setData(data);
    Navigator.pop(context);
  }

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
                  requestorCtrl.text == ''
                ) ? true : false;
              });
            },
          ),
        ],
      );
    }

  @override
  Widget build(BuildContext context) {
    final pengguna = Provider.of<User>(context);
    String formattedStartDate = new DateFormat.yMMMMEEEEd().format(startDate);
    String formattedEndDate = new DateFormat.yMMMMEEEEd().format(endDate);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text('Form', style: TextStyle(color: Colors.teal),),
        leading: FlatButton(
          onPressed: (){
            Navigator.pop(context);
          },
          child: Icon(Icons.keyboard_backspace, color: Colors.teal,),
        ),
        actions: <Widget>[
          FlatButton.icon(
            onPressed: (){
              if(requestorCtrl.text == ''){
                Fluttertoast.showToast(msg: 'Harap mengisi nama/organisasi!',
                gravity: ToastGravity.BOTTOM,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                toastLength: Toast.LENGTH_SHORT
                );
              } else
              if(selected == null){
                Fluttertoast.showToast(msg: 'Harap mengisi lab yang akan dipinjam!',
                gravity: ToastGravity.BOTTOM,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                toastLength: Toast.LENGTH_SHORT
                );
              } else {
                sendData(pengguna.uid);
              }
            },
            icon: Icon(Icons.send, color: Colors.teal),
            label: Text('Mengirim')
          )
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: buildField(placeholder: 'Awanama', labelName: 'NAMA PEMOHON', controller: requestorCtrl)
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Column(
                    children: <Widget>[
                      Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Text('TANGGAL PEMINJAMAN', style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold, color: Colors.black26)),
                          ],
                        ),
                      Padding(
                        padding: const EdgeInsets.only(top:10),
                        child: InkWell(
                          onTap:(){
                            _selectDate(context,'start');
                          },
                          child: Container(
                            constraints: BoxConstraints(minHeight: 40),
                            // decoration: BoxDecoration(color: Colors.teal),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              mainAxisSize: MainAxisSize.max,
                              children: <Widget>[
                                Text(formattedStartDate, style: TextStyle(fontSize: 20.0)),
                              ],
                            ),
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
                        child: InkWell(
                          onTap:(){
                            _selectDate(context,'end');
                          },
                          child: Container(
                            constraints: BoxConstraints(minHeight: 40),
                            // decoration: BoxDecoration(color: Colors.teal),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              mainAxisSize: MainAxisSize.max,
                              children: <Widget>[
                                Text(formattedEndDate, style: TextStyle(fontSize: 20.0)),
                              ],
                            ),
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
                        child: InkWell(
                          onTap:(){
                            _selectTime(context,'start');
                          },
                          child: Container(
                            constraints: BoxConstraints(minHeight: 40),
                            // decoration: BoxDecoration(color: Colors.teal),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              mainAxisSize: MainAxisSize.max,
                              children: <Widget>[
                                Text(startTime.hour.toString()+':'+startTime.minute.toString(), style: TextStyle(fontSize: 20.0)),
                              ],
                            ),
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
                        child: InkWell(
                          onTap:(){
                            _selectTime (context,'end');
                          },
                          child: Container(
                            constraints: BoxConstraints(minHeight: 40),
                            // decoration: BoxDecoration(color: Colors.teal),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              mainAxisSize: MainAxisSize.max,
                              children: <Widget>[
                                Text(endTime.hour.toString()+':'+endTime.minute.toString(), style: TextStyle(fontSize: 20.0)),
                              ],
                            ),
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
                          height: 40,
                          width: double.infinity,
                          child: DropdownButton<RoomModel>(
                            hint: Text('Pilih Kelas', style: TextStyle(fontSize: 14)),
                            value: selected,
                            onChanged: (RoomModel value){
                              setState(() {
                                selected = value;
                              });
                            },
                            items: dataKelas.map((RoomModel rm){
                              return DropdownMenuItem<RoomModel>(
                                value: rm,
                                child: Row(
                                  children: <Widget>[
                                    Text('FIKLAB-'+rm.roomNumber,style: TextStyle(fontSize: 20),)
                                  ]
                                )
                              );
                            }).toList(),
                          ),
                        )
                      ),
                    ],
                  )
                ),
              ],
            ),
          ),
        ),
      ),
    );

  }
}

class RoomModel {
  bool isSelected;
  final String roomNumber;
  RoomModel({this.isSelected, this.roomNumber});
}

class RoomItem extends StatelessWidget {
  final RoomModel roomModel;
  RoomItem(this.roomModel);
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Container(
      margin: const EdgeInsets.all(10),
      constraints: BoxConstraints(minWidth: (screenWidth - 60) / 4, maxWidth: (screenWidth - 60) / 4),
      decoration: BoxDecoration(
        color: roomModel.isSelected ? Colors.teal : Colors.transparent,
        border: Border.all(
          width: 1.0,
          color: Colors.teal
        )
      ),
      child: Text(roomModel.roomNumber,
        style: TextStyle(
          color: roomModel.isSelected ? Colors.white : Colors.teal
        ),
      )
    );
  }
}

