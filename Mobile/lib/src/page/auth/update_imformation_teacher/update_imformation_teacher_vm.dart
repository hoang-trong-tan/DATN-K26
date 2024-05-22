import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kltn/src/model/user_model.dart';
import 'package:kltn/src/remote/service/body/update_imformation_body.dart';
import 'package:path/path.dart';

import '../../../base/base_vm.dart';
import '../../../model/course_type_model.dart';
import '../../../model/experience_model.dart';

class UpdateImformationTearcherVM extends BaseViewModel {
  TextEditingController fullNameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController universityController = TextEditingController();
  TextEditingController specializedController = TextEditingController();
  TextEditingController companyController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  File? image;
  File? imageDiploma;
  String? select;
  UserModel userModel = UserModel();
  List<ExperienceModel> list = [];
  bool checkImformation = false;
  String checkvalidateName = '';
  String checkvalidatePhone = '';
  String checkvalidateDate = '';
  String checkvalidateEmail = '';
  String checkvalidateUniversity = '';
  String checkvalidateSpecialized = '';
  String checkvalidateType = '';
  String checkvalidateExperience = '';
  String checkvalidateCompany = '';
  String checkvalidateTitle = '';
  String checkvalidateDescription = '';
  String checkvalidateimageDiploma = '';
  bool checkValidateImfomation = false;
  String dateTime = '';
  List<CourseTypeModel> listTypeModel = [];
  String avatar = '';
  String diploma = '';
  Function(bool)? callback;

  @override
  void onInit() {
    getUser();
    fetchTypeAll();
  }

