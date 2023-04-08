// import 'package:flutter/material.dart';
// import 'package:flutter_inapp_purchase/flutter_inapp_purchase.dart';
//
// class SubscriptionPage extends StatefulWidget {
//   @override
//   _SubscriptionPageState createState() => _SubscriptionPageState();
// }
//
// class _SubscriptionPageState extends State<SubscriptionPage> {
//   List<IAPItem> _items = [];
//   List<PurchasedItem> _purchased = [];
//
//   @override
//   void initState() {
//     super.initState();
//     FlutterInappPurchase.instance.initConnection;
//     _getProduct();
//     FlutterInappPurchase.instance.purchaseUpdatedStream.listen((data) {
//       setState(() {
//         _purchased = data;
//       });
//     });
//   }
//
//   Future<void> _getProduct() async {
//     List<IAPItem> items = await FlutterInappPurchase.instance.getProducts(['monthly_subscription', 'yearly_subscription']);
//     setState(() {
//       _items = items;
//     });
//   }
//
//   Future<void> _buyProduct(IAPItem item) async {
//     try {
//       PurchasedItem purchased = await FlutterInappPurchase.instance.purchaseProduct(item.productId);
//       if (purchased != null && purchased.status == 0) {
//         // The purchase was successful
//       } else {
//         // The purchase failed
//       }
//     } catch (error) {
//       // Handle the error
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Subscriptions'),
//       ),
//       body: ListView.builder(
//         itemCount: _items.length,
//         itemBuilder: (context, index) {
//           return ListTile(
//             title: Text(_items[index].title),
//             subtitle: Text(_items[index].description),
//             onTap: () => _buyProduct(_items[index]),
//           );
//         },
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:pay/pay.dart';

class GooglePayment extends StatefulWidget {
  final String paymentConfigurationAsset;
  final String paymentItemLabel;
  final String paymentItemAmount;
  final Color googlePayButtonColor;
  final double googlePayButtonHeight;

  const GooglePayment({
    Key? key,
    this.paymentConfigurationAsset = 'sample_payment_configuration.json',
    this.paymentItemLabel = 'usd',
    this.paymentItemAmount = '5.00',
    this.googlePayButtonColor = Colors.white,
    this.googlePayButtonHeight = 200.0,
  }) : super(key: key);

  @override
  State<GooglePayment> createState() => _GooglePaymentState();
}

class _GooglePaymentState extends State<GooglePayment> {
  @override
  Widget build(BuildContext context) {
    final paymentItems = <PaymentItem>[
      PaymentItem(
        amount: widget.paymentItemAmount,
        label: widget.paymentItemLabel,
        status: PaymentItemStatus.final_price,
      ),
    ];

    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Row(
          children: [
            GooglePayButton(
              paymentConfigurationAsset: widget.paymentConfigurationAsset,
              paymentItems: paymentItems,
              type: GooglePayButtonType.pay,
              onPaymentResult: onGooglePayResult,
              height: widget.googlePayButtonHeight,
            ),
          ],
        ),
      ),
    );
  }

  void onGooglePayResult(paymentResult) {
    // Send the resulting Google Pay token to your server / PSP
  }
}

// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// class googleSignIn extends StatefulWidget {
//   const googleSignIn({Key? key}) : super(key: key);
//
//   @override
//   State<googleSignIn> createState() => _googleSignInState();
// }
//
// class _googleSignInState extends State<googleSignIn> {
//   GoogleSignInAccount _currentUser;
//   PaymentsClient _paymentsClient;
//
//   @override
//   void initState() {
//     super.initState();
//     _initializeGooglePay();
//   }
//
//   Future<void> _initializeGooglePay() async {
//     // Initialize the PaymentsClient.
//     final client = await _createPaymentsClient();
//     setState(() {
//       _paymentsClient = client;
//     });
//
//     // Request user authorization to use Google Pay.
//     await _requestAuthorization();
//
//     // Set up the payment data request.
//     final request = PaymentDataRequest(
//       merchantInfo: MerchantInfo(
//         merchantName: 'Example Merchant',
//       ),
//       transactionInfo: TransactionInfo(
//         totalPriceStatus: TotalPriceStatus.finalPrice,
//         totalPrice: '10.00',
//         currencyCode: 'USD',
//       ),
//     );
//   }
//
//   Future<PaymentsClient> _createPaymentsClient() async {
//     final http.Client httpClient = await GoogleAuthProvider.autoAuthenticate();
//     return PaymentsClient(
//       httpClient: httpClient,
//       environment: PaymentEnvironment.production,
//     );
//   }
//
//   Future<void> _requestAuthorization() async {
//     _currentUser = await GoogleSignIn().signIn();
//     final googleAuthClient = await GoogleAuthProvider.addGoogleAccount(
//       _currentUser.authHeaders['Authorization'],
//     );
//   }
//
//   Future<void> _handleGooglePay() async {
//     try {
//       // Set up the payment data request.
//       final request = PaymentDataRequest(
//         merchantInfo: MerchantInfo(
//           merchantName: 'Example Merchant',
//         ),
//         transactionInfo: TransactionInfo(
//           totalPriceStatus: TotalPriceStatus.finalPrice,
//           totalPrice: '10.00',
//           currencyCode: 'USD',
//         ),
//       );
//
//       // Load the payment data.
//       final paymentData = await _paymentsClient.loadPaymentData(request);
//
//       // Process the payment data.
//       await _processPayment(paymentData);
//     } catch (e) {
//       print('Error processing payment: $e');
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//
//     );
//   }
// }
