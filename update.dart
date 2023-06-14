import 'dart:io';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'entry_form.dart';
import 'drop_down.dart';
import 'datepicker_screen.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class UpdateRecord extends StatefulWidget {
  const UpdateRecord({Key? key, required this.patientKey}) : super(key: key);

  final String patientKey;

  @override
  State<UpdateRecord> createState() => _UpdateRecordState();
}

class _UpdateRecordState extends State<UpdateRecord> {
  final userNameController = TextEditingController();
  final userAgeController = TextEditingController();
  final userAddressController = TextEditingController();
  final userDateOfAdmissionController = TextEditingController();
  final userCategoryController = TextEditingController();
  final usermediaController = TextEditingController();
  final uploadedFileURLController = TextEditingController();

  late DatabaseReference dbRef;

  @override
  void initState() {
    super.initState();
    dbRef = FirebaseDatabase.instance.ref().child('Patient');
    getpatientData();
  }

  void getpatientData() async {
    DataSnapshot snapshot = await dbRef.child(widget.patientKey).get();

    Map patient = snapshot.value as Map;

    userNameController.text = patient['Name'];
    userAgeController.text = patient['Age'];
    userAddressController.text = patient['Address'];
    userDateOfAdmissionController.text = patient['DateOfAdmission'];
    userCategoryController.text = patient['Category'];
    uploadedFileURLController.text = patient['UploadedFile'] ?? '';
  }

  String selectedDate = "";
  String? selectedCategory;

  void handleDateSelected(String date) {
    setState(() {
      selectedDate = date;
      userDateOfAdmissionController.text = date;
    });
  }

  void handleCategorySelected(String? category) {
    setState(() {
      selectedCategory = category;
      userCategoryController.text = category ?? '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Updating record'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  'Updating data in Firebase Realtime Database',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 20,
                ),
                TextField(
                  controller: userNameController,
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Name',
                    hintText: 'Enter Your Name',
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                TextField(
                  controller: userAgeController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Age',
                    hintText: 'Enter Your Age',
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                TextField(
                  controller: userAddressController,
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Address',
                    hintText: 'Enter Your Address',
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                Row(
                  children: [
                    MyDropdown(onCategorySelected: handleCategorySelected),
                  ],
                ),
                const SizedBox(
                  height: 8,
                ),
                Column(
                  children: [
                    DatePicker(onDateSelected: handleDateSelected),
                  ],
                ),
                const SizedBox(
                  height: 8,
                ),
                ElevatedButton(
                  onPressed: () async {
                    FilePickerResult? result =
                        await FilePicker.platform.pickFiles();

                    if (result != null) {
                      File file = File(result.files.single.path ?? '');
                      String fileName = result.files.single.name;
                      String? fileURL = await uploadFile(file, fileName);
                      if (fileURL != null) {
                        setState(() {
                          uploadedFileURLController.text = fileURL;
                        });
                      }
                    }
                  },
                  child: Text('Choose File'),
                ),
                if (uploadedFileURLController.text.isNotEmpty)
                  Text('Selected File: ${uploadedFileURLController.text}'),
                ElevatedButton(
                  onPressed: () {
                    updateRecord();
                  },
                  child: Text('Upload File'),
                ),
                const SizedBox(
                  height: 8,
                ),
                MaterialButton(
                  onPressed: () {
                    Map<String, String> patients = {
                      'Name': userNameController.text,
                      'Age': userAgeController.text,
                      'Address': userAddressController.text,
                      'DateOfAdmission': userDateOfAdmissionController.text,
                      'Category': userCategoryController.text,
                      'UploadedFile': uploadedFileURLController.text,
                    };

                    dbRef
                        .child(widget.patientKey)
                        .update(patients)
                        .then((value) => {Navigator.pop(context)});
                  },
                  child: const Text('Update Data'),
                  color: Colors.blue,
                  textColor: Colors.white,
                  minWidth: 300,
                  height: 40,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<String?> uploadFile(File file, String fileName) async {
    try {
      firebase_storage.Reference storageRef =
          firebase_storage.FirebaseStorage.instance.ref().child(fileName);

      firebase_storage.UploadTask uploadTask = storageRef.putFile(file);

      firebase_storage.TaskSnapshot taskSnapshot =
          await uploadTask.whenComplete(() => null);

      String fileURL = await taskSnapshot.ref.getDownloadURL();
      return fileURL;
    } catch (e) {
      print(e);
      return null;
    }
  }

  void updateRecord() {
    print('Updating record with file');
  }
}
