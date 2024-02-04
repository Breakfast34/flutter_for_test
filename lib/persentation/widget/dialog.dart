// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';

class ShowDialog extends StatelessWidget {
  String productDesc;
  String description;

  ShowDialog({
    Key? key,
    required this.productDesc,
    required this.description,
  }) : super(key: key);

  // final List<Product> listProducts;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        height: 250,
        width: 350,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.background,
          borderRadius: BorderRadius.circular(26),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              productDesc,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Theme.of(context).colorScheme.onBackground,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Container(
              padding: const EdgeInsets.only(left: 10),
              alignment: Alignment.topLeft,
              child: Text(
                description,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onBackground,
                  fontSize: 18,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
            Divider(
              color: Theme.of(context).colorScheme.onBackground,
              thickness: 1,
            ),
            InkWell(
              onTap: () => Navigator.pop(context),
              child: Text(
                'Close',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onBackground,
                  fontSize: 18,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
