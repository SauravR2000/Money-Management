import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:money_management_app/features/dashboard/presentation/Dashboard%20Screens/transaction_listing/transaction_listing_body.dart';
import 'package:money_management_app/shared_widgets/screen_padding.dart';

@RoutePage()
class TransactionListingScreen extends StatelessWidget {
  const TransactionListingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("All Transactions"),
      ),
      body: screenPadding(child: TransactionListingBody()),
    );
  }
}
