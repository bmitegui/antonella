// import 'package:flutter/material.dart';
// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:flutter_inappwebview/flutter_inappwebview.dart';

// class NuveiPaymentPage extends StatefulWidget {
//   const NuveiPaymentPage({super.key});

//   @override
//   State<NuveiPaymentPage> createState() => _NuveiPaymentPageState();
// }

// class _NuveiPaymentPageState extends State<NuveiPaymentPage> {
//   final localhostServer = InAppLocalhostServer(documentRoot: 'assets');
//   InAppWebViewController? webViewController;

//   @override
//   void initState() {
//     super.initState();
//     _startServerAndLoad();
//   }

//   Future<void> _startServerAndLoad() async {
//     await localhostServer.start();

//     // 1️⃣ Obtener token del backend
//     final res = await http.post(
//       Uri.parse("http://TU_BACKEND/create-payment-session"),
//       headers: {"Content-Type": "application/json"},
//       body: jsonEncode({"amount": "10", "currency": "USD"}),
//     );

//     final token = jsonDecode(res.body)["sessionToken"];

//     // 2️⃣ Cargar HTML con token
//     final paymentUrl = "http://localhost:8080/payment.html?sessionToken=$token";

//     webViewController?.loadUrl(
//       urlRequest: URLRequest(url: WebUri(paymentUrl)),
//     );
//   }

//   @override
//   void dispose() {
//     localhostServer.close();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("Pago Nuvei")),
//       body: InAppWebView(
//         initialUrlRequest:
//             URLRequest(url: WebUri("http://localhost:8080/payment.html")),
//         onWebViewCreated: (controller) {
//           webViewController = controller;

//           controller.addJavaScriptHandler(
//             handlerName: "onPaymentResult",
//             callback: (args) {
//               final result = args.first;
//               Navigator.pop(context, result);
//             },
//           );
//         },
//       ),
//     );
//   }
// }
