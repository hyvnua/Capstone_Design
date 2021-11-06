class Memo {
  final String id;
  final String title;
  final String text;

  Memo({required this.id,required this.title,required this.text});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'text': text,
    };
  }

  // 각 memo 정보를 보기 쉽도록 print 문을 사용하여 toString을 구현하세요
  @override
  String toString() {
    return 'Memo{id: $id , title: $title, text: $text}';
  }
}
