class User{
  String? id;
  String? fullname;
  String? email ;
  int? age ;

  User({this.id, this.fullname, this.email, this.age});

  User.fromFirestore(Map<String , dynamic>? data){
    id = data?['id'];
    fullname = data?['fullname'];
    email = data?['email'];
    age = data?['age'];
     }

  Map<String , dynamic> toFirestore(){
    return {
      'id':id,
      'fullname':fullname,
      'email':email,
      'age':age
    };
  }

}
