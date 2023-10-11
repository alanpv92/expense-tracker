import 'package:expensetracker/ui/widgets/custom_bottom_navbar.dart';
import 'package:flutter/material.dart';

class Dash extends StatelessWidget {
  const Dash({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(child: SizedBox()),
          CustomBottomNavBar(),
        ],
      ),
    );
  }
}
