import 'package:flutter/material.dart';
import 'entry_form.dart';
import 'drawer_header.dart';
import 'package:flutter/cupertino.dart';
import 'search.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("DocDesk: Doctor's Handbook"),
        ),
        body: Center(
          child: Container(
              margin: const EdgeInsets.fromLTRB(20, 0, 20, 20),
              child: Column(
                children: [
                  SizedBox(
                    height: 30.0,
                  ),
                  Text(
                    "GAYATRI HOSPITAL",
                    style: TextStyle(
                        color: Colors.purple[900],
                        fontSize: 22,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Image.asset(
                    "assests/images/logo.jpg",
                    fit: BoxFit.contain,
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Text(
                    "For Your Desk : ",
                    style: TextStyle(
                        color: Colors.purple[900],
                        fontSize: 22,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 25.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Make New Patient Entry",
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.purple[900],
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                CupertinoPageRoute(
                                  builder: (context) => EntryForm(),
                                ));
                          },
                          child: Text("Make Entry"),
                          style: TextButton.styleFrom(),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Search for Patient Data",
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.purple[900],
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                CupertinoPageRoute(
                                  builder: (context) => search(),
                                ));
                          },
                          child: Text("Search Data"),
                          style: TextButton.styleFrom(),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Statistics",
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.purple[900],
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {},
                          child: Text("  Click Here  "),
                          style: TextButton.styleFrom(),
                        ),
                      ],
                    ),
                  ),
                ],
              )),
        ),
        drawer: Drawer(
          child: SingleChildScrollView(
            child: Container(
              child: Column(
                children: [
                  MyHeaderDrawer(),
                  SizedBox(
                    height: 5.0,
                  ),
                  ListTile(
                    leading: Icon(Icons.home),
                    title: Text(
                      "Home",
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    onTap: () {
                      Navigator.push(
                          context,
                          CupertinoPageRoute(
                            builder: (context) => HomePage(),
                          ));
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.document_scanner_rounded),
                    title: Text(
                      "Data Entry",
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    onTap: () {
                      Navigator.push(
                          context,
                          CupertinoPageRoute(
                            builder: (context) => EntryForm(),
                          ));
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.search),
                    title: Text(
                      "Search Entry",
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    onTap: () {
                      Navigator.push(
                          context,
                          CupertinoPageRoute(
                            builder: (context) => search(),
                          ));
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.medical_information),
                    title: Text(
                      "About the App",
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    onTap: null,
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
