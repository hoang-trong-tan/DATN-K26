import 'dart:io';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:kltn/src/base/base_vm.dart';
import 'package:kltn/src/model/experience_model.dart';
import 'package:kltn/src/model/user_model.dart';
import 'package:kltn/src/remote/service/body/profile_body.dart';
import 'package:path/path.dart';

enum TypeExperience {
  // ignore: constant_identifier_names
  EDIT,
  // ignore: constant_identifier_names
  CREATE
}

class YourProfileVM extends BaseViewModel {
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController dateTimeController = TextEditingController();
  TextEditingController companyController = TextEditingController();
  TextEditingController titleCOntroller = TextEditingController();
  TextEditingController descriptionCOntroller = TextEditingController();
  ScrollController scrollController = ScrollController();
  List<String> gender = ['Nam', 'Nữ', 'Khác'];
  String? select;
  String checkvalidateName = '';
  String checkvalidatePhone = '';
  String checkvalidateEmail = '';
  String checkvalidateCompany = '';
  String checkvalidateTitile = '';
  String checkvalidateDescription = '';
  String avatar = '';
  File? image;
  bool checkCompany = false;
  bool checkTitle = false;
  bool checkDiscription = false;
  String dateTime = '';
  UserModel userModel = UserModel();
  List<ExperienceModel> list = [];

  @override
  void onInit() {
    getUser();
  }

  Future<void> getImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      image = File(pickedFile.path);
    }
    notifyListeners();
  }

  Future<void> uploadPhoto() async {
    if (image == null) {
      return;
    }
    showLoading();
    notifyListeners();

    var fileFromImage = File(image?.path ?? "");
    var basenamename = basenameWithoutExtension(fileFromImage.path);
    var pathString = fileFromImage.path.split(basename(fileFromImage.path))[0];

    var pathStringWithExtension = "$pathString${basenamename}_image.jpg";

    var result = await FlutterImageCompress.compressAndGetFile(
      image?.path ?? "",
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
        avatar = response.data ?? "";
      }
      hideLoading();
      notifyListeners();
    } on DioException catch (e) {
      log(e.message ?? "");
      showError(e.message ?? "");
    }
  }

  Future<void> getUser() async {
    showLoading();
    notifyListeners();

    try {
      final response = await api.apiServices
          .getUser({'x-atoken-id': prefs.token.toString()}, {'x-client-id': prefs.userID.toString()});
      if (response.status! >= 200 || response.status! < 400) {
        userModel = response.data ?? UserModel();
        nameController.text = response.data?.userName ?? '';
        emailController.text = response.data?.userEmail ?? '';
        avatar = response.data?.userAvatar ?? '';
        phoneController.text = response.data?.userPhone ?? '';
        list.addAll(response.data?.userExperience ?? []);
        try {
          dateTime = response.data?.userBirthday ?? '';
          final date2 = DateTime.parse(response.data?.userBirthday ?? '');
          var dateTime2 = DateFormat('dd/MM/yyyy').format(date2);
          dateTimeController.text = dateTime2;
        } catch (e) {
          log(e.toString());
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
    if (image != null) {
      await uploadPhoto();
    }

    final body = ProfileBody()
      ..userAvatar = avatar
      ..userName = nameController.text
      ..userBirthday = dateTime
      ..userPhone = phoneController.text
      ..userExperience = userModel.userExperience ?? [];

    try {
      final response = await api.apiServices.updateProfile(
        {'x-atoken-id': prefs.token.toString()},
        {'x-client-id': prefs.userID.toString()},
        body,
      );
      if (response.status! >= 200 || response.status! < 400) {
        showSucces("Cập nhật thông tin thành công");
        userModel = response.data ?? UserModel();
        prefs.userName = response.data?.userName ?? '';

        notifyListeners();
      }
      hideLoading();
      notifyListeners();
    } on DioException catch (e) {
      log(e.message ?? "");
      showError("Cập nhật thông tin không thành công");
    }
  }

  void checkValidateExperience() {
    if (checkCompany == false) {
      checkvalidateCompany = 'Vui lòng nhập tên công ty';
    }
    if (checkTitle == false) {
      checkvalidateTitile = 'Vui lòng nhập vị trí công việc';
    }
    if (checkDiscription == false) {
      checkvalidateDescription = 'Vui lòng nhập mô tả vị trí đã làm việc';
    }
  }

  void addExperience() {
    final dataExperience = ExperienceModel()
      ..company = companyController.text
      ..title = titleCOntroller.text
      ..description = descriptionCOntroller.text;
    companyController.text = '';
    titleCOntroller.text = '';
    descriptionCOntroller.text = '';
    list.add(dataExperience);
    userModel.userExperience = list;
    notifyListeners();
  }

  void editExperience(int index) {
    final dataExperience = ExperienceModel()
      ..company = companyController.text
      ..title = titleCOntroller.text
      ..description = descriptionCOntroller.text;
    userModel.userExperience?[index] = dataExperience;
    notifyListeners();
  }
}
