import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:kltn/src/base/base_page.dart';
import 'package:kltn/src/page/your_profile/widgets/item_your_profile.dart';
import 'package:kltn/src/page/your_profile/your_profile_vm.dart';

import '../../utils/app_colors.dart';
import 'widgets/dialog_add_experience.dart';

class YourProfilePage extends StatefulWidget {
  const YourProfilePage({super.key});

  @override
  State<YourProfilePage> createState() => _YourProfilePageState();
}

class _YourProfilePageState extends State<YourProfilePage> with MixinBasePage<YourProfileVM> {
  @override
  Widget build(BuildContext context) {
    return builder(
      () => WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          resizeToAvoidBottomInset: true,
          backgroundColor: Colors.white,
          appBar: AppBar(
            toolbarHeight: 80,
            backgroundColor: Colors.white,
            elevation: 0,
            leading: Padding(
              padding: const EdgeInsets.only(left: 15),
              child: Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(40),
                      border: Border.all(color: AppColors.gray99, width: 0.5),
                    ),
                    child: IconButton(
                        onPressed: () {
                          Navigator.pop(context, provider.userModel);
                        },
                        icon: const Icon(
                          Icons.arrow_back_rounded,
                          color: Colors.black,
                          size: 20,
                        )),
                  ),
                ],
              ),
            ),
            title: Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.only(left: MediaQuery.of(context).size.width / 7),
              child: const Text(
                'Thông tin của tôi',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
          body: ScrollConfiguration(
            behavior: const ScrollBehavior().copyWith(overscroll: false),
            child: SingleChildScrollView(
              controller: provider.scrollController,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
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
                                  ? provider.avatar.isNotEmpty
                                      ? Image.network(provider.avatar)
                                      : Image.asset('assets/image/logo.png')
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
                      height: 30,
                    ),
                    ItemYourProfileWidget(
                      controller: provider.nameController,
                      lable: 'Họ và tên',
                      hintText: 'Họ và tên',
                      validate: (p0) {
                        if (p0!.trim().isEmpty || provider.nameController.text.isEmpty) {
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
                      hintText: '0123456789',
                      textInputType: TextInputType.phone,
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
                      // validate: ,
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
                      hintText: 'course@gmail.com',
                      textInputType: TextInputType.emailAddress,
                      readOnly: true,
                      validate: (p0) {
                        final emailRegExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
                        if (p0!.trim().isEmpty || provider.emailController.text.isEmpty) {
                          setState(() {
                            provider.checkvalidateEmail = 'Vui lòng nhập Email';
                          });
                        } else if (!emailRegExp.hasMatch(p0)) {
                          setState(() {
                            provider.checkvalidateEmail = 'Email không hợp lệ';
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
                    // Text(
                    //   'Giới tính',
                    //   style:
                    //       TextStyle(color: AppColors.black.withOpacity(0.8), fontSize: 14, fontWeight: FontWeight.w400),
                    // ),
                    // const SizedBox(
                    //   height: 7,
                    // ),
                    // Container(
                    //   width: MediaQuery.of(context).size.width,
                    //   decoration: BoxDecoration(
                    //       borderRadius: BorderRadiusDirectional.circular(8), color: AppColors.grayE0.withOpacity(0.3)),
                    //   child: DropdownButton(
                    //       isExpanded: true,
                    //       // isDense: true,
                    //       value: provider.select,
                    //       style: const TextStyle(color: AppColors.black, fontSize: 14, fontWeight: FontWeight.w400),
                    //       padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 15),
                    //       elevation: 0,
                    //       underline: Container(),
                    //       borderRadius: BorderRadius.zero,
                    //       hint: Text(
                    //         'Vui lòng chọn giới tính',
                    //         style: TextStyle(
                    //             fontSize: 14, color: AppColors.black.withOpacity(0.5), decoration: TextDecoration.none),
                    //       ),
                    //       items: provider.gender
                    //           .map(
                    //             (e) => DropdownMenuItem(
                    //               value: e,
                    //               child: Text(
                    //                 e,
                    //               ),
                    //             ),
                    //           )
                    //           .toList(),
                    //       onChanged: (values) {
                    //         setState(() {
                    //           provider.select = values;
                    //         });
                    //       }),
                    // ),
                    // const SizedBox(
                    //   height: 20,
                    // ),
                    Text(
                      'Ngày sinh',
                      style:
                          TextStyle(color: AppColors.black.withOpacity(0.8), fontSize: 14, fontWeight: FontWeight.w400),
                    ),
                    const SizedBox(
                      height: 7,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadiusDirectional.circular(8), color: AppColors.grayE0.withOpacity(0.3)),
                      child: TextField(
                        controller: provider.dateTimeController,
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
                                      setState(() {
                                        provider.dateTime = DateFormat('MM/dd/yyyy').format(newDate);
                                        var dateTime = DateFormat('dd/MM/yyyy').format(newDate);
                                        provider.dateTimeController.text = dateTime;
                                      });
                                    },
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ),
                    Visibility(
                      visible: provider.userModel.userRole == 'teacher',
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Kinh nghiệm",
                            style: TextStyle(
                                color: AppColors.black.withOpacity(0.8), fontSize: 14, fontWeight: FontWeight.w400),
                          ),
                          const SizedBox(
                            height: 7,
                          ),
                          ListView.separated(
                            controller: provider.scrollController,
                            itemCount: (provider.userModel.userExperience ?? []).length,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                behavior: HitTestBehavior.opaque,
                                onTap: () {
                                  provider.companyController.text =
                                      provider.userModel.userExperience?[index].company ?? '';
                                  provider.titleCOntroller.text = provider.userModel.userExperience?[index].title ?? '';
                                  provider.descriptionCOntroller.text =
                                      provider.userModel.userExperience?[index].description ?? '';
                                  showDialog(
                                    context: context,
                                    barrierDismissible: false,
                                    builder: (context) {
                                      return DialogAddExperience(
                                        provider: provider,
                                        typeExperience: TypeExperience.EDIT,
                                        index: index,
                                      );
                                    },
                                  );
                                },
                                child: Padding(
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
                                                  provider.userModel.userExperience?[index].company ?? '',
                                                  overflow: TextOverflow.ellipsis,
                                                  style: const TextStyle(
                                                      color: Colors.black, fontWeight: FontWeight.w500, fontSize: 18),
                                                ),
                                                const SizedBox(
                                                  height: 2,
                                                ),
                                                Text(
                                                  provider.userModel.userExperience?[index].title ?? '',
                                                  overflow: TextOverflow.ellipsis,
                                                  style: const TextStyle(
                                                      color: AppColors.h666666,
                                                      fontSize: 16,
                                                      fontWeight: FontWeight.w400),
                                                ),
                                              ],
                                            ),
                                          ),
                                          const Icon(
                                            Icons.edit,
                                            color: AppColors.blue_246BFD,
                                            size: 15,
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        provider.userModel.userExperience?[index].description ?? '',
                                        style: const TextStyle(
                                            color: AppColors.h9497AD, fontSize: 14, fontWeight: FontWeight.w400),
                                      ),
                                    ],
                                  ),
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
                              showDialog(
                                context: context,
                                barrierDismissible: false,
                                builder: (context) {
                                  return DialogAddExperience(
                                    provider: provider,
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
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          bottomNavigationBar: BottomAppBar(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
            // height: 100,
            // color: Colors.amber,
            child: GestureDetector(
              onTap: () async {
                await provider.updateprofile();
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
          ),
        ),
      ),
    );
  }

  @override
  YourProfileVM create() {
    return YourProfileVM();
  }

  @override
  void initialise(BuildContext context) {}
}
