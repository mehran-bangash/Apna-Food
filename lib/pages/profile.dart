import 'dart:io';
import 'package:apna_food/services/shared_prefences.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:random_string/random_string.dart';
import '../widgets/profile_second_card.dart';
import '../widgets/profile_card.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}
 final ImagePicker _picker=ImagePicker();
File? selectImage;

class _ProfileState extends State<Profile> {
  String? profile,name,email;

  getSharedPrefence()async{
    profile=await SharedPrefenceHelper().getUserProfile();
    name=await SharedPrefenceHelper().getUserName();
    email=await SharedPrefenceHelper().getUserEmail();
    setState(() {

    });
  }
  onthisload()async{
    await getSharedPrefence();
    setState(() {

    });
  }

  getImage()async{
    var image=await _picker.pickImage(source: ImageSource.gallery);
     selectImage=File(image!.path);
     setState(() {
       uploadImage();
     });
  }

  uploadImage()async{
    if(selectImage !=null){
      final addId = randomAlphaNumeric(10);
      Reference firebaseStorageref =
      FirebaseStorage.instance.ref().child('blogImages').child(addId);
      final UploadTask task = firebaseStorageref.putFile(selectImage!);
      var downloadUrl = await (await task).ref.getDownloadURL();
        await SharedPrefenceHelper().saveUserProfile(downloadUrl);

setState(() {
});
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    onthisload();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: name ==null ? const CircularProgressIndicator():SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height / 4.2,
                  width: MediaQuery.of(context).size.width,
                  decoration: const BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.only(
                          bottomRight: Radius.elliptical(100, 30),
                          bottomLeft: Radius.elliptical(100, 30))),
                ),
                Center(
                  child: Container(
                    margin: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height / 6.5),
                    child: Material(
                      elevation: 10,
                      borderRadius: BorderRadius.circular(60),
                      child: ClipRRect(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(60)),
                          child:selectImage==null? GestureDetector(
                            onTap: () {
                              getImage();
                            },
                            child:profile==null? Image.asset(
                              'assets/images/Mehran.png',
                              height: 120,
                              width: 120,
                              fit: BoxFit.cover,
                            ):Image.network(profile!,height: 120,width: 120,fit: BoxFit.cover,),
                          ):Image.file(
                            selectImage!,
                            height: 120,
                            width: 120,
                            fit: BoxFit.cover,
                          )
                      ),
                    ),
                  ),
                ),
                Center(
                  child: Padding(
                    padding:
                        const EdgeInsets.only(top: 80, right: 80, left: 90),
                    child: Text(
                      "Mehran Ali",
                      style: GoogleFonts.roboto(
                          fontSize: 25, color: Colors.white),
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            ProfileCard(
              icon: Icons.person,
              firstText: "Name",
              secondText: name!,
            ),
             ProfileCard(
              icon: Icons.email,
              firstText: "Gmail",
              secondText: email!,
            ),
            const ProfileSecondCard(
              icon: Icons.article,
              text: "Terms and Condition",
            ),
            const ProfileSecondCard(
              icon: Icons.delete,
              text: "Delete Account",
            ),
            const ProfileSecondCard(
              icon: Icons.power_settings_new,
              text: "LogOut",
            )
          ],
        ),
      ),
    );
  }
}
