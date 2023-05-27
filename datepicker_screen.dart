import "package:flutter/material.dart";
import 'package:intl/intl.dart';

class DatePicker extends StatefulWidget {
  @override
  State<DatePicker> createState() => _DatePickerState();

  final Function(String) onDateSelected;
  DatePicker({required this.onDateSelected});
}

class _DatePickerState extends State<DatePicker> {
  TextEditingController dateController = TextEditingController();

  @override
  void initState() {
    super.initState();
    dateController.text = "";
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(10),
        child: Center(
            child: TextField(
          style: TextStyle(color: Colors.purple[900]),
          controller: dateController,
          decoration: const InputDecoration(
              icon: Icon(Icons.calendar_today), labelText: "Enter Date"),
          readOnly: true,
          onTap: () async {
            DateTime? pickedDate = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(2000),
              lastDate: DateTime(2101),
            );
            if (pickedDate != null) {
              String formattedDate =
                  DateFormat("yyyy-MM-dd").format(pickedDate);

              setState(() {
                dateController.text = formattedDate.toString();
              });

              widget.onDateSelected(formattedDate);
            } else {
              print("Not selected");
            }
          },
        )));
  }
}
