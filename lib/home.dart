import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:anti_alcohol/communication.dart';
import 'package:flutter/painting.dart';

class home extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: Drawer( //side menu 구현(메뉴화면)
        child: ListView(
          children: <Widget>[
            Container(
              height : 55.0,  // 사용자 정보 목록 높이 설정
              child: DrawerHeader( //사용자 정보 목록
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    CircleAvatar(
                      //backgroundImage: ,
                      radius: 25.0,
                    ),
                    Expanded(
                      child: Text("OOO사용자님",
                        style: TextStyle(
                          fontSize: 15.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Icon(Icons.menu),
                  ],
                ),
              ),
            ),
            // Divider(height: 3.0, color: Colors.black,),
            
            Container(
              color: Colors.grey[300],
              height : 150,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(5.0,30.0,0.0,0.0),
                child: ListTile(//절약 비용 목록
                  title: Text(
                    "절약 비용 목록\n오늘까지 절약한 비용 : 580,000\n오늘 절약한 비용 : 12,000",
                    style: TextStyle(
                      fontSize: 18.0,
                    ),
                  ),
                ),
              ),

            ),
            
            Divider(height: 3.0, color: Colors.black,),
            Container(
              height : 55,
              child: ListTile(//커뮤니티 목록
                title: Text(
                  "커뮤니티 목록",
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onTap: () => {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                    builder: (context) => Communication(),
                    ),
                  ),
                  // Navigator.pop(context),
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