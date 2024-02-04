import 'package:flutter/material.dart';
import 'package:gp_calculator/utilities/constants.dart';

class DropdownCard extends StatefulWidget {
  final String title;
  final List<String> dropdownList;
  final String? selectedOption;
  final Function(String?) onSelect;

  const DropdownCard({
    super.key,
    required this.title,
    required this.dropdownList,
    required this.onSelect,
    required this.selectedOption,
  });

  @override
  State<DropdownCard> createState() => _DropdownCardState();
}

class _DropdownCardState extends State<DropdownCard> {
  String? _option;

  @override
  void initState() {
    _option = widget.selectedOption;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('${widget.title}:'),
        GestureDetector(
          onTap: () async {
            String? selectedOption = await showDialog(
              context: context,
              builder: (BuildContext context) {
                return SimpleDialog(
                  title: Text('Select ${widget.title}'),
                  titlePadding: const EdgeInsets.all(12),
                  surfaceTintColor: kPrimaryColor,
                  shape: const RoundedRectangleBorder(),
                  children: widget.dropdownList
                      .map(
                        (option) => SimpleDialogOption(
                          child: Text(option),
                          onPressed: () {
                            Navigator.pop(context, option);
                          },
                        ),
                      )
                      .toList(),
                );
              },
            );

            if (selectedOption != null) {
              setState(() {
                _option = selectedOption;
              });
              widget.onSelect(selectedOption);
            }
          },
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(10.0)
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(_option ?? 'None'),
                const Icon(Icons.arrow_drop_down),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
