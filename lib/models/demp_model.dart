import 'dart:convert';

class DemoModel {
  final String name;
  final double amount;
  final DateTime dateTime;
  DemoModel({
    this.name,
    this.amount,
    this.dateTime,
  });

  DemoModel copyWith({
    String name,
    double amount,
    DateTime dateTime,
  }) {
    return DemoModel(
      name: name ?? this.name,
      amount: amount ?? this.amount,
      dateTime: dateTime ?? this.dateTime,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'amount': amount,
      'dateTime': dateTime.millisecondsSinceEpoch,
    };
  }

  factory DemoModel.fromMap(Map<String, dynamic> map) {
    return DemoModel(
      name: map['name'],
      amount: map['amount'],
      dateTime: DateTime.fromMillisecondsSinceEpoch(map['dateTime']),
    );
  }

  String toJson() => json.encode(toMap());

  factory DemoModel.fromJson(String source) =>
      DemoModel.fromMap(json.decode(source));

  @override
  String toString() =>
      'DemoModel(name: $name, amount: $amount, dateTime: $dateTime)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is DemoModel &&
        other.name == name &&
        other.amount == amount &&
        other.dateTime == dateTime;
  }

  @override
  int get hashCode => name.hashCode ^ amount.hashCode ^ dateTime.hashCode;
}
