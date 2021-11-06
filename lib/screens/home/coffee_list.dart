import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:alcohol_project/models/coffee.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:alcohol_project/screens/home/coffee_tile.dart';


class CoffeeList extends StatefulWidget {
  const CoffeeList({Key? key}) : super(key: key);

  @override
  _CoffeeListState createState() => _CoffeeListState();
}

class _CoffeeListState extends State<CoffeeList> {
  @override
  Widget build(BuildContext context) {
    // provider로 데이터를 가져옴
    final coffees = Provider.of<List<Coffee>>(context) ?? [];

    return ListView.builder(
      itemCount: coffees.length,
      itemBuilder: (context, index){
        return CoffeeTile(coffee: coffees[index]);
      },
    );
    // coffees.forEach((e) {
    //   print(e.name);
    //   print(e.sugars);
    //   print(e.strength);
    // });
    // for(var doc in coffees!.docs){
    //   print(doc.data());
    // }
    return Container();
  }
}
