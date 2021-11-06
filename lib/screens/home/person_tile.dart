import 'package:alcohol_project/models/Person.dart';
import 'package:alcohol_project/models/coffee.dart';
import 'package:flutter/material.dart';

class PersonTile extends StatelessWidget {
  //const PersonTile({Key? key}) : super(key: key);

  final Person person;
  PersonTile({ required this.person });


  @override
  Widget build(BuildContext context) {

    int avatar_chooose(){
      if(person.score < 100){
        return 1;
      }else if(person.score >= 100 && person.score < 200){
        return 2;
      }else if(person.score >= 200 && person.score < 300){
        return 3;
      }else if(person.score >= 300 && person.score < 400){
        return 4;
      }else if(person.score >= 400 && person.score < 500){
        return 5;
      }else{
        return 5;
      }
    }

    return Padding(
      padding: EdgeInsets.only(top : 8.0),
      child: Card(
        margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
        child: ListTile(
          leading: CircleAvatar(
            // radius: 25.0,
            // backgroundColor: Colors.brown[person.score],
            // backgroundImage: AssetImage('assets/coffee_icon.png'),
            radius: 25.0,
            backgroundColor: Colors.brown[person.score],
            backgroundImage: AssetImage('assets/${avatar_chooose()}.png'),
          ),
          title: Text(person.name),
          subtitle: Text('score : ${person.score} !!'),
          // subtitle: Text('score : ${person.score} !!  uid : ${person.uid}'),
        ),
      ),
    );
  }
}