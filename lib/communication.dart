import 'package:flutter/material.dart';
import 'package:anti_alcohol/menu.dart';


class Communication extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("커뮤니티"),
        automaticallyImplyLeading: false,

      ),
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
              height : 55,
              child: ListTile(   //커뮤니티 목록
                title: Text("커뮤니티 목록"),
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


      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0.0),
              child: Container(  //경쟁순위 큰 박스
                padding: const EdgeInsets.only(bottom: 8),
                child: Row(
                  children: <Widget>[
                    Container(
                      height: 150,
                      width : 250,
                      decoration: BoxDecoration(
                        color: Colors.amber,
                      ),
                    ),//경쟁순위 작은 박스
                    Container(
                      height : 150,
                      width : 140,
                      decoration: const BoxDecoration(
                        color: Colors.blueGrey,
                      ),
                      child: Column(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: CircleAvatar(
                                child : Image.asset('assets/elephant.png', height: 70, width: 70,),
                                // backgroundImage: AssetImage('assets/koala.png'),
                                radius: 50.0,
                                backgroundColor: Colors.grey[350],
                              ),
                            ),
                            Text(
                              '현재 나의 순위 : 53위',
                              style : TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            //TextAlign.center = true,
                          ],
                      ),
                    ),//현재 나의 순위 작은 박스
                  ],
                ),
              ),
            ), //경쟁순위 보여주는 박스
            Expanded(//게시판 박스
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
                  child: Column(
                    children: <Widget>[
                      Container(
                        height : 425,
                        width : 450,
                        decoration: BoxDecoration(
                          color: Colors.black45,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ), //게시판 박스
          ],
        ),
      ),
    );
  }
}

