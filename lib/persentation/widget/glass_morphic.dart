// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable
import 'package:flutter/material.dart';

class GlassBox extends StatelessWidget {
  Widget widget;
  List<BoxShadow>? boxShadow;
  GradientTransform? transform;
  AlignmentGeometry? begin;
  AlignmentGeometry? end;

  GlassBox({
    Key? key,
    required this.widget,
    this.boxShadow,
    this.transform,
    this.begin,
    this.end,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      foregroundDecoration: BoxDecoration(
        gradient: LinearGradient(
          begin: begin ?? Alignment.topCenter,
          end: end ?? Alignment.bottomCenter,
          transform: transform ?? const GradientRotation(3.14 / 2),
          colors: [
            Theme.of(context).colorScheme.primary.withOpacity(0.5),
            Theme.of(context).colorScheme.secondary.withOpacity(0.5),
          ],
        ),
        borderRadius: BorderRadius.circular(26),
      ),
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        boxShadow: boxShadow ??
            [
              BoxShadow(
                color: Theme.of(context).colorScheme.primary.withOpacity(0.5),
                spreadRadius: 1,
                blurRadius: 1,
                offset: const Offset(4, 5),
              ),
            ],
        borderRadius: BorderRadius.circular(26),
      ),
      child: widget,
    );
  }
}
