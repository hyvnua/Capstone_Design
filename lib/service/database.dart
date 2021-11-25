import 'package:alcohol_project/models/Board.dart';
import 'package:alcohol_project/models/Person.dart';
import 'package:alcohol_project/models/myDateTime.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:alcohol_project/models/coffee.dart';
import 'package:alcohol_project/models/user.dart';


class DatabaseService{
  final CollectionReference coffeeCollection = FirebaseFirestore.instance.collection('coffees');// 컬렉션객체 생성: 컬렉션은 하나의 고객 데이터를 가지고있는것임
  final CollectionReference memberCollection = FirebaseFirestore.instance.collection('member');// 컬렉션객체 생성: 컬렉션은 하나의 고객 데이터를 가지고있는것임
  final CollectionReference boardCollection = FirebaseFirestore.instance.collection('board');
  final CollectionReference calendarCollection = FirebaseFirestore.instance.collection('calendar');
  //final Query Top3_memberCollection = FirebaseFirestore.instance.collection('member').orderBy("score",descending: true).limit(3);// Top3의 member정보만 내림차순으로 가져옴
  //final Query DescendAll_memberCollection = FirebaseFirestore.instance.collection('member').orderBy("score",descending: true);
  final String uid;
  // int board_count=0;


  DatabaseService({required this.uid});


  Future member_settingUserData(String name, String drink) async{//setting_form.dart 에서 사용자 정보 바꿨을 경우 실행
    return await memberCollection.doc(uid).update({// set은 데이터베이스 필드까지 초기화 시켜버림 -> 필드값만 바꿀경우 update 사용
      'name': name,// 별명
      'drink': drink// 나이
    });
  }

  Future member_updateUserSteps(String steps) async{//setting_form.dart 에서 사용자 정보 바꿨을 경우 실행
    return await memberCollection.doc(uid).update({// set은 데이터베이스 필드까지 초기화 시켜버림 -> 필드값만 바꿀경우 update 사용
      'steps': steps,// 별명
    });
  }

  Future member_updateUserData(String name, String drink, int score) async{
    return await memberCollection.doc(uid).update({// set은 데이터베이스 필드까지 초기화 시켜버림 -> 필드값만 바꿀경우 update 사용
      'name': name,// 별명
      'drink': drink,// 나이
      'score': score// 점수
    });
  }

  Future member_updateUserScore(int score) async{
    return await memberCollection.doc(uid).update({// set은 데이터베이스 필드까지 초기화 시켜버림 -> 필드값만 바꿀경우 update 사용
      'score': score+100// 점수
    });
  }

  Future member_updateCalendar(DateTime curr_date) async{
    return await calendarCollection.doc(uid).set({// set은 데이터베이스 필드까지 초기화 시켜버림 -> 필드값만 바꿀경우 update 사용
      'date': curr_date.toString() + ','//
    });
  }



  Future member_updateUserStepsScore(int score, int step_score) async{
    return await memberCollection.doc(uid).update({// set은 데이터베이스 필드까지 초기화 시켜버림 -> 필드값만 바꿀경우 update 사용
      'score': score+step_score// 점수
    });
  }

  Future board_addmemo(String date, String name, String title,  String text, int score) async{

    return await boardCollection.doc(date.toString()).set({// set은 데이터베이스 필드까지 초기화 시켜버림 -> 필드값만 바꿀경우 update 사용
      'uid' : this.uid,
      'date' : date,
      'name' : name,
      'title' : title,
      'text' : text,
      'score': score
    });
  }


  Future board_removMemo(String date) async{
    return await boardCollection.doc(date).delete();
  }

  // Future updateUserData(String sugars, String name, int strength) async{
  //   return await coffeeCollection.doc(uid).set({
  //     'sugars': sugars,//설탕
  //     'name': name,//이름
  //     'strength':strength,// 진하기
  //   });
  // }





  List<Person> member_ListFromSnapshot(QuerySnapshot snapshot){
    return snapshot.docs.map((e){
      return Person(
          name: e.get('name') ?? '',
          drink: e.get('drink') ?? '0',
          score: e.get('score') ?? 0,
          uid: e.get('uid') ?? '',
          steps: e.get('steps') ?? '0',
          startday: e.get('startday') ?? '0',

      );
    }).toList();
  }


  List<Board> board_ListFromSnapshot(QuerySnapshot snapshot){
    return snapshot.docs.map((e){
      return Board(
          date: e.get('date') ?? '',
          uid: e.get('uid') ?? '',
          title: e.get('title') ?? '',
          text: e.get('text') ?? '',
          name: e.get('name') ?? '',
          score: e.get('score') ?? 0
      );
    }).toList();
  }

