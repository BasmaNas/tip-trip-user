import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:tip_trip/payment/payment_card.dart';

class checkout {
  static var _tokenUrl = Uri.parse('https://api.sandbox.checkout.com/tokens');
  static var _paymentUrl =
      Uri.parse('https://api.sandbox.checkout.com/payments');

  static const String _publicKey =
      'pk_test_4b13f870-0dc0-4b14-9618-3785ab6b035b';
  static const String _secretKey =
      'sk_test_64c95c42-7562-4973-8a2b-45ada6a0b9b1';

  static const Map<String, String> _tokenHeader = {
    'Content-Type': 'Application/json',
    'Authorization': _publicKey
  };

  static const Map<String, String> _paymentHeader = {
    'Content-Type': 'Application/json',
    'Authorization': _secretKey
  };

  //////////////// take token
  Future<String> getToken(PaymentCard card) async {
    Map<String, String> body = {
      'type': 'card',
      'number': card.number,
      'expiry_month': card.expiry_month,
      'expiry_year': card.expiry_year
    };
    http.Response response = await http.post(_tokenUrl,
        headers: _tokenHeader, body: jsonEncode(body));

    switch (response.statusCode) {
      case 201:
        var data = jsonDecode(response.body);
        return data['token'];
        break;
      default:
        return ('card invalid!!');
        break;
    }
  }

  /////////////////
  Future<String> makePayment(PaymentCard card, int amount) async {
    String token = await getToken(card);
    Map<String, dynamic> body = {
      'source': {'type': 'token', 'token': token},
      'amount': amount,
      'currency': 'USD'
    };

    http.Response response = await http.post(_paymentUrl,
        headers: _paymentHeader, body: jsonEncode(body));

    switch (response.statusCode) {
      case 201:
        //   var data = jsonDecode(response.body);
        // print(data["response_summary"]);
        return ('payment Succed');
        break;
      default:
        return ('payment failed');
    }
  }
}
