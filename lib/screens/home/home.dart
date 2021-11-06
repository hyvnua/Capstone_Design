import 'package:alcohol_project/screens/board/screen/view.dart';
import 'package:alcohol_project/screens/home/person_list.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:alcohol_project/models/coffee.dart';
import 'package:alcohol_project/screens/home/coffee_list.dart';
import 'package:alcohol_project/screens/home/settings_form.dart';
import 'package:alcohol_project/service/auth.dart';
import 'package:flutter/material.dart';
import 'package:alcohol_project/service/database.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:alcohol_project/models/Person.dart';

class Home extends StatelessWidget {
  //const Home({Key? key}) : super(key: key);

  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {

    void _showSettingsPanel(){//사용자 계정에 저장되어있는 정보를 바꾸기위해 사용되는 메소드
      showModalBottomSheet(context: context, builder: (context){
        return Container(
          padding: EdgeInsets.symmetric(vertical: 20.0,horizontal: 60.0),
          child: SettingsForm(),
        );
      });
    }

    //stream파이프를 통해서 스냅샷으로 firebase에서 실시간으로 업데이트된 정보를 가져온다
    return StreamProvider<List<Person>>.value(
    //return StreamProvider<List<Coffee>>.value(
      //value: DatabaseService(uid: '').coffees,//DatabaseService 위젯의 get coffees를 호출 -> 커피컬랙션의 모든 정보를 list형식으로 받아서 stream에 저장
      value: DatabaseService(uid: '').member_info,//DatabaseService 위젯의 get coffees를 호출 -> 커피컬랙션의 모든 정보를 list형식으로 받아서 stream에 저장

      //initialData: null,
      initialData: [],
      child: Scaffold(
        backgroundColor: Colors.brown[100],
        endDrawer: Drawer(
          //side menu 구현(메뉴화면)
          child: ListView(
            children: <Widget>[
              Container(
                height: 55.0, // 사용자 정보 목록 높이 설정
                child: DrawerHeader(
                  //사용자 정보 목록
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      CircleAvatar(
                        //backgroundImage: ,
                        radius: 25.0,
                      ),
                      Expanded(
                        child: Text(
                          "OOO사용자님",
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
                color: Colors.lightGreen[300],
                height: 150,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(5.0, 30.0, 0.0, 0.0),
                  child: ListTile(
                    //절약 비용 목록
                    title: Text(
                      "절약 비용 목록\n오늘까지 절약한 비용 : 580,000\n오늘 절약한 비용 : 12,000",
                      style: TextStyle(
                        fontSize: 18.0,
                      ),
                    ),
                  ),
                ),
              ),

              Divider(
                height: 3.0,
                color: Colors.black,
              ),

              Container(
                height: 55,
                child: ListTile(
                  //커뮤니티 목록
                  title: Text(
                    "프로필 수정하기",
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onTap: () async {
                    _showSettingsPanel();
                    // Navigator.pop(context),
                  },
                ),
              ),


              Divider(
                height: 3.0,
                color: Colors.black,
              ),
              Container(
                height: 55,
                child: ListTile(
                  //커뮤니티 목록
                  title: Text(
                    "커뮤니티 목록",
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
              //     onTap: () => {
              //       Navigator.push(
              //         context,
              //         MaterialPageRoute(
              //           builder: (context) => MyHomePage(),
              //         ),
              //       ),
              //       // Navigator.pop(context),
              //     },
                 ),
              ),
              Divider(
                height: 3.0,
                color: Colors.black,
              ),
              Container(
                  height: 55,
                  child: ListTile(
                    //커뮤니티 목록
                    title: Text(
                      "로그아웃하기",
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onTap: () async {
                      await _auth.signOut();
                      // Navigator.pop(context),
                    },
                  ),
              ),
              Divider(
                height: 3.0,
                color: Colors.black,
              ),


            ],
          ),
        ),



        appBar: AppBar(
            title: Text('안티 알코올'),
            backgroundColor: Colors.brown[400],
            elevation: 0.0, //메뉴바의 그라데이션
            // actions: <Widget>[
            //   FlatButton.icon(
            //     icon: Icon(Icons.person),
            //     label: Text('logout하기'),
            //     onPressed: () async {
            //       await _auth.signOut(); //authService의 signOut을 호출
            //     },
            //   ),
            //   FlatButton.icon(// 셋팅버튼 생성
            //       onPressed: (){
            //         _showSettingsPanel();//위의 매소드 호출
            //       },
            //       icon: Icon(Icons.settings),
            //       label: Text('Setting'),
            //   ),
            // ]
       ),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/coffee_bg.png'),
              fit:BoxFit.cover,
            )
          ),
          //child: CoffeeList(),
          child: PersonList(),

        ),
      ),
    );
  }
}
