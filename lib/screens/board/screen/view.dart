import 'package:alcohol_project/models/Board.dart';
import 'package:alcohol_project/models/Person.dart';
import 'package:alcohol_project/models/user.dart';
import 'package:alcohol_project/screens/board/db/memo.dart';
import 'package:alcohol_project/screens/board/screen/memoBuilder.dart';
import 'package:alcohol_project/screens/home/boarderTile.dart';
import 'package:alcohol_project/service/database.dart';
import 'package:alcohol_project/shared/loading.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'edit.dart';
import 'package:alcohol_project/screens/board/db/db.dart';
// import 'package:memomemo/screens/view.dart';
import 'package:flutter/src/material/flat_button.dart';

class MyHomePage extends StatefulWidget {

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String deleteId = '';
  @override
  Widget build(BuildContext context) {

    // final member_info = Provider.of<List<Person>>(context);//home.dart 에서 streamProvider로 Person<List> 형식으로 데이터 가져옴
    final user = Provider.of<MyUser>(context);


    return StreamBuilder<List<Board>>(
      stream: DatabaseService(uid:user.uid).Boarder_info,
      builder: (context, snapshot) {
        if(!snapshot.hasData){
          return Loading();
        }
        else{
          // final user_selfData = Provider.of<member_UserData>(context) ?? [];
          return Scaffold(

            appBar: AppBar(
              backgroundColor: Colors.brown[600],
              title: Text("커뮤니티"),
            ),


            body: Container(
              decoration: BoxDecoration(
                color: Colors.brown[200],
              ),
              child: memoBuilder(),
            ),

            // body: Column(
            //   children: <Widget>[
            //     // Padding(
            //     //   padding: EdgeInsets.only(left: 20, top: 40, bottom: 20),
            //     //   // child: Container(
            //     //   //   child: Text('메모메모',
            //     //   //       style: TextStyle(fontSize: 36, color: Colors.blue)),
            //     //   //   alignment: Alignment.centerLeft,
            //     //   // ),
            //     // ),
            //     Expanded(child: memoBuilder(context))
            //   ],
            // ),
            floatingActionButton: FloatingActionButton.extended(//버튼 클릭시 개시물 작성할수 있도록
              onPressed: () {
                Navigator.push(
                  context,
                  CupertinoPageRoute(
                    builder: (context) => EditPage(
                    ),
                  ),
                );
              },
              tooltip: "게시물을 작성하세요",
              label: Text('게시물 추가'),
              icon: Icon(Icons.add),
              backgroundColor: Colors.lightGreen[700],
            ), // This trailing comma makes auto-formatting nicer for build methods.
          );
        }

      }
    );
  }

  //delete yes or no


  // void showAlertDialog(BuildContext context) async {
  //   await showDialog(
  //     context: context,
  //     barrierDismissible: false, // user must tap button!
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         title: Text('삭제 경고'),
  //         content: Text("정말 삭제하시겠습니까?\n삭제된 게시물은 복구되지 않습니다."),
  //         actions: <Widget>[
  //           FlatButton(
  //             child: Text('삭제'),
  //             onPressed: () {
  //               Navigator.pop(context, "삭제");
  //               setState(() {
  //                 deleteMemo(deleteId);
  //               });
  //               deleteId = '';
  //             },
  //           ),
  //           FlatButton(
  //             child: Text('취소'),
  //             onPressed: () {
  //               deleteId = '';
  //               Navigator.pop(context, "취소");
  //             },
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }


}
