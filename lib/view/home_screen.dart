import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pingolearn_round/Api/Api/api_response.dart';
import 'package:pingolearn_round/model/response_model/comments_response_model.dart';
import 'package:pingolearn_round/view_model/comments_data_view_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  CommentsDataViewModel commentsDataViewModel =
      Get.put(CommentsDataViewModel());

  @override
  void initState() {
    commentsDataViewModel.initConfig();
    commentsDataViewModel.commentsDataViewModel();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFF5F9FD),
      appBar: AppBar(
        backgroundColor: Color(0xFF0C54BE),
        title: Text(
          'Comments',
          style: TextStyle(
            fontFamily: 'Poppins-Bold',
            color: Color(0xFFFF5F9FD),
            fontWeight: FontWeight.w700,
          ),
        ),
        elevation: 0,
      ),
      body: GetBuilder<CommentsDataViewModel>(
        builder: (controller) {
          print('--isHidden--${controller.isHidden}');
          print(
              '==controller.apiResponse.status==${controller.apiResponse.status}');
          if (controller.apiResponse.status == Status.COMPLETE) {
            List<CommentResponseModel> itemList = controller.apiResponse.data;

            return Container(
              padding: const EdgeInsets.only(right: 15, left: 15, top: 15),
              color: Color(0xFFFF5F9FD),
              child: Column(children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: itemList.length,
                    itemBuilder: (context, index) {
                      CommentResponseModel item = itemList[index];
                      return Column(
                        children: [
                          Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10)),
                            child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CircleAvatar(
                                      child: Text(
                                        '${item.id}',
                                        style: TextStyle(
                                          fontFamily: 'Poppins-Bold',
                                          color: Colors.black,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                      backgroundColor: Color(0xFFCED3DC)),
                                  SizedBox(width: 10),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Text('Name : ',
                                                style: TextStyle(
                                                  fontFamily: 'Poppins-Regular',
                                                  color: Color(0xFFCED3DC),
                                                  fontStyle: FontStyle.italic,
                                                )),
                                            Expanded(
                                              child: Text(
                                                '${item.name}',
                                                maxLines: 1,
                                                style: TextStyle(
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  fontFamily: 'Poppins-Bold',
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 5),
                                        Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Text('Email : ',
                                                style: TextStyle(
                                                  fontFamily: 'Poppins-Regular',
                                                  color: Color(0xFFCED3DC),
                                                  fontStyle: FontStyle.italic,
                                                )),
                                            Expanded(
                                              child: Text(
                                                controller.isHidden
                                                    ? "${item.email}"
                                                        .replaceRange(
                                                            3,
                                                            "${item.email}"
                                                                .indexOf("@"),
                                                            "****")
                                                    : '${item.email}',
                                                maxLines: 1,
                                                style: TextStyle(
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  fontFamily: 'Poppins-Bold',
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 5),
                                        Text(
                                          '${item.body}',
                                          softWrap: true,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            fontFamily: 'Poppins-Regular',
                                          ),
                                          maxLines: 4,
                                        )
                                      ],
                                    ),
                                  )
                                ]),
                          ),
                          SizedBox(
                            height: 15,
                          )
                        ],
                      );
                    },
                  ),
                )
              ]),
            );
          } else if (controller.apiResponse.status == Status.COMPLETE) {
            return Center(child: Text('Server Issue'));
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
