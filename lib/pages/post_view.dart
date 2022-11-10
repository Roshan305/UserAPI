import 'dart:html';

import 'package:flutter/material.dart';
import 'package:intern_project/pages/detail_view.dart';
import 'package:http/http.dart' as http;
import 'data_model.dart';

class PostView extends StatefulWidget {
  @override
  _PostViewState createState() => _PostViewState();
}

Future<DataModel?> submitData(String comment) async{
  var response = await http.post(Uri.https('jsonplaceholder.typicode.com/posts', 'jsonplaceholder.typicode.com/posts/%7Bpost_id%7D/comments'), 
  body: {"Comment" : comment});
  var data = response.body;
  print(data);

  if(response.statusCode == 201) {
    String responseString = response.body;
    dataModelFromJson(responseString);
  }
  else return null;
}

class _PostViewState extends State<PostView> {
  late DataModel _dataModel;
  TextEditingController commentController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      centerTitle: true,
      title: Text("HTTP Post Method"),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(), hintText: 'Enter Comment here'),
                  controller: commentController,
              ),
              SizedBox(height: 10,),
              ElevatedButton(onPressed: () async {
                String comment = commentController.text;

                DataModel? data = await submitData(comment);

                setState(() {
                  _dataModel = data!; 
                });
              }, child: Text("Submit"))
            ],
          ),
        ),
      )

    );

}
}
