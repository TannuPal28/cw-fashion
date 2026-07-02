class AddressResponse {
  final bool success;
  final List<AddressModel> addresses;

  AddressResponse({required this.success, required this.addresses});

  factory AddressResponse.fromJson(Map<String, dynamic> json) {
    return AddressResponse(
      success: json["success"],
      addresses: (json["addresses"] as List)
          .map((e) => AddressModel.fromJson(e))
          .toList(),
    );
  }
}

class AddressModel {
  final String id;
  final String label;
  final String fullName;
  final String phone;
  final String alternatePhone;
  final String addressLine1;
  final String addressLine2;
  final String landmark;
  final String city;
  final String state;
  final String pincode;
  final String country;
  final bool isDefault;
  final String addressType;

  AddressModel({
    required this.id,
    required this.label,
    required this.fullName,
    required this.phone,
    required this.alternatePhone,
    required this.addressLine1,
    required this.addressLine2,
    required this.landmark,
    required this.city,
    required this.state,
    required this.pincode,
    required this.country,
    required this.isDefault,
    required this.addressType,
  });

  factory AddressModel.fromJson(Map<String, dynamic> json) {
    return AddressModel(
      id: json["_id"] ?? "",
      label: json["label"] ?? "",
      fullName: json["fullName"] ?? "",
      phone: json["phone"] ?? "",
      alternatePhone: json["alternatePhone"] ?? "",
      addressLine1: json["addressLine1"] ?? "",
      addressLine2: json["addressLine2"] ?? "",
      landmark: json["landmark"] ?? "",
      city: json["city"] ?? "",
      state: json["state"] ?? "",
      pincode: json["pincode"] ?? "",
      country: json["country"] ?? "",
      isDefault: json["isDefault"] ?? false,
      addressType: json["addressType"] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "_id": id,
      "label": label,
      "fullName": fullName,
      "phone": phone,
      "alternatePhone": alternatePhone,
      "addressLine1": addressLine1,
      "addressLine2": addressLine2,
      "landmark": landmark,
      "city": city,
      "state": state,
      "pincode": pincode,
      "country": country,
      "isDefault": isDefault,
      "addressType": addressType,
    };
  }
}
