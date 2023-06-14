import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:url_launcher/url_launcher.dart';
import 'update.dart';
import 'search.dart';

@override
Widget build(BuildContext context) {
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    title: '',
    theme: ThemeData(
      textTheme: const TextTheme(
          // bodyText2: TextStyle(color: Colors.red, fontWeight: FontWeight.w900),
          ),
    ),
  );
}

class FetchData extends StatefulWidget {
  const FetchData({Key? key}) : super(key: key);

  @override
  State<FetchData> createState() => _FetchDataState();
}

class _FetchDataState extends State<FetchData> {
  bool isSearching = false;

  Query dbRef = FirebaseDatabase.instance.ref().child('Patient');
  DatabaseReference reference =
      FirebaseDatabase.instance.ref().child('Patient');
  final Searchfilter = TextEditingController();

  Widget listItem({required Map patient}) {
    return Container(
      width: double.maxFinite,
      margin: const EdgeInsets.all(10),
      height: 200,
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text("Name: "),
              Text(
                patient['Name'],
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Colors.deepPurple,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text("Age: "),
              Text(
                patient['Age'],
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Colors.deepPurple,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text("Address: "),
              Text(
                patient['Address'],
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Colors.deepPurple,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text("DateOfAdmission: "),
              Text(
                patient['DateOfAdmission'],
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Colors.deepPurple,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text("Category: "),
              Text(
                patient['Category'],
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Colors.deepPurple,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => UpdateRecord(patientKey: patient['key']),
                    ),
                  );
                },
                child: Row(
                  children: [
                    Icon(
                      Icons.edit,
                      color: Theme.of(context).primaryColor,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                width: 6,
              ),
              GestureDetector(
                onTap: () {
                  reference.child(patient['key']).remove();
                },
                child: Row(
                  children: [
                    Icon(
                      Icons.delete,
                      color: Colors.red[700],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: !isSearching
            ? Text('Search Data')
            : TextField(
                controller: Searchfilter,
                onChanged: (String value) {
                  setState(() {});
                },
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  icon: Icon(
                    Icons.search,
                    color: Colors.white,
                  ),
                  hintText: "Search Data Here",
                  hintStyle: TextStyle(color: Colors.white),
                ),
              ),
        actions: [
          isSearching
              ? IconButton(
                  icon: Icon(Icons.cancel),
                  onPressed: () {
                    setState(() {
                      this.isSearching = false;
                    });
                  },
                )
              : IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    setState(() {
                      this.isSearching = true;
                    });
                  },
                ),
        ],
      ),
      body: Container(
        height: double.infinity,
        child: FirebaseAnimatedList(
          query: dbRef,
          itemBuilder: (BuildContext context, DataSnapshot snapshot,
              Animation<double> animation, int index) {
            final patient1 = snapshot.value as Map;

            Map patient = snapshot.value as Map;
            patient['key'] = snapshot.key;

            if (Searchfilter.text.isEmpty) {
              return listItem(patient: patient);
            } else if (patient['Name'].toLowerCase().contains(Searchfilter.text.toLowerCase())) {
              return listItem(patient: patient);
            } 
            else if (patient['Age'].toLowerCase().contains(Searchfilter.text.toLowerCase())) {
              return listItem(patient: patient);
            } 
            else if (patient['Address'].toLowerCase().contains(Searchfilter.text.toLowerCase())) {
              return listItem(patient: patient);
            }
            else if (patient['DateOfAdmission'].toLowerCase().contains(Searchfilter.text.toLowerCase())) {
              return listItem(patient: patient);
            }
            else if (patient['Category'].toLowerCase().contains(Searchfilter.text.toLowerCase())) {
              return listItem(patient: patient);
            }    
            else {
              return Container();
            }
          },
        ),
      ),
    );
  }
}
