import 'package:expensetracker/ui/constants/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final currentSelectIndexProvider = StateProvider<int>((ref) => 0);

class CustomBottomNavBar extends ConsumerWidget {
  CustomBottomNavBar({super.key});
  final List selectedColors = [
    Colors.blue,
    Colors.red,
    Colors.green,
  ];
  final List<String> labels = [
    StringContants.all,
    StringContants.expense,
    StringContants.income,
  ];
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedIndex = ref.watch(currentSelectIndexProvider);

    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      height: 75,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(color: selectedColors[selectedIndex]),
      child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: List.generate(
              3,
              (index) => Expanded(
                    child: GestureDetector(
                      onTap: () {
                        ref
                            .read(currentSelectIndexProvider.notifier)
                            .update((state) => index);
                      },
                      child: Text(
                        labels[index],
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: selectedIndex == index
                                ? FontWeight.w800
                                : FontWeight.w400,
                            color: Colors.white,
                            fontSize: selectedIndex == index ? 25 : 15),
                      ),
                    ),
                  ))),
    );
  }
}
