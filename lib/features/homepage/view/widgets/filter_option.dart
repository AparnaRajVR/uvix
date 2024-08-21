import 'package:flutter/material.dart';

class FilterOption extends StatefulWidget {
  final String title;
  final List<String> options;
  final Function(List<String>) onChanged;

  FilterOption(
      {required this.title, required this.options, required this.onChanged});

  @override
  _FilterOptionState createState() => _FilterOptionState();
}

class _FilterOptionState extends State<FilterOption> {
  List<String> selectedOptions = [];

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text(widget.title),
      children: widget.options.map((option) {
        return CheckboxListTile(
          title: Text(option),
          value: selectedOptions.contains(option),
          onChanged: (bool? value) {
            setState(() {
              if (value == true) {
                selectedOptions.add(option);
              } else {
                selectedOptions.remove(option);
              }
            });
            widget.onChanged(selectedOptions);
          },
        );
      }).toList(),
    );
  }
}
