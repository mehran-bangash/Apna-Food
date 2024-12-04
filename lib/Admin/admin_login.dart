import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:apna_food/services/database_method.dart';
import '../services/widget_support.dart';
import 'admin_home.dart';

class AdminLogin extends StatefulWidget {
  const AdminLogin({super.key});

  @override
  State<AdminLogin> createState() => _AdminLoginState();
}

class _AdminLoginState extends State<AdminLogin> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFededeb),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 14),
              child: Center(
                child: Text(
                  "Let's Start With Admin!",
                  style: AppWidget.headTextFieldStyle(),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height / 2.5),
              child: Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 53, 51, 51),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(70),
                        topRight: Radius.circular(70))),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                top: 100,
                left: MediaQuery.of(context).size.width * (260 / 1080),
              ),
              child: Container(
                padding: const EdgeInsets.only(left: 25, top: 25, right: 20),
                height: 500,
                width: MediaQuery.of(context).size.width * (600 / 1080),
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(30))),
                child: Form(
                  key: formkey,
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 50,
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 20, top: 30),
                        padding: const EdgeInsets.only(
                          left: 25,
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: const Color.fromARGB(255, 160, 160, 147),
                          ),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(20)),
                        ),
                        child: Center(
                          child: TextFormField(
                            controller: usernameController,
                            keyboardType: TextInputType.name,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "cannot be empty";
                              } else {
                                return null;
                              }
                            },
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: "Username",
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 20, top: 30),
                        padding: const EdgeInsets.only(
                          left: 25,
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: const Color.fromARGB(255, 160, 160, 147),
                          ),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(20)),
                        ),
                        child: Center(
                          child: TextFormField(
                            controller: passwordController,
                            keyboardType: TextInputType.visiblePassword,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "cannot be empty";
                              } else {
                                return null;
                              }
                            },
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: "Password",
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      GestureDetector(
                        onTap: () async {
                          if (formkey.currentState!.validate()) {
                            // Query Firestore for the document that matches the username
                            QuerySnapshot querySnapshot = await DatabaseMethod()
                                .getAdminDetail(usernameController.text);
                            if (querySnapshot.docs.isEmpty) {
                              // ignore: use_build_context_synchronously
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(const SnackBar(
                                backgroundColor: Colors.orangeAccent,
                                content: Text(
                                  "Username is not correct",
                                  style: TextStyle(
                                      fontSize: 17, color: Colors.white),
                                ),
                              ));
                            } else {
                              // Get the first document from the query
                              var adminData = querySnapshot.docs.first;

                              // Check if the password matches
                              if (adminData['password'] !=
                                  passwordController.text) {
                                // ignore: use_build_context_synchronously
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(const SnackBar(
                                  backgroundColor: Colors.orangeAccent,
                                  content: Text(
                                    "Password is not correct",
                                    style: TextStyle(
                                        fontSize: 17, color: Colors.white),
                                  ),
                                ));
                              } else {
                                // Navigate to AdminHome if credentials are correct
                                Route route = MaterialPageRoute(
                                  builder: (context) => const AdminHome(),
                                );
                                // ignore: use_build_context_synchronously
                                Navigator.pushReplacement(context, route);
                              }
                            }
                          }
                        },
                        child: Container(
                          height: 60,
                          margin: const EdgeInsets.only(
                              left: 20, top: 30, bottom: 10, right: 10),
                          padding: const EdgeInsets.only(
                            left: 25,
                          ),
                          decoration: const BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                          ),
                          child: const Center(
                            child: Text(
                              "Login ",
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
