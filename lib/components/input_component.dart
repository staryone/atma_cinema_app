import 'package:flutter/material.dart';
import 'package:atma_cinema/utils/constants.dart';
import 'package:intl/intl.dart';

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

class InputForm extends StatefulWidget {
  final Function(String?) validasi;
  final TextEditingController controller;
  final String hintTxt;
  final String labelTxt;
  final IconData? iconData;
  final TextInputType? txtInputType;
  final bool password;
  final bool isDate;
  final VoidCallback? onToggleVisibility;
  final VoidCallback? onTap;
  final Color? borderColor;

  const InputForm({
    Key? key,
    required this.validasi,
    required this.controller,
    required this.hintTxt,
    required this.labelTxt,
    this.iconData,
    this.txtInputType,
    this.password = false,
    this.isDate = false,
    this.onToggleVisibility,
    this.borderColor,
    this.onTap,
  }) : super(key: key);

  @override
  createState() => _InputFormState();
}

class _InputFormState extends State<InputForm> {
  bool isPasswordVisible = false;

  void togglePasswordVisibility() {
    setState(() {
      isPasswordVisible = !isPasswordVisible;
    });
  }

  Future<void> _selectDate(BuildContext context) async {
    DateTime initialDate;
    final dateFormat = DateFormat("dd/MM/YYYY");

    try {
      final formatDate = dateFormat.parse(widget.controller.text);
      initialDate = formatDate;
    } catch (e) {
      initialDate = DateTime.now();
    }

    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (pickedDate != null) {
      setState(() {
        widget.controller.text =
            "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 29),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          displayText(text: widget.labelTxt),
          SizedBox(
            width: 350,
            height: 48.9,
            child: TextFormField(
              validator: (value) => widget.validasi(value),
              autofocus: false,
              controller: widget.controller,
              obscureText: widget.password && !isPasswordVisible,
              keyboardType:
                  widget.isDate ? TextInputType.none : widget.txtInputType,
              readOnly: widget.isDate,
              onTap: widget.onTap,
              decoration: InputDecoration(
                hintText: widget.hintTxt,
                hintStyle: TextStyle(
                  color: colorPrimary.withOpacity(0.2),
                  fontSize: 16,
                ),
                floatingLabelBehavior: FloatingLabelBehavior.never,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(7),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(7),
                  borderSide: BorderSide(
                    color: widget.borderColor ?? colorBorder,
                    width: 1.0,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(7),
                  borderSide: BorderSide(
                    color: widget.borderColor ?? colorPrimary,
                    width: 2.0,
                  ),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(7),
                  borderSide: BorderSide(
                    color: Colors.red,
                    width: 1.0,
                  ),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(7),
                  borderSide: BorderSide(
                    color: Colors.red,
                    width: 2.0,
                  ),
                ),
                errorStyle: const TextStyle(
                  height: 0,
                  fontSize: 0,
                ),
                suffixIcon: widget.password
                    ? IconButton(
                        icon: Icon(
                          isPasswordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                        onPressed: () {
                          togglePasswordVisibility();
                          if (widget.onToggleVisibility != null) {
                            widget.onToggleVisibility!();
                          }
                        },
                      )
                    : (widget.iconData != null ? Icon(widget.iconData) : null),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
