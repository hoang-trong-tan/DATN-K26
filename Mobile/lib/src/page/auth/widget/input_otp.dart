// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:kltn/src/utils/app_colors.dart';

// ignore: must_be_immutable
class InputOtpWidget extends StatefulWidget {
  const InputOtpWidget(
      {Key? key,
      required this.controller,
      this.textInputType = TextInputType.text,
      this.checkPassword = false,
      this.textInputAction = TextInputAction.next,
      this.autoFocus = false,
      this.validate})
      : super(key: key);
  final Function(String?)? validate;
  final TextEditingController controller;
  final TextInputType textInputType;
  final bool checkPassword;
  final TextInputAction textInputAction;
  final bool autoFocus;

  @override
  State<InputOtpWidget> createState() => _InputOtpWidgetState();
}

class _InputOtpWidgetState extends State<InputOtpWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadiusDirectional.circular(8),
              color: AppColors.grayE0.withOpacity(0.5)),
          child: TextFormField(
            textAlign: TextAlign.center,
            controller: widget.controller,
            onChanged: widget.validate,
            textInputAction: widget.textInputAction,
            keyboardType: widget.textInputType,
            autofocus: widget.autoFocus,
            inputFormatters: [LengthLimitingTextInputFormatter(1)],
            maxLength: 1,
            style: const TextStyle(
                color: AppColors.black,
                fontSize: 16,
                fontWeight: FontWeight.w500),
            decoration: InputDecoration(
                hintText: '-',
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 7, horizontal: 15),
                border: const OutlineInputBorder(borderSide: BorderSide.none),
                suffixIconColor: AppColors.black.withOpacity(0.8),
                counterText: ''),
          ),
        ),
      ],
    );
  }
}
