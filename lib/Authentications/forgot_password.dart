import 'package:apna_food/Authentications/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'Sign_up.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  bool showPrefixIcon = true;
  FocusNode focusNode = FocusNode();
  String email = "";

  TextEditingController emailController = TextEditingController();
  final formkey = GlobalKey<FormState>();

  forgotPassword() async {
    try {
      if (emailController.text.isNotEmpty) {
        await FirebaseAuth.instance
            .sendPasswordResetEmail(email: emailController.text.toString());
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            backgroundColor: Colors.orangeAccent,
            content: Text("Send Email SuccessFully")));
        Navigator.pushReplacement(
            // ignore: use_build_context_synchronously
            context,
            MaterialPageRoute(
              builder: (context) => const Login(),
            ));
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == "email-not-found") {
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            backgroundColor: Colors.orangeAccent,
            content: Text("Email not found")));
      }
    }
  }

  @override
  void initState() {
    super.initState();
    focusNode.addListener(
      () {
        setState(() {
          showPrefixIcon = !focusNode.hasFocus;
        });
      },
    );
  }

  @override
  void dispose() {
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Form(
        key: formkey,
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 40, top: 40, right: 40),
              child: Center(
                child: Text(
                  "Password Recovery",
                  style: TextStyle(
                      fontSize: 25,
                      color: Colors.white,
                      fontFamily: "Poppins",
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const Center(
              child: Text(
                "Enter your mail",
                style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                    fontFamily: "Poppins",
                    fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            Container(
              margin: const EdgeInsets.only(left: 20, right: 20),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
              child: TextFormField(
                controller: emailController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter the email";
                  } else {
                    null;
                  }
                  return null;
                },
                focusNode: focusNode,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: "Enter xyz@gmail.com",
                  hintStyle: const TextStyle(fontSize: 16, color: Colors.white),
                  prefixIcon: showPrefixIcon
                      ? const Icon(
                          Icons.person,
                          color: Colors.white,
                        )
                      : null,
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    borderSide: BorderSide(color: Colors.white),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            SizedBox(
              height: 40,
              width: 300,
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all<Color>(
                    Colors.white,
                  ),
                  overlayColor:
                      WidgetStateProperty.all<Color>(Colors.orangeAccent),
                ),
                child: Text(
                  textAlign: TextAlign.end,
                  "Send Email",
                  style: GoogleFonts.nunito(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
                onPressed: () async {
                  if (formkey.currentState!.validate()) {
                    setState(() {
                      email = emailController.text;
                    });
                    await forgotPassword();
                  }
                },
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Do not have an Account? ",
                  style: GoogleFonts.nunito(
                      color: Colors.white60,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SignUp(),
                        ));
                  },
                  child: Text(
                    "Create",
                    style: GoogleFonts.nunito(
                        color: const Color.fromARGB(255, 184, 166, 6),
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
