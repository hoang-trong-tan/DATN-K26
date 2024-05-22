import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kltn/src/base/base_page.dart';
import 'package:kltn/src/components/paginate.dart';
import 'package:kltn/src/page/book_mark/book_mark_vm.dart';
import 'package:kltn/src/page/book_mark/widget/bottom_remove.dart';
import 'package:kltn/src/page/detail_course/detail_course_page.dart';
import 'package:shimmer/shimmer.dart';

import '../../utils/app_colors.dart';

class BookMarkPage extends StatefulWidget {
  const BookMarkPage({super.key});

  @override
  State<BookMarkPage> createState() => _BookMarkPageState();
}

class _BookMarkPageState extends State<BookMarkPage> with MixinBasePage<BookMarkVM> {
  @override
  Widget build(BuildContext context) {
    return builder(
      () => Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
          title: const Center(
            child: Text(
              'Khóa học yêu thích',
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.only(left: 15),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 30,
                  child: ScrollConfiguration(
                    behavior: const ScrollBehavior().copyWith(overscroll: false),
                    child: !provider.isLoadingCatelory
                        ? ListView.builder(
                            itemCount: provider.listTypeModel.length,
                            scrollDirection: Axis.horizontal,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  setState(() {
                                    provider.index = index;
                                    provider.getCart(id: provider.listTypeModel[index].id);
                                  });
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 15),
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                    decoration: BoxDecoration(
                                      color: provider.index == index ? AppColors.blue_246BFD : Colors.white,
                                      borderRadius: BorderRadius.circular(20),
                                      border: Border.all(
                                        color: AppColors.h8C8C8C.withOpacity(0.4),
                                        width: 0.5,
                                      ),
                                    ),
                                    child: Center(
                                      child: Text(
                                        provider.listTypeModel[index].typeName ?? '',
                                        style: TextStyle(
                                            fontSize: 12,
                                            color: provider.index == index ? Colors.white : Colors.black,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          )
                        : ListView.builder(
                            itemCount: 10,
                            scrollDirection: Axis.horizontal,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.only(right: 15),
                                child: Shimmer.fromColors(
                                  baseColor: Colors.grey.shade300,
                                  highlightColor: Colors.grey.shade100,
                                  child: Container(
                                    width: 50,
                                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Expanded(
                  child: ScrollConfiguration(
                    behavior: const ScrollBehavior().copyWith(overscroll: false),
                    child: Paginate(
                      onRefresh: () {
                        provider.getCart(id: provider.listTypeModel[provider.index].id);
                      },
                      refreshController: provider.refreshController,
                      enablePullDown: true,
                      onLoading: () {},
                      child: CustomScrollView(
                        controller: provider.scrollController,
                        slivers: [
                          SliverToBoxAdapter(
                              child: !provider.isLoadingCourse
                                  ? provider.listCart.isNotEmpty
                                      ? ListView.builder(
                                          itemCount: provider.listCart.length,
                                          shrinkWrap: true,
                                          controller: provider.scrollController,
                                          padding: EdgeInsets.zero,
                                          itemBuilder: (context, index) {
                                            return GestureDetector(
                                              onTap: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) => DetailCoursePage(
                                                        id: provider.listCart[index].courseShema?.id ?? ''),
                                                  ),
                                                );
                                              },
                                              child: Padding(
                                                padding: const EdgeInsets.only(bottom: 10, right: 15),
                                                child: Container(
                                                  padding: const EdgeInsets.all(5),
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(5),
                                                    border: Border.all(
                                                        color: AppColors.h8C8C8C.withOpacity(0.4), width: 0.5),
                                                  ),
                                                  child: Stack(
                                                    children: [
                                                      Positioned(
                                                          right: 0,
                                                          top: 0,
                                                          child: IconButton(
                                                              onPressed: () {
                                                                showModalBottomSheet(
                                                                  context: context,
                                                                  backgroundColor: Colors.transparent,
                                                                  builder: (context) {
                                                                    return RemoveWidget(
                                                                      model: provider.listCart[index],
                                                                      provider: provider,
                                                                      index: index,
                                                                    );
                                                                  },
                                                                );
                                                              },
                                                              icon: const Icon(
                                                                Icons.bookmark,
                                                                color: AppColors.blue_246BFD,
                                                              ))),
                                                      Row(
                                                        children: [
                                                          Container(
                                                            width: 100,
                                                            height: 100,
                                                            decoration: BoxDecoration(
                                                                borderRadius: BorderRadius.circular(5),
                                                                image: DecorationImage(
                                                                    image: NetworkImage(provider.listCart[index]
                                                                            .courseShema?.courseThumnail ??
                                                                        ''),
                                                                    fit: BoxFit.cover)),
                                                          ),
                                                          const SizedBox(
                                                            width: 7,
                                                          ),
                                                          Column(
                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                            children: [
                                                              SizedBox(
                                                                width: 200,
                                                                child: Text(
                                                                  provider.listCart[index].courseShema?.courseName ??
                                                                      '',
                                                                  overflow: TextOverflow.ellipsis,
                                                                  style: TextStyle(
                                                                      fontSize: 14,
                                                                      color: Colors.black.withOpacity(0.7),
                                                                      fontWeight: FontWeight.w500),
                                                                ),
                                                              ),
                                                              const SizedBox(
                                                                height: 5,
                                                              ),
                                                              Row(
                                                                children: [
                                                                  const Icon(
                                                                    Icons.person,
                                                                    color: AppColors.h8C8C8C,
                                                                    size: 18,
                                                                  ),
                                                                  const SizedBox(
                                                                    width: 5,
                                                                  ),
                                                                  Text(
                                                                    provider.listCart[index].courseShema?.userTeacher
                                                                            ?.userName ??
                                                                        '',
                                                                    style: const TextStyle(
                                                                        color: AppColors.h8C8C8C,
                                                                        fontSize: 12,
                                                                        fontWeight: FontWeight.w400),
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
                                                                    '${NumberFormat.decimalPattern().format(provider.listCart[index].courseShema?.coursePrice ?? 0)} VND',
                                                                    style: const TextStyle(
                                                                        color: AppColors.blue_246BFD,
                                                                        fontSize: 16,
                                                                        fontWeight: FontWeight.w500),
                                                                  ),
                                                                  const SizedBox(
                                                                    width: 10,
                                                                  ),
                                                                  Container(
                                                                    // width: 50,
                                                                    padding: const EdgeInsets.all(4),
                                                                    decoration: BoxDecoration(
                                                                        borderRadius: BorderRadius.circular(20),
                                                                        color: Colors.amber.withOpacity(0.2)),
                                                                    child: Text(
                                                                        provider.typeCourse(provider.listCart[index]
                                                                                .courseShema?.courseType ??
                                                                            ''),
                                                                        style: const TextStyle(
                                                                            fontSize: 12,
                                                                            color: Colors.amber,
                                                                            fontWeight: FontWeight.w400)),
                                                                  ),
                                                                ],
                                                              ),
                                                            ],
                                                          )
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                        )
                                      : const Padding(
                                          padding: EdgeInsets.only(top: 300),
                                          child: Center(
                                            child: Text(
                                              'Không có dữ liệu',
                                              style: TextStyle(color: Colors.black, fontSize: 14),
                                            ),
                                          ))
                                  : ListView.builder(
                                      itemCount: 10,
                                      shrinkWrap: true,
                                      controller: provider.scrollController,
                                      padding: EdgeInsets.zero,
                                      itemBuilder: (context, index) {
                                        return Padding(
                                          padding: const EdgeInsets.only(bottom: 10, right: 15),
                                          child: Container(
                                            padding: const EdgeInsets.all(5),
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(5),
                                              border: Border.all(color: AppColors.h8C8C8C.withOpacity(0.4), width: 0.5),
                                            ),
                                            child: Stack(
                                              children: [
                                                Positioned(
                                                  right: 0,
                                                  top: 0,
                                                  child: Shimmer.fromColors(
                                                    baseColor: Colors.grey.shade300,
                                                    highlightColor: Colors.grey.shade100,
                                                    child: Container(
                                                      width: 25,
                                                      height: 35,
                                                      decoration: BoxDecoration(
                                                          borderRadius: BorderRadius.circular(5), color: Colors.white),
                                                    ),
                                                  ),
                                                ),
                                                Row(
                                                  children: [
                                                    Shimmer.fromColors(
                                                      baseColor: Colors.grey.shade300,
                                                      highlightColor: Colors.grey.shade100,
                                                      child: Container(
                                                        width: 100,
                                                        height: 100,
                                                        decoration: BoxDecoration(
                                                          color: Colors.white,
                                                          borderRadius: BorderRadius.circular(5),
                                                        ),
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      width: 7,
                                                    ),
                                                    Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Shimmer.fromColors(
                                                          baseColor: Colors.grey.shade300,
                                                          highlightColor: Colors.grey.shade100,
                                                          child: Container(
                                                            width: 50,
                                                            height: 10,
                                                            decoration: BoxDecoration(
                                                                borderRadius: BorderRadius.circular(5),
                                                                color: Colors.white),
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                          height: 5,
                                                        ),
                                                        Shimmer.fromColors(
                                                          baseColor: Colors.grey.shade300,
                                                          highlightColor: Colors.grey.shade100,
                                                          child: Container(
                                                            width: 100,
                                                            height: 10,
                                                            decoration: BoxDecoration(
                                                                borderRadius: BorderRadius.circular(5),
                                                                color: Colors.white),
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                          height: 5,
                                                        ),
                                                        Row(
                                                          mainAxisAlignment: MainAxisAlignment.start,
                                                          children: [
                                                            Shimmer.fromColors(
                                                              baseColor: Colors.grey.shade300,
                                                              highlightColor: Colors.grey.shade100,
                                                              child: Container(
                                                                width: 100,
                                                                height: 10,
                                                                decoration: BoxDecoration(
                                                                    borderRadius: BorderRadius.circular(5),
                                                                    color: Colors.white),
                                                              ),
                                                            ),
                                                            const SizedBox(
                                                              width: 10,
                                                            ),
                                                            Shimmer.fromColors(
                                                              baseColor: Colors.grey.shade300,
                                                              highlightColor: Colors.grey.shade100,
                                                              child: Container(
                                                                width: 50,
                                                                height: 20,
                                                                padding: const EdgeInsets.all(4),
                                                                decoration: BoxDecoration(
                                                                    borderRadius: BorderRadius.circular(20),
                                                                    color: Colors.white),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    )
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                    )
                              // : ListView.builder(
                              //     itemCount: 10,
                              //     shrinkWrap: true,
                              //     controller: provider.scrollController,
                              //     padding: EdgeInsets.zero,
                              //     itemBuilder: (context, index) {
                              //       return Padding(
                              //         padding:
                              //             const EdgeInsets.only(top: 7,bottom:7,right:15),
                              //         child: Container(
                              //           padding: const EdgeInsets.all(5),
                              //           decoration: BoxDecoration(
                              //             borderRadius: BorderRadius.circular(5),
                              //             border: Border.all(
                              //                 color: AppColors.h8C8C8C
                              //                     .withOpacity(0.4),
                              //                 width: 0.5),
                              //           ),
                              //           child: Row(
                              //             children: [
                              //               Shimmer.fromColors(
                              //                 baseColor: Colors.grey.shade300,
                              //                 highlightColor: Colors.grey.shade100,
                              //                 child: Container(
                              //                   width: 100,
                              //                   height: 100,
                              //                   decoration: BoxDecoration(
                              //                       borderRadius:
                              //                           BorderRadius.circular(5),
                              //                       color: Colors.white),
                              //                 ),
                              //               ),
                              //               const SizedBox(
                              //                 width: 7,
                              //               ),
                              //               Column(
                              //                 crossAxisAlignment:
                              //                     CrossAxisAlignment.start,
                              //                 children: [
                              //                   Shimmer.fromColors(
                              //                     baseColor: Colors.grey.shade300,
                              //                     highlightColor:
                              //                         Colors.grey.shade100,
                              //                     child: Container(
                              //                       width: 30,
                              //                       height: 10,
                              //                       padding:
                              //                           const EdgeInsets.all(4),
                              //                       decoration: BoxDecoration(
                              //                           borderRadius:
                              //                               BorderRadius.circular(
                              //                                   20),
                              //                           color: Colors.white),
                              //                     ),
                              //                   ),
                              //                   const SizedBox(
                              //                     height: 5,
                              //                   ),
                              //                   Shimmer.fromColors(
                              //                     baseColor: Colors.grey.shade300,
                              //                     highlightColor:
                              //                         Colors.grey.shade100,
                              //                     child: Container(
                              //                       width: 70,
                              //                       height: 10,
                              //                       padding:
                              //                           const EdgeInsets.all(4),
                              //                       decoration: BoxDecoration(
                              //                         color: Colors.white,
                              //                         borderRadius:
                              //                             BorderRadius.circular(20),
                              //                       ),
                              //                     ),
                              //                   ),
                              //                   const SizedBox(
                              //                     height: 5,
                              //                   ),
                              //                   Shimmer.fromColors(
                              //                     baseColor: Colors.grey.shade300,
                              //                     highlightColor:
                              //                         Colors.grey.shade100,
                              //                     child: Container(
                              //                       width: 100,
                              //                       height: 10,
                              //                       padding:
                              //                           const EdgeInsets.all(4),
                              //                       decoration: BoxDecoration(
                              //                         color: Colors.white,
                              //                         borderRadius:
                              //                             BorderRadius.circular(20),
                              //                       ),
                              //                     ),
                              //                   ),
                              //                   const SizedBox(
                              //                     height: 5,
                              //                   ),
                              //                   Row(
                              //                     mainAxisAlignment:
                              //                         MainAxisAlignment.start,
                              //                     children: [
                              //                       Shimmer.fromColors(
                              //                         baseColor:
                              //                             Colors.grey.shade300,
                              //                         highlightColor:
                              //                             Colors.grey.shade100,
                              //                         child: Container(
                              //                           width: 150,
                              //                           height: 10,
                              //                           padding:
                              //                               const EdgeInsets.all(4),
                              //                           decoration: BoxDecoration(
                              //                             color: Colors.white,
                              //                             borderRadius:
                              //                                 BorderRadius.circular(
                              //                                     20),
                              //                           ),
                              //                         ),
                              //                       ),
                              //                       const SizedBox(
                              //                         width: 10,
                              //                       ),
                              //                       Shimmer.fromColors(
                              //                         baseColor:
                              //                             Colors.grey.shade300,
                              //                         highlightColor:
                              //                             Colors.grey.shade100,
                              //                         child: Container(
                              //                           width: 30,
                              //                           height: 10,
                              //                           padding:
                              //                               const EdgeInsets.all(4),
                              //                           decoration: BoxDecoration(
                              //                             color: Colors.white,
                              //                             borderRadius:
                              //                                 BorderRadius.circular(
                              //                                     20),
                              //                           ),
                              //                         ),
                              //                       ),
                              //                     ],
                              //                   ),
                              //                 ],
                              //               )
                              //             ],
                              //           ),
                              //         ),
                              //       );
                              //     },
                              //   ),
                              )
                        ],
                      ),
                    ),
                  ),
                ),
              ]),
        ),
      ),
    );
  }

  @override
  BookMarkVM create() {
    return BookMarkVM();
  }

  @override
  void initialise(BuildContext context) {}
}
