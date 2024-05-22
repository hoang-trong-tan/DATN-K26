import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:kltn/src/base/base_page.dart';
import 'package:kltn/src/model/quiz_title_model.dart';
import 'package:kltn/src/page/video/video_vm.dart';
import 'package:kltn/src/page/video/widget/answer_and_question_widget.dart';
import 'package:kltn/src/page/video/widget/document_widget.dart';
import 'package:kltn/src/page/video/widget/quiz_widget.dart';
import 'package:kltn/src/utils/app_colors.dart';
import 'package:video_player/video_player.dart';

class VideoPage extends StatefulWidget {
  final String url;
  final String idCourse;
  final String idVideo;
  final bool isView;
  final List<QuizTitleModel> idVideoSession;

  const VideoPage(
      {Key? key,
      required this.url,
      required this.idCourse,
      required this.idVideo,
      required this.idVideoSession,
      required this.isView})
      : super(key: key);

  @override
  State<VideoPage> createState() => _VideoWidgetState();
}

class _VideoWidgetState extends State<VideoPage> with MixinBasePage<VideoVM> {
  @override
  void dispose() {
    super.dispose();
    provider.chewieController.dispose();
    provider.chewieController.videoPlayerController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return builder(
      () => WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: widget.url.isEmpty && provider.checkView
            ? const Scaffold(
                body: Center(
                child: CircularProgressIndicator(
                  backgroundColor: AppColors.blue_246BFD,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              ))
            : widget.idCourse.isNotEmpty
                ? DefaultTabController(
                    length: 3,
                    child: SafeArea(
                      child: Scaffold(
                        backgroundColor: Colors.white,
                        resizeToAvoidBottomInset: false,
                        body: Column(
                          children: [
                            Stack(
                              children: [
                                Center(
                                  child: AspectRatio(
                                    aspectRatio: 16 / 9,
                                    child: Chewie(
                                      controller: provider.chewieController,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 15, top: 10),
                                  child: Container(
                                    height: 40,
                                    width: 40,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    child: IconButton(
                                      onPressed: () {
                                        Navigator.pop(context, provider.checkProcess);
                                      },
                                      icon: const Icon(
                                        Icons.arrow_back,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              color: Colors.white,
                              child: TabBar(
                                onTap: (value) {
                                  setState(() {
                                    provider.index = value;
                                  });
                                },
                                indicatorPadding: const EdgeInsets.only(top: 43),
                                indicatorWeight: 0.1,
                                indicator: const BoxDecoration(
                                  color: AppColors.blue_246BFD,
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(5),
                                    topRight: Radius.circular(5),
                                  ),
                                ),
                                tabs: [
                                  Tab(
                                    child: Text(
                                      'Hỏi & đáp',
                                      style: TextStyle(
                                        color: provider.index == 0 ? AppColors.blue_246BFD : AppColors.h434343,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                  Tab(
                                    child: Text(
                                      'Bài tập',
                                      style: TextStyle(
                                        color: provider.index == 1 ? AppColors.blue_246BFD : AppColors.h434343,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                  Tab(
                                    child: Text(
                                      'Tài liệu',
                                      style: TextStyle(
                                        color: provider.index == 2 ? AppColors.blue_246BFD : AppColors.h434343,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.all(15),
                              child: provider.index == 0
                                  ? AnswerAndQuestionWidget(provider: provider)
                                  : provider.index == 1
                                      ? QuizWidget(
                                          provider: provider,
                                        )
                                      : DocumentWidget(provider: provider),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                : Scaffold(
                    backgroundColor: Colors.black,
                    body: Stack(
                      children: [
                        Center(
                          child: AspectRatio(
                            aspectRatio: 16 / 9,
                            child: Chewie(
                              controller: provider.chewieController,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 15, top: 50),
                          child: Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: IconButton(
                              onPressed: () {
                                Navigator.pop(context, provider.checkProcess);
                              },
                              icon: const Icon(
                                Icons.arrow_back,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
      ),
    );
  }

  @override
  VideoVM create() {
    return VideoVM();
  }

  @override
  Future<void> initialise(BuildContext context) async {
    provider.idCourse = widget.idCourse;
    provider.idVideo = widget.idVideo;
    provider.quizTitleModel = widget.idVideoSession;
    int timeParse = 0;
    bool checkDuration = false;
    Future.delayed(
      Duration(milliseconds: widget.url != '' ? 0 : 1000),
      () {
        setState(() {
          if (widget.url != '') {
            // ignore: deprecated_member_use
            provider.videoPlayerController = VideoPlayerController.network(widget.url);
          } else {
            // ignore: deprecated_member_use
            provider.videoPlayerController = VideoPlayerController.network(provider.modelVideo.videoUrl ?? '');
          }
          provider.videoPlayerController.addListener(() {
            if (provider.videoPlayerController.value.isInitialized && !checkDuration) {
              Duration totalDuration = provider.videoPlayerController.value.duration;
              int totalSeconds = totalDuration.inSeconds;
              double time = totalSeconds * 0.8;
              timeParse = time.toInt();
              checkDuration = true;
            }
            if (!provider.checkProcess &&
                !widget.isView &&
                provider.videoPlayerController.value.position >= Duration(seconds: timeParse) &&
                checkDuration) {
              provider.checkProcess = true;
              provider.createProcess();
            }
          });

          provider.chewieController = ChewieController(
            videoPlayerController: provider.videoPlayerController,
            autoPlay: true,
            autoInitialize: true,
            showControls: true,
            aspectRatio: 16 / 9,
            showControlsOnInitialize: false,
            errorBuilder: (context, errorMessage) => Center(
              child: Text(
                errorMessage,
                style: const TextStyle(color: AppColors.blue_246BFD),
              ),
            ),
            placeholder: const Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.white,
              ),
            ),
            materialProgressColors: ChewieProgressColors(
              playedColor: AppColors.blue_246BFD,
              handleColor: Colors.white,
              backgroundColor: Colors.grey,
              bufferedColor: AppColors.blue_246BFD.withOpacity(0.2),
            ),
            optionsTranslation: OptionsTranslation(
              playbackSpeedButtonText: 'Tốc độ phát',
              cancelButtonText: 'Hủy',
            ),
            looping: false,
          );
        });
      },
    );
  }
}
