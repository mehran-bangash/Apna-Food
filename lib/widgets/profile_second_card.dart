import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
class ProfileSecondCard extends StatefulWidget {
  final IconData icon;
  final String  text;

  const ProfileSecondCard({super.key, required this.icon, required this.text});

  @override
  State<ProfileSecondCard> createState() => _ProfileSecondCardState();
}

class _ProfileSecondCardState extends State<ProfileSecondCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15,right: 15,bottom: 10,top: 10),
      child: Material(
        elevation: 10,
        borderRadius: BorderRadius.circular(10),
        child: SizedBox(
          height: 85,
          width: MediaQuery.of(context).size.width,
          child:  Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
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
              const SizedBox(height: 10,),
              Text(
                widget.text,
                style:
                GoogleFonts.roboto(fontWeight: FontWeight.w600,fontSize: 18, color: Colors.black),
              )
            ],
          ),
        ),
      ),
    );
  }
}
