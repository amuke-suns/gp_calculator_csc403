import 'package:flutter/material.dart';

class DropdownCardNoEdit extends StatelessWidget {
  final String title;
  final String selectedOption;

  const DropdownCardNoEdit({
    super.key,
    required this.title,
    required this.selectedOption,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('$title:'),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
          ),
          child: Text(selectedOption),
        ),
      ],
    );
  }
}
