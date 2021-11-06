import 'package:alcohol_project/models/Person.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:alcohol_project/models/coffee.dart';
import 'package:alcohol_project/models/user.dart';


class DatabaseService{
  final CollectionReference coffeeCollection = FirebaseFirestore.instance.collection('coffees');// 컬렉션객체 생성: 컬렉션은 하나의 고객 데이터를 가지고있는것임
  final CollectionReference memberCollection = FirebaseFirestore.instance.collection('member');// 컬렉션객체 생성: 컬렉션은 하나의 고객 데이터를 가지고있는것임
  final CollectionReference boardCollection = FirebaseFirestore.instance.collection('board');
  //final Query Top3_memberCollection = FirebaseFirestore.instance.collection('member').orderBy("score",descending: true).limit(3);// Top3의 member정보만 내림차순으로 가져옴
  //final Query DescendAll_memberCollection = FirebaseFirestore.instance.collection('member').orderBy("score",descending: true);
  final String uid;

  DatabaseService({required this.uid});


  Future member_settingUserData(String name, String age) async{//setting_form.dart 에서 사용자 정보 바꿨을 경우 실행
    return await memberCollection.doc(uid).update({// set은 데이터베이스 필드까지 초기화 시켜버림 -> 필드값만 바꿀경우 update 사용
      'name': name,// 별명
      'age': age// 나이
    });
  }

  Future member_updateUserData(String name, String age, int score) async{
    return await memberCollection.doc(uid).update({// set은 데이터베이스 필드까지 초기화 시켜버림 -> 필드값만 바꿀경우 update 사용
      'name': name,// 별명
      'age': age,// 나이
      'score': score// 점수
    });
  }

  Future updateUserData(String sugars, String name, int strength) async{
    return await coffeeCollection.doc(uid).set({
      'sugars': sugars,//설탕
      'name': name,//이름
      'strength':strength,// 진하기
    });
  }





  List<Person> member_ListFromSnapshot(QuerySnapshot snapshot){
    return snapshot.docs.map((e){
      return Person(
          name: e.get('name') ?? '',
          age: e.get('age') ?? '0',
          score: e.get('score') ?? 0,
          uid: e.get('uid') ?? ''
      );
    }).toList();
  }

  List<Coffee> _coffeeListFromSnapshot(QuerySnapshot snapshot){
    return snapshot.docs.map((e){
      return Coffee(
          name: e.get('name') ?? '',
          sugars: e.get('sugars') ?? '0',
          strength: e.get('strength') ?? 0
      );
    }).toList();
  }


  // Stream<List<Person>> get Top3_member_info{//Top3의 member정보를 가져옴
  //   if(){
  //     return
  //   }else{
  //     return DescendAll_memberCollection.orderBy("score",descending: true).limit(3).snapshots()
  //         .map(member_ListFromSnapshot);
  //   }
  // }


  // Stream<List<Person>> get Top3_member_info{//Top3의 member정보를 가져옴
  //   return Top3_memberCollection.snapshots()
  //       .map(member_ListFromSnapshot);
  // }


  Stream<List<Person>> get member_info{//컬랙션 안에 있는 snapshots 을 이용해서 문서를 가져옴
    return memberCollection.orderBy("score",descending: true).snapshots()
      .map(member_ListFromSnapshot);
    //snapshots() 메소드는 Stream의 형태로 QuerySnapshot class를 반환함
    
  }

  Stream<List<Coffee>> get coffees{//컬랙션 안에 있는 snapshots 을 이용해서 문서를 가져옴
    return coffeeCollection.snapshots()
        .map(_coffeeListFromSnapshot);
    //snapshots() 메소드는 Stream의 형태로 QuerySnapshot class를 반환함

  }





  Stream<member_UserData> get member_userData{// firestore로부터 Userdata 클래스 형태로 가져오기 위해 사용
    //snapshots() 메소드는 Stream의 형태로 QuerySnapshot class를 반환함
    return memberCollection.doc(uid).snapshots()//해당 컬렉션에 있는 uid와 비교해서 값을 가져옴
        .map(member_userDataFromSnapshot);
  }

  Stream<UserData> get userData{// firestore로부터 Userdata 클래스 형태로 가져오기 위해 사용
    //snapshots() 메소드는 Stream의 형태로 QuerySnapshot class를 반환함
    return coffeeCollection.doc(uid).snapshots()//해당 컬렉션에 있는 uid와 비교해서 값을 가져옴
        .map(_userDataFromSnapshot);
  }





  member_UserData member_userDataFromSnapshot(DocumentSnapshot snapshot){//가져온 자료를 UserData 객체에 셋팅
    return member_UserData(
      uid: uid,
      name: snapshot['name'],
      age: snapshot['age'],
      score: snapshot['score'],
      // name: snapshot.get('name'),
      // sugars: snapshot.get('sugars'),
      // strength: snapshot.get('strength'),
    );
  }

  UserData _userDataFromSnapshot(DocumentSnapshot snapshot){//가져온 자료를 UserData 객체에 셋팅
    return UserData(
      uid: uid,
      name: snapshot['name'],
      sugars: snapshot['sugars'],
      strength: snapshot['strength'],
      // name: snapshot.get('name'),
      // sugars: snapshot.get('sugars'),
      // strength: snapshot.get('strength'),
    );
  }

}