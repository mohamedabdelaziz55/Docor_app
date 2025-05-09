import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Widgets/shedule_card.dart';



class SchedulgeTabDoc1 extends StatelessWidget {
  const SchedulgeTabDoc1({super.key});

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(children: [
        const SizedBox(
          height: 30,
        ),
        ScheduleCard(
          confirmation: "Confirmed",
          mainText: "Dr. Marcus Horizon",
          subText: "Cardiologist",
          date: "26/06/2022",
          time: "10:30 AM",
          image: "assets/icons/male-doctor.png",
        ),
        const SizedBox(
          height: 20,
        ),
        ScheduleCard(
          confirmation: "Confirmed",
          mainText: "Dr. Marcus Horizon",
          subText: "Cardiologist",
          date: "26/06/2022",
          time: "2:00 PM",
          image: "assets/icons/female-doctor2.png",
        )
      ]),
    );
  }
}
