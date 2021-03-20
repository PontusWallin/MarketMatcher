import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class SharedWidgets {

  TextFormField buildTextFormField({TextEditingController controller, bool obscureText = false,
    String label, Function validator, Function onChanged}) {

    return TextFormField(
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(labelText: label),
        validator: validator,
        onChanged: onChanged
    );
  }

  Widget buildLoadingPage() {
    return Center(child: SpinKitFadingCircle(
        color: Colors.blue,
        size: 120
    ));
  }

  ElevatedButton buildButton(String label, Function onPressed) {

    return ElevatedButton(
        child: Text(
          label,
          style: TextStyle(color: Colors.white),
        ),
        onPressed: () async {
          onPressed();
        });
  }

  AppBar buildAppBar(String label, Icon icon, Function onPressed) {
    return AppBar(
      backgroundColor: Colors.blue,
      actions: [
        ElevatedButton.icon(
          onPressed: onPressed,
          icon: icon,
          label: Text(label),
        )
      ],
    );
  }

  final double PADDING_FACTOR = 20.0;
  SizedBox sizedBox([int padding_multiplier]) {

    padding_multiplier == null ? padding_multiplier = 1 : padding_multiplier = padding_multiplier;
    return SizedBox(height: PADDING_FACTOR * padding_multiplier);
  }

}