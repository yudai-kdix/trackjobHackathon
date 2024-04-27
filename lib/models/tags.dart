class Tags{
  int? id;
  String name;
  int countTrue ;
  int countFalse ;
  bool isMemorized;

  Tags(
      {this.id,
      required this.name,
      this.countTrue = 0,
      this.countFalse = 0,
      this.isMemorized = false});

  Map<String, dynamic> toMap() {
    // idがnullならマップに含めない（自動インクリメントのため）
    var map = {
      'name': name,
      'countTrue': countTrue,
      'countFalse': countFalse,
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
      countTrue: map['countTrue'],
      countFalse: map['countFalse'],
      isMemorized: map['isMemorized'] == 1,
    );
  }
}