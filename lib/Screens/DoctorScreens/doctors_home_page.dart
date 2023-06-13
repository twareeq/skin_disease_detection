import 'package:flutter/material.dart';

import '../../constants/my_colors.dart';
import 'doctor_section.dart';

class DoctorsHomePage extends StatefulWidget {
  const DoctorsHomePage({Key? key}) : super(key: key);

  @override
  State<DoctorsHomePage> createState() => _DoctorsHomePageState();
}

class _DoctorsHomePageState extends State<DoctorsHomePage> {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: const Color(0xFFD9E4EE),
      child: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height/3.5,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    pColor.withOpacity(0.8),
                    pColor
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
                borderRadius: const BorderRadius.only(
                  bottomRight: Radius.circular(20),
                  bottomLeft: Radius.circular(20)
                )
              ),
            ),
            SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CircleAvatar(
                              radius: 30,
                              backgroundImage: AssetImage('images/image3.jpg'),
                            ),
                            Icon(
                              Icons.notifications_outlined,
                              size: 30,
                              color: wColor,
                            )
                          ],
                        ),
                        const SizedBox(height: 15),
                        const Text(
                          'Hi, Welcome',
                          style: TextStyle(
                            color: wColor,
                            fontSize: 18,
                            fontWeight: FontWeight.w500
                          ),
                        ),
                        const SizedBox(height: 15),
                        const Text(
                          'Protecting your skin is \nour first priority',
                          style: TextStyle(
                            color: wColor,
                            fontSize: 20,
                            fontWeight: FontWeight.w500
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 15, bottom: 20),
                          width: MediaQuery.of(context).size.width,
                          height: 55,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: wColor,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.black12,
                                blurRadius: 6,
                                spreadRadius: 3,
                              )
                            ]
                          ),
                          child: TextField(
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              prefixIcon: const Icon(
                                Icons.search,
                                size: 25,
                              ),
                              hintText: "Search here...",
                              hintStyle: TextStyle(
                                color: Colors.black.withOpacity(0.5)
                              )
                            ),
                          ),
                        ),
                        const SizedBox(height: 15.0),
                        Text(
                          'Recommended Doctors',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            color: bColor.withOpacity(0.7)
                          ),
                        ),
                        const DoctorSection()
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
