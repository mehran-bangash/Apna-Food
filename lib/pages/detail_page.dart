import 'package:apna_food/services/database_method.dart';
import 'package:apna_food/services/shared_prefences.dart';
import 'package:flutter/material.dart';
import '../services/widget_support.dart';

// ignore: must_be_immutable
class DetailPage extends StatefulWidget {
  String image, name, detail, price;

  DetailPage(
      {super.key,
      required this.image,
      required this.name,
      required this.detail,
      required this.price});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  int a = 1, total = 0;
  //DateTime? _currentTime;
  //DateTime? _deliveryTime;
  String? id;

  getSharedPref() async {
    // Fetch the user ID from SharedPreferences
    id = await SharedPrefenceHelper().getUserID();
    setState(() {});
  }

  onTheLoad() async {
    await getSharedPref();
  }

  @override
  void initState() {
    super.initState();
    total = int.parse(widget.price);
    getSharedPref();
    // _currentTime = DateTime.now();
    onTheLoad();
    // Set a delivery time by adding a duration (e.g., 1 hour) to the current time
    //  _deliveryTime = _currentTime?.add(Duration(hours: 1)); // Adjust delivery time (e.g., +1 hour)
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Container(
        margin: const EdgeInsets.only(top: 50, right: 20, left: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: const Icon(
                Icons.arrow_back_ios_new_outlined,
                color: Colors.black,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.network(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height / 2.5,
                    widget.image,
                    fit: BoxFit.fill,
                  ),
                )),
            const SizedBox(
              height: 15,
            ),
            Row(
              children: [
                Text(
                  widget.name,
                  style: AppWidget.smallHeadTextFieldStyle(),
                ),
                const Spacer(),
                GestureDetector(
                  onTap: () {
                    if (a > 1) {
                      --a;
                      total = total - int.parse(widget.price);
                    }
                    setState(() {});
                  },
                  child: Container(
                    decoration: const BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.all(Radius.circular(5))),
                    child: const Icon(
                      Icons.remove,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 5,
                ),
                Text(
                  a.toString(),
                  style: AppWidget.boldTextFieldStyle(),
                ),
                const SizedBox(
                  width: 5,
                ),
                GestureDetector(
                    onTap: () {
                      ++a;
                      total = total + int.parse(widget.price);
                      setState(() {});
                    },
                    child: Container(
                      decoration: const BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.all(Radius.circular(5))),
                      child: const Icon(
                        Icons.add,
                        color: Colors.white,
                      ),
                    ))
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              widget.detail,
              maxLines: 4,
              style: AppWidget.lightTextFieldStyle(),
            ),
            const SizedBox(
              height: 15,
            ),
            Row(
              children: [
                Text(
                  "Delivery Time",
                  style: AppWidget.smallHeadTextFieldStyle(),
                ),
                const SizedBox(
                  width: 15,
                ),
                const Icon(
                  Icons.alarm,
                  color: Colors.black45,
                ),
                const SizedBox(
                  width: 3,
                ),
                Text(
                  "30",
                  // _deliveryTime == null
                  //     ? "Loading..."
                  //     : "${_deliveryTime?.hour}:${_deliveryTime?.minute.toString().padLeft(2, '0')}",
                  style: AppWidget.smallHeadTextFieldStyle(),
                ),
              ],
            ),
            const SizedBox(
              height: 40,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Total Price",
                  style: AppWidget.smallHeadTextFieldStyle(),
                ),
                Container(
                  padding: const EdgeInsets.only(
                      left: 10, top: 2, bottom: 2, right: 5),
                  height: 30,
                  width: 170,
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      color: Colors.black),
                  child: GestureDetector(
                    onTap: () async {
                      Map<String, dynamic> addFoodtoCart = {
                        "Name": widget.name,
                        "Quantity": a.toString(),
                        "Price": total.toString(),
                        "Image": widget.image
                      };
                      await DatabaseMethod().addFoodCart(id!, addFoodtoCart);
                      // ignore: use_build_context_synchronously
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          backgroundColor: Colors.orangeAccent,
                          content: Text("Add SuccessFully")));
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Add to cart",
                          style: TextStyle(fontSize: 15, color: Colors.white),
                        ),
                        Container(
                          decoration: const BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              color: Colors.black54),
                          child: const Icon(
                            Icons.shopping_cart_outlined,
                            color: Colors.white,
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              "\$$total",
              style: AppWidget.smallHeadTextFieldStyle(),
            ),
          ],
        ),
      ),
    ));
  }
}
