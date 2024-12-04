import 'dart:io';
import 'package:apna_food/Admin/admin_home.dart';
import 'package:apna_food/services/database_method.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:random_string/random_string.dart';
import '../services/widget_support.dart';
import 'package:image_picker/image_picker.dart';

class AdminFood extends StatefulWidget {
  const AdminFood({super.key});

  @override
  State<AdminFood> createState() => _AdminFoodState();
}

class _AdminFoodState extends State<AdminFood> {
  TextEditingController namecontroller = TextEditingController();
  TextEditingController pricecontroller = TextEditingController();
  TextEditingController detailcontroller = TextEditingController();
  List<String> fooditems = ['Ice-cream', 'Pizza', 'Salad', 'Burger'];
  String? value;

  final ImagePicker _picker = ImagePicker();
  File? selectedImage;

  Future getImage() async {
    var image = await _picker.pickImage(source: ImageSource.gallery);
    selectedImage = File(image!.path);
    setState(() {});
  }

  uploaditem() async {
    if (selectedImage != null &&
        namecontroller.text != '' &&
        pricecontroller.text != "" &&
        detailcontroller.text != "") {
      final addId = randomAlphaNumeric(10);
      Reference firebaseStorageref =
          FirebaseStorage.instance.ref().child('blogImages').child(addId);
      final UploadTask task = firebaseStorageref.putFile(selectedImage!);
      var downloadUrl = await (await task).ref.getDownloadURL();

      Map<String, dynamic> addItemDetail = {
        'Image': downloadUrl,
        'Name': namecontroller.text,
        'Price': pricecontroller.text,
        'Detail': detailcontroller.text,
      };
      await DatabaseMethod().addFoodItem(value!, addItemDetail).then(
        (value) {
          // ignore: use_build_context_synchronously
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              backgroundColor: Colors.orangeAccent,
              content: Text("Food has been added SuccessFully")));
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.only(bottom: 50),
          margin: const EdgeInsets.only(
            top: 15,
            left: 10,
          ),
          child: SafeArea(
            child: Column(
              children: [
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const AdminHome(),
                            ));
                      },
                      child: const Icon(
                        Icons.arrow_back,
                        color: Colors.grey,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 160),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Add Item",
                          style: AppWidget.headTextFieldStyle(),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Upload the item Picture",
                    style: AppWidget.smallHeadTextFieldStyle(),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                selectedImage == null
                    ? GestureDetector(
                        onTap: () async {
                          await getImage();
                        },
                        child: Center(
                          child: Material(
                            elevation: 5,
                            borderRadius: BorderRadius.circular(20),
                            child: Container(
                              height: 150,
                              width: 150,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.black),
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(20)),
                              ),
                              child: const Icon(
                                size: 20,
                                Icons.camera_alt_outlined,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      )
                    : Center(
                        child: Material(
                          elevation: 5,
                          borderRadius: BorderRadius.circular(20),
                          child: Container(
                            height: 150,
                            width: 150,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.black),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(20)),
                            ),
                            child: ClipRRect(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(20)),
                              child: Image.file(
                                selectedImage!,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      ),
                const SizedBox(
                  height: 20,
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "item name",
                    style: AppWidget.smallHeadTextFieldStyle(),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    decoration: const BoxDecoration(
                      color: Color(0xFFececf8),
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    child: TextField(
                      controller: namecontroller,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Enter item name',
                          hintStyle: AppWidget.lightTextFieldStyle()),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "item price",
                    style: AppWidget.smallHeadTextFieldStyle(),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    decoration: const BoxDecoration(
                      color: Color(0xFFececf8),
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    child: TextField(
                      controller: pricecontroller,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Enter item price',
                          hintStyle: AppWidget.lightTextFieldStyle()),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "item Detail",
                    style: AppWidget.smallHeadTextFieldStyle(),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    decoration: const BoxDecoration(
                      color: Color(0xFFececf8),
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    child: TextField(
                      maxLines: 6,
                      controller: detailcontroller,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Enter item Detail',
                          hintStyle: AppWidget.lightTextFieldStyle()),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Select category",
                    style: AppWidget.smallHeadTextFieldStyle(),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    width: MediaQuery.of(context).size.width,
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        color: Color(0xFFececfb)),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton(
                        items: fooditems
                            .map((item) => DropdownMenuItem(
                                value: item,
                                child: Text(
                                  item,
                                  style: const TextStyle(
                                      fontSize: 18, color: Colors.black),
                                )))
                            .toList(),
                        onChanged: ((value) => setState(() {
                              this.value = value;
                            })),
                        dropdownColor: Colors.white,
                        hint: const Text('Select Category'),
                        icon: const Icon(
                          Icons.arrow_drop_down,
                          color: Colors.black,
                        ),
                        value: value,
                      ),
                    )),
                const SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: () async {
                    await uploaditem();
                  },
                  child: Material(
                    elevation: 10,
                    borderRadius: const BorderRadius.all(Radius.circular(5)),
                    child: Container(
                      height: 40,
                      width: 160,
                      decoration: const BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.all(Radius.circular(5))),
                      child: const Center(
                        child: Text(
                          "Add",
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
