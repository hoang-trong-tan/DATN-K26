import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:kltn/src/page/detail_mentor/detail_mentor_page.dart';
import 'package:kltn/src/page/detail_top_mentor/detail_top_mentor_page.dart';
import 'package:kltn/src/page/home/home_vm.dart';
import 'package:kltn/src/utils/app_colors.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shimmer/shimmer.dart';

import '../../../components/paginate.dart';

class TopMentorWidget extends StatefulWidget {
  const TopMentorWidget({super.key, required this.provider});
  final HomeVM provider;

  @override
  State<TopMentorWidget> createState() => _TopMentorWidgetState();
}

class _TopMentorWidgetState extends State<TopMentorWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        children: [
          const SizedBox(
            height: 5,
          ),
          Row(
            children: [
              const Text(
                'Top giảng viên',
                style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w600),
              ),
              const Spacer(),
              !widget.provider.isLoadingTopMentor
                  ? GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const DetailTopMentorPage(),
                          ),
                        );
                      },
                      child: const Text(
                        'Xem tất cả',
                        style: TextStyle(fontSize: 12, color: Colors.amber, fontWeight: FontWeight.w400),
                      ))
                  : Shimmer.fromColors(
                      baseColor: Colors.grey.shade300,
                      highlightColor: Colors.grey.shade100,
                      child: Container(
                        height: 10,
                        width: 50,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(
                            10,
                          ),
                        ),
                      ),
                    ),
            ],
          ),
          // const SizedBox(
          //   height: 20,
          // ),
          SizedBox(
            height: (MediaQuery.of(context).size.width / 4) + 20,
            child: Paginate(
              onRefresh: () {
                widget.provider.fetchAllMentor(isRefresh: true);
              },
              refreshController: widget.provider.refreshMentorController,
              enablePullDown: true,
              enablePullUp: widget.provider.isEnablePullUpMentor,
              scrollDirection: Axis.horizontal,
              header: const ClassicHeader(
                idleText: '',
                releaseText: '',
                completeText: '',
                refreshingText: '',
                failedText: '',
                canTwoLevelText: '',
              ),
              footer: const ClassicFooter(
                loadingText: '.',
                canLoadingText: '',
                failedText: '',
                idleText: '',
                idleIcon: SizedBox(),
                noDataText: '',
              ),
              onLoading: () {
                widget.provider.fetchAllMentor(isRefresh: false);
              },
              child: !widget.provider.isLoadingTopMentor
                  ? SizedBox(
                      height: (MediaQuery.of(context).size.width / 4) + 20,
                      child: ScrollConfiguration(
                        behavior: const ScrollBehavior().copyWith(overscroll: false),
                        child: widget.provider.listMentor.isNotEmpty
                            ? ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                itemCount: widget.provider.listMentor.length,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.only(right: 20, top: 20),
                                    child: InkResponse(
                                      splashColor: Colors.transparent,
                                      highlightColor: Colors.transparent,
                                      onTap: () => Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => DetailMentorPage(
                                              idMentor: widget.provider.listMentor[index].id ?? '',
                                            ),
                                          )),
                                      child: Column(
                                        children: [
                                          Container(
                                            height: (MediaQuery.of(context).size.width - 90) / 4,
                                            width: (MediaQuery.of(context).size.width - 90) / 4,
                                            padding: const EdgeInsets.all(5),
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(50),
                                              border: Border.all(color: AppColors.blue_246BFD, width: 2),
                                            ),
                                            child: ClipRRect(
                                              borderRadius: BorderRadius.circular(50),
                                              child: (widget.provider.listMentor[index].userAvatar ?? '').isEmpty
                                                  ? Image.asset(
                                                      'assets/image/logo.png',
                                                      fit: BoxFit.contain,
                                                    )
                                                  : CachedNetworkImage(
                                                      imageUrl: widget.provider.listMentor[index].userAvatar ?? '',
                                                      fit: BoxFit.cover,
                                                      placeholder: (context, url) => const Center(
                                                        child: CircularProgressIndicator(),
                                                      ),
                                                      errorWidget: (context, url, error) => const Icon(Icons.error),
                                                    ),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 7,
                                          ),
                                          SizedBox(
                                            width: (MediaQuery.of(context).size.width - 90) / 4,
                                            child: Text(
                                              widget.provider.listMentor[index].userName ?? '',
                                              textAlign: TextAlign.center,
                                              overflow: TextOverflow.ellipsis,
                                              style: const TextStyle(
                                                  color: Colors.black, fontSize: 12, fontWeight: FontWeight.w400),
                                            ),
                                          )
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
                    )
                  : SizedBox(
                      height: (MediaQuery.of(context).size.width / 4) + 20,
                      child: ListView.builder(
                        physics: const AlwaysScrollableScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        itemCount: 10,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: EdgeInsets.only(right: (10 - index == 1) ? 0 : 20, top: 20),
                            child: Column(
                              children: [
                                Shimmer.fromColors(
                                  baseColor: Colors.grey.shade300,
                                  highlightColor: Colors.grey.shade100,
                                  child: Container(
                                    height: (MediaQuery.of(context).size.width - 90) / 4,
                                    width: (MediaQuery.of(context).size.width - 90) / 4,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(60),
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 7),
                                Shimmer.fromColors(
                                  baseColor: Colors.grey.shade300,
                                  highlightColor: Colors.grey.shade100,
                                  child: Container(
                                    height: 10,
                                    width: 50,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(
                                        10,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
