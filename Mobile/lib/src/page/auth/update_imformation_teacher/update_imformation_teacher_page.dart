import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kltn/src/base/base_page.dart';
import 'package:kltn/src/page/auth/update_imformation_teacher/widget/list_experience_widget.dart';
import '../../../utils/app_colors.dart';
import '../../main/main_page.dart';
import '../../your_profile/widgets/item_your_profile.dart';
import 'update_imformation_teacher_vm.dart';

class UpdateImformationTeacherpage extends StatefulWidget {
  const UpdateImformationTeacherpage({super.key, required this.checkLogin});
  final Map<String, dynamic>? checkLogin;

  @override
  State<UpdateImformationTeacherpage> createState() => _UpdateImformationTeacherpageState();
}

class _UpdateImformationTeacherpageState extends State<UpdateImformationTeacherpage>
    with MixinBasePage<UpdateImformationTearcherVM> {
  @override
  Widget build(BuildContext context) {
    return builder(
      () => WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: Scaffold(
          appBar: AppBar(
            // toolbarHeight: 80,
            backgroundColor: AppColors.blue_246BFD,
            elevation: 0,

            title: const Text(
              'Cập nhật thông tin giảng viên',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            centerTitle: true,
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                const SizedBox(
                  height: 20,
                ),
                Center(
                  child: Stack(
                    children: [
                      Container(
                        width: 100,
                        height: 100,
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          border: Border.all(color: AppColors.blue_246BFD, width: 2),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child: provider.image == null
                              ? Image.asset(
                                  'assets/image/logo.png',
                                  fit: BoxFit.contain,
                                )
                              : Image.file(provider.image!),
                        ),
                      ),
                      Positioned(
                        right: 0,
                        bottom: 0,
                        child: GestureDetector(
                          onTap: () {
                            provider.getImage();
                          },
                          child: Container(
                            height: 30,
                            width: 30,
                            decoration: BoxDecoration(
                                color: AppColors.blue_246BFD,
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(color: Colors.white, width: 1)),
                            child: const Icon(
                              Icons.mode_edit_outline_outlined,
                              color: Colors.white,
                              size: 15,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                ItemYourProfileWidget(
                  controller: provider.fullNameController,
                  lable: 'Họ và tên',
                  hintText: 'Nhập họ và tên',
                  textInputAction: TextInputAction.next,
                  validate: (p0) {
                    if (p0!.trim().isEmpty || provider.fullNameController.text.isEmpty) {
                      setState(() {
                        provider.checkvalidateName = 'Vui lòng nhập họ tên';
                      });
                    } else {
                      setState(() {
                        provider.checkvalidateName = '';
                      });
                    }
                  },
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  provider.checkvalidateName,
                  style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w400, color: Colors.red),
                ),
                const SizedBox(
                  height: 5,
                ),
                ItemYourProfileWidget(
                  controller: provider.phoneController,
                  lable: 'Số điện thoại',
                  hintText: 'Nhập số điện thoại',
                  textInputType: TextInputType.phone,
                  textInputAction: TextInputAction.next,
                  validate: (p0) {
                    final phoneRegExp = RegExp(r'^[0-9]{10}$');
                    if (p0!.trim().isEmpty || provider.phoneController.text.isEmpty) {
                      setState(() {
                        provider.checkvalidatePhone = 'Vui lòng nhập số điện thoại';
                      });
                    } else if (!phoneRegExp.hasMatch(p0)) {
                      setState(() {
                        provider.checkvalidatePhone = 'Số điện thoại không hợp lệ';
                      });
                    } else {
                      setState(() {
                        provider.checkvalidatePhone = '';
                      });
                    }
                  },
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  provider.checkvalidatePhone,
                  style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w400, color: Colors.red),
                ),
                const SizedBox(
                  height: 5,
                ),
                ItemYourProfileWidget(
                  controller: provider.emailController,
                  lable: 'Email',
                  hintText: 'Nhập địa chỉ email',
                  textInputAction: TextInputAction.next,
                  readOnly: true,
                  textInputType: TextInputType.emailAddress,
                  validate: (p0) {
                    if (p0!.trim().isEmpty || provider.emailController.text.isEmpty) {
                      setState(() {
                        provider.checkvalidateEmail = 'Vui lòng địa chỉ email';
                      });
                    } else {
                      setState(() {
                        provider.checkvalidateEmail = '';
                      });
                    }
                  },
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  provider.checkvalidateEmail,
                  style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w400, color: Colors.red),
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    Text(
                      'Ngày sinh',
                      style:
                          TextStyle(color: AppColors.black.withOpacity(0.8), fontSize: 14, fontWeight: FontWeight.w400),
                    ),
                    const Text(
                      '*',
                      style: TextStyle(color: Colors.red),
                    ),
                  ],
                ),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadiusDirectional.circular(8), color: AppColors.grayE0.withOpacity(0.3)),
                  child: TextField(
                    controller: provider.dateController,
                    keyboardType: TextInputType.datetime,
                    readOnly: true,
                    style: const TextStyle(color: AppColors.black, fontSize: 14, fontWeight: FontWeight.w400),
                    decoration: const InputDecoration(
                        hintText: '13/02/2023',
                        suffixIcon: Icon(Icons.date_range_outlined),
                        contentPadding: EdgeInsets.symmetric(vertical: 7, horizontal: 15),
                        border: OutlineInputBorder(borderSide: BorderSide.none)),
                    onTap: () {
                      showCupertinoModalPopup(
                        context: context,
                        builder: (context) {
                          return Container(
                            height: 216,
                            padding: const EdgeInsets.only(top: 6.0),
                            margin: EdgeInsets.only(
                              bottom: MediaQuery.of(context).viewInsets.bottom,
                            ),
                            color: CupertinoColors.systemBackground.resolveFrom(context),
                            child: SafeArea(
                              top: false,
                              child: CupertinoDatePicker(
                                initialDateTime: DateTime.now(),
                                mode: CupertinoDatePickerMode.date,
                                maximumDate: DateTime.now(),
                                use24hFormat: true,
                                onDateTimeChanged: (DateTime newDate) {
                                  provider.dateTime = DateFormat('MM/dd/yyyy').format(newDate);
                                  setState(() {
                                    var dateTime = DateFormat('dd/MM/yyyy').format(newDate);
                                    provider.dateController.text = dateTime;
                                    if (provider.dateController.text.isEmpty) {
                                      setState(() {
                                        provider.checkvalidateDate = 'Vui lòng ngày sinh';
                                      });
                                    } else {
                                      setState(() {
                                        provider.checkvalidateDate = '';
                                      });
                                    }
                                  });
                                },
                              ),
                            ),
                          );
                        },
                      );
                      if (provider.dateController.text.isEmpty) {
                        setState(() {
                          provider.checkvalidateDate = 'Vui lòng ngày sinh';
                        });
                      } else {
                        setState(() {
                          provider.checkvalidateDate = '';
                        });
                      }
                    },
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  provider.checkvalidateDate,
                  style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w400, color: Colors.red),
                ),
                const SizedBox(
                  height: 5,
                ),
                ItemYourProfileWidget(
                  controller: provider.universityController,
                  lable: 'Trường Đại học/Cao đẳng',
                  hintText: 'Nhập tên trường Đại học/Cao đẳng',
                  textInputAction: TextInputAction.next,
                  validate: (p0) {
                    if (p0!.trim().isEmpty || provider.universityController.text.isEmpty) {
                      setState(() {
                        provider.checkvalidateUniversity = 'Vui lòng nhập tên trường Đại học/Cao đẳng';
                      });
                    } else {
                      setState(() {
                        provider.checkvalidateUniversity = '';
                      });
                    }
                  },
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  provider.checkvalidateUniversity,
                  style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w400, color: Colors.red),
                ),
                const SizedBox(
                  height: 5,
                ),
                ItemYourProfileWidget(
                  controller: provider.specializedController,
                  lable: 'Chuyên ngành',
                  hintText: 'Nhập tên chuyên ngành',
                  textInputAction: TextInputAction.next,
                  validate: (p0) {
                    if (p0!.trim().isEmpty || provider.specializedController.text.isEmpty) {
                      setState(() {
                        provider.checkvalidateSpecialized = 'Vui lòng nhập tên chuyên ngành';
                      });
                    } else {
                      setState(() {
                        provider.checkvalidateSpecialized = '';
                      });
                    }
                  },
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  provider.checkvalidateSpecialized,
                  style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w400, color: Colors.red),
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    Text(
                      'Chọn danh mục dạy',
                      style:
                          TextStyle(color: AppColors.black.withOpacity(0.8), fontSize: 14, fontWeight: FontWeight.w400),
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
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadiusDirectional.circular(8), color: AppColors.grayE0.withOpacity(0.3)),
                  child: DropdownButton(
                      isExpanded: true,
                      // isDense: true,
                      value: provider.select,
                      style: const TextStyle(color: AppColors.black, fontSize: 14, fontWeight: FontWeight.w400),
                      padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 15),
                      elevation: 0,
                      underline: Container(),
                      onTap: () {
                        if ((provider.select ?? '').isEmpty) {
                          setState(() {
                            provider.checkvalidateType = 'Vui lòng chọn danh mục giảng dạy';
                          });
                        } else {
                          setState(() {
                            provider.checkvalidateType = '';
                          });
                        }
                      },
                      borderRadius: BorderRadius.zero,
                      hint: Text(
                        'Vui lòng chọn danh mục dạy',
                        style: TextStyle(
                            fontSize: 14, color: AppColors.black.withOpacity(0.5), decoration: TextDecoration.none),
                      ),
                      items: provider.listTypeModel
                          .map(
                            (e) => DropdownMenuItem(
                              value: e.id,
                              child: Text(
                                e.typeName ?? '',
                              ),
                            ),
                          )
                          .toList(),
                      onChanged: (values) {
                        setState(() {
                          provider.select = values;
                          if ((provider.select ?? '').isEmpty) {
                            setState(() {
                              provider.checkvalidateType = 'Vui lòng chọn danh mục giảng dạy';
                            });
                          } else {
                            setState(() {
                              provider.checkvalidateType = '';
                            });
                          }
                        });
                      }),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  provider.checkvalidateType,
                  style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w400, color: Colors.red),
                ),
                const SizedBox(
                  height: 5,
                ),
                ListExperienceWidget(provider: provider),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    Text(
                      'Ảnh bằng cấp',
                      style:
                          TextStyle(color: AppColors.black.withOpacity(0.8), fontSize: 14, fontWeight: FontWeight.w400),
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
                provider.imageDiploma == null
                    ? GestureDetector(
                        onTap: () {
                          provider.getImageDiploma();
                        },
                        child: SizedBox(
                          height: 100,
                          width: 100,
                          child: Image.asset('assets/image/add_image.png'),
                        ),
                      )
                    : GestureDetector(
                        onTap: () {
                          provider.getImageDiploma();
                        },
                        child: SizedBox(
                          height: 100,
                          width: 100,
                          child: Image.file(
                            provider.imageDiploma!,
                          ),
                        ),
                      ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  provider.checkvalidateimageDiploma,
                  style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w400, color: Colors.red),
                ),
                const SizedBox(height: 5),
                Row(
                  children: [
                    SizedBox(
                      height: 30,
                      width: 30,
                      child: Checkbox(
                        value: provider.checkImformation,
                        checkColor: AppColors.blue_246BFD,
                        activeColor: AppColors.white,
                        side: MaterialStateBorderSide.resolveWith(
                          (states) => const BorderSide(
                            color: AppColors.blue_246BFD,
                            width: 1.5,
                          ),
                        ),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(3)),
                        onChanged: (value) {
                          setState(() {
                            provider.checkImformation = value ?? false;
                          });
                        },
                      ),
                    ),
                    const Text(
                      'Xác nhận thông tin trên là chính xác',
                      style: TextStyle(
                        color: AppColors.black,
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: provider.checkImfor()
                      ? () {
                          provider.updateprofile();
                        }
                      : () {
                          provider.checkValidateImformation();
                        },
                  child: Container(
                    height: 55,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: AppColors.blue_246BFD,
                    ),
                    child: const Center(
                      child:
                          Text('Gửi', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500)),
                    ),
                  ),
                ),
              ]),
            ),
          ),
        ),
      ),
    );
  }

  @override
  UpdateImformationTearcherVM create() {
    return UpdateImformationTearcherVM();
  }

  @override
  void initialise(BuildContext context) {
    provider.callback = (p0) {
      if (widget.checkLogin?['profile'] != null) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => MainPage(initPage: widget.checkLogin?['profile']),
          ),
          (route) => false,
        );
      } else if (widget.checkLogin?['id_course'] != null || widget.checkLogin?['notification'] != null) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => MainPage(login: widget.checkLogin),
          ),
          (route) => false,
        );
      } else {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => MainPage(),
          ),
          (route) => false,
        );
      }
    };
  }
}
