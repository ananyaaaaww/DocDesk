import 'package:flutter/material.dart';

class MyDropdown extends StatefulWidget {
  @override
  _MyDropdownState createState() => _MyDropdownState();

  final ValueChanged<String?> onCategorySelected;

  MyDropdown({required this.onCategorySelected});
}

class _MyDropdownState extends State<MyDropdown> {
  String? dropdownValue = "Endoscopic Treatment";

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: dropdownValue,
      onChanged: (String? newValue) {
        setState(() {
          dropdownValue = newValue ?? "Endoscopic Treatment";
          widget.onCategorySelected(dropdownValue);
        });
      },
      items: <String>[
        "Endoscopic Treatment",
        "Fracture Treatment",
        "Joint Replacement",
        "Arthritis",
        "Orthopaedic Physio",
        "Spine Clinics"
      ].map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(
            value,
            style: TextStyle(color: Colors.purple[900]),
          ),
        );
      }).toList(),
    );
  }
}
