class Memo {
  final String date;
  final String user_uid;
  final String title;
  final String text;

  Memo({required this.date,required this.user_uid,required this.title,required this.text});

  Map<String, dynamic> toMap() {
    return {
      'date' : date,
      'user_uid': user_uid,
      'title': title,
      'text': text,
    };
  }

  // 각 memo 정보를 보기 쉽도록 print 문을 사용하여 toString을 구현하세요
  @override
  String toString() {
    return 'Memo{date: $date , id: $user_uid , title: $title, text: $text}';
  }
}
