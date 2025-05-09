import 'package:flutter/material.dart';

import '../../UserView/Widgets/shedule_card.dart';



class ScheduleTab1 extends StatelessWidget {
  const ScheduleTab1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          const SizedBox(
            height: 30,
          ),
          ScheduleCard(
            mainText: "Mohamed Elsafty",
            subText: "",
            date: "5/06/2025",
            time: "10:30 AM",
            image: "assets/images/persona.jpg",
          ),
          const SizedBox(
            height: 20,
          ),
          ScheduleCard(
            mainText: "Ahmed Mohamed",
            subText: "",
            date: "5/06/2025",
            time: "2:00 PM",
            image: "assets/images/personp.jpg",
          ),
        ],
      ),
    );
  }
}