  Future<void> getImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      image = File(pickedFile.path);
    }
    notifyListeners();
  }

  Future<void> getImageDiploma() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      imageDiploma = File(pickedFile.path);
      checkvalidateimageDiploma = '';
    }
    notifyListeners();
  }

  void addExperience() {
    final dataExperience = ExperienceModel()
      ..company = companyController.text
      ..title = titleController.text
      ..description = descriptionController.text;
    companyController.text = '';
    titleController.text = '';
    descriptionController.text = '';
    list.add(dataExperience);
    // userModel.userExperience?.add(dataExperience);
    userModel.userExperience = list;
    notifyListeners();
  }

  void editExperience(int index) {
    final dataExperience = ExperienceModel()
      ..company = companyController.text
      ..title = titleController.text
      ..description = descriptionController.text;
    userModel.userExperience?[index] = dataExperience;
    notifyListeners();
  }

  void checkValidateExperience() {
    if (companyController.text.isEmpty) {
      checkvalidateCompany = 'Vui lòng nhập tên công ty';
    }
    if (titleController.text.isEmpty) {
      checkvalidateTitle = 'Vui lòng nhập vị trí công việc';
    }
    if (descriptionController.text.isEmpty) {
      checkvalidateDescription = 'Vui lòng nhập mô tả vị trí đã làm việc';
    }
  }

  void checkValidateImformation() {
    if (fullNameController.text.isEmpty) {
      checkvalidateName = 'Vui lòng nhập họ tên';
    }
    if (phoneController.text.isEmpty) {
      checkvalidatePhone = 'Vui lòng nhập số điện thoại';
    }
    if (emailController.text.isEmpty) {
      checkvalidateEmail = 'Vui lòng địa chỉ email';
    }
    if (dateController.text.isEmpty) {
      checkvalidateDate = 'Vui lòng ngày sinh';
    }
    if (universityController.text.isEmpty) {
      checkvalidateUniversity = 'Vui lòng nhập tên trường Đại học/Cao đẳng';
    }
    if (specializedController.text.isEmpty) {
      checkvalidateSpecialized = 'Vui lòng nhập tên chuyên ngành';
    }
    if ((select ?? '').isEmpty) {
      checkvalidateType = 'Vui lòng chọn danh mục giảng dạy';
    }
    if (imageDiploma == null) {
      checkvalidateimageDiploma = 'Vui lòng thêm ảnh bằng cấp để xác minh';
    }
    if (list.isEmpty) {
      checkvalidateExperience = 'Vui lòng thêm kinh nghiệm';
    }
    if (checkImformation == false) {
      onShowImfo('Vui lòng xác nhận tất cả thông tin trên');
    }

    notifyListeners();
  }

  Future<void> getUser() async {
    showLoading();
    notifyListeners();

    try {
      final response = await api.apiServices
          .getUser({'x-atoken-id': prefs.token.toString()}, {'x-client-id': prefs.userID.toString()});
      if (response.status! >= 200 || response.status! < 400) {
        userModel = response.data ?? UserModel();
        fullNameController.text = response.data?.userName ?? '';
        emailController.text = response.data?.userEmail ?? '';
      }
      hideLoading();
      notifyListeners();
    } on DioException catch (e) {
      log(e.message ?? "");
      showError(e.message ?? "");
    }
  }

  Future fetchTypeAll() async {
    showLoading();
    try {
      final response = await api.apiServices.getCourseType();
      if (response.status! >= 200 || response.status! < 400) {
        listTypeModel.clear();
        listTypeModel.addAll(response.data ?? []);
      }
      hideLoading();
      notifyListeners();

      // ignore: deprecated_member_use
    } on DioError catch (e) {
      log(e.message.toString());
      showError('Không thể kết nối đến máy chủ.\nVui lòng thử lại.');
    }
  }

  Future<void> uploadPhoto(File images, bool check) async {
    showLoading();
    notifyListeners();

    var fileFromImage = File(images.path);
    var basenamename = basenameWithoutExtension(fileFromImage.path);
    var pathString = fileFromImage.path.split(basename(fileFromImage.path))[0];

    var pathStringWithExtension = "$pathString${basenamename}_image.jpg";

    var result = await FlutterImageCompress.compressAndGetFile(
      images.path,
      pathStringWithExtension,
      quality: 70,
      rotate: 0,
    );
    final body = FormData.fromMap({
      'imgaes': await MultipartFile.fromFile(result?.path ?? "", filename: basename(result?.path ?? "")),
    });

    try {
      final response = await api.apiServices
          .uploadImage({'x-atoken-id': prefs.token.toString()}, {'x-client-id': prefs.userID.toString()}, body);
      if (response.status! >= 200 || response.status! < 400) {
        if (check) {
          avatar = response.data ?? "";
        } else {
          diploma = response.data ?? "";
        }
      }
      hideLoading();
      notifyListeners();
    } on DioException catch (e) {
      log(e.message ?? "");
      showError(e.message ?? "");
    }
  }

  Future<void> updateprofile() async {
    showLoading();
    notifyListeners();
    if (image == null || imageDiploma == null) {
      onShowImfo('Vui lòng thêm đại diện');
      hideLoading();
      notifyListeners();
      return;
    }
    if (image != null && imageDiploma != null) {
      await uploadPhoto(image!, true);
      await uploadPhoto(imageDiploma!, false);
    }
    final body = UpdateImfomationBody()
      ..userAvatar = avatar
      ..userName = fullNameController.text
      ..userPhone = phoneController.text
      ..userUniversity = universityController.text
      ..userMajor = specializedController.text
      ..courseTtype = select
      ..userBirthday = dateTime
      ..userExperience = userModel.userExperience ?? []
      ..userDiploma = diploma;

    try {
      final response = await api.apiServices.updateImformation(
        {'x-atoken-id': prefs.token.toString()},
        {'x-client-id': prefs.userID.toString()},
        body,
      );
      if (response.status! >= 200 || response.status! < 400) {
        userModel = response.data ?? UserModel();
        prefs.userName = response.data?.userName ?? '';
        prefs.userUpdate = true;
        callback?.call(true);
        showSucces("Cập nhật thông tin thành công");

        notifyListeners();
      }
      hideLoading();
      notifyListeners();
    } on DioException catch (e) {
      log(e.message ?? "");
      showError("Cập nhật thông tin không thành công");
    }
  }

  bool checkImfor() {
    if (fullNameController.text.isNotEmpty &&
        phoneController.text.isNotEmpty &&
        emailController.text.isNotEmpty &&
        dateController.text.isNotEmpty &&
        universityController.text.isNotEmpty &&
        specializedController.text.isNotEmpty &&
        (select ?? '').isNotEmpty &&
        imageDiploma != null &&
        list.isNotEmpty &&
        checkImformation) {
      return true;
    }
    return false;
  }
}
