
import 'package:apna_food/pages/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:random_string/random_string.dart';
import '../services/databaseMethod.dart';
import '../widgets/customTextField.dart';
import '../services/shared_prefences.dart';
import 'login.dart';





class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignupState();
}

class _SignupState extends State<SignUp> {
  String name = "",
      email = "",
      password = "";
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  final _formkey = GlobalKey<FormState>();
  bool _isLoading = false;

  registration() async {
    try {
      if (password
          .toString()
          .isNotEmpty &&
          confirmPasswordController
              .toString()
              .isNotEmpty) {
        await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password);

        String id = randomAlphaNumeric(10);

        Map<String, dynamic> userinfo = {
          'Name': nameController.text,
          'Email': emailController.text,
          'Wallet': '0',
          'Id': id
        };
        await DatabaseMethod().adduserDetail(id, userinfo);
        await SharedPrefenceHelper().saveUserId(id);
        await SharedPrefenceHelper().saveUserName(nameController.text);
        await SharedPrefenceHelper().saveUserEmail(emailController.text);
        await SharedPrefenceHelper().saveUserWallet('0');
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            backgroundColor: Colors.orangeAccent,
            content: Text(
              "Registration Successfully",
              style: TextStyle(fontSize: 17, color: Colors.white),
            )));
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const Home(),
            ));
      }
    } on FirebaseAuthException catch (e) {
      String errorMessage = "Registration failed";
      if (e.code == 'weak-password') {
        errorMessage = "Weak password";
      } else if (e.code == 'email-already-in-use') {
        errorMessage = "Email already in use";
      }

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.orangeAccent,
        content: Text(errorMessage,
            style: const TextStyle(fontSize: 17, color: Colors.white)),
      ));
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  height: MediaQuery
                      .of(context)
                      .size
                      .height / 3.0,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      gradient: const LinearGradient(
                          begin: Alignment.bottomLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Color(0xFFff5c30),
                            Color(0xffe74b1a),
                          ]),
                      borderRadius: BorderRadius.vertical(
                          bottom: Radius.elliptical(
                              MediaQuery
                                  .of(context)
                                  .size
                                  .width, 100))),
                  child: Padding(
                    padding: const EdgeInsets.all(30),
                    child: Column(
                      children: [
                        Text(
                          "Sign up",
                          style: GoogleFonts.nunito(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "Create a new account",
                          style: GoogleFonts.nunito(
                              color: Colors.grey.shade300,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 30,
                    top: 140,
                    right: 30,
                  ),
                  child: Card(
                    elevation: 5.0,
                    child: Container(
                      height: MediaQuery
                          .of(context)
                          .size
                          .height * 0.6,
                      width: MediaQuery
                          .of(context)
                          .size
                          .width / 1,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20)),
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 30, left: 20, right: 20),
                        child: Form(
                          key: _formkey,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Name",
                                style: GoogleFonts.nunito(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              TextFieldWidget(
                                controller: nameController,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your name';
                                  }
                                  return null;
                                },
                                hintText: "Enter name",
                                keyboardType: TextInputType.name,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                "Email",
                                style: GoogleFonts.nunito(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              TextFieldWidget(
                                controller: emailController,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your Email';
                                  }
                                  return null;
                                },
                                hintText: "Enter email",
                                keyboardType: TextInputType.emailAddress,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                "Password",
                                style: GoogleFonts.nunito(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              TextFieldWidget(
                                controller: passwordController,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your password';
                                  }
                                  if (value.length < 6) {
                                    return 'Password must be at least 6 characters long';
                                  }
                                  return null;
                                },
                                hintText: "Enter password",
                                keyboardType: TextInputType.visiblePassword,
                                obscureTextWidget: true,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                "Confirm password",
                                style: GoogleFonts.nunito(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              TextFieldWidget(
                                controller: confirmPasswordController,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please confirm your password';
                                  }
                                  if (value != passwordController.text) {
                                    return 'Passwords do not match';
                                  }
                                  return null;
                                },
                                hintText: "Confirm password",
                                keyboardType: TextInputType.visiblePassword,
                                obscureTextWidget: true,
                              ),
                              const SizedBox(
                                height: 40,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    "Already have an account? ",
                                    style: GoogleFonts.nunito(
                                        color: Colors.black,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  InkWell(
                                    borderRadius: BorderRadius.circular(5),
                                    onTap: () {
                                      Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                            const Login(),
                                          ));
                                    },
                                    child: Text(
                                      "Login Now!",
                                      style: GoogleFonts.nunito(
                                          color: Colors.purple,
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            Center(
              child: SizedBox(
                  height: 40,
                  width: 250,
                  child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: WidgetStateProperty.all<Color>(
                          const Color(0xFFff5c30),
                        ),
                        overlayColor: WidgetStateProperty.all<Color>(
                            Colors.orangeAccent),
                      ),
                      onPressed: _isLoading
                          ? null
                          : () async {
                        if (_formkey.currentState!.validate()) {
                          setState(() {
                            _isLoading = true;
                            name = nameController.text;
                            email = emailController.text;
                            password = passwordController.text;
                          });
                          await registration();
                        }
                      },
                      child: _isLoading
                          ? const CircularProgressIndicator(
                        color: Colors.white,
                      )
                          : Text(
                        "Sign Up",
                        style: GoogleFonts.nunito(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ))),
            ),
            const SizedBox(
              height: 50,
            ),
          ],
        ),
      ),
    );
  }
}
