import 'package:flutter/material.dart';

class MyTextBox extends StatelessWidget {
  final String text;
  final String sectionName;
  final void Function()? onPressed;

  const MyTextBox({
    Key? key,
    required this.text,
    required this.sectionName,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.only(
        left: 15,
        bottom: 15,
      ),
      margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // section name
              Text(
                sectionName,
                style: TextStyle(
                  color: theme.colorScheme.secondary,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),

              //edit button
              IconButton(
                onPressed: onPressed,
                icon: Icon(
                  Icons.edit,
                  color: theme.iconTheme.color,
                ),
              )
            ],
          ),
          const SizedBox(
            height: 8,
          ),
          // text
          Text(
            text,
            style: TextStyle(
              fontSize: 15,
              color: theme.colorScheme.onSurface,
            ),
          ),
        ],
      ),
    );
  }
}
