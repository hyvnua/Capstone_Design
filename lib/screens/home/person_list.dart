import 'package:alcohol_project/models/Person.dart';
import 'package:alcohol_project/models/user.dart';
import 'package:alcohol_project/screens/home/person_tile.dart';
import 'package:alcohol_project/service/database.dart';
import 'package:alcohol_project/shared/loading.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PersonList extends StatefulWidget {
  const PersonList({Key? key}) : super(key: key);

  @override
  _PersonListState createState() => _PersonListState();
}

class _PersonListState extends State<PersonList> {
  @override
  Widget build(BuildContext context) {
    final member_info = Provider.of<List<Person>>(context); //home.dart 에서 streamProvider로 Person<List> 형식으로 데이터 가져옴
    //final member_info_Top3 = Provider.of<List<Person_Top3>>(context) ?? []; //home.dart 에서 streamProvider로 Person<List> 형식으로 데이터 가져옴

    final user = Provider.of<MyUser>(context);
    //print("member_info Test하는곳 : ${member_info[1]}");



    // return StreamBuilder<List<Person_Top3>>(
    //   stream: DatabaseService(uid: user.uid).member_info_Top3,
    //   builder: (context, snapshot) {
    //     if (snapshot.hasData) {
    //       return ListView.builder(
    //         //itemCount: 3,//Top3 의 정보만 출력함
    //         itemCount: member_info_Top3.length,
    //         itemBuilder: (context, index) {
    //           return PersonTile(person_top3: member_info_Top3[index]);
    //         },
    //       );
    //     }
    //     else{
    //       return Loading();
    //     }
    //   }
    // );

    return ListView.builder(
      shrinkWrap: true,
      itemCount: 3,//Top3 의 정보만 출력함
      //itemCount: member_info.length,
      itemBuilder: (context, index) {
        if(member_info.isEmpty){
          return Loading();
        }else{
          return PersonTile(person: member_info[index]);
          // return PersonTile(person: member_info[index]);
        }
      },
    );

    // return ListView.builder(
    //   shrinkWrap: true,
    //   itemCount: 3,//Top3 의 정보만 출력함
    //   //itemCount: member_info.length,
    //   itemBuilder: (context, index) {
    //     if(member_info.isEmpty){
    //       return Loading();
    //     }else{
    //       return PersonTile(person: member_info[index]);
    //     }
    //   },
    // );

    // return ListView.builder(
    //   //itemCount: 3,//Top3 의 정보만 출력함
    //   itemCount: member_info_Top3.length,
    //   itemBuilder: (context, index) {
    //     return PersonTile(person_top3 : member_info_Top3[index]);
    //   },
    // );
  }
}

// class _PersonListState extends State<PersonList> {
//   @override
//   Widget build(BuildContext context) {
//     final member_info = Provider.of<List<Person>>(context) ?? [];
//     final user = Provider.of<MyUser>(context);
//     //final member_userData = Provider.of<member_userData>(context);
//
//     int Myrank(){
//       int count = 0;
//       for(int i=0; i < member_info.length; i++){
//         //for(int i=0; i < member_info.length; i++){
//         if(user.uid == member_info[i]){
//           break;
//         }else{
//           count++;
//         }
//       }
//       return count;
//     }
//     //print(Myrank());
//
//     return ListView.builder(
//       //itemCount: 3,//Top3 의 정보만 출력함
//       itemCount: member_info.length,
//       itemBuilder: (context, index){
//         return PersonTile(person: member_info[index]);
//       },
//     );
//     // coffees.forEach((e) {
//     //   print(e.name);
//     //   print(e.sugars);
//     //   print(e.strength);
//     // });
//     // for(var doc in coffees!.docs){
//     //   print(doc.data());
//     // }
//     return Container();
//   }
// }
