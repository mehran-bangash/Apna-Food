import 'package:flutter/material.dart';
import '../Authentications/Signup.dart';
import '../services/widget_support.dart';
import '../widgets/content_model.dart';

class Onboard extends StatefulWidget {
  const Onboard({super.key});

  @override
  State<Onboard> createState() => _OnboardState();
}

class _OnboardState extends State<Onboard> {
  int currentIndex = 0;
  late PageController _controller;

  @override
  void initState() {
    // TODO: implement initState
    _controller = PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: _controller,
                onPageChanged: (int index) {
                  setState(() {
                    currentIndex = index;
                  });
                },
                itemCount: UnBoardingContent.contents.length,
                itemBuilder: (_, i) {
                  return Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20, top: 40),
                    child: Column(
                      children: [
                        Image.asset(
                          UnBoardingContent.contents[i].image,
                          height: 350,
                          width: MediaQuery.of(context).size.width,
                          fit: BoxFit.fill,
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Text(
                          UnBoardingContent.contents[i].title,
                          style: AppWidget.smallHeadTextFieldStyle()
                              .copyWith(color: Colors.black),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          UnBoardingContent.contents[i].description,
                          style: AppWidget.lightTextFieldStyle()
                              .copyWith(color: Colors.black38),
                        )
                      ],
                    ),
                  );
                },
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                UnBoardingContent.contents.length,
                    (index) => buildDot(
                    index, context), // Replace this with actual widget logic
              ),
            ),
            GestureDetector(
              onTap: () {
                if (currentIndex == UnBoardingContent.contents.length - 1) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SignUp(),
                      ));
                }
                _controller.nextPage(
                    duration: const Duration(microseconds: 100),
                    curve: Curves.bounceIn);
              },
              child: Container(
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(40)),
                    color: Colors.red),
                height: 40,
                width: double.infinity,
                margin: const EdgeInsets.all(40),
                child: Center(
                  child: Text(
                    currentIndex == UnBoardingContent.contents.length - 1
                        ? "Start"
                        : "Next",
                    style: const TextStyle(
                        fontSize: 17, color: Colors.white, fontFamily: "Poppins"),
                  ),
                ),
              ),
            )
          ],
        ));
  }

  Container buildDot(int index, BuildContext context) {
    return Container(
      height: 10.0,
      width: currentIndex == index ? 18 : 7,
      margin: const EdgeInsets.only(right: 5),
      decoration: BoxDecoration(
          color: Colors.black38, borderRadius: BorderRadius.circular(6)),
    );
  }
}
