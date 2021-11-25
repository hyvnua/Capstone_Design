import 'dart:ffi';

import 'package:alcohol_project/models/user.dart';
import 'package:alcohol_project/screens/board/screen/view.dart';
import 'package:alcohol_project/screens/home/MyRank.dart';
import 'package:alcohol_project/screens/home/calendar.dart';
import 'package:alcohol_project/screens/home/calender.dart';
import 'package:alcohol_project/screens/home/person_list.dart';
import 'package:alcohol_project/screens/home/walking.dart';
import 'package:alcohol_project/shared/loading.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:alcohol_project/models/coffee.dart';
import 'package:alcohol_project/screens/home/coffee_list.dart';
import 'package:alcohol_project/screens/home/settings_form.dart';
import 'package:alcohol_project/service/auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:alcohol_project/service/database.dart';
import 'package:flutter/painting.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:alcohol_project/models/Person.dart';
import 'package:flutter_clean_calendar/flutter_clean_calendar.dart';
import 'package:pedometer/pedometer.dart';



class Home extends StatelessWidget {
  //const Home({Key? key}) : super(key: key);

  final AuthService _auth = AuthService();



  @override
  Widget build(BuildContext context) {

    void _showSettingsPanel() {//사용자 계정에 저장되어있는 정보를 바꾸기위해 사용되는 메소드
      showModalBottomSheet(context: context, builder: (context){
        return Container(
          padding: EdgeInsets.symmetric(vertical: 20.0,horizontal: 60.0),
          child: SettingsForm(),
        );
      });
    }

    final user = Provider.of<MyUser>(context);

    //stream파이프를 통해서 스냅샷으로 firebase에서 실시간으로 업데이트된 정보를 가져온다
    return StreamProvider<List<Person>>.value(
      //return StreamProvider<List<Coffee>>.value(

      //value: DatabaseService(uid: '').coffees,//DatabaseService 위젯의 get coffees를 호출 -> 커피컬랙션의 모든 정보를 list형식으로 받아서 stream에 저장
      value: DatabaseService(uid:'').member_info,//DatabaseService 위젯의 get coffees를 호출 -> 커피컬랙션의 모든 정보를 list형식으로 받아서 stream에 저장

      //catchError: (_, err) => Error(err.toString()),
      //catchError: print("error"),
      //catchError: (User,List<Person>) => null,

      //initialData: null,
      initialData: [],
      child: Scaffold(
        //backgroundColor: Colors.lightGreen[100],
        backgroundColor: Colors.lightGreen[100],
        appBar: AppBar(
          title: Text('안티 알코올'),
          backgroundColor: Colors.brown[600],
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


        // body: StreamBuilder<List<Person_Top3>>(
        //   stream: DatabaseService(uid: user.uid).member_info_Top3,
        //   builder: (context, snapshot) {
        //     if(snapshot.hasData){
        //       return Container(
        //         decoration: BoxDecoration(
        //             image: DecorationImage(
        //               image: AssetImage('assets/coffee_bg.png'),
        //               fit:BoxFit.cover,
        //             )
        //         ),
        //         //child: CoffeeList(),
        //         child: PersonList(),
        //       );
        //     }
        //     else{
        //       return Loading();
        //     }
        //   }
        // ),

        body: ListView(
          children: [
            Container(
              height: 285,
              // decoration: BoxDecoration(
              //     image: DecorationImage(
              //       image: AssetImage('assets/coffee_bg.png'),
              //       fit:BoxFit.cover,
              //     )
              // ),
              child: CalendarScreen(cur_date: DateTime.now()),
              //child: CalendarScreen(),
            ),
            SizedBox(height: 5,),

            Padding(
              padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),

              child: CupertinoButton(
                padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                // borderRadius: BorderRadius.all(Radius.circular(0.0)),
                child: Text(
                    '출 석  체 크',
                    style: TextStyle(fontSize: 20,color: Colors.white)
                ),
                onPressed: (){
                  _showCupertinoDialog(context);
                },
                color : Colors.amber,
              ),
            ),

            SizedBox(height: 5,),

            Padding(
              padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
              child: Container(
                // decoration: BoxDecoration(
                //   color: Colors.black,
                //   borderRadius: BorderRadius.circular(20.0)
                // ),
                height: 45,
                width: 100,
                alignment:Alignment.center,

                child:walking(
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Container(
                height: 220,
                width: 400,

                // decoration: BoxDecoration(
                //     image: DecorationImage(
                //       image: AssetImage('assets/coffee_bg.png'),
                //       fit:BoxFit.cover,
                //     )
                // ),
                child: Row(
                  children: <Widget> [
                    Container(
                      height: 260,
                      width: 260,
                      decoration: BoxDecoration(
                        color: Colors.brown[200],
                      ),

                      child: Column(
                        children: [
                          //Text('현재 Score Top3 랭킹'),
                          PersonList(),
                        ],
                      ),

                    ),
                    Container(
                      height: 260,
                      width: 140,
                      decoration: BoxDecoration(
                        color: Colors.brown[400],

                      ),
                      child: Column(
                        children: [
                          SizedBox(height: 20.0,),
                          MyRank(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),

        // floatingActionButton: StreamBuilder<member_UserData>(
        //   stream: DatabaseService(uid: user.uid).member_userData,
        //   builder: (context, snapshot) {
        //     if(snapshot.hasData){
        //       return Container(
        //         height: 37.0,
        //         width: 150.0,
        //         child: FittedBox(
        //           child: FloatingActionButton.extended(
        //
        //             onPressed: () => showDialog<String>(
        //               context: context,
        //               builder: (BuildContext context) => AlertDialog(
        //                 title: const Text('술을 섭취하셨나요?'),
        //                 //content: const Text('AlertDialog description'),
        //                 actions: <Widget>[
        //                   TextButton(
        //                     onPressed: () => Navigator.pop(context, '네'),
        //                     child: const Text('네'),
        //                   ),
        //                   TextButton(
        //                     onPressed: () async {
        //                       await DatabaseService(uid: user.uid).member_updateUserScore(
        //                           snapshot.data!.score
        //                       );
        //                       await DatabaseService(uid: user.uid).member_updateCalendar(
        //                           DateTime.now()
        //                       );
        //
        //                       CalendarScreen(cur_date: DateTime.now());
        //
        //
        //
        //                       Navigator.pop(context, '아니오');
        //                     },
        //                     child: const Text('아니오'),
        //                   ),
        //                 ],
        //               ),
        //             ),
        //
        //             label: const Text('출석 체크하기'),
        //             icon: const Icon(Icons.add),
        //             backgroundColor: Colors.pink,
        //
        //           ),
        //         ),
        //       );
        //     }else{
        //       return Loading();
        //     }
        //
        //   }
        // ),
        //
        // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

        //Drawer 에 streamPovider 적용 전 _ 백업 코드
        endDrawer: Drawer(//측면 메뉴바 구성
          //side menu 구현(메뉴화면)
          child: StreamBuilder<member_UserData>(
            stream: DatabaseService(uid: user.uid).member_userData,
            builder: (context, snapshot) {
              if(snapshot.hasData){
                final Person person = new Person(
                    name: snapshot.data!.name,
                    drink: snapshot.data!.drink,
                    score: snapshot.data!.score,
                    uid: snapshot.data!.uid,
                    steps : snapshot.data!.steps,
                    startday: snapshot.data!.startday,
                );

                String savePrice(String drink){

                  int saveMoney = int.parse(drink) * 5000;
                  return saveMoney.toString();
                }



                int Dday(){
                  DateTime start=DateTime.parse(snapshot.data!.startday);
                  DateTime today=DateTime.parse(DateFormat('yyyyMMdd').format(DateTime.now()));
                  int difference = int.parse(today.difference(start).inDays.toString());
                  return difference;
                }

                String monthPrice(String drink){
                  int saveMoney = int.parse(drink) * 5000 * Dday();
                  return saveMoney.toString();
                }

                return ListView(
                  children: <Widget>[
                    Container(
                      //color: Colors.brown[600],
                      height: 55.0, // 사용자 정보 목록 높이 설정
                      child: DrawerHeader(
                        //사용자 정보 목록
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            CircleAvatar(

                              radius: 13.0,
                              backgroundImage: AssetImage('assets/${person.avatar_choose()}.png'),
                            ),
                            Expanded(
                              child: Text(
                                "${snapshot.data!.name} 사용자님",
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
                      color: Colors.lightGreen[100],
                      height: 150,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(5.0, 21.0, 0.0, 0.0),
                        child: ListTile(
                          //절약 비용 목록
                          title: Text(
                            "D-DAY: ${Dday()}\n"
                            "나의 주량 : ${snapshot.data!.drink} 병\n"
                            "오늘 절약한 비용 :  ${savePrice(snapshot.data!.drink)} 원\n"
                            "현재 누적 절약 비용: ${monthPrice(snapshot.data!.drink)} 원",

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
                        onTap: () async{
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
                        onTap: () async=> {
                          Navigator.push(
                            context,
                            await MaterialPageRoute(
                              // 새로운 builder를 만들어서 진행함. builder는 context를 이용해서 해당 위젯이 위젯tree에 어느 위치에 있는지 알게해줌
                                builder: (context) => MyHomePage()
                            ),//view.dart로 이동

                            // await MaterialPageRoute(
                            //   // 새로운 builder를 만들어서 진행함. builder는 context를 이용해서 해당 위젯이 위젯tree에 어느 위치에 있는지 알게해줌
                            //   builder: (context) => StreamBuilder<member_UserData>(
                            //       stream: DatabaseService(uid:user.uid).member_userData,
                            //       builder: (context, snapshot) {
                            //         if(!snapshot.hasData){// 데이터 아직 다 못받아왔으면
                            //           return Loading();
                            //         }
                            //         else{
                            //           return Material(
                            //               child: MyHomePage()
                            //           );
                            //         }
                            //
                            //       }
                            //   ),//view.dart로 이동
                            // ),

                          ),
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
                );
              }else{
                return Loading();
              }
            }
          ),
        ),

        // Drawer 에 streamPovider 적용 전 _ 백업 코드
        // endDrawer: Drawer(//측면 메뉴바 구성
        //   //side menu 구현(메뉴화면)
        //   child: ListView(
        //     children: <Widget>[
        //       Container(
        //         height: 55.0, // 사용자 정보 목록 높이 설정
        //         child: DrawerHeader(
        //           //사용자 정보 목록
        //           child: Row(
        //             crossAxisAlignment: CrossAxisAlignment.center,
        //             children: <Widget>[
        //               CircleAvatar(
        //                 //backgroundImage: ,
        //                 radius: 25.0,
        //               ),
        //               Expanded(
        //                 child: Text(
        //                   "OOO사용자님",
        //                   style: TextStyle(
        //                     fontSize: 15.0,
        //                     fontWeight: FontWeight.bold,
        //                   ),
        //                 ),
        //               ),
        //               Icon(Icons.menu),
        //             ],
        //           ),
        //         ),
        //       ),
        //       // Divider(height: 3.0, color: Colors.black,),
        //
        //       Container(
        //         color: Colors.lightGreen[300],
        //         height: 150,
        //         child: Padding(
        //           padding: const EdgeInsets.fromLTRB(5.0, 30.0, 0.0, 0.0),
        //           child: ListTile(
        //             //절약 비용 목록
        //             title: Text(
        //               "절약 비용 목록\n오늘까지 절약한 비용 : 580,000\n오늘 절약한 비용 : 12,000",
        //               style: TextStyle(
        //                 fontSize: 18.0,
        //               ),
        //             ),
        //           ),
        //         ),
        //       ),
        //
        //       Divider(
        //         height: 3.0,
        //         color: Colors.black,
        //       ),
        //
        //       Container(
        //         height: 55,
        //         child: ListTile(
        //           //커뮤니티 목록
        //           title: Text(
        //             "프로필 수정하기",
        //             style: TextStyle(
        //               fontSize: 20.0,
        //               fontWeight: FontWeight.bold,
        //             ),
        //           ),
        //           onTap: () async{
        //             _showSettingsPanel();
        //             // Navigator.pop(context),
        //           },
        //         ),
        //       ),
        //
        //
        //       Divider(
        //         height: 3.0,
        //         color: Colors.black,
        //       ),
        //       Container(
        //         height: 55,
        //         child: ListTile(
        //           //커뮤니티 목록
        //           title: Text(
        //             "커뮤니티 목록",
        //             style: TextStyle(
        //               fontSize: 20.0,
        //               fontWeight: FontWeight.bold,
        //             ),
        //           ),
        //           onTap: () async=> {
        //             Navigator.push(
        //               context,
        //               await MaterialPageRoute(
        //                 // 새로운 builder를 만들어서 진행함. builder는 context를 이용해서 해당 위젯이 위젯tree에 어느 위치에 있는지 알게해줌
        //                 builder: (context) => MyHomePage(),//view.dart로 이동
        //               ),
        //             ),
        //             // Navigator.pop(context),
        //           },
        //         ),
        //       ),
        //       Divider(
        //         height: 3.0,
        //         color: Colors.black,
        //       ),
        //       Container(
        //         height: 55,
        //         child: ListTile(
        //           //커뮤니티 목록
        //           title: Text(
        //             "로그아웃하기",
        //             style: TextStyle(
        //               fontSize: 20.0,
        //               fontWeight: FontWeight.bold,
        //             ),
        //           ),
        //           onTap: () async {
        //             await _auth.signOut();
        //             // Navigator.pop(context),
        //           },
        //         ),
        //       ),
        //       Divider(
        //         height: 3.0,
        //         color: Colors.black,
        //       ),
        //     ],
        //   ),
        // ),
      ),
    );
  }
}


void _showCupertinoDialog(BuildContext context){
  showDialog(
    context : context,
    builder : (context) => CupertinoAlertDialog(
      title : Text("출석체크"),
      content : Text("오늘 금주를 성공하셨나요?"),
      actions: <Widget>[
        CupertinoDialogAction(
          child: Text('네'),
          onPressed: (){
            Navigator.of(context).pop();
          },
        ),
        CupertinoDialogAction(
          child: Text('아니오'),
          onPressed: (){
            Navigator.of(context).pop();
          },
        ),
      ],
    ),
  );
}