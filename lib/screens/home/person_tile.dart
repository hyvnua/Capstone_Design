import 'package:alcohol_project/models/Person.dart';
import 'package:alcohol_project/models/coffee.dart';
import 'package:flutter/material.dart';

class PersonTile extends StatelessWidget {
  //const PersonTile({Key? key}) : super(key: key);

  // final Person_Top3 person_top3;
  // PersonTile({ required this.person_top3 });
  //
  final Person person;
  PersonTile({ required this.person });


  @override
  Widget build(BuildContext context) {

    // int avatar_chooose(){
    //   if(person.score < 100){
    //     return 1;
    //   }else if(person.score >= 100 && person.score < 200){
    //     return 2;
    //   }else if(person.score >= 200 && person.score < 300){
    //     return 3;
    //   }else if(person.score >= 300 && person.score < 400){
    //     return 4;
    //   }else if(person.score >= 400 && person.score < 500){
    //     return 5;
    //   }else if(person.score >= 500 && person.score < 600){
    //     return 6;
    //   }else if(person.score >= 600 && person.score < 700){
    //     return 7;
    //   }else if(person.score >= 700 && person.score < 800){
    //     return 8;
    //   }else{
    //     return 9;
    //   }
    // }

    // return Padding(
    //   //padding: EdgeInsets.only(top : 4.0),
    //   padding: EdgeInsets.fromLTRB(0, 0, 0, 4),
    //   child: Container(
    //     decoration: BoxDecoration(
    //       border: Border.all(
    //         width: 1,
    //         color: Colors.blue,
    //       ),
    //     ),
    //     height: 50,
    //     width: 400,
    //     child: Card(
    //       margin: EdgeInsets.fromLTRB(20.0, -10.0, 20.0, 0.0),
    //       child: ListTile(
    //         dense: true,
    //
    //         leading: CircleAvatar(
    //           // radius: 25.0,
    //           radius: 15.0,
    //           // backgroundColor: Colors.brown[person.score],
    //           //backgroundColor: Colors.brown[person_top3.score],
    //
    //           backgroundImage: AssetImage('assets/${person.avatar_choose()}.png'),
    //         ),
    //
    //         title: Text(person.name),
    //         subtitle: Text('score : ${person.score} !!'),
    //         // title: Text(person_top3.name),
    //         // subtitle: Text('score : ${person_top3.score} !!'),
    //         // subtitle: Text('score : ${person.score} !!  uid : ${person.uid}'),
    //       ),
    //     ),
    //   ),
    // );


    return Padding(
      //padding: EdgeInsets.only(top : 4.0),
      padding: EdgeInsets.fromLTRB(0, 4, 0, 4),
      child: Card(
        //margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
        margin: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
        child: Padding(
          padding: const EdgeInsets.only(top: 0.0),
          child: ListTile(
            dense: true,

            leading: CircleAvatar(
              // radius: 25.0,
              radius: 20.0,
              backgroundColor: Colors.brown[person.score],
              //backgroundColor: Colors.brown[person_top3.score],

              backgroundImage: AssetImage('assets/${person.avatar_choose()}.png'),
            ),

            title: Text(
              person.name,
              style : TextStyle(
                fontSize: 17,
                color: Colors.black,
              ),
            ),
            subtitle: Text(
              '점수 : ${person.score} 점',
              style : TextStyle(
                fontSize: 12,
                color: Colors.black,
              ),
            ),
            // title: Text(person_top3.name),
            // subtitle: Text('score : ${person_top3.score} !!'),
            // subtitle: Text('score : ${person.score} !!  uid : ${person.uid}'),
          ),
        ),
      ),
    );


  }
}