class Contact {
  String id;
  String address;
  String phoneNumber;

  Contact({
    required this.id,
    required this.address,
    required this.phoneNumber,
  });

  factory Contact.fromJson(Map<String, dynamic> json) => Contact(
        id: json["_id"],
        address: json["address"],
        phoneNumber: json["phoneNumber"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "address": address,
        "phoneNumber": phoneNumber,
      };
}
