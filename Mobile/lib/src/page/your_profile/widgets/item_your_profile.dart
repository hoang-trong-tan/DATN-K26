// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:kltn/src/utils/app_colors.dart';

class ItemYourProfileWidget extends StatelessWidget {
  const ItemYourProfileWidget(
      {Key? key,
      required this.lable,
      required this.hintText,
      required this.controller,
      this.textInputType = TextInputType.text,
      this.maxLine = 1,
      this.readOnly=false,
      this.textInputAction=TextInputAction.done,
      this.validate})
      : super(key: key);
  final String lable;
  final String hintText;
  final Function(String?)? validate;
  final TextEditingController controller;
  final TextInputType textInputType;
  final int maxLine;
  final bool readOnly;
  final TextInputAction textInputAction;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              lable,
              style: TextStyle(color: AppColors.black.withOpacity(0.8), fontSize: 14, fontWeight: FontWeight.w400),
            ),
            const Text(
              '*',
              style: TextStyle(color: Colors.red),
            ),
          ],
        ),
        const SizedBox(
          height: 7,
        ),
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadiusDirectional.circular(8), color: AppColors.grayE0.withOpacity(0.3)),
          child: TextFormField(
            // key: ,
            controller: controller,
            // validator: validate,
            onChanged: validate,
            maxLines: maxLine,
            keyboardType: textInputType,
            readOnly: readOnly,
            textInputAction: textInputAction,
            style: const TextStyle(color: AppColors.black, fontSize: 14, fontWeight: FontWeight.w400),
            decoration: InputDecoration(
              hintText: hintText,
              // errorText: validate != null ?  validate!(controller.text):null,
              contentPadding: const EdgeInsets.symmetric(vertical: 7, horizontal: 15),
              border: const OutlineInputBorder(borderSide: BorderSide.none),
            ),
          ),
        ),
        // const SizedBox(
        //   height: 5,
        // ),
        // Text(
        //   validate != null ? validate!(controller.text) : '',
        //   style: const TextStyle(
        //       fontSize: 12, fontWeight: FontWeight.w400, color: Colors.red),
        // )
      ],
    );
  }
}
