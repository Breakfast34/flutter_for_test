// ignore_for_file: must_be_immutable

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CarouselLoading extends StatelessWidget {
  CarouselController carouselController;
  int itemCount;
  CarouselOptions options;
  Widget Function(BuildContext, int, int)? itemBuilder;
  CarouselLoading({
    Key? key,
    required this.carouselController,
    required this.itemCount,
    required this.options,
    this.itemBuilder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return itemBuilder != null
        ? CarouselSlider.builder(
            carouselController: carouselController,
            itemCount: itemCount,
            options: options,
            itemBuilder: itemBuilder,
          )
        : Shimmer.fromColors(
            baseColor: Theme.of(context).colorScheme.primary,
            highlightColor: Theme.of(context).colorScheme.secondary,
            child: CarouselSlider.builder(
              disableGesture: false,
              carouselController: carouselController,
              itemCount: itemCount,
              options: options,
              itemBuilder: itemBuilder ??
                  (BuildContext context, int index, int realIndex) {
                    return Container(
                      margin: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primary,
                        borderRadius: BorderRadius.circular(26),
                      ),
                    );
                  },
            ),
          );
  }
}
