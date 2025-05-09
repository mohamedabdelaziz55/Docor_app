import 'package:flutter/material.dart';
import 'package:get/get.dart';



class ProfileDoctorScreen extends StatelessWidget {
  const ProfileDoctorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final double w = MediaQuery.of(context).size.width;
    final double h = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        leading: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
          child: Image(image: AssetImage('assets/icons/back1.png')),
        ),
        title: Text('Dr. Marcus Horizon'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image(
              image: AssetImage('assets/images/doctor3.png'),
              width: double.infinity,
              height: h * 0.4,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomListProfileDoctor(
                  icon: Icons.call,
                  text: 'Voice Call',
                  color: Colors.blue,
                ),
                CustomListProfileDoctor(
                  icon: Icons.video_call,
                  text: 'Video Call',
                  color: Colors.deepPurpleAccent,
                ),
                CustomListProfileDoctor(
                  icon: Icons.message,
                  text: 'Message',
                  color: Colors.orangeAccent,
                ),
              ],
            ),
            SizedBox(height: h * 0.017),
            Text('Medicine & Heart Specialist', style: TextStyle(fontSize: 16)),
            Text(
              'Good Health Clinic , MBBS, FCPS',
              style: TextStyle(
                fontSize: 15,
                color: Colors.black.withOpacity(0.6),
              ),
            ),
            Row(
              children: [
                Icon(Icons.star, color: Colors.orangeAccent, size: 16),
                Icon(Icons.star, color: Colors.orangeAccent, size: 16),
                Icon(Icons.star, color: Colors.orangeAccent, size: 16),
                Icon(Icons.star, color: Colors.orangeAccent, size: 16),
                Icon(Icons.star, color: Colors.orangeAccent, size: 16),
              ],
            ),
            SizedBox(height: 10),
            Text(
              'About Dr. Marcus Horizon',
              style: TextStyle(fontSize: w * 0.04),
            ),
            SizedBox(height: h * 0.011),
            Text(
              r'Throughout his career, he has demonstrated a commitment to improving patient health and well-being. Dr. Smith values open communication and takes the time to listen to his patients concerns, ensuring they feel comfortable and informed about their treatment options.',
              style: TextStyle(
                fontSize: w * 0.03,
                color: Colors.black.withOpacity(0.6),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomListProfileDoctor extends StatelessWidget {
  const CustomListProfileDoctor({
    super.key,
    required this.icon,
    required this.text,
    required this.color,
  });

  final IconData icon;
  final String text;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final double w = MediaQuery.of(context).size.width;
    final double h = MediaQuery.of(context).size.height;
    return Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(w * 0.01),
      ),
      height: h * 0.06,
      width: w * 0.29,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Icon(icon, color: Colors.white, size: 18),
            Text('  $text', style: TextStyle(color: Colors.white)),
          ],
        ),
      ),
    );
  }
}
