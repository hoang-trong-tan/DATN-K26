import 'package:flutter/material.dart';
import 'package:kltn/src/page/detail_mentor/detail_mentor_page.dart';
import 'package:kltn/src/page/search/search_vm.dart';

import '../../../utils/app_colors.dart';

class MentorWidget extends StatefulWidget {
  const MentorWidget({super.key, required this.provider});
  final SearchVM provider;

  @override
  State<MentorWidget> createState() => _MentorWidgetState();
}

class _MentorWidgetState extends State<MentorWidget> {
  @override
  Widget build(BuildContext context) {
    return widget.provider.listSearchUser.isNotEmpty
        ? ScrollConfiguration(
            behavior: const ScrollBehavior().copyWith(overscroll: false),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 15),
              child: ListView.builder(
                itemCount: widget.provider.listSearchUser.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              DetailMentorPage(idMentor: widget.provider.listSearchUser[index].id ?? ''),
                        ),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 15),
                      child: Row(
                        children: [
                          Container(
                            height: 60,
                            width: 60,
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(70),
                              border: Border.all(color: Colors.black),
                            ),
                            child: CircleAvatar(
                                maxRadius: 45,
                                // minRadius: 40,
                                backgroundColor: Colors.white,
                                backgroundImage: (widget.provider.listSearchUser[index].userAvatar ?? '').isNotEmpty
                                    ? NetworkImage(widget.provider.listSearchUser[index].userAvatar ?? '')
                                    : const AssetImage('assets/image/logo.png') as ImageProvider<Object>),
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          Text(
                            widget.provider.listSearchUser[index].userName ?? '',
                            style: const TextStyle(fontSize: 16, color: AppColors.h333333, fontWeight: FontWeight.w600),
                          ),
                          const Spacer(),
                          // Container(
                          //   height: 40,
                          //   width: 40,
                          //   padding: const EdgeInsets.all(5),
                          //   decoration: BoxDecoration(
                          //     borderRadius: BorderRadius.circular(40),
                          //     color: AppColors.h9497AD.withOpacity(0.2),
                          //   ),
                          //   child: const Icon(
                          //     Icons.phone,
                          //     color: AppColors.blue_246BFD,
                          //   ),
                          // ),
                          // const SizedBox(
                          //   width: 8,
                          // ),
                          // Container(
                          //   height: 40,
                          //   width: 40,
                          //   padding: const EdgeInsets.all(5),
                          //   decoration: BoxDecoration(
                          //     borderRadius: BorderRadius.circular(40),
                          //     color: AppColors.h9497AD.withOpacity(0.2),
                          //   ),
                          //   child: const Icon(
                          //     Icons.chat,
                          //     color: AppColors.blue_246BFD,
                          //   ),
                          // ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          )
        : const Center(
            child: Text(
              'Không có dữ liệu',
              style: TextStyle(color: Colors.black, fontSize: 14, fontWeight: FontWeight.w400),
            ),
          );
  }
}
