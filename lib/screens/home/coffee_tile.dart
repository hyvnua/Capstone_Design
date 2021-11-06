import 'package:alcohol_project/models/coffee.dart';
import 'package:flutter/material.dart';

class CoffeeTile extends StatelessWidget {
  //const ({Key? key}) : super(key: key);

  final Coffee coffee;
  CoffeeTile({ required this.coffee });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top : 8.0),
      child: Card(
        margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
        child: ListTile(
          leading: CircleAvatar(
            radius: 25.0,
            backgroundColor: Colors.brown[coffee.strength],
            backgroundImage: AssetImage('assets/coffee_icon.png'),
          ),
          title: Text(coffee.name),
          subtitle: Text('Takes ${coffee.sugars} sugar(s)'),
        ),
      ),
    );
  }
}
