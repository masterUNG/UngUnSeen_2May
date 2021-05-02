import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:ungunseen/models/post_model.dart';
import 'package:ungunseen/states/show_detail.dart';
import 'package:ungunseen/utility/my_constant.dart';
import 'package:ungunseen/widgets/show_progress.dart';
import 'package:ungunseen/widgets/show_title.dart';

class ShowListPost extends StatefulWidget {
  @override
  _ShowListPostState createState() => _ShowListPostState();
}

class _ShowListPostState extends State<ShowListPost> {
  bool load = true;
  bool haveData;
  List<PostModel> postModels = [];
  List<String> images = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    readData();
  }

  String findImage(PostModel model) {
    String result = model.path; // ['aa','bb','cc','dd'] ==> String
    result = result.substring(1, result.length - 1); // 'aa','bb','cc','dd'
    List<String> strings = result.split(','); //['aa','bb','cc','dd'] ==> array
    int index = 0;
    for (var item in strings) {
      strings[index] = item.trim();
      index++;
    }
    return strings[0];
  }

  Future<Null> readData() async {
    if (postModels.length != 0) {
      postModels.clear();
    }

    String api = '${MyConstant.domain}/ungunseen/getAllPost.php';
    await Dio().get(api).then((value) {
      if (value.toString() == 'null') {
        setState(() {
          haveData = false;
          load = false;
        });
      } else {
        for (var item in json.decode(value.data)) {
          PostModel model = PostModel.fromMap(item);
          setState(() {
            postModels.add(model);
          });
        }

        setState(() {
          haveData = true;
          load = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, '/addPost')
            .then((value) => readData()),
        child: Text('Add'),
      ),
      body: load
          ? ShowProgress()
          : haveData
              ? ListView.builder(
                  itemCount: postModels.length,
                  itemBuilder: (context, index) => GestureDetector(
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              ShowDetail(postModel: postModels[index]),
                        )),
                    child: Card(
                      color:
                          index % 2 == 0 ? Colors.grey[100] : Colors.grey[300],
                      child: Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: Container(
                              padding: EdgeInsets.all(8),
                              height: 120,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  ShowTitle(
                                      title: postModels[index].title,
                                      indexStyle: 1),
                                  ShowTitle(
                                      title: postModels[index].detail,
                                      indexStyle: 2),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: CachedNetworkImage(
                                imageUrl:
                                    '${MyConstant.domain}${findImage(postModels[index])}',
                                    placeholder: (context, url) => ShowProgress(),
                                    errorWidget: (context, url, error) => Image.asset('images/question.png'),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              : Center(child: ShowTitle(title: 'No Post', indexStyle: 0)),
    );
  }
}
