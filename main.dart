import 'package:flutter/material.dart';
import 'pages/entry_form.dart';
import 'package:google_fonts/google_fonts.dart';
import 'pages/home_page.dart';
import 'pages/search.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const DocDesk());
}

class DocDesk extends StatefulWidget {
  const DocDesk({Key? key}) : super(key: key);

  @override
  State<DocDesk> createState() => _DocDeskState();
}

class _DocDeskState extends State<DocDesk> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        "/first": (context) => EntryForm(),
        "/second": (context) => HomePage(),
        "/third": (context) => search(),
      },
      home: HomePage(),
      themeMode: ThemeMode.light,
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        fontFamily: GoogleFonts.lato().fontFamily,
      ),
    );
  }
}
