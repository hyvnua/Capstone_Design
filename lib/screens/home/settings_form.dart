import 'package:alcohol_project/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:alcohol_project/service/database.dart';
import 'package:provider/provider.dart';
import 'package:alcohol_project/models/user.dart';
import 'package:alcohol_project/shared/constants.dart';

class SettingsForm extends StatefulWidget {
  @override
  _SettingsFormState createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {

  final _formKey = GlobalKey<FormState>();//form을 사용하기 위해 필요한것
  //final List<String> sugars = ['0', '1', '2', '3', '4'];
  final List<String> drink = ['0', '1', '2', '3', '4','5','6','more'];

  // form values
  // String _currentName = 'User';//실시간으로 선택하면 그 값들이 여기 저장될것임
  // String _currentSugars = '0';
  // int _currentStrength = 100;

  // form values
  String _currentName = '';//실시간으로 선택하면 그 값들이 여기 저장될것임
  String _currentdrink = '';
  int _currentScore = 0;

  @override
  Widget build(BuildContext context) {

    final user = Provider.of<MyUser>(context);//로그인시 사용한 uid를 다른위젯에서도 사용 가능하도록 하기 위해 사용

    //return StreamBuilder<UserData>(// stream을 이용해서 firestore 데이터 가져오기
    return StreamBuilder<member_UserData>(// stream을 이용해서 firestore 데이터 가져오기
      //stream: DatabaseService(uid: user.uid).userData,//DatabaseService 위젯의 stream get을 이용해서 해당 uid의 name, sugar, strength가져옴=
      stream: DatabaseService(uid: user.uid).member_userData,//DatabaseService 위젯의 stream get을 이용해서 해당 계정 정보를 가져옴
      builder: (context, snapshot) {

        // member_UserData? member_userData = snapshot.data;
        // print("user_uid : ${member_userData!.name}, error인가요? ");
        //print("hasData : ${snapshot.hasData}, error인가요? ");

        if(snapshot.hasData){//해당 uid가 firestore 컬렉션에 있다면 실행

          //UserData? userData = snapshot.data;//firestore로부터 가져온 정보를 UserData 객체형태로 저장
          member_UserData? member_userData = snapshot.data;//firestore로부터 가져온 정보를 UserData 객체형태로 저장


          return Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                Text(
                  '계정 정보 수정 ',
                  style: TextStyle(fontSize: 25.0),
                ),
                SizedBox(height: 20.0),
                TextFormField(//입력폼

                  decoration: textInputDecoration.copyWith(hintText: 'ex)이름 '),
                  //initialValue: userData!.name,//firestore로 부터 가져온 데이터를 넣은 userData객체로  name을 넣어줌
                  initialValue: member_userData!.name,//firestore로 부터 가져온 데이터를 넣은 member_userData객체로  name을 넣어줌

                  validator: (val) => val!.isEmpty ? 'Please enter a name' : null,//검증하는 곳으로, 비어있으면 문구 실행
                  onChanged: (val) => setState(() => _currentName = val),//변경되었으면 currentName 변수에 변경된 값을 저장
                ),
                SizedBox(height: 10.0),

                DropdownButtonFormField(
                  decoration: textInputDecoration,//택스트필드 꾸미는 위젯
                  //value: _currentSugars ?? userData!.sugars,//firestore로부터 가져온 데이터 중 sugars를 현재 sugar에다가 넣어줌
                  //value: _currentdrink ?? member_userData!.drink,//firestore로부터 가져온 데이터 중 sugars를 현재 sugar에다가 넣어 줌
                  value: member_userData!.drink,
                  items: drink.map((drink) {//위에 있는 배열을 가져옴
                  //items: sugars.map((sugar) {//위에 있는 배열을 가져옴

                    return DropdownMenuItem(//드롭다운형식으로 보여줌
                      //value: sugar,
                      value: drink,

                      //child: Text('$sugar sugars'),//배열에 들어있는 값으로 차례로 드롭다운 메뉴형식으로 보여줌
                      child: Text('$drink 병'),//배열에 들어있는 값으로 차례로 드롭다운 메뉴형식으로 보여줌
                    );
                  }).toList(),// map을 사용했으니 tolist로 마무리
                  //onChanged: (value) => setState(() => _currentSugars = value.toString()),//변경된 값을 저장
                  onChanged: (value) => setState(() => _currentdrink = value.toString()),//변경된 값을 저장

                ),

                // Slider(
                //   //value: (_currentStrength ?? userData.strength).toDouble(),//움직이는 값에따라 정수로 바꿔줘야함
                //   value: (_currentScore ?? member_userData.score).toDouble(),//움직이는 값에따라 정수로 바꿔줘야함
                //
                //   // activeColor: Colors.brown[_currentStrength ?? userData.strength],//바의 색이 움직일때마다 바로 적용됨
                //   // inactiveColor: Colors.brown[_currentStrength ?? userData.strength],
                //   activeColor: Colors.brown[_currentScore ?? member_userData.score],//바의 색이 움직일때마다 바로 적용됨
                //   inactiveColor: Colors.brown[_currentScore ?? member_userData.score],
                //
                //   min: 100.0,//바의 최소값을 설정
                //   max: 900.0,
                //   divisions: 8,
                //   //onChanged: (val) => setState(() => _currentStrength = val.round()),//정수 형태로 바꿔줘야함
                //   onChanged: (val) => setState(() => _currentScore = val.round()),//정수 형태로 바꿔줘야함
                // ),
                SizedBox(height: 10.0),
                RaisedButton(
                  color: Colors.brown[600],
                  child: Text(
                    'Update',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () async {
                    if(_formKey.currentState!.validate()){//글로벌키를 이용해서 현재 폼에서의 동작이라는것이 검증되면 실행
                      // await DatabaseService(uid : user.uid).updateUserData(// updata버튼 누르면 설정한 값들을 이용해서 firestore에 데이터를 바로 업데이트
                      //     _currentSugars ?? userData.sugars,
                      //     _currentName ?? userData.name,
                      //     _currentStrength ?? userData.strength
                      // );

                      // await DatabaseService(uid : user.uid).member_updateUserData(// updata버튼 누르면 설정한 값들을 이용해서 firestore에 데이터를 바로 업데이트
                      //     _currentName ?? member_userData.name,
                      //     _currentAge ?? member_userData.age,
                      //     _currentScore ?? member_userData.score
                      // );

                      if(_currentName == ''){
                        _currentName = member_userData.name;
                      }

                      if(_currentdrink == ''){
                        _currentdrink = member_userData.drink;
                      }

                      await DatabaseService(uid : user.uid).member_settingUserData(// updata버튼 누르면 설정한 값들을 이용해서 firestore에 데이터를 바로 업데이트
                          _currentName ?? member_userData.name,
                          _currentdrink ?? member_userData.drink
                      );

                      Navigator.pop(context);
                      //호출한 위젯인 home위젯으로 돌아간다.
                      // 이때 home 위젯에서는 firestore 의 업데이트된 데이터를 가져와서 화면에 띄워준다.
                    }
                  },
                ),
              ],
            ),
          );
        }else{// 해당 uid가 firestore 컬렉션에 없다면 실행
          //print("해당 uid (${user.uid} ) 가 존재하지 않습니다. error -> settings_form.dart 로 가서 확인하기 ");
          return Loading();
        }
      }
    );
  }
}