import 'dart:convert';

List<Voucher> voucherFromJson(String str) =>
    List<Voucher>.from(json.decode(str).map((x) => Voucher.fromJson(x)));

String voucherToJson(List<Voucher> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Voucher {
  String? id;
  bool? isAvailable;
  String? name;
  int? amount;
  List<UserUseVoucher>? user;
  Conditions? conditions;
  DateTime? expireAt;

  Voucher({
    this.id,
    this.isAvailable,
    this.name,
    this.amount,
    this.user,
    this.conditions,
    this.expireAt,
  });

  factory Voucher.fromJson(Map<String, dynamic> json) => Voucher(
        id: json["_id"],
        isAvailable: json["isAvailable"],
        name: json["name"],
        amount: json["amount"],
        user: List<UserUseVoucher>.from(
            json["user"].map((x) => UserUseVoucher.fromJson(x))),
        conditions: Conditions.fromJson(json["conditions"]),
        expireAt: DateTime.parse(json["expireAt"]),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "isAvailable": isAvailable,
        "name": name,
        "amount": amount,
        "user": List<dynamic>.from(user!.map((x) => x.toJson())),
        "conditions": conditions?.toJson(),
        "expireAt": expireAt?.toIso8601String(),
      };
}

class Conditions {
  int? minValues;
  DateTime? startDate;
  DateTime? endDate;

  Conditions({
    this.minValues,
    this.startDate,
    this.endDate,
  });

  factory Conditions.fromJson(Map<String, dynamic> json) => Conditions(
        minValues: json["minValues"],
        startDate: DateTime.parse(json["startDate"]),
        endDate: DateTime.parse(json["endDate"]),
      );

  Map<String, dynamic> toJson() => {
        "minValues": minValues,
        "startDate": startDate?.toIso8601String(),
        "endDate": endDate?.toIso8601String(),
      };
}

class UserUseVoucher {
  String? id;
  String? userId;
  String? orderId;

  UserUseVoucher({
    this.id,
    this.userId,
    this.orderId,
  });

  factory UserUseVoucher.fromJson(Map<String, dynamic> json) => UserUseVoucher(
        id: json["_id"],
        userId: json["userId"],
        orderId: json["orderId"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "userId": userId,
        "orderId": orderId,
      };
}
