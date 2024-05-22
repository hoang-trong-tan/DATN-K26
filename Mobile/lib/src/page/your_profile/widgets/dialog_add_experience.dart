import 'package:flutter/material.dart';
import 'package:kltn/src/page/your_profile/your_profile_vm.dart';

import '../../../utils/app_colors.dart';
import 'item_your_profile.dart';

class DialogAddExperience extends StatefulWidget {
  const DialogAddExperience({super.key, required this.provider, required this.typeExperience, this.index});
  final YourProfileVM provider;
  final TypeExperience typeExperience;
  final int? index;

  @override
  State<DialogAddExperience> createState() => _DialogAddExperienceState();
}

class _DialogAddExperienceState extends State<DialogAddExperience> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: const EdgeInsets.symmetric(horizontal: 20),
      content: SizedBox(
        width: MediaQuery.of(context).size.width - 30,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(
              height: 15,
            ),
            Center(
              child: Row(
                children: [
                  const Spacer(),
                  const Text(
                    'Thêm thông tin kinh nghiệm',
                    style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                  const Spacer(),
                  GestureDetector(onTap: () => Navigator.pop(context), child: const Icon(Icons.close)),
                ],
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            ItemYourProfileWidget(
              controller: widget.provider.companyController,
              lable: 'Công ty',
              hintText: 'Nhập tên công ty',
              textInputType: TextInputType.text,
              validate: (p0) {
                if (p0!.trim().isEmpty || widget.provider.companyController.text.isEmpty) {
                  setState(() {
                    widget.provider.checkvalidateCompany = 'Vui lòng nhập tên công ty';
                    widget.provider.checkCompany = false;
                  });
                } else {
                  setState(() {
                    widget.provider.checkvalidateCompany = '';
                    widget.provider.checkCompany = true;
                  });
                }
              },
            ),
            Text(
              widget.provider.checkvalidateCompany,
              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w400, color: Colors.red),
            ),
            const SizedBox(
              height: 7,
            ),
            ItemYourProfileWidget(
              controller: widget.provider.titleCOntroller,
              lable: 'Vị trí công việc',
              hintText: 'Nhập vị trí công việc',
              textInputType: TextInputType.text,
              validate: (p0) {
                if (p0!.trim().isEmpty || widget.provider.titleCOntroller.text.isEmpty) {
                  setState(() {
                    widget.provider.checkvalidateTitile = 'Vui lòng nhập vị trí công việc';
                    widget.provider.checkTitle = false;
                  });
                } else {
                  setState(() {
                    widget.provider.checkvalidateTitile = '';
                    widget.provider.checkTitle = true;
                  });
                }
              },
            ),
            Text(
              widget.provider.checkvalidateTitile,
              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w400, color: Colors.red),
            ),
            const SizedBox(
              height: 7,
            ),
            ItemYourProfileWidget(
              controller: widget.provider.descriptionCOntroller,
              lable: 'Mô tả',
              hintText: 'Nhập mô tả',
              textInputType: TextInputType.text,
              maxLine: 5,
              validate: (p0) {
                if (p0!.trim().isEmpty || widget.provider.descriptionCOntroller.text.isEmpty) {
                  setState(() {
                    widget.provider.checkvalidateDescription = 'Vui lòng nhập mô tả vị trí đã làm việc';
                    widget.provider.checkDiscription = false;
                  });
                } else {
                  setState(() {
                    widget.provider.checkvalidateDescription = '';
                    widget.provider.checkDiscription = true;
                  });
                }
              },
            ),
            Text(
              widget.provider.checkvalidateDescription,
              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w400, color: Colors.red),
            ),
            const SizedBox(
              height: 20,
            ),
            GestureDetector(
              onTap: widget.provider.titleCOntroller.text.isNotEmpty &&
                      widget.provider.companyController.text.isNotEmpty &&
                      widget.provider.descriptionCOntroller.text.isNotEmpty
                  ? () {
                      if (widget.typeExperience == TypeExperience.CREATE) {
                        widget.provider.addExperience();
                        print("dddddd");
                      } else {
                        print("dddddd");
                        widget.provider.editExperience(widget.index ?? 0);
                      }
                      Navigator.pop(context);
                    }
                  : () {
                      setState(() {
                        if (widget.typeExperience == TypeExperience.CREATE) {
                          widget.provider.checkValidateExperience();
                        } else {
                          Navigator.pop(context);
                        }
                      });
                    },
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  color: AppColors.blue_246BFD,
                ),
                child: const Center(
                  child: Text('Cập nhật',
                      style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500)),
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
          ],
        ),
      ),
    );
  }
}
