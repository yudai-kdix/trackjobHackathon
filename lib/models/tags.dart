class Tags{
  int? id;
  String name;
  int coutTrue ;
  int coutFalse ;
  bool isMemorized;

  Tags(
      {this.id,
      required this.name,
      this.coutTrue = 0,
      this.coutFalse = 0,
      this.isMemorized = false});

  Map<String, dynamic> toMap() {
    // idがnullならマップに含めない（自動インクリメントのため）
    var map = {
      'name': name,
      'coutTrue': coutTrue,
      'coutFalse': coutFalse,
      'isMemorized': isMemorized ? 1 : 0,
    };
    if (id != null) {
      map['id'] =  id as Object;
    }
    return map;
  }
  static Tags fromMap(Map<String, dynamic> map) {
    return Tags(
      id: map['id'],
      name: map['name'],
      coutTrue: map['coutTrue'],
      coutFalse: map['coutFalse'],
      isMemorized: map['isMemorized'] == 1,
    );
  }
}