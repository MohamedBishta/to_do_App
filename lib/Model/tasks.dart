import 'package:cloud_firestore/cloud_firestore.dart';

class Tasks{
  String? id;
  String? title;
  String? description;
  bool? isDone;
  Timestamp? date;

  Tasks({this.id,required this.title, required this.description,this.isDone = false,required this.date});

  Tasks.fromFirestore(Map<String ,dynamic>? data){
    this.id = data?['id'];
    this.title = data?['title'];
    this.description = data?['description'];
    this.isDone = data?['isDone'];
    this.date = data?['date'];
  }
  Map <String ,dynamic> toFirestore({userId}){
    return {
      'id':id,
      'title':title,
      'description':description,
      'isDone':isDone,
      'date':date,
    };
  }
}