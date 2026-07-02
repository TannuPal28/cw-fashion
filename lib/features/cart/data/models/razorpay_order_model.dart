class RazorpayOrderModel {

  final bool success;

  final String razorpayOrderId;

  final int amount;

  final String currency;

  final String key;

  RazorpayOrderModel({

    required this.success,

    required this.razorpayOrderId,

    required this.amount,

    required this.currency,

    required this.key,

  });

  factory RazorpayOrderModel.fromJson(
      Map<String,dynamic> json){

    return RazorpayOrderModel(

      success: json["success"],

      razorpayOrderId: json["razorpayOrderId"],

      amount: json["amount"],

      currency: json["currency"],

      key: json["key"],

    );

  }

}