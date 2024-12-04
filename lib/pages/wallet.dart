import 'package:flutter/material.dart';
import '../services/shared_prefences.dart';
import '../services/widget_support.dart';

class Wallet extends StatefulWidget {
  const Wallet({super.key});

  @override
  State<Wallet> createState() => _WalletState();
}

class _WalletState extends State<Wallet> {
  String? wallet, id;
  int? add;

  getSharedPrefences() async {
    wallet = await SharedPrefenceHelper().getUserWallet();
    id = await SharedPrefenceHelper().getUserID();
    setState(() {});
  }

  ontheLoad() async {
    await getSharedPrefences();
    setState(() {});
  }

  @override
  void initState() {
    ontheLoad();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Material(
              elevation: 5,
              borderRadius: BorderRadius.circular(10),
              child: Center(
                child: Container(
                  height: 50,
                  margin: const EdgeInsets.only(top: 10),
                  child: Text(
                    "Wallet",
                    style: AppWidget.headTextFieldStyle(),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                color: Color(0xffb6b6bb),
              ),
              child: Row(
                children: [
                  Container(
                    margin: const EdgeInsets.only(left: 15, top: 5),
                    child: Image.asset(
                      'assets/images/Wallet.png',
                      height: 50,
                      width: 50,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(
                    width: 3,
                  ),
                  Column(
                    children: [
                      const Text(
                        "Your wallet",
                        style: TextStyle(
                            fontFamily: "Poppins",
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                            color: Colors.grey),
                      ),
                      Text(
                        "\$" "100",
                        style: AppWidget.headTextFieldStyle(),
                      ),
                    ],
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 5),
              child: Text(
                "Add Money",
                style: AppWidget.smallHeadTextFieldStyle(),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  margin: const EdgeInsets.all(2),
                  decoration: const BoxDecoration(
                      border: Border(
                          right: BorderSide(color: Colors.white70),
                          left: BorderSide(color: Colors.white70),
                          bottom: BorderSide(color: Colors.white70),
                          top: BorderSide(color: Colors.white70)),
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      color: Color(0xFFf2f2f2)),
                  child: const Text(
                    "\$" "100",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(2),
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      color: Color(0xFFf2f2f2)),
                  child: const Text(
                    "\$" "500",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(2),
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      color: Color(0xFFf2f2f2)),
                  child: const Text(
                    "\$" "1000",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(2),
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      color: Color(0xFFf2f2f2)),
                  child: const Text(
                    "\$" "2000",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding:
                  const EdgeInsets.only(left: 20, right: 20, top: 5, bottom: 5),
              child: Container(
                height: 50,
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                    color: Color(0xff008080),
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                child: const Center(
                  child: Text(
                    "Add Money",
                    style: TextStyle(
                      fontFamily: "Poppins",
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
