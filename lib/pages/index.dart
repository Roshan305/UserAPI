import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intern_project/pages/post_view.dart';
import 'package:intern_project/theme/colors.dart';
import 'package:http/http.dart' as http;
import 'package:intern_project/pages/detail_view.dart';
  
class IndexPage extends StatefulWidget {
  @override
  _IndexPageState createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  List users = [];
  bool isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.fetchUser();
  }

  Future fetchUser() async {
    setState(() {
      isLoading = true;
    });
    var url = "https://jsonplaceholder.typicode.com/posts";
    var response = await http.get(Uri.parse(url));
    if(response.statusCode == 200) {
      var items = json.decode(response.body);
      setState(() {
        users = items;
        isLoading = false;
      });
    } else {
      setState(() {
        users = [];
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Listing Users"),
        actions: <Widget>[
                 TextButton(
              style: ButtonStyle(
              foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
              backgroundColor: MaterialStateProperty.all<Color>(Colors.yellow),
        ),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => PostView()));
         },
        child: Text('Post'),
  
  ), 
        ],
  
      ),
      body: getBody(),
    );
  }

  Widget getBody(){
    if(users.contains(null) || users.length < 0 || isLoading){
      return Center(child: CircularProgressIndicator());
    }
    return ListView.builder(
      itemCount: users.length,
      itemBuilder: (context, index){
      return getCard(users[index]);
    });
  }
  Widget getCard(index){
    var idValue = index['id'];
    var titleValue = index['title'];
    return Card(
      child: InkWell(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: ListTile(
            title: Row(
              children: <Widget>[
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: primary,
                    borderRadius: BorderRadius.circular(60/2),
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image:
                    NetworkImage("https://media.istockphoto.com/vectors/user-avatar-profile-icon-black-vector-illustration-vector-id1209654046?k=20&m=1209654046&s=612x612&w=0&h=Atw7VdjWG8KgyST8AXXJdmBkzn0lvgqyWod9vTb2XoE=")
                    )
                  ),
                ),
                SizedBox(width: 20,),
               Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(idValue.toString(), style: TextStyle(fontSize: 16),),
                   SizedBox(height: 10,),
                    Text(titleValue.toString(), style: TextStyle(fontSize: 12, color: Colors.purple),),
                ],
               )
              ],
            ),
          ),
        ),
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => DetailView()));
        },
      ),
    );
    }

}