  List<Person_Top3> member_Top3_ListFromSnapshot(QuerySnapshot snapshot){
    return snapshot.docs.map((e){
      return Person_Top3(
          name: e.get('name') ?? '',
          drink: e.get('drink') ?? '0',
          score: e.get('score') ?? 0,
          uid: e.get('uid') ?? ''
      );
    }).toList();
  }




  member_UserData member_userDataFromSnapshot(DocumentSnapshot snapshot){//가져온 자료를 UserData 객체에 셋팅
    return member_UserData(
      uid: this.uid,
      name: snapshot['name'],
      drink: snapshot['drink'],
      score: snapshot['score'],
      steps: snapshot['steps'],
      startday: snapshot['startday'],
      // name: snapshot.get('name'),
      // sugars: snapshot.get('sugars'),
      // strength: snapshot.get('strength'),
    );
  }

  myDateTime member_userCalender(DocumentSnapshot snapshot){//가져온 자료를 UserData 객체에 셋팅
    return myDateTime(
        cur_dateTime: snapshot['date'].toString(),
    );
  }


  // UserData _userDataFromSnapshot(DocumentSnapshot snapshot){//가져온 자료를 UserData 객체에 셋팅
  //   return UserData(
  //     uid: uid,
  //     name: snapshot['name'],
  //     sugars: snapshot['sugars'],
  //     strength: snapshot['strength'],
  //     // name: snapshot.get('name'),
  //     // sugars: snapshot.get('sugars'),
  //     // strength: snapshot.get('strength'),
  //   );
  // }

  // List<Coffee> _coffeeListFromSnapshot(QuerySnapshot snapshot){
  //   return snapshot.docs.map((e){
  //     return Coffee(
  //         name: e.get('name') ?? '',
  //         sugars: e.get('sugars') ?? '0',
  //         strength: e.get('strength') ?? 0
  //     );
  //   }).toList();
  // }


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


  Stream<List<Person>> get member_info {//컬랙션 안에 있는 snapshots 을 이용해서 문서를 가져옴
    return memberCollection.orderBy("score",descending: true).snapshots()
      .map(member_ListFromSnapshot);
    //snapshots() 메소드는 Stream의 형태로 QuerySnapshot class를 반환함
    
  }

  Stream<List<Person_Top3>> get member_info_Top3 {//컬랙션 안에 있는 snapshots 을 이용해서 문서를 가져옴
    return memberCollection.orderBy("score",descending: true).limit(3).snapshots()
        .map(member_Top3_ListFromSnapshot);
    //snapshots() 메소드는 Stream의 형태로 QuerySnapshot class를 반환함

  }

  // Stream<List<Coffee>> get coffees{//컬랙션 안에 있는 snapshots 을 이용해서 문서를 가져옴
  //   return coffeeCollection.snapshots()
  //       .map(_coffeeListFromSnapshot);
  //   //snapshots() 메소드는 Stream의 형태로 QuerySnapshot class를 반환함
  //
  // }




  Stream<List<Board>> get Boarder_info {//컬랙션 안에 있는 snapshots 을 이용해서 문서를 가져옴
    return boardCollection.orderBy("date",descending: true).snapshots()
        .map(board_ListFromSnapshot);
    //snapshots() 메소드는 Stream의 형태로 QuerySnapshot class를 반환함

  }



  Stream<member_UserData> get member_userData{// firestore로부터 현재 계정 uid로 시작하는 데이터 가져옴
    //snapshots() 메소드는 Stream의 형태로 QuerySnapshot class를 반환함
    return memberCollection.doc(uid).snapshots()//해당 컬렉션에 있는 uid와 비교해서 값을 가져옴
        .map(member_userDataFromSnapshot);
  }

  Stream<myDateTime> get calendar_dateTime{// firestore로부터 현재 계정 uid로 시작하는 데이터 가져옴
    //snapshots() 메소드는 Stream의 형태로 QuerySnapshot class를 반환함
    return calendarCollection.doc(uid).snapshots()//해당 컬렉션에 있는 uid와 비교해서 값을 가져옴
        .map(member_userCalender);
  }

  //
  // Stream<UserData> get userData{// firestore로부터 Userdata 클래스 형태로 가져오기 위해 사용
  //   //snapshots() 메소드는 Stream의 형태로 QuerySnapshot class를 반환함
  //   return coffeeCollection.doc(uid).snapshots()//해당 컬렉션에 있는 uid와 비교해서 값을 가져옴
  //       .map(_userDataFromSnapshot);
  // }



}