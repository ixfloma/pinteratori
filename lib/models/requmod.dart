import 'package:cloud_firestore/cloud_firestore.dart';

class Requmod{
  final String id;
  final String pemohon;
  final String tglPinjam;
  final String tglSelesai;
  final String waktuMulai;
  final String waktuSelesai;
  final String kelasTuju;
  final String status;
  final createdAt;
  final String createdBy;
  final List label;
  final DocumentReference ref;
  
  Requmod.fromMap(Map<String, dynamic> map,{this.ref}):
  assert(map['id'] != null),
  assert(map['pemohon'] != null),
  assert(map['tglPinjam'] != null),
  assert(map['tglSelesai'] != null),
  assert(map['waktuMulai'] != null),
  assert(map['waktuSelesai'] != null),
  assert(map['kelasTuju'] != null),
  assert(map['status'] != null),
  assert(map['createdAt'] != null),
  assert(map['createdBy'] != null),
  assert(map['label'] != null),

  id = map ['id'],
  pemohon = map['pemohon'],
  tglPinjam = map['tglPinjam'],
  tglSelesai = map['tglSelesai'],
  waktuMulai = map['waktuMulai'],
  waktuSelesai = map['waktuSelesai'],
  kelasTuju = map['kelasTuju'],
  status = map['status'],
  createdAt = map['createdAt'],
  createdBy = map['createdBy'],
  label = map['label'];

  Requmod.fromSnapshot(DocumentSnapshot snapshot)
    : this.fromMap(snapshot.data, ref: snapshot.reference);
}