import 'package:flutter/material.dart';
import 'package:anti_alcohol/communication.dart';

class home extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: Drawer( //side menu 구현(메뉴화면)
        child: ListView(
          children: <Widget>[
            Container(
              height : 65.0,  // 사용자 정보 목록 높이 설정
              child: DrawerHeader( //사용자 정보 목록
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    CircleAvatar(
                      //backgroundImage: ,
                      radius: 30.0,
                    ),
                    Expanded(
                      child: Text("OOO사용자님"),
                    ),
                    Icon(Icons.menu),
                  ],
                ),
              ),
            ),
            Divider(height: 3.0, color: Colors.black,),
            Container(
              height : 200,
              child: ListTile(   //절약 비용 목록

                title: Text("절약 비용 목록"),
              ),

            ),
            Divider(height: 3.0, color: Colors.black,),
            Container(
              height : 200,
              child: ListTile(   //커뮤니티 목록
                title: Text("커뮤니티 목록"),
                onTap: () => {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //   builder: (context) => communication(),
                  //   ),
                  // ),
                  Navigator.pop(context),
                },
              ),
            ),
            Divider(height: 3.0, color: Colors.black,),
          ],
        ),
      ),
      appBar: AppBar( //appbar 구현 (고정)

      ),
      body: Container(
        child: Text('project'),
      ),
    );
  }
}