import 'package:flutter/material.dart';


class CustomFloatingActionButton extends StatelessWidget {

  const CustomFloatingActionButton({
    super.key, required this.widget,
  });

  final Widget widget;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
        onPressed: () {
          showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              builder: (context) => widget);
        },
        color: const Color(0xffCAEEA3),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
        child: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.add),
            SizedBox(width: 8),
            Text('Add new'),
          ],
        ));
  }
}