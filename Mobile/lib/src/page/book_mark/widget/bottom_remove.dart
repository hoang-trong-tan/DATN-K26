import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kltn/src/page/book_mark/book_mark_vm.dart';

import '../../../remote/service/respone/cart/cart_response.dart';
import '../../../utils/app_colors.dart';

class RemoveWidget extends StatelessWidget {
  const RemoveWidget({super.key, required this.model, this.provider, this.index});
  final CartResponse model;
  final BookMarkVM? provider;
  final int? index;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30))),
      height: 275,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        child: Column(
          children: [
            const Text(
              'Xóa khỏi mục yêu thích?',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.black),
            ),
            const SizedBox(
              height: 5,
            ),
            Divider(
              color: AppColors.h8C8C8C.withOpacity(0.4),
            ),
            const SizedBox(
              height: 5,
            ),
            Container(
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                // border: Border.all(
                //     color: AppColors.h8C8C8C.withOpacity(0.4), width: 0.5),
              ),
              child: Row(
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        image: DecorationImage(
                            image: NetworkImage(model.courseShema?.courseThumnail ?? ''), fit: BoxFit.cover)),
                  ),
                  const SizedBox(
                    width: 7,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          model.courseShema?.courseName ?? '',
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: 14, color: Colors.black.withOpacity(0.7), fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        const Row(
                          children: [
                            Icon(
                              Icons.person,
                              color: AppColors.h8C8C8C,
                              size: 18,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              'Nguyễn Tấn Phiên',
                              style: TextStyle(color: AppColors.h8C8C8C, fontSize: 12, fontWeight: FontWeight.w400),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              '${NumberFormat.decimalPattern().format(model.courseShema?.coursePrice ?? 0)} VND',
                              style: const TextStyle(
                                  color: AppColors.blue_246BFD, fontSize: 16, fontWeight: FontWeight.w500),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Container(
                              // width: 50,
                              padding: const EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20), color: Colors.amber.withOpacity(0.2)),
                              child: const Text('Bán chạy',
                                  style: TextStyle(fontSize: 12, color: Colors.amber, fontWeight: FontWeight.w400)),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 50,
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(50), color: AppColors.hE2E2E2),
                      child: const Center(
                        child: Text(
                          'Hủy',
                          style: TextStyle(color: AppColors.blue_246BFD, fontSize: 16, fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 15,
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      provider?.deleteCart(model.id, context, index ?? 0);
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 50,
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(50), color: AppColors.blue_246BFD),
                      child: const Center(
                        child: Text(
                          'Xóa',
                          style: TextStyle(color: AppColors.white, fontSize: 16, fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
