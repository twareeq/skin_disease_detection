import 'package:flutter/material.dart';
import '../../constants/my_colors.dart';
import 'doctors_home_page.dart';

class FindDoctors extends StatelessWidget {
  const FindDoctors({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              pColor.withOpacity(0.8),
              pColor,
            ],
          ),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: Image.asset("assets/doctor.png"),
            ),
            const SizedBox(height: 10),
            const Text(
              "Doctors Online",
              style: TextStyle(
                color: wColor,
                fontSize: 35,
                fontWeight: FontWeight.bold,
                letterSpacing: 1,
                wordSpacing: 2
              ),
            ),
            const Text(
              "Appoint Your Doctor",
              style: TextStyle(
                color: wColor,
                fontSize: 18,
                fontWeight: FontWeight.w500
              ),
            ),
            const SizedBox(height: 60),
            Material(
              color: wColor,
              borderRadius: BorderRadius.circular(10),
              child: InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const DoctorsHomePage()));
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 40),
                  child: const Text('Let\'s Go', style: TextStyle(
                    color: pColor,
                    fontSize: 20,
                    fontWeight: FontWeight.bold
                  ),),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Image.asset(
              'assets/heart.png',
              color: wColor,
              scale: 2,
            )
          ],
        ),
      ),
    );
  }
}