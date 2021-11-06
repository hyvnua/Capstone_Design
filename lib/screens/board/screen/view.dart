import 'package:alcohol_project/screens/board/db/memo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
    return Scaffold(
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
              color: Colors.grey[300],
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
                  "커뮤니티 목록",
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                // onTap: () => {
                //   Navigator.push(
                //     context,
                //     // MaterialPageRoute(
                //     //   builder: (context) => Communication(key: key, title: '커뮤니티',),
                //     // ),
                //   ),
                //   // Navigator.pop(context),
                // },
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
        title: Text("커뮤니티"),
      ),

      body: Column(
        children: <Widget>[
          // Padding(
          //   padding: EdgeInsets.only(left: 20, top: 40, bottom: 20),
          //   // child: Container(
          //   //   child: Text('메모메모',
          //   //       style: TextStyle(fontSize: 36, color: Colors.blue)),
          //   //   alignment: Alignment.centerLeft,
          //   // ),
          // ),
          Expanded(child: memoBuilder(context))
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
              context, CupertinoPageRoute(builder: (context) => EditPage()));
        },
        tooltip: "게시물을 작성하세요",
        label: Text('게시물 추가'),
        icon: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Future<List<Memo>> loadMemo() async {
    DBHelper sd = DBHelper();
    return await sd.memos();
  }

  Future<void> deleteMemo(String id) async {
    DBHelper sd = DBHelper();
    await sd.deleteMemo(id);
  }

  //delete yes or no
  void showAlertDialog(BuildContext context) async {
    String result = await showDialog(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('삭제 경고'),
            content: Text("정말 삭제하시겠습니까?"),
            actions: <Widget>[
              FlatButton(
                child: Text('삭제'),
                onPressed: () {
                  Navigator.pop(context, "삭제");
                  setState(() {
                    deleteMemo(deleteId);
                  });
                  deleteId = '';
                },
              ),
              FlatButton(
                child: Text('취소'),
                onPressed: () {
                  deleteId = '';
                  Navigator.pop(context, "취소");
                },
              )
            ],
          );
        }
    );
  }




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

  Widget memoBuilder(BuildContext parentContext) {
    return FutureBuilder<List<Memo>>(
      builder: (context, snap) {
        if (snap.data == null || snap.data!.isEmpty) {
          return Container(
            alignment: Alignment.center,
            child: Text(
              '지금 바로 "게시물 추가" 버튼을 눌러\n새로운 게시물을 추가해보세요!\n\n\n\n\n\n\n\n\n',
              style: TextStyle(fontSize: 15, color: Colors.blueAccent),
              textAlign: TextAlign.center,
            ),
          );
        }
        return ListView.builder(
          physics: BouncingScrollPhysics(),
          padding: EdgeInsets.all(20),
          itemCount: snap.data!.length,
          itemBuilder: (context, index) {
            Memo memo = snap.data![index];
            // return InkWell(
            //   onTap: () {
            //     Navigator.push(
            //         parentContext,
            //         CupertinoPageRoute(
            //             builder: (context) => ViewPage(id: memo.id)));
            //   },
            //   onLongPress: () {
            //     deleteId = memo.id;
            //     showAlertDialog(parentContext);
            //   },
            //   child: Container(
            //       margin: EdgeInsets.all(5),
            //       padding: EdgeInsets.all(15),
            //       alignment: Alignment.center,
            //       height: 100,
            //       child: Column(
            //         mainAxisAlignment: MainAxisAlignment.center,
            //         crossAxisAlignment: CrossAxisAlignment.stretch,
            //         children: <Widget>[
            //           Column(
            //             mainAxisAlignment: MainAxisAlignment.center,
            //             crossAxisAlignment: CrossAxisAlignment.stretch,
            //             children: <Widget>[
            //               Text(
            //                 memo.title,
            //                 style: TextStyle(
            //                   fontSize: 20,
            //                   fontWeight: FontWeight.w500,
            //                 ),
            //                 overflow: TextOverflow.ellipsis,
            //               ),
            //               Text(
            //                 memo.text,
            //                 style: TextStyle(fontSize: 15),
            //                 overflow: TextOverflow.ellipsis,
            //               ),
            //             ],
            //           ),
            //         ],
            //       ),
            //       decoration: BoxDecoration(
            //         color: Color.fromRGBO(240, 240, 240, 1),
            //         border: Border.all(
            //           color: Colors.blue,
            //           width: 1,
            //         ),
            //         boxShadow: [
            //           BoxShadow(color: Colors.lightBlue, blurRadius: 3)
            //         ],
            //         borderRadius: BorderRadius.circular(12),
            //       )),
            // );
            return InkWell(
              onTap: (){

              },
              onLongPress: () {
                print(memo.id);
                deleteId = memo.id;
                setState(() {
                  showAlertDialog(parentContext);
                });
              },
              child: Container(
                margin: EdgeInsets.all(5),
                padding: EdgeInsets.all(10),
                alignment: Alignment.center,
                // height : 80,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Column(

                      children: <Widget>[
                        Text(memo.title,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(memo.text,
                          style : TextStyle(
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),

                    // Widget to display the list of project
                  ],
                ),
                decoration: BoxDecoration(
                  color: Colors.grey[50],
                  border : Border.all(
                    color: Colors.blue,
                    width: 1,
                  ),
                  boxShadow: [BoxShadow(
                    color: Colors.blue,
                    blurRadius: 4,
                  )],
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            );
          },
        );
      },
      future: loadMemo(),
    );
  }
}
