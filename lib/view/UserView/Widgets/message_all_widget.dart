import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';



class MessageAllWidget extends StatelessWidget {
  final String mainText;
  final String subText;
  final String image;
  final String time;
  final String messageCount;

  MessageAllWidget({
    required this.mainText,
    required this.subText,
    required this.image,
    required this.messageCount,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {

    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          // User image
          Container(
            height: MediaQuery.of(context).size.height * 0.06,
            width: MediaQuery.of(context).size.width * 0.150,
            decoration: BoxDecoration(
              color: Colors.green,
              shape: BoxShape.circle,
              image: DecorationImage(
                image: AssetImage(image),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(width: 10),
          // Message text
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  mainText,
                  style: GoogleFonts.poppins(
                    fontSize: 15,
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  subText,
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    color: Colors.black,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ],
            ),
          ),
          // Time and message count
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(time),
              SizedBox(height: 5),
              Container(
                height: 20,
                width: 20,
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 2, 134, 117),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    messageCount,
                    style: TextStyle(fontSize: 10, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
