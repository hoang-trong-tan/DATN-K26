
import 'package:flutter/material.dart';
import 'package:kltn/src/utils/app_colors.dart';

class ItemProfileWidget extends StatelessWidget {
  const ItemProfileWidget(
      {super.key,
      required this.icon,
      required this.title,
      this.divider = true,
      required this.ontap});
  final IconData icon;
  final String title;
  final Function() ontap;
  final bool divider;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15),
      child: Column(
        children: [
          const SizedBox(
            height: 7,
          ),
          InkResponse(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onTap: ontap,
            child: Row(
              children: [
                Icon(
                  icon,
                  color: AppColors.blue_246BFD.withOpacity(0.8),
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  title,
                  style: TextStyle(
                    color: Colors.black.withOpacity(0.8),
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const Spacer(),
                Icon(
                  Icons.navigate_next,
                  color: AppColors.blue_246BFD.withOpacity(0.8),
                  size: 30,
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 7,
          ),
          Visibility(
            visible: divider,
            child: const Divider(
              color: AppColors.grayE0,
              height: 0.5,
            ),
          ),
        ],
      ),
    );
  }
}
