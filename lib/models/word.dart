class Word{
  int? id;
  String term;
  String definition;
  List<String> tags;
  bool judge1;
  bool judge2;
  int countTrue = 0;
  int countFalse = 0;
  bool isMemorized;

  Word(
      {this.id,
      required this.term,
      required this.definition,
      required this.tags,
      required this.judge1,
      required this.judge2,
      required this.countTrue,
      required this.countFalse,
      this.isMemorized = false});

  Map<String, dynamic> toMap() {
    // idがnullならマップに含めない（自動インクリメントのため）
    var map = {
      'term': term,
      'definition': definition,
      'tags': tags.join(','), // タグリストをカンマ区切りの文字列に変換
      'judge1': judge1 ? 1 : 0,
      'judge2': judge2 ? 1 : 0,
      'countTrue': countTrue,
      'countFalse': countFalse,
      'isMemorized': isMemorized ? 1 : 0,
    };
    if (id != null) {
      map['id'] =  id as Object;
    }
    return map;
  }
  static Word fromMap(Map<String, dynamic> map) {
    return Word(
      id: map['id'],
      term: map['term'],
      definition: map['definition'],
      tags: map['tags'].split(','), // カンマ区切りの文字列をリストに変換
      judge1: map['judge1'] == 1,
      judge2: map['judge2'] == 1,
      countTrue: map['countTrue'],
      countFalse: map['countFalse'],
      isMemorized: map['isMemorized'] == 1,
    );
  }
}