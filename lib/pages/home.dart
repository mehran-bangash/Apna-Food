import 'package:apna_food/services/databaseMethod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../services/widget_support.dart';
import 'detail_page.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool iceCream = false, pizza = false, salad = false, burger = false;
  Stream? foodStream;

  @override
  void initState() {
    super.initState();
    // Set iceCream to true by default
    iceCream = true;
  }


  Widget allFoodDetailHorizontal() {
    return StreamBuilder(
      stream: foodStream,
      builder: (context, AsyncSnapshot snapshot) {
        return snapshot.hasData?
           ListView.builder(
            padding: EdgeInsets.zero,
            itemCount: snapshot.data.docs.length,
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              DocumentSnapshot ds = snapshot.data.docs[index];
              return Container(
                  margin: const EdgeInsets.all(10),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => DetailPage(image:  ds["Image"],name:  ds["Name"],detail: ds["Detail"],price: ds["Price"],),));
                    },
                    child: Material(
                        borderRadius: BorderRadius.circular(20),
                        elevation: 5,
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              DetailPage(image:  ds["Image"],name:  ds["Name"],detail: ds["Detail"],price: ds["Price"],),
                                        ));
                                  },
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(15), // Adjust the border radius as needed
                                    child: Image.network(
                                      ds["Image"],
                                      height: 150,
                                      width: 150,
                                      fit: BoxFit.cover,
                                    ),
                                  ),

                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                ds["Name"],
                                style: AppWidget.smallHeadTextFieldStyle(),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                ds["Detail"],
                                style: AppWidget.lightTextFieldStyle(),
                                maxLines:  3,
                                overflow: TextOverflow.ellipsis,
                                softWrap: true,
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                "\$"+ds["Price"],
                                style: AppWidget.smallHeadTextFieldStyle(),
                              )
                            ],
                          ),
                        )),
                  ));
            },
          )
       : const CircularProgressIndicator();

      },
    );
  }
  Widget allFoodDetailVertical() {
    return StreamBuilder(
      stream: foodStream,
      builder: (context, AsyncSnapshot snapshot) {
        if (!snapshot.hasData) {
          return const CircularProgressIndicator();
        }
        return ListView.builder(
          padding: EdgeInsets.zero,
          itemCount: snapshot.data.docs.length,
          shrinkWrap: true,
          scrollDirection: Axis.vertical, // You want vertical scrolling here
          itemBuilder: (context, index) {
            DocumentSnapshot ds = snapshot.data.docs[index];
            return GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) =>DetailPage(image:  ds["Image"],name:  ds["Name"],detail: ds["Detail"],price: ds["Price"],),));
              },
              child: Container(
                margin: const EdgeInsets.only(right: 10,bottom: 20),
                child: Material(
                  elevation: 5.0,
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    margin: const EdgeInsets.all(10), // Add margin around each item
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: Image.network(
                            ds["Image"],  // Use the correct network image URL from Firestore
                            height: 150,
                            width: 150,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 10),
                              Text(
                                ds["Name"], // Display name from Firestore
                                style: AppWidget.smallHeadTextFieldStyle(),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                ds["Detail"], // Display description from Firestore
                                style: AppWidget.lightTextFieldStyle(),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                "\$${ds["Price"]}", // Display price from Firestore
                                style: AppWidget.smallHeadTextFieldStyle(),
                              ),
                              const SizedBox(height: 10,)
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //bottomNavigationBar: const BottomNavState(),
        body: SingleChildScrollView(
              child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
              const SizedBox(height: 10,),
              Padding(
                padding: const EdgeInsets.only(top: 25),
                child: Text(
                  " Hello Mehran Ali",
                  style: AppWidget.boldTextFieldStyle(),
                ),
              ),
              Padding(
                  padding: const EdgeInsets.all(15),
                  child: Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.black,
                    ),
                    child: const Icon(
                      Icons.shopping_cart_outlined,
                      color: Colors.white,
                    ),
                  )),
                          ],
                        ),
                        Padding(
              padding: const EdgeInsets.only(left: 8, top: 5),
              child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                      textAlign: TextAlign.start,
                      "Delicious Food",
                      style: AppWidget.headTextFieldStyle()))),
                        Padding(
                          padding: const EdgeInsets.only(left: 8, top: 5),
                          child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                  textAlign: TextAlign.start,
                  "Discover and Get Great Food",
                  style: AppWidget.lightTextFieldStyle()),
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        showItem(),
                        const SizedBox(
                          height: 20,
                        ),
                        SizedBox(
              height: 300,
              child: allFoodDetailHorizontal()),
                        const SizedBox(
                          height: 15,
                        ),
                        allFoodDetailVertical(),]
                      ),
            ));
  }

  Widget showItem() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Material(
            elevation: 5,
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            child: GestureDetector(
              onTap: () async{
                iceCream = true;
                salad = false;
                burger = false;
                pizza = false;
                foodStream=DatabaseMethod().getFoodDetail("Ice-cream");
                setState(() {});
              },
              child: Container(
                  height: 70,
                  width: 70,
                  decoration: BoxDecoration(
                    color: iceCream ? Colors.black : Colors.white,
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                  ),
                  child: Image.asset(
                    "assets/images/ice-cream.png",
                    height: 30,
                    width: 30,
                    color: iceCream ? Colors.white : Colors.black,
                  )),
            )),
        Material(
            elevation: 5,
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            child: GestureDetector(
              onTap: () async{
                iceCream = false;
                salad = false;
                burger = false;
                pizza = true;
                foodStream=DatabaseMethod().getFoodDetail("Pizza");

                setState(() {});
              },
              child: Container(
                  height: 70,
                  width: 70,
                  decoration: BoxDecoration(
                    color: pizza ? Colors.black : Colors.white,
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                  ),
                  child: Image.asset(
                    "assets/images/pizza.png",
                    height: 50,
                    width: 50,
                    color: pizza ? Colors.white : Colors.black,
                    fit: BoxFit.cover,
                  )),
            )),
        Material(
            elevation: 5,
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            child: GestureDetector(
              onTap: () async{
                iceCream = false;
                salad = true;
                burger = false;
                pizza = false;
                foodStream=DatabaseMethod().getFoodDetail("Salad");
                setState(() {});
              },
              child: Container(
                  height: 70,
                  width: 70,
                  decoration: BoxDecoration(
                    color: salad ? Colors.black : Colors.white,
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                  ),
                  child: Image.asset(
                    "assets/images/salad.png",
                    height: 50,
                    width: 50,
                    color: salad ? Colors.white : Colors.black,
                    fit: BoxFit.cover,
                  )),
            )),
        Material(
            elevation: 5,
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            child: GestureDetector(
              onTap: ()async {
                iceCream = false;
                salad = false;
                burger = true;
                pizza = false;
                foodStream=DatabaseMethod().getFoodDetail("Burger");

                setState(() {});
              },
              child: Container(
                  height: 70,
                  width: 70,
                  decoration: BoxDecoration(
                    color: burger ? Colors.black : Colors.white,
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                  ),
                  child: Image.asset(
                    "assets/images/burger.png",
                    height: 50,
                    width: 50,
                    color: burger ? Colors.white : Colors.black,
                    fit: BoxFit.cover,
                  )),
            )),
      ],
    );
  }
}
