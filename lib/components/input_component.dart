import 'package:flutter/material.dart';
import 'package:atma_cinema/utils/constants.dart';

//Label Text
Padding displayText({required String text}) {
  return Padding(
    padding: const EdgeInsets.only(top: 20),
    child: SizedBox(
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 16,  // Customize font size as needed
          fontWeight: FontWeight.normal,
        ),
      ),
    ),
  );
}

//Input text
Padding inputForm(Function(String?) validasi,
    {required TextEditingController controller,
    required String hintTxt,
    IconData? iconData,
    bool password = false}) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 20),
    child: SizedBox(
      width: 350,
      child: TextFormField(
        validator: (value) => validasi(value),
        autofocus: true,
        controller: controller,
        obscureText: password,
        decoration: InputDecoration(
          hintText: hintTxt,
          border: const OutlineInputBorder(),
          suffixIcon: Icon(iconData),
        ),
      ),
    ),
  );
}
