import 'package:flutter/material.dart';
import 'package:kltn/src/page/auth/update_imformation_teacher/update_imformation_teacher_vm.dart';

import '../../../../utils/app_colors.dart';
import '../../../your_profile/your_profile_vm.dart';
import 'dialog_experience_wiget.dart';

class ListExperienceWidget extends StatefulWidget {
  const ListExperienceWidget({super.key, required this.provider});
  final UpdateImformationTearcherVM provider;

  @override
  State<ListExperienceWidget> createState() => _ListExperienceWidgetState();
}

class _ListExperienceWidgetState extends State<ListExperienceWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              'Kinh nghiệm',
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
        ListView.separated(
          // controller: widget.provider.scrollController,
          itemCount: (widget.provider.userModel.userExperience ?? []).length,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.provider.userModel.userExperience?[index].company ?? '',
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w400,
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(
                              height: 2,
                            ),
                            Text(
                              widget.provider.userModel.userExperience?[index].title ?? '',
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                color: AppColors.h666666,
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          widget.provider.companyController.text =
                              widget.provider.userModel.userExperience?[index].company ?? '';
                          widget.provider.titleController.text =
                              widget.provider.userModel.userExperience?[index].title ?? '';
                          widget.provider.descriptionController.text =
                              widget.provider.userModel.userExperience?[index].description ?? '';
                          showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (context) {
                              return DialogExperienceWidget(
                                provider: widget.provider,
                                typeExperience: TypeExperience.EDIT,
                                index: index,
                              );
                            },
                          );
                        },
                        child: const Icon(
                          Icons.edit,
                          color: AppColors.blue_246BFD,
                          size: 15,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    widget.provider.userModel.userExperience?[index].description ?? '',
                    style: const TextStyle(color: AppColors.h9497AD, fontSize: 12, fontWeight: FontWeight.w400),
                  ),
                ],
              ),
            );
          },
          separatorBuilder: (BuildContext context, int index) {
            return Divider(
              color: AppColors.h9497AD.withOpacity(0.5),
              height: 0,
            );
          },
        ),
        const SizedBox(
          height: 10,
        ),
        GestureDetector(
          onTap: () {
            if ((widget.provider.list).isEmpty) {
              setState(() {
                widget.provider.checkvalidateExperience = 'Vui lòng thêm kinh nghiệm';
              });
            } else {
              setState(() {
                widget.provider.checkvalidateExperience = '';
              });
            }
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) {
                return DialogExperienceWidget(
                  provider: widget.provider,
                  typeExperience: TypeExperience.CREATE,
                );
              },
            );
          },
          child: const Center(
            child: Column(
              children: [
                Icon(
                  Icons.add,
                  color: AppColors.blue_246BFD,
                  size: 40,
                ),
                Text(
                  'Thêm thông tin kinh nghiệm',
                  style: TextStyle(color: AppColors.blue_246BFD),
                ),
              ],
            ),
          ),
        ),
        Text(
          widget.provider.checkvalidateExperience,
          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w400, color: Colors.red),
        ),
      ],
    );
  }
}
