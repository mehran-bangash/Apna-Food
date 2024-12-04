import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileCard extends StatefulWidget {

  final IconData icon;
  final String  firstText;
  final String secondText;

  const ProfileCard({super.key, required this.icon, required this.firstText, required this.secondText});

  @override
  State<ProfileCard> createState() => _ProfileCardState();
}

class _ProfileCardState extends State<ProfileCard> {
  @override
  Widget build(BuildContext context) {
    return
       Padding(
        padding: const EdgeInsets.only(left: 15,right: 15,bottom: 10,top: 10),
        child: Material(
          elevation: 10,
          borderRadius: BorderRadius.circular(10),
          child: SizedBox(
            height: 85,
            width: MediaQuery.of(context).size.width,
            child:  Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                  child: Icon(
                    widget.icon,
                    color: Colors.black,
                    size: 35,
                  ),
                ),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10,),
                    Text(
                      widget.firstText,
                      style:
                      GoogleFonts.roboto(fontWeight: FontWeight.w600,fontSize: 17, color: Colors.black),
                    ),
                    const SizedBox(height: 5,),
                    Text(
                      widget.secondText,
                      style:
                      GoogleFonts.roboto(fontWeight: FontWeight.w600,fontSize: 17, color: Colors.black),
                    ),
                  ],)
              ],
            ),
          ),
        ),
      );
    }
  }



