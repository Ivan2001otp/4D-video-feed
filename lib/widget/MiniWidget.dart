import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ReelMiniWidget extends StatelessWidget {
  final String widgetName;
  final IconData icon;

  const ReelMiniWidget({super.key, required this.widgetName, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        IconButton(
          onPressed: () {},
          icon: Icon(
            icon,
            color: widgetName == "Like" ? Colors.red : Colors.white,
          ),
        ),
        const SizedBox(
          height: 4,
        ),
        Text(
          widgetName,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(
          height: 40,
        ),
      ],
    );
  }
}
