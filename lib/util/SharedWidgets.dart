import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:market_matcher/services/authentication.dart';

class SharedWidgets {

  TextFormField buildNumberFormField({TextEditingController controller, bool obscureText = false,
    String label, Function validator, Function onChanged}) {

    return TextFormField(
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(labelText: label),
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        validator: validator,
        onChanged: onChanged
    );
  }

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

  ElevatedButton buildButton({String label, Function onPressed}) {

    return ElevatedButton(
        child: Text(
          label,
          style: TextStyle(color: Colors.white),
        ),
        onPressed: () async {
          onPressed();
        });
  }

  AppBar buildAppBar({String title, String label, Icon icon,Function onPressed}) {

    List<Widget> actionList = <Widget>[];
    if(label != null && icon != null) {
      ElevatedButton buttonForAppBar = ElevatedButton.icon(onPressed: onPressed, icon: icon, label: Text(label));
      actionList.add(buttonForAppBar);
    }

    return AppBar(
      backgroundColor: Colors.blue,
      title: Text(title),
      elevation: 8.0,
      actions: actionList
    );
  }

  FloatingActionButton buildHomeFAB(BuildContext context) {
    return FloatingActionButton(
      child: Icon(Icons.home),
      onPressed: () {
        Navigator.pop(
          context,
        );
      },
    );
  }

  final double PADDING_FACTOR = 20.0;
  SizedBox sizedBox([int padding_multiplier]) {

    padding_multiplier == null ? padding_multiplier = 1 : padding_multiplier = padding_multiplier;
    return SizedBox(height: PADDING_FACTOR * padding_multiplier);
  }

}