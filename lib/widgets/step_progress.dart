import 'package:flutter/material.dart';

class StepProgress extends StatefulWidget {
  final double currentStep;
  final double steps;

  const StepProgress({super.key, required this.currentStep, required this.steps});
  
  @override
  State<StatefulWidget> createState() => _StepProgressState();
}

class _StepProgressState extends State<StepProgress> {
  double widthProgress = 0;

   @override
  void initState() {
    
    super.initState();
    _onSizeWidget();
  }

  void _onSizeWidget() {
    WidgetsBinding.instance.addPostFrameCallback((timestamp) {
      if(context.size is Size) {
        Size size = context.size!;
        widthProgress = size.width / (widget.steps -1);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.sizeOf(context).width;
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text('${(widget.currentStep + 1).toInt()} / ${widget.steps.toInt()}', style: const TextStyle( color: Colors.white),)
          ],
        ),
        Container(
          height: 4,
          width: width,
          margin: const EdgeInsets.symmetric(vertical: 16),
          decoration: BoxDecoration(
            color: Colors.deepPurpleAccent.withOpacity(0.4),
                borderRadius: const BorderRadius.all(Radius.circular(8))
          ),
          child: Stack(
            children: [
              AnimatedContainer(
                width: widthProgress * widget.currentStep,
                duration: const Duration(milliseconds: 300), decoration: const BoxDecoration(
                color: Colors.deepPurpleAccent,
                borderRadius: BorderRadius.all(Radius.circular(8))
              ),)
            ],
          ),
        )
      ],
    );
  }

}