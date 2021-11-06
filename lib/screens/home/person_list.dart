import 'package:alcohol_project/models/Person.dart';
import 'package:alcohol_project/models/user.dart';
import 'package:alcohol_project/screens/home/person_tile.dart';
import 'package:alcohol_project/service/database.dart';
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
    final member_info = Provider.of<List<Person>>(context) ?? [];
    final user = Provider.of<MyUser>(context);

    int Myrank(){
      int count = 1;
      for(int i=0; i < member_info.length; i++){
        if(user.uid == member_info[i].uid){
          print("나의 순위를 찾았습니다. ");
          break;
        }else{
          // print("사용자 uid ${user.uid}");
          // print(member_info[i].uid);
          count++;
        }
      }
      print(count);
      return count;
    }
    print(Myrank());

    return ListView.builder(
      itemCount: 3,//Top3 의 정보만 출력함
      //itemCount: member_info.length,
      itemBuilder: (context, index){
        return PersonTile(person: member_info[index]);
      },
    );
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
