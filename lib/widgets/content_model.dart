class UnBoardingContent {
  String image;
  String title;
  String description;

  UnBoardingContent(
      {required this.image, required this.title, required this.description});

  static List<UnBoardingContent> contents = [
    UnBoardingContent(
        image: "assets/images/Delivery1.jpg",
        title: "Select From our\n Best Menu",
        description: "Pick Food from our menu\n   more than 35 times"),
    UnBoardingContent(
        image: "assets/images/Delivery2.jpg",
        title: "Easy and online payment",
        description: "You can pay cash and\nCard payment is available"),
    UnBoardingContent(
        image: "assets/images/Delivery3.jpg",
        title: "Quick Delivery at your Doorstep",
        description: "Deliver your food at your \n      Doorstep"),
  ];
}
