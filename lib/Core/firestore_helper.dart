import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:to_do_list/Model/tasks.dart';

import '../Model/user.dart';

class FirestoreHelper{

  static CollectionReference<User> getUserCollection(){
    var reference  = FirebaseFirestore.instance.collection('users').withConverter(
      fromFirestore: (snapshot, options) {
        Map<String , dynamic>? doc = snapshot.data();
        return User.fromFirestore(doc);
      },
      toFirestore: (user, options) {
        return user.toFirestore();
      },
    );
    return reference;
  }

  static Future<void> addNewUser(User user) async {
    var userCollection = getUserCollection();
    var docReference = userCollection.doc(user.id);
    await docReference.set(user);
  }

  static Future<User?> getUser(String userId) async{
    var userCollection = getUserCollection();
    var docRefernece = userCollection.doc(userId);
    var snapshot = await docRefernece.get();
    var user = snapshot.data();
    return user;
  }
  
  static CollectionReference<Tasks> getTasksCollection(String userId ){
    var collectionReference = getUserCollection().doc(userId).collection("tasks").withConverter(fromFirestore: (snapshot, options) {
      return Tasks.fromFirestore(snapshot.data());
    }, toFirestore: (task, options) {
      return task.toFirestore();
    },);
    return collectionReference;
  }

  static Future<void> addNewTask({required String userId,required Tasks task}) async {
    var collectionReference = getTasksCollection(userId);
    var doc = collectionReference.doc();
    task.id = doc.id;
    await doc.set(task);
  }

  static Future<List<Tasks>> getAllTasks(String userId,Timestamp date) async {
    var collectionReference = getTasksCollection(userId).where("date",isEqualTo: date);
    var quarySnapshot = await collectionReference.get();
    var listQuaryDocs = quarySnapshot.docs;
    List<Tasks> tasksList = listQuaryDocs.map((snapshot) => snapshot.data()).toList();
    return tasksList;
}

  static Stream<List<Tasks>> listenToTasks(String userId,Timestamp date){
    var collectionReference = getTasksCollection(userId).where("date",isEqualTo: date);
    var quarySnapshots = collectionReference.snapshots();
    var streamTask = quarySnapshots.map((snapshot) => snapshot.docs.map((document) => document.data()).toList());
    return streamTask ;
  }

  static Future<void> deleteTask({required String userId, required String taskId})async{
    var collectionReference = getTasksCollection(userId);
    var docReference = collectionReference.doc(taskId);
    await docReference.delete();
  }
}