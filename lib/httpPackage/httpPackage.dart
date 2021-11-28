import 'package:flutter/material.dart';
import 'package:flutter_network/httpPackage/network/Apis.dart';
import 'package:flutter_network/model/Todo.dart';

class NetworkHttp extends StatefulWidget {
  const NetworkHttp({Key? key}) : super(key: key);

  @override
  _NetworkHttpState createState() => _NetworkHttpState();
}

class _NetworkHttpState extends State<NetworkHttp> {
  @override
  Widget build(BuildContext context) {
    final key = GlobalKey<ScaffoldState>();
    return Scaffold(
      key: key,
      appBar: AppBar(
        title: Text("Http Package"),
      ),
      body: FutureBuilder<Todo>(
        future: Apis.getPostById(),
        builder: (BuildContext context, AsyncSnapshot<Todo> snapshot) {
          if (snapshot.hasData) {
            return setupUi(snapshot.data);
          } else if (snapshot.hasError) {
            return noDataFound();
          } else {
            return showProgress();
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Apis.postTodo(Todo(
                  userId: 1,
                  title: "New Todo in server",
                  completed: false,
                  id: 0))
              .then((value) {
            key.currentState!.showSnackBar(SnackBar(
                content: Text(
                    "${value.title} is added in server with id ${value.id}")));
          });
        },
        child: Icon(Icons.add),
      ),
    );
  }

  Widget setupUi(Todo? data) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Card(
        elevation: 6,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: Icon(Icons.post_add),
              title: Text(data!.title),
              subtitle: Text(data!.completed.toString()),
            ),
          ],
        ),
      ),
    );
  }

  Widget noDataFound() {
    return Center(
      child: Text("No Data Return"),
    );
  }

  Widget showProgress() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }
}
