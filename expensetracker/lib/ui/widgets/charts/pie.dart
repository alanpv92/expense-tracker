import 'dart:math';

import 'package:expensetracker/ui/models/chart.dart';
import 'package:flutter/material.dart';

class CustomAnimatedPieChart extends StatefulWidget {
  final List<ChartDataSet> chartDataSet;
  final bool shouldAnimate;
  final Size? size;
  final Color holeColor;
  const CustomAnimatedPieChart(
      {super.key,
      this.shouldAnimate = true,
      required this.chartDataSet,
      this.holeColor = Colors.white,
      this.size});

  @override
  State<CustomAnimatedPieChart> createState() => _CustomAnimatedPieChartState();
}

class _CustomAnimatedPieChartState extends State<CustomAnimatedPieChart>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation _animation;

  @override
  void initState() {
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500));
    _animation =
        Tween<double>(begin: 0, end: 2 * pi).animate(_animationController);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _animationController.addListener(() {
        setState(() {});
      });
      if (widget.shouldAnimate) {
        _animationController.forward();
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: widget.size ?? const Size(200, 200),
      painter: PieChartPainter(
          holeColor: widget.holeColor,
          fullAngleValue: widget.shouldAnimate ? _animation.value : 2 * pi,
          shouldAnimate: widget.shouldAnimate,
          chartDataSet: widget.chartDataSet),
    );
  }
}

class PieChartPainter extends CustomPainter {
  final bool shouldAnimate;
  final List<ChartDataSet> chartDataSet;
  final double fullAngleValue;
  final Color holeColor;
  PieChartPainter(
      {required this.shouldAnimate,
      required this.chartDataSet,
      required this.holeColor,
      required this.fullAngleValue});
  @override
  void paint(Canvas canvas, Size size) {
    double totalValue = chartDataSet.fold(
        0, (previousValue, element) => previousValue + element.value);
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width * 0.8;
    final rect = Rect.fromCenter(center: center, width: radius, height: radius);

    double startingAngle = -pi / 2;
    for (var element in chartDataSet) {
      double sweepAngle = (element.value / totalValue) * fullAngleValue;
      canvas.drawArc(rect, startingAngle, sweepAngle, true,
          Paint()..color = element.color);
      startingAngle += sweepAngle;
    }
    canvas.drawCircle(center, radius * 0.1, Paint()..color = holeColor);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return shouldAnimate;
  }
}
