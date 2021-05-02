import 'package:flutter/material.dart';
import 'package:ungunseen/models/post_model.dart';
import 'package:ungunseen/utility/my_constant.dart';
import 'package:ungunseen/widgets/show_title.dart';

class ShowDetail extends StatefulWidget {
  final PostModel postModel;
  ShowDetail({@required this.postModel});

  @override
  _ShowDetailState createState() => _ShowDetailState();
}

class _ShowDetailState extends State<ShowDetail> {
  PostModel model;
  List<String> strings;
  int index = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    model = widget.postModel;

    createArray();
  }

  void createArray() {
    String string = model.path;
    string = string.substring(1, string.length - 1);
    strings = string.split(',');
    int i = 0;
    for (var item in strings) {
      strings[i] = item.trim();
      i++;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(model.title),
      ),
      body: Center(
        child: Column(
          children: [
            ShowTitle(title: model.detail, indexStyle: 1),
            buildImage(),
            Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      index = 0;
                    });
                  },
                  child: Container(
                    width: 48,
                    height: 48,
                    child: Image.network(
                      '${MyConstant.domain}${strings[0]}',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      index = 1;
                    });
                  },
                  child: Container(
                    width: 48,
                    height: 48,
                    child: Image.network(
                      '${MyConstant.domain}${strings[1]}',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      index = 2;
                    });
                  },
                  child: Container(
                    width: 48,
                    height: 48,
                    child: Image.network(
                      '${MyConstant.domain}${strings[2]}',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      index = 3;
                    });
                  },
                  child: Container(
                    width: 48,
                    height: 48,
                    child: Image.network(
                      '${MyConstant.domain}${strings[3]}',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
            ), ///########## Here
          ],
        ),
      ),
    );
  }

  Container buildImage() {
    return Container(
      width: 250,
      height: 250,
      child: Image.network('${MyConstant.domain}${strings[index]}'),
    );
  }
}
