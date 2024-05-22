import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:kltn/src/base/base_page.dart';
import 'package:kltn/src/components/paginate.dart';
import 'package:kltn/src/page/detail_top_mentor/detail_top_mentor_vm.dart';
import 'package:kltn/src/page/detail_top_mentor/widget/loading_widget.dart';
import 'package:kltn/src/utils/app_colors.dart';

import '../detail_mentor/detail_mentor_page.dart';

class DetailTopMentorPage extends StatefulWidget {
  const DetailTopMentorPage({super.key});

  @override
  State<DetailTopMentorPage> createState() => _DetailTopMentorPageState();
}

class _DetailTopMentorPageState extends State<DetailTopMentorPage> with MixinBasePage<DetailTopMentorVM> {
  @override
  Widget build(BuildContext context) {
    return builder(
      () => Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          toolbarHeight: 60,
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
                        Navigator.pop(context);
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
            padding: EdgeInsets.only(left: MediaQuery.of(context).size.width / 5.5),
            child: const Text(
              'Top giảng viên',
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
          child: Paginate(
            onRefresh: () {
              provider.fetchAllMentor(isRefresh: true);
            },
            refreshController: provider.refreshMentorController,
            enablePullDown: true,
            enablePullUp: true,
            onLoading: () {
              provider.fetchAllMentor(isRefresh: false);
            },
            child: provider.isLoading
                ? const LoadingWidget()
                : Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: provider.listMentor.isNotEmpty
                        ? ListView.builder(
                            itemCount: provider.listMentor.length,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                behavior: HitTestBehavior.translucent,
                                onTap: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => DetailMentorPage(
                                        idMentor: provider.listMentor[index].id ?? '',
                                      ),
                                    )),
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 15, left: 15, bottom: 15),
                                  child: Row(
                                    children: [
                                      Container(
                                        width: 60,
                                        height: 60,
                                        padding: const EdgeInsets.all(5),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(50),
                                          border: Border.all(color: AppColors.blue_246BFD, width: 2),
                                        ),
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(50),
                                          child: (provider.listMentor[index].userAvatar ?? '').isEmpty
                                              ? Image.asset(
                                                  'assets/image/logo.png',
                                                  fit: BoxFit.contain,
                                                )
                                              : CachedNetworkImage(
                                                  imageUrl: provider.listMentor[index].userAvatar ?? '',
                                                  fit: BoxFit.cover,
                                                  placeholder: (context, url) => const Center(
                                                    child: CircularProgressIndicator(),
                                                  ),
                                                  errorWidget: (context, url, error) => const Icon(Icons.error),
                                                ),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 8,
                                      ),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            provider.listMentor[index].userName ?? "",
                                            style: const TextStyle(
                                                fontSize: 16, color: AppColors.h333333, fontWeight: FontWeight.w600),
                                          ),
                                          const SizedBox(
                                            height: 4,
                                          ),
                                          // const Text(
                                          //   'CNTT',
                                          //   style: TextStyle(
                                          //       fontSize: 10, color: AppColors.h9497AD, fontWeight: FontWeight.w400),
                                          // ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          )
                        : const Center(
                            child: Text(
                              'Không có dữ liệu',
                              style: TextStyle(color: Colors.black, fontSize: 14),
                            ),
                          ),
                  ),
          ),
        ),
      ),
    );
  }

  @override
  DetailTopMentorVM create() {
    return DetailTopMentorVM();
  }

  @override
  void initialise(BuildContext context) {}
}
