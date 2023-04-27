import 'package:flutter/material.dart';
import 'package:foodit/core/export.dart';
import 'package:foodit/utils/widgets/scrollable_column.dart';
import 'package:khalti_flutter/khalti_flutter.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Payment Method"),
      ),
      body: ScrollableColumn(children: [
        Text(
          "Select Payment Method",
          style: context.textStyles.displayLarge,
        ).pb(16),
        // KhaltiButton.wallet(
        //     config: config, onSuccess: onSuccess, onFailure: onFailure)
      ]),
    );
  }
}
