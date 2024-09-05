import 'dart:convert';
import 'package:aidaly/controllers/Role/Shopper_Controllar/add_to_card_controllar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class StripePaymentController extends GetxController {
  AddToCartControllar addToCartCtrl = Get.put(AddToCartControllar());



  Future<void> initPaymentSheet() async {
    try {
      // 1. Create payment intent on the client side by calling Stripe API
      final data = await createPaymentIntent();

      // 2. Initialize the payment sheet
    await Stripe.instance.initPaymentSheet(
      paymentSheetParameters: SetupPaymentSheetParameters(
        // Set to true for custom flow
        customFlow: false,
        // Main params
        merchantDisplayName: 'Test Merchant',
        paymentIntentClientSecret: data['client_secret'],
        // Customer keys
        customerEphemeralKeySecret: data['ephemeralKey'],
        customerId: data['id'],

        style: ThemeMode.dark,
      ),
    );
    } catch (e) {
      print('Error initializing payment sheet: $e');
      rethrow;
    }
  }

///create payment
  Future createPaymentIntent() async{
    final url = Uri.parse('https://api.stripe.com/v1/payment_intents');
    final secretKey=dotenv.env["STRIPE_SECRET_KEY"]!;

    var body={
      'amount': '120',
      'currency': 'eur',
    };

    final response= await http.post(
        url,
        headers: {
          "Authorization": "Bearer $secretKey",
          'Content-Type': 'application/x-www-form-urlencoded'
        },
        body: body
    );

    print(body);

    if(response.statusCode==200){
      var json=jsonDecode(response.body);
      print(json);
      return json;

    }
    else{
      print("error in calling payment intent");
    }
  }
}
