import 'dart:convert';
// import 'package:crypto/crypto.dart';
import 'package:alcohol_project/models/Person.dart';
import 'package:alcohol_project/models/WorldTime.dart';
import 'package:alcohol_project/models/user.dart';
import 'package:alcohol_project/service/database.dart';
import 'package:alcohol_project/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:alcohol_project/screens/board/db/memo.dart';
import 'package:alcohol_project/screens/board/db/db.dart';
import 'package:ntp/ntp.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

//게시물 입력받는 위젯

class EditPage extends StatefulWidget {
  //const EditPage({Key? key}) : super(key: key);

  @override
  _EditPageState createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  // 입력받을 내용을 저장할 변수
  late String date = '';
  late String title = '';
  late String text = '';
  late String user_uid = '';
  late String name = '';
  late int score = 0;


  @override
  Widget build(BuildContext context) {
    // final member_info = Provider.of<List<Person>>(context) ?? [];//home.dart 에서 streamProvider로 Person<List> 형식으로 데이터 가져옴
    final user = Provider.of<MyUser>(context);
    //WorldTime time_Kor = WorldTime(url: 'Asia/Seoul', location: 'Seoul', flag: 'south_korea.png');



    void Korean_Time() async{// 한국시간 구하는 함수
      // print( DateFormat.yMd().add_jms() .format(DateTime.now()));
      // print( DateFormat("dd.MM.yy HH:mm:ss").format(DateTime.now()));

      DateTime currentTime = await NTP.now();
      currentTime = currentTime.toUtc().add(Duration(hours: 9));
      print("한국시간 NTP : ${currentTime}");

      this.date = currentTime.toString();

      //
      // await time_Kor.getTime();
      // print("한국시간 : " + time_Kor.time);
      // this.date = time_Kor.time.toString();

      // Navigator.pushNamed(context, '/home',arguments:{
      //   'location': instance.location,
      //   'flag': instance.flag,
      //   'time' : instance.time,
      //   'isDaytime': instance.isDaytime,
      // });
    }


    return StreamBuilder<member_UserData>(
      stream: DatabaseService(uid: user.uid).member_userData,
      builder: (context, snapshot) {
        if(snapshot.hasData){

          member_UserData? member_userData = snapshot.data;
          this.name = member_userData!.name;
          this.score = member_userData!.score;
          // this.date = DateFormat("dd.MM.yy HH:mm:ss").format(DateTime.now());
          Korean_Time();

          return Scaffold(
            // resizeToAvoidBottomInset: false,
            appBar: AppBar(
              backgroundColor: Colors.brown[600],
              actions: <Widget>[
                IconButton(
                  icon: const Icon(Icons.save),
                  onPressed: () async {
                    await DatabaseService(uid: user.uid).member_updateUserScore(
                      snapshot.data!.score
                    );
                    await DatabaseService(uid: user.uid).board_addmemo(
                      // updata버튼 누르면 설정한 값들을 이용해서 firestore에 데이터를 바로 업데이트
                      // uid ?? user.uid,
                        this.date,
                        //this.date ?? time_Kor!.time,
                        this.name ?? member_userData!.name,
                        this.title,
                        this.text,
                        this.score ?? member_userData!.score
                    );
                    Navigator.pop(context);
                  }, //데이터베이스로 내용을 보내서 추가시킨다.
                  // onPressed: updateDB,
                )
              ],
            ),

            body: SingleChildScrollView(
              // 내용이 위젯 화면 넘치면 에러나는거 방지하기 위해 사용
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: <Widget>[
                    TextField(
                      //게시물의 title을 입력받는 form
                      onChanged: (String title) {
                        this.title = title;
                      },
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w500,
                      ),
                      keyboardType: TextInputType.multiline,
                      maxLines: 1,
                      decoration: InputDecoration(
                        hintText: '제목을 입력하세요',
                      ),
                    ),

                    Padding(padding: EdgeInsets.all(10)),

                    // TextField(  //id입력
                    //   onChanged :(String id){this.id  = id;},
                    //   keyboardType: TextInputType.multiline,
                    //   maxLines: 1,
                    //   decoration: InputDecoration(
                    //     hintText: '사용자를 입력하세요',
                    //   ),
                    // ),
                    // Padding(padding: EdgeInsets.all(10)),

                    TextField(
                      //게시물의 내용을 입력받는 form
                      onChanged: (String text) {
                        this.text = text;
                      },
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      decoration: InputDecoration(
                        hintText: '내용을 입력하세요',
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // body: Padding(padding: EdgeInsets.all(20), child: loadBuilder()),
          );
        }
        else{
          return Loading();
        }

      }
    );
  }



  // Future<void> saveDB() async{
  //   DBHelper sd = DBHelper();
  //
  //   var fido = Memo(
  //     date : DateTime.now().toString(),
  //     user_uid : this.user_uid,   //시간으로 id설정
  //     title : this.title,
  //     text: this.text,
  //   );
  //
  //   await sd.insertMemo(fido);
  //
  //   print(await sd.memos());
  //
  // }




//   return Scaffold(
  //     // resizeToAvoidBottomInset: false,
  //     appBar: AppBar(
  //       actions: <Widget>[
  //         IconButton(
  //           icon: const Icon(Icons.save),
  //           onPressed: () async {
  //             await DatabaseService(uid: user.uid).board_addmemo(
  //                 // updata버튼 누르면 설정한 값들을 이용해서 firestore에 데이터를 바로 업데이트
  //                 // uid ?? user.uid,
  //                 this.date,
  //                 this.name,
  //                 this.title,
  //                 this.text);
  //             Navigator.pop(context);
  //           }, //데이터베이스로 내용을 보내서 추가시킨다.
  //           // onPressed: updateDB,
  //         )
  //       ],
  //     ),
  //
  //     body: SingleChildScrollView(
  //       // 내용이 위젯 화면 넘치면 에러나는거 방지하기 위해 사용
  //       child: Padding(
  //         padding: const EdgeInsets.all(10),
  //         child: Column(
  //           children: <Widget>[
  //             TextField(
  //               //게시물의 title을 입력받는 form
  //               onChanged: (String title) {
  //                 this.title = title;
  //               },
  //               style: TextStyle(
  //                 fontSize: 30,
  //                 fontWeight: FontWeight.w500,
  //               ),
  //               keyboardType: TextInputType.multiline,
  //               maxLines: 1,
  //               decoration: InputDecoration(
  //                 hintText: '제목을 입력하세요',
  //               ),
  //             ),
  //
  //             Padding(padding: EdgeInsets.all(10)),
  //
  //             // TextField(  //id입력
  //             //   onChanged :(String id){this.id  = id;},
  //             //   keyboardType: TextInputType.multiline,
  //             //   maxLines: 1,
  //             //   decoration: InputDecoration(
  //             //     hintText: '사용자를 입력하세요',
  //             //   ),
  //             // ),
  //             // Padding(padding: EdgeInsets.all(10)),
  //
  //             TextField(
  //               //게시물의 내용을 입력받는 form
  //               onChanged: (String text) {
  //                 this.text = text;
  //               },
  //               keyboardType: TextInputType.multiline,
  //               maxLines: null,
  //               decoration: InputDecoration(
  //                 hintText: '내용을 입력하세요',
  //               ),
  //             ),
  //           ],
  //         ),
  //       ),
  //     ),
  //     // body: Padding(padding: EdgeInsets.all(20), child: loadBuilder()),
  //   );
  // }






// String Str2sha256(String text){
//   var bytes = utf8.encode(text);
//
//   var digest = sha256.convert(bytes);
//
//   return digest.toString();
// }

// Future<List<Memo>> loadMemo(String id) async {
//   DBHelper sd = DBHelper();
//   return await sd.findMemo(id);
// }


// loadBuilder() {
//   return FutureBuilder<List<Memo>>(
//     future: loadMemo(widget.id),
//     builder: (BuildContext context, AsyncSnapshot<List<Memo>> snapshot) {
//       if (snapshot.data == null || snapshot.data == []) {
//         return Container(child: Text("데이터를 불러올 수 없습니다."));
//       } else {
//         Memo memo = snapshot.data[0];
//
//         var tecTitle = TextEditingController();
//         title = memo.title;
//         tecTitle.text = title;
//
//         var tecText = TextEditingController();
//         text = memo.text;
//         tecText.text = text;
//
//         return Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: <Widget>[
//             TextField(
//               controller: tecTitle,
//               maxLines: 2,
//               onChanged: (String title) {
//                 this.title = title;
//               },
//               style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500),
//               //obscureText: true,
//               decoration: InputDecoration(
//                 //border: OutlineInputBorder(),
//                 hintText: '게시물의 제목을 적어주세요.',
//               ),
//             ),
//             Padding(padding: EdgeInsets.all(10)),
//             TextField(
//               controller: tecText,
//               maxLines: 8,
//               onChanged: (String text) {
//                 this.text = text;
//               },
//               //obscureText: true,
//               decoration: InputDecoration(
//                 //border: OutlineInputBorder(),
//                 hintText: '게시물의 내용을 적어주세요.',
//               ),
//             ),
//           ],
//         );
//       }
//     },
//   );
// }

// void updateDB() {
//   DBHelper sd = DBHelper();
//
//   var fido = Memo(
//     id: widget.id, // String
//     title: this.title,
//     text: this.text,
//   );
//
//   sd.updateMemo(fido);
//   Navigator.pop(_context);
// }
}


//
// class EditPage extends StatelessWidget {
//   String id = '';
//   String title = '';
//   String text = '';
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         // resizeToAvoidBottomInset: false,
//         appBar: AppBar(
//           actions: <Widget>[
//             IconButton(
//               icon: const Icon(Icons.save),
//               onPressed: saveDB,
//               // onPressed: updateDB,
//             )
//           ],
//         ),
//         body: Padding(
//           padding: const EdgeInsets.all(10),
//           child: Column(
//             children: <Widget>[
//               TextField(
//                 onChanged :(String title){this.title  = title;},
//                 style: TextStyle(
//                   fontSize: 30,
//                   fontWeight: FontWeight.w500,
//                 ),
//                 keyboardType: TextInputType.multiline,
//                 maxLines: 1,
//                 decoration: InputDecoration(
//                   hintText: '제목을 입력하세요',
//                 ),
//               ),
//               Padding(padding: EdgeInsets.all(10)),
//
//               // TextField(  //id입력
//               //   onChanged :(String id){this.id  = id;},
//               //   keyboardType: TextInputType.multiline,
//               //   maxLines: 1,
//               //   decoration: InputDecoration(
//               //     hintText: '사용자를 입력하세요',
//               //   ),
//               // ),
//               // Padding(padding: EdgeInsets.all(10)),
//               TextField(
//                 onChanged :(String text){this.text = text;},
//                 keyboardType: TextInputType.multiline,
//                 maxLines: null,
//                 decoration: InputDecoration(
//                   hintText: '내용을 입력하세요',
//                 ),
//               ),
//             ],
//           ),
//         ),
//         // body: Padding(padding: EdgeInsets.all(20), child: loadBuilder()),
//     );
//   }
//
//   Future<void> saveDB() async{
//     DBHelper sd = DBHelper();
//
//     var fido = Memo(
//       id : DateTime.now().toString(),   //시간으로 id설정
//       //id : Str2sha256(DateTime.now().toString()),
//       title : this.title,
//       text: this.text,
//     );
//
//     await sd.insertMemo(fido);
//
//     print(await sd.memos());
//
//   }
//
//   // String Str2sha256(String text){
//   //   var bytes = utf8.encode(text);
//   //
//   //   var digest = sha256.convert(bytes);
//   //
//   //   return digest.toString();
//   // }
//
//   // Future<List<Memo>> loadMemo(String id) async {
//   //   DBHelper sd = DBHelper();
//   //   return await sd.findMemo(id);
//   // }
//
//
//   // loadBuilder() {
//   //   return FutureBuilder<List<Memo>>(
//   //     future: loadMemo(widget.id),
//   //     builder: (BuildContext context, AsyncSnapshot<List<Memo>> snapshot) {
//   //       if (snapshot.data == null || snapshot.data == []) {
//   //         return Container(child: Text("데이터를 불러올 수 없습니다."));
//   //       } else {
//   //         Memo memo = snapshot.data[0];
//   //
//   //         var tecTitle = TextEditingController();
//   //         title = memo.title;
//   //         tecTitle.text = title;
//   //
//   //         var tecText = TextEditingController();
//   //         text = memo.text;
//   //         tecText.text = text;
//   //
//   //         return Column(
//   //           crossAxisAlignment: CrossAxisAlignment.stretch,
//   //           children: <Widget>[
//   //             TextField(
//   //               controller: tecTitle,
//   //               maxLines: 2,
//   //               onChanged: (String title) {
//   //                 this.title = title;
//   //               },
//   //               style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500),
//   //               //obscureText: true,
//   //               decoration: InputDecoration(
//   //                 //border: OutlineInputBorder(),
//   //                 hintText: '게시물의 제목을 적어주세요.',
//   //               ),
//   //             ),
//   //             Padding(padding: EdgeInsets.all(10)),
//   //             TextField(
//   //               controller: tecText,
//   //               maxLines: 8,
//   //               onChanged: (String text) {
//   //                 this.text = text;
//   //               },
//   //               //obscureText: true,
//   //               decoration: InputDecoration(
//   //                 //border: OutlineInputBorder(),
//   //                 hintText: '게시물의 내용을 적어주세요.',
//   //               ),
//   //             ),
//   //           ],
//   //         );
//   //       }
//   //     },
//   //   );
//   // }
//
//   // void updateDB() {
//   //   DBHelper sd = DBHelper();
//   //
//   //   var fido = Memo(
//   //     id: widget.id, // String
//   //     title: this.title,
//   //     text: this.text,
//   //   );
//   //
//   //   sd.updateMemo(fido);
//   //   Navigator.pop(_context);
//   // }
// }
