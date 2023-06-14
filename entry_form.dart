import 'dart:io';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'drop_down.dart';
import 'datepicker_screen.dart';


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
  File? selectedFile = null;

  Map<String, dynamic> patient = {};

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

  Future<void> _pickFile() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        allowMultiple: false,
        type: FileType.any,
      );

      if (result != null) {
        List<PlatformFile> files = result.files;
        File file = File(files[0].path!);

       
        String fileName = DateTime.now().microsecondsSinceEpoch.toString() +
            "_" +
            files[0].name;

        
        firebase_storage.Reference storageRef =
            firebase_storage.FirebaseStorage.instance.ref().child(fileName);
        firebase_storage.UploadTask uploadTask = storageRef.putFile(file);
        firebase_storage.TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() {});

        setState(() {
          selectedFile = file;
        });

        print("File Uploaded");

      
      } else {
       
      }
    } on Exception catch (e) {
      print("Error picking file: $e");
    }
  }
  
showAlertDialog(BuildContext context) { 
  Widget okButton = ElevatedButton(  
    child: Text("OK"),  
    onPressed: () {  
      Navigator.of(context).pop();  
    },  
  );   
   AlertDialog alert = AlertDialog( 
    content: Text("Entry Done, Doctor!"),  
    actions: [  
      okButton,  
    ],  
  );  
  
  // show the dialog  
  showDialog(  
    context: context,  
    builder: (BuildContext context) {  
      return alert;  
    },  
  );  
}  
  void _enterToDatabase() {
    if (selectedFile != null) {
      firebase_storage.Reference storageRef = firebase_storage
          .FirebaseStorage.instance.ref()
          .child('files/${DateTime.now().microsecondsSinceEpoch.toString()}');
      firebase_storage.UploadTask uploadTask =
          storageRef.putFile(selectedFile!);
      uploadTask.whenComplete(() async {
        String fileUrl = await storageRef.getDownloadURL();
        showAlertDialog(context);  
        patient['Name'] = Name1.text;
        patient['Age'] = Age1.text;
        patient['Address'] = Address1.text;
        patient['DateOfAdmission'] = selectedDate;
        patient['Category'] = selectedCategory;
        patient['UploadedFile'] = fileUrl;
        print("entry done");
       
        dbRef.push().set(patient);
      }).catchError((error) {
        
        print("Upload Error: $error");
      });
    } else {
      patient['Name'] = Name1.text;
      patient['Age'] = Age1.text;
      patient['Address'] = Address1.text;
      patient['DateOfAdmission'] = selectedDate;
      patient['Category'] = selectedCategory;

      
      dbRef.push().set(patient);
    }
  }
  

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SingleChildScrollView(
        child: Flexible(
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
                  padding: const EdgeInsets.all(13.0),
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
                                  TextStyle(fontSize: 16, color: Colors.purple[900]),
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
                      ElevatedButton(
                        onPressed: _pickFile,
                        child: Text("Upload File"),
                        style: TextButton.styleFrom(),
                      ),
                      SizedBox(height: 10.0),
                      ElevatedButton(
                        onPressed: _enterToDatabase,
                        
                        child: Text("Enter to database"),
                        style: TextButton.styleFrom(),
                      ),
                    ],
                  ),
                ),
            ],
          ),
          
        ),
      ),
    );
  }
}

