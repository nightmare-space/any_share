import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class GestureWithScale extends StatefulWidget {
  const GestureWithScale({
    Key? key,
    this.onTap,
    this.child,
    this.radio = 0.02,
  }) : super(key: key);
  final void Function()? onTap;
  final Widget? child;
  final double radio;

  @override
  State createState() => _GestureWithScaleState();
}

class _GestureWithScaleState extends State<GestureWithScale> with SingleTickerProviderStateMixin {
  AnimationController? animationController;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
    );
    animationController!.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(9999),
      onTap: () {
        if (widget.onTap == null) {
          return;
        }
        setState(() {});
        HapticFeedback.heavyImpact();
        animationController!.reverse();
        widget.onTap!();
      },
      onTapDown: (_) {
        if (widget.onTap == null) {
          return;
        }
        animationController!.forward();
        HapticFeedback.heavyImpact();
        setState(() {});
      },
      onTapCancel: () {
        if (widget.onTap == null) {
          return;
        }
        animationController!.reverse();
        HapticFeedback.heavyImpact();
        setState(() {});
      },
      child: Transform(
        alignment: Alignment.center,
        transform: Matrix4.identity()
          ..scale(
            1.0 - animationController!.value * widget.radio,
          ),
        child: widget.child,
      ),
    );
    return Transform(
      alignment: Alignment.center,
      transform: Matrix4.identity()
        ..scale(
          1.0 - animationController!.value * widget.radio,
        ),
      child: GestureDetector(
        onTap: () {
          if (widget.onTap == null) {
            return;
          }
          setState(() {});
          HapticFeedback.heavyImpact();
          animationController!.reverse();
          widget.onTap!();
        },
        onPanDown: (_) {
          if (widget.onTap == null) {
            return;
          }
          animationController!.forward();
          HapticFeedback.heavyImpact();
          setState(() {});
        },
        onTapCancel: () {
          if (widget.onTap == null) {
            return;
          }
          animationController!.reverse();
          HapticFeedback.heavyImpact();
          setState(() {});
        },
        child: widget.child,
      ),
    );
  }
}
