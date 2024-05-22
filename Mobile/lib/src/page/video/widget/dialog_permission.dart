import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../utils/app_colors.dart';
import '../../profile/widgets/dialog_widget.dart';

class DialogPermision extends StatelessWidget {
  const DialogPermision({super.key, this.title = ''});
  final String title;

  @override
  Widget build(BuildContext context) {
    return PlaceholderDialog(
      icon: Icon(
        Icons.login,
        color: Colors.blue[700],
        size: 80.0,
      ),
      title: 'Cảnh báo',
      message: title.isNotEmpty ? title : 'Vui lòng cấp quyền để xem tài liệu',
      actions: [
        SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    height: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: AppColors.gray99,
                    ),
                    child: const Align(
                      alignment: Alignment.center,
                      child: Text(
                        'Trở về',
                        style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w400),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                    openAppSettings();
                  },
                  child: Container(
                    height: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: AppColors.blue_246BFD,
                    ),
                    child: const Align(
                        alignment: Alignment.center,
                        child: Text('Cài đặt',
                            style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w400))),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
