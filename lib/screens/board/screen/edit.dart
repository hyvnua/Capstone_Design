import 'dart:convert';
// import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:alcohol_project/screens/board/db/memo.dart';
import 'package:alcohol_project/screens/board/db/db.dart';

// class EditPage extends StatefulWidget {
//   // EditPage({Key key, this.id}) : super(key: key);
//   // final String id;
//
//   String title = '';
//   String text = '';
//
//   @override
//   _EditPageState createState() => _EditPageState();
// }
//
// class _EditPageState extends State<EditPage> {
//   // BuildContext _context;
//   //
//   // String title = '';
//   // String text = '';
//   // String createTime = '';
//
//   @override
//   Widget build(BuildContext context) {
// _context = context;

class EditPage extends StatefulWidget {
  //const EditPage({Key? key}) : super(key: key);

  @override
  _EditPageState createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  String id = '';
  String title = '';
  String text = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: saveDB,
            // onPressed: updateDB,
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: <Widget>[
              TextField(
                onChanged :(String title){this.title  = title;},
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
                onChanged :(String text){this.text = text;},
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

  Future<void> saveDB() async{
    DBHelper sd = DBHelper();

    var fido = Memo(
      id : DateTime.now().toString(),   //시간으로 id설정
      //id : Str2sha256(DateTime.now().toString()),
      title : this.title,
      text: this.text,
    );

    await sd.insertMemo(fido);

    print(await sd.memos());

  }

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
