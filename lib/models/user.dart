class MyUser{//uid만 얻기위한 사용자 객체
  final String uid;

  MyUser({ required this.uid});
}


// class UserData{//firestore에서 회원가입으로 인한 유저 정보에 따른 컬렉션 저장데이터를 가져오기 위한 객체
//
//   final String uid;
//   final String name;
//   final String sugars;
//   final int strength;
//
//   UserData({required this.uid, required this.sugars, required this.name, required this.strength});
// }

// class member_UserData{//firestore에서 회원가입으로 인한 유저 정보에 따른 컬렉션 저장데이터를 가져오기 위한 객체
//
//   final String uid;
//   final String name;
//   final String age;
//   final int score;
//
//   member_UserData({required this.uid, required this.age, required this.name, required this.score});
// }

class member_UserData{//firestore에서 회원가입으로 인한 유저 정보에 따른 컬렉션 저장데이터를 가져오기 위한 객체

  final String uid;
  final String name;
  final String drink;
  final int score;
  final String steps;
  final String startday;

  member_UserData({required this.uid, required this.drink, required this.name, required this.score,required this.steps, required this.startday});
}