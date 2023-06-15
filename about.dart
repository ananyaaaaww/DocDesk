// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ListScreen extends StatefulWidget {
  const ListScreen({Key? key}) : super(key: key);

  @override
  State<ListScreen> createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  double screenHeight = 0;
  double screenWidth = 0;

  bool startAnimation = false;

  List<String> texts = [
    "Doctor's Handbook for Patient's Data",
    "Easy Data Entry and Updating of Data",
    "Quick Search and Filteration of Data",
    "Mobile Access Anytime and Anywhere",
    "Data Security of the Patient Database",
  ];

  List<IconData> icons = [
    Icons.local_hospital_outlined,
    Icons.edit,
    Icons.filter_alt,
    Icons.mobile_friendly,
    Icons.security,
  ];

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() {
        startAnimation = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text('All About DocDesk'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(6.0),
          child: Expanded(
            child: SingleChildScrollView(
              //scrollDirection: Axis.horizontal,
              //physics: const BouncingScrollPhysics(),
              // padding: EdgeInsets.
              // symmetric(
              //   horizontal:screenWidth
              // ),
              child: Column(
                children: [
                  const SizedBox(
                    height: 25,
                  ),
                  GestureDetector(
                    onTap: () {
                      // Future.delayed(const Duration(milliseconds: 500), () {
                      //   setState(() {
                      //     startAnimation = true;
                      //   });
                      // });
                    },
                    child: Center(
                      child: const Text(
                        "Welcome to the App",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: Colors.deepPurple),
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Flexible(
                        child: Container(
                          margin: const EdgeInsets.all(10),
                          child: Image.asset(
                            "assests/images/ddlogo.jpg.png",
                            width: 150,
                            height: 200,
                          ),
                        ),
                      ),
                      Text("X"),
                      Flexible(
                        child: Container(
                          margin: const EdgeInsets.all(10),
                          child: Image.asset(
                            "assests/images/logo.jpg",
                            width: 180,
                            height: 200,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Key Features",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Colors.deepPurple),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ListView.builder(
                    primary: false,
                    shrinkWrap: true,
                    itemCount: texts.length,
                    itemBuilder: (context, index) {
                      return item(index);
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "About the App",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Colors.deepPurple),
                  ),
                  SizedBox(height: 15.0),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: Text(
                        textAlign: TextAlign.justify,
                        " • DocDesk is a comprehensive and user-friendly mobile application designed to simplify the task of doctors and healthcare professionals in managing patient details efficiently.\n\n• With its intuitive interface and powerful features, doctors can keep all patient information at their fingertips, making it easy to enter, search, and access patient data anytime, anywhere.\n\n • DocDesk is designed to enhance the efficiency and effectiveness of doctors in managing patient information.\n\n • The app eliminates the hassle of manual paperwork and doctors can focus on providing optimal care to their patients while keeping their medical histories and other essential information easily accessible.",
                        style: TextStyle(
                          fontSize: 14.0,
                          color: Color.fromARGB(255, 76, 12, 82),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 15.0),
                  Text(
                    "Connect with the Developer",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Colors.deepPurple),
                  ),
                  SizedBox(height: 8.0),
                  Text('Ananya Chandrakar',
                      style: TextStyle(
                        fontSize: 15,
                        decoration: TextDecoration.underline,
                        color: Colors.purple[900],
                      )),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          IconButton(
                            icon: Icon(
                              Icons.mail_rounded,
                              color: Colors.deepPurple,
                            ),
                            onPressed: () async {
                              const url = 'https://blog.logrocket.com';
                              // ignore: deprecated_member_use
                              if (await canLaunch(url)) {
                                await launch(url);
                              } else {
                                throw 'Could not launch $url';
                              }
                            },
                          ),
                          Text("ananyachandrakar0403@gmail.com",
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.purple[900],
                              ))
                        ],
                      ),
                      //SizedBox(width: 10.0),
                      Row(
                        children: [
                          IconButton(
                            icon: Icon(
                              Icons.connect_without_contact,
                              color: Colors.deepPurple,
                            ),
                            onPressed: () async {
                              final url = Uri.parse(
                                'https://www.w3schools.com',
                              );
                              if (await canLaunchUrl(url)) {
                                launchUrl(url);
                              } else {
                                // ignore: avoid_print
                                print("Can't launch $url");
                              }
                            },
                          ),
                          Text("linkedin.com/in/ananyachandrakar",
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.purple[900],
                              ))
                        ],
                      ),
                      Row(
                        children: [
                          IconButton(
                              icon: Icon(
                                Icons.phone,
                                color: Colors.deepPurple,
                              ),
                              onPressed: () async {
                                const url = 'tel://8964001725';
                                if (await canLaunch(url)) {
                                  await launch(url);
                                } else {
                                  throw 'Could not launch $url';
                                }
                              }),
                          Text("+91 8964001725",
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.purple[900],
                              ))
                        ],
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget item(int index) {
    return AnimatedContainer(
      height: 40,
      width: screenWidth,
      curve: Curves.easeInOut,
      duration: Duration(milliseconds: 300 + (index * 200)),
      transform:
          Matrix4.translationValues(startAnimation ? 0 : screenWidth, 0, 0),
      margin: const EdgeInsets.only(
        bottom: 12,
      ),
      padding: EdgeInsets.symmetric(
        horizontal: screenWidth / 20,
      ),
      decoration: BoxDecoration(
        color: Colors.deepPurple,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(
            color: Colors.white,
            icons[index],
          ),
          Text(
            "${texts[index]}",
            style: const TextStyle(
                fontSize: 16, fontWeight: FontWeight.w500, color: Colors.white),
          ),
        ],
      ),
    );
  }
}
