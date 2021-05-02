import 'dart:io';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ungunseen/utility/dialog.dart';
import 'package:ungunseen/utility/my_constant.dart';
import 'package:ungunseen/widgets/show_progress.dart';

class AddPost extends StatefulWidget {
  @override
  _AddPostState createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> {
  List<File> files = [];
  File file;
  String post, detail;
  List<String> pathImages = [];
  bool upload = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    for (var i = 0; i < 4; i++) {
      files.add(null);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Post'),
      ),
      body: Stack(
        children: [
          buildContent(),
          upload ? ShowProgress() : SizedBox(),
        ],
      ),
    );
  }

  Center buildContent() {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          children: [
            buildPost(),
            buildImage(),
            buildContral(),
            buildDetail(),
            buildAddPost(),
          ],
        ),
      ),
    );
  }

  bool checkAllImage() {
    bool result = true; // file[] != null
    for (var item in files) {
      if (item == null) {
        result = false;
      }
    }
    return result;
  }

  Future<Null> processUploadAndInsert() async {
    setState(() {
      upload = true;
    });

    String apiSaveData = '${MyConstant.domain}/ungunseen/saveFile.php';

    for (var item in files) {
      int i = Random().nextInt(1000000);
      String nameFile = 'post$i.jpg';

      try {
        Map<String, dynamic> map = Map();
        map['file'] =
            await MultipartFile.fromFile(item.path, filename: nameFile);
        FormData formData = FormData.fromMap(map);
        await Dio().post(apiSaveData, data: formData).then((value) async {
          pathImages.add('/ungunseen/postImage/$nameFile');
          print('Upload Success ==>$nameFile');

          if (pathImages.length == 4) {
            String apiInsert =
                '${MyConstant.domain}/ungunseen/insertPost.php?isAdd=true&title=$post&path=${pathImages.toString()}&detail=$detail';
            await Dio().get(apiInsert).then((value) => Navigator.pop(context));
          }
        });
      } catch (e) {}
    }
  }

  Container buildAddPost() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 16),
      width: 250,
      child: ElevatedButton(
        onPressed: () {
          if ((post?.isEmpty ?? true) || (detail?.isEmpty ?? true)) {
            normalDialog(context, 'Have Space ?', 'Please Fill Every Blank');
          } else if (checkAllImage()) {
            processUploadAndInsert();
          } else {
            normalDialog(
                context, 'รูปภาพไม่ครบ', 'กรุณาเลือกรูปภาพ ให้ครบ 4 รูป');
          }
        },
        child: Text('Add Post'),
      ),
    );
  }

  Future<Null> takeImage(ImageSource source, int index) async {
    try {
      var result = await ImagePicker().getImage(
        source: source,
        maxWidth: 800,
        maxHeight: 800,
      );
      setState(() {
        files[index] = File(result.path);
        file = files[index];
      });
    } catch (e) {}
  }

  Future<Null> confirmDialog(int index) async {
    showDialog(
      context: context,
      builder: (context) => SimpleDialog(
        title: ListTile(
          leading: Icon(Icons.add_a_photo),
          title: Text('Choose Source Image${index + 1}'),
          subtitle: Text('Please Tap Camera or Gallery'),
        ),
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  takeImage(ImageSource.camera, index);
                },
                child: Text('Camera'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  takeImage(ImageSource.gallery, index);
                },
                child: Text('Gallery'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Cancel'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Container buildContral() {
    return Container(
      width: 250,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          files[0] == null
              ? IconButton(
                  icon: Icon(
                    Icons.add_a_photo,
                    size: 36,
                  ),
                  onPressed: () => confirmDialog(0),
                )
              : GestureDetector(
                  onLongPress: () => confirmDialog(0),
                  onTap: () {
                    setState(() {
                      file = files[0];
                    });
                  },
                  child: Container(
                    width: 36,
                    height: 36,
                    child: Image.file(
                      files[0],
                    ),
                  ),
                ),
          files[1] == null
              ? IconButton(
                  icon: Icon(
                    Icons.add_a_photo,
                    size: 36,
                  ),
                  onPressed: () => confirmDialog(1),
                )
              : GestureDetector(
                  onTap: () {
                    setState(() {
                      file = files[1];
                    });
                  },
                  child: Container(
                    width: 36,
                    height: 36,
                    child: Image.file(
                      files[1],
                    ),
                  ),
                ),
          files[2] == null
              ? IconButton(
                  icon: Icon(
                    Icons.add_a_photo,
                    size: 36,
                  ),
                  onPressed: () => confirmDialog(2),
                )
              : GestureDetector(
                  onTap: () {
                    setState(() {
                      file = files[2];
                    });
                  },
                  child: Container(
                    width: 36,
                    height: 36,
                    child: Image.file(
                      files[2],
                    ),
                  ),
                ),
          files[3] == null
              ? IconButton(
                  icon: Icon(
                    Icons.add_a_photo,
                    size: 36,
                  ),
                  onPressed: () => confirmDialog(3),
                )
              : GestureDetector(
                  onTap: () {
                    setState(() {
                      file = files[3];
                    });
                  },
                  child: Container(
                    width: 36,
                    height: 36,
                    child: Image.file(
                      files[3],
                    ),
                  ),
                ),
        ],
      ),
    );
  }

  Container buildImage() {
    return Container(
        margin: EdgeInsets.symmetric(vertical: 16),
        width: 250,
        height: 200,
        child:
            file == null ? Image.asset('images/image.png') : Image.file(file));
  }

  Container buildPost() {
    return Container(
      width: 250,
      child: TextField(
        onChanged: (value) => post = value.trim(),
        decoration: InputDecoration(labelText: 'Post :'),
      ),
    );
  }

  Container buildDetail() {
    return Container(
      width: 250,
      child: TextField(
        onChanged: (value) => detail = value.trim(),
        decoration: InputDecoration(labelText: 'Detail Post :'),
      ),
    );
  }
}
