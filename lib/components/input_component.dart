import 'package:flutter/material.dart';
import 'package:atma_cinema/utils/constants.dart';

//Label Text
Padding displayText({required String text}) {
  return Padding(
    padding: const EdgeInsets.only(left: 0),
    child: SizedBox(
      child: Text(
        text,
        style: styleMedium,
      ),
    ),
  );
}

//Input text
Padding inputForm(Function(String?) validasi,
    {required TextEditingController controller,
    required String hintTxt,
    required String labelTxt,
    IconData? iconData,
    TextInputType? txtInputType,
    bool password = false}) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 29),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        displayText(text: labelTxt),
        SizedBox(
          width: 350,
          height: 48.9,
          child: TextFormField(
            validator: (value) => validasi(value),
            autofocus: false,
            controller: controller,
            obscureText: password,
            keyboardType: txtInputType,
            decoration: InputDecoration(
              hintText: hintTxt,
              hintStyle: styleNormal,
              floatingLabelBehavior: FloatingLabelBehavior.never,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(7),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(7),
                borderSide: BorderSide(
                  color: colorBorder,
                  width: 1.0,
                ),
              ),
              errorStyle: TextStyle(
                height: 0,
                fontSize: 0,
              ),
              suffixIcon: Icon(iconData),
            ),
          ),
        ),
      ],
    ),
  );
}
