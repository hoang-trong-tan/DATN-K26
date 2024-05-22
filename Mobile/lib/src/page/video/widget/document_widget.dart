import 'package:flutter/material.dart';
import 'package:kltn/src/page/video/video_vm.dart';

class DocumentWidget extends StatefulWidget {
  const DocumentWidget({super.key, required this.provider});
  final VideoVM provider;

  @override
  State<DocumentWidget> createState() => _QuizWidgetState();
}

class _QuizWidgetState extends State<DocumentWidget> {
  @override
  Widget build(BuildContext context) {
    return widget.provider.listDocument.isNotEmpty
        ? SizedBox(
            height: 450,
            child: ListView.separated(
              itemCount: widget.provider.listDocument.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    widget.provider.downloadDocument(context, widget.provider.listDocument[index]);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          widget.provider.listDocument[index],
                          maxLines: 3,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      // widget.provider.fileExists
                      //     ? const Icon(
                      //         Icons.save,
                      //         color: Colors.green,
                      //       )
                      //     : widget.provider.dowloading
                      //         ? Stack(
                      //             alignment: Alignment.center,
                      //             children: [
                      //               CircularProgressIndicator(
                      //                 value: widget.provider.progress,
                      //                 strokeWidth: 3,
                      //                 backgroundColor: Colors.grey,
                      //                 valueColor: const AlwaysStoppedAnimation<Color>(Colors.blue),
                      //               ),
                      //               Text(
                      //                 (widget.provider.progress * 100).toStringAsFixed(2),
                      //                 style: const TextStyle(fontSize: 12),
                      //               )
                      //             ],
                      //           )
                      //         :
                      // GestureDetector(
                      //   onTap: () {
                      //     OpenFile.open('/storage/emulated/0/Android/data/com.example.kltn/files/files/3.ProductBacklog_DaDuocChinhSuaBFD.docx');
                      //     print("fff ${widget.provider.filePath}");
                      //   },
                      //   child: const Icon(
                      //     Icons.save,
                      //     color: Colors.green,
                      //   ),
                      // ),
                      const Icon(Icons.document_scanner),
                      // const Icon(
                      //   Icons.quiz_outlined,
                      //   color: AppColors.blue_246BFD,
                      // ),
                    ],
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return Divider(
                  color: Colors.grey.withOpacity(0.5),
                );
              },
            ),
          )
        : const Padding(
            padding: EdgeInsets.only(top: 240),
            child: Center(
              child: Text(
                'Không có tài liệu',
                style: TextStyle(color: Colors.black, fontSize: 14),
              ),
            ),
          );
  }
}
