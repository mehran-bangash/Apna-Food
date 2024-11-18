import 'package:flutter/material.dart';

class AppWidget {
  static TextStyle boldTextFieldStyle() {
    return const TextStyle(
      fontFamily: 'Poppins',
      fontSize: 18, // Now it uses the instance variable 'size'
      color: Colors.black,
    );
  }

  static TextStyle headTextFieldStyle() {
    return const TextStyle(
      fontFamily: 'Poppins',
      fontSize: 20, // Now it uses the instance variable 'size'
      color: Colors.black,
    );
  }

  static TextStyle smallHeadTextFieldStyle() {
    return const TextStyle(
      fontFamily: 'Poppins',
      fontSize: 16, // Now it uses the instance variable 'size'
      color: Colors.black,
    );
  }

  static TextStyle smallHeadWhiteTextFieldStyle() {
    return const TextStyle(
      fontFamily: 'Poppins',
      fontSize: 15, // Now it uses the instance variable 'size'
      color: Colors.black,
    );
  }

  static TextStyle lightTextFieldStyle() {
    return const TextStyle(
      fontFamily: 'Poppins',
      fontSize: 15, // Now it uses the instance variable 'size'
      color: Colors.black38,
    );
  }
}
