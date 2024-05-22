// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:kltn/src/utils/app_colors.dart';

// ignore: must_be_immutable
class ItemTextFieldWidget extends StatefulWidget {
  const ItemTextFieldWidget(
      {Key? key,
      required this.lable,
      required this.hintText,
      required this.controller,
      this.textInputType = TextInputType.text,
      this.validate})
      : super(key: key);
  final String lable;
  final String hintText;
  final Function(String?)? validate;
  final TextEditingController controller;
  final TextInputType textInputType;

  @override
  State<ItemTextFieldWidget> createState() => _ItemTextFieldWidgetState();
}

class _ItemTextFieldWidgetState extends State<ItemTextFieldWidget> {
  bool obscureText = true;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.lable,
          style: TextStyle(
              color: AppColors.black.withOpacity(0.8),
              fontSize: 14,
              fontWeight: FontWeight.w400),
        ),
        const SizedBox(
          height: 7,
        ),
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadiusDirectional.circular(8),
              color: AppColors.grayE0.withOpacity(0.3)),
          child: TextFormField(
            controller: widget.controller,
            onChanged: widget.validate,
            keyboardType: widget.textInputType,
            obscureText: obscureText,
            style: TextStyle(
                color: AppColors.black.withOpacity(0.7),
                fontSize: 14,
                fontWeight: FontWeight.w400),
            decoration: InputDecoration(
              hintText: widget.hintText,
              // errorText: validate != null ?  validate!(controller.text):null,
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 7, horizontal: 15),
              border: const OutlineInputBorder(borderSide: BorderSide.none),
              suffixIconColor: AppColors.black.withOpacity(0.8),
              suffixIcon: GestureDetector(
                onTap: () {
                  setState(() {
                    obscureText = !obscureText;
                  });
                },
                child: Icon(!obscureText
                    ? Icons.visibility_outlined
                    : Icons.visibility_off_outlined),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
