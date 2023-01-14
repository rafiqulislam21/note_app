import 'package:flutter/material.dart';

class EmptyWidget extends StatelessWidget {
  final IconData? icon;
  final double? iconSize;

  const EmptyWidget({Key? key, this.icon, this.iconSize = 80})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
          child: Card(
        elevation: 0,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(16))),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Icon(
            icon ?? Icons.error_outline,
            color: Colors.grey,
            size: iconSize,
          ),
        ),
      )),
    );
  }
}
