import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'drop_down.dart';
import 'datepicker_screen.dart';
import 'package:image_picker/image_picker.dart';

class EntryForm extends StatefulWidget {
  @override
  State<EntryForm> createState() => _EntryFormState();
}

class _EntryFormState extends State<EntryForm> {
  final Name1 = TextEditingController();
  final Age1 = TextEditingController();
  final Address1 = TextEditingController();

  String selectedDate = "";
  String? selectedCategory = "";

  void handleDateSelected(String date) {
    setState(() {
      selectedDate = date;
    });
  }

  void handleCategorySelected(String? category) {
    setState(() {
      selectedCategory = category;
    });
  }

  late DatabaseReference dbRef;

  @override
  void initState() {
    super.initState();
    dbRef = FirebaseDatabase.instance.ref().child('Patient');
  }

  @override
  void dispose() {
    Name1.dispose();
    Age1.dispose();
    Address1.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Material(
      child: Column(
        children: [
          SizedBox(height: 100.0),
          Text(
            "Enter New Patient's Data",
            style: TextStyle(
              color: Colors.purple[900],
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 20.0),
          Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 16.0, horizontal: 32.0),
            child: Column(
              children: [
                TextFormField(
                  controller: Name1,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    hintText: "Enter Patient's Name",
                    hintStyle: TextStyle(
                      fontSize: 16,
                    ),
                    labelText: "Name",
                    labelStyle: TextStyle(
                      fontSize: 20,
                      color: Colors.purple[900],
                    ),
                  ),
                ),
                TextFormField(
                  controller: Age1,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: "Enter Patient's Age",
                    hintStyle: TextStyle(
                      fontSize: 16,
                    ),
                    labelText: "Age",
                    labelStyle: TextStyle(
                      fontSize: 20,
                      color: Colors.purple[900],
                    ),
                  ),
                ),
                TextFormField(
                  controller: Address1,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    hintText: "Enter Patient's Address",
                    hintStyle: TextStyle(
                      fontSize: 16,
                    ),
                    labelText: "Address",
                    labelStyle: TextStyle(
                      fontSize: 20,
                      color: Colors.purple[900],
                    ),
                  ),
                ),
                SizedBox(height: 30.0),
                Column(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Date of Admission",
                        style:
                            TextStyle(fontSize: 19, color: Colors.purple[900]),
                      ),
                    ),
                    DatePicker(onDateSelected: handleDateSelected),
                  ],
                ),
                SizedBox(height: 15.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Choose Category",
                      style: TextStyle(fontSize: 16, color: Colors.purple[900]),
                    ),
                    MyDropdown(onCategorySelected: handleCategorySelected),
                  ],
                ),
                SizedBox(height: 15.0),
                Row(
                  children: [
                    Text(
                      "Upload ECG/X-ray and Other Reports Below",
                      style: TextStyle(fontSize: 16, color: Colors.purple[900]),
                    ),
                  ],
                ),
                SizedBox(height: 20.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () async{
                    ImagePicker imagePicker = ImagePicker();
                    XFile? file =
                        await imagePicker.pickImage(source: ImageSource.gallery);
                    print('${file?.path}');
                    if (file == null) return;
                    String uniqueFileName = DateTime.now().millisecondsSinceEpoch.toString();

                     //Get a reference to storage root
                    Reference referenceRoot = FirebaseStorage.instance.ref();
                    Reference referenceDirImages =
                        referenceRoot.child('images');
                        //Create a reference for the image to be stored
                    Reference referenceImageToUpload =
                        referenceDirImages.child('name');

                      } ,
                      child: Text("Select File"),
                      style: TextButton.styleFrom(),
                    ),
                    SizedBox(width: 20.0),
                    ElevatedButton(
                      onPressed: () {
                        print("Media Uploaded");
                      },
                      child: Text("Upload File"),
                      style: TextButton.styleFrom(),
                    ),
                  ],
                ),
                SizedBox(height: 30.0),
                ElevatedButton(
                  onPressed: () {
                    Map<String, String?> patient = {
                      'Name': Name1.text,
                      'Age': Age1.text,
                      'Address': Address1.text,
                      'DateOfAdmission': selectedDate,
                      'Category': selectedCategory,
                      'UploadedFile': '',
                    };

                    dbRef.push().set(patient);
                    print("Entry done, doctor");
                  },
                  child: Text("Enter to database"),
                  style: TextButton.styleFrom(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
