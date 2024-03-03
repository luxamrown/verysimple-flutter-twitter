import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:simple_twt/model/post.dart';

void main() {
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return ChangeNotifierProvider(create: (context) => MyAppState(), child: MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.blue,
          ),
          textTheme: GoogleFonts.montserratTextTheme(textTheme)),
      home: MyHome(),
    ));
  }
}

class MyHome extends StatefulWidget {
  @override
  State<MyHome> createState() => _MyHomeState();
}

class MyAppState extends ChangeNotifier {
  bool adminMode = false;

  void handleAdmin() {
      adminMode = !adminMode;

      notifyListeners();
  }
}

class _MyHomeState extends State<MyHome> {
  bool addPageIsOpen = false;

  final allPosts = Post.initPost();

  final formNameController = TextEditingController();
  final formContentController = TextEditingController();

  void handleLikePost(Post post) {
    setState(() {
      post.setLike();
    });
  }

  void handleAddPost() {
    setState(() {
      if(formNameController.text.isNotEmpty && formContentController.text.isNotEmpty){
        allPosts.insert(0, Post(id:allPosts.length + 1, name: formNameController.text, username: "@${formNameController.text.replaceAll(" ", "")}", timestamp: "${DateTime.timestamp().hour}:${DateTime.timestamp().minute}", content: formContentController.text, likeCount: Random().nextInt(500), isLiked: false));
        
        formNameController.clear();
        
        formContentController.clear();
        
        addPageIsOpen = !addPageIsOpen;
      }
    });
  }

  void handleDeletePost(Post selectedPost) {
    setState(() {
      allPosts.removeWhere((post) => post.id == selectedPost.id);
    });
  }

  void showAddContent() {
    setState(() {
      addPageIsOpen = !addPageIsOpen;
    });
  }

  // var allPost = <Post>[];
  @override
  Widget build(BuildContext context) {

    var appState = context.watch<MyAppState>();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Simple twt",
            style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      
      body: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: !addPageIsOpen ? PostListPage() : FormNewPost(),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,

      floatingActionButton: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            Visibility(visible: !addPageIsOpen,child: FloatingActionButton.extended(
                onPressed: appState.handleAdmin,
                tooltip: 'Create',
                label: const Text('Admin'),
                icon: const Icon(Icons.person),
              ),
            ),

            const Spacer(),

            Visibility(visible: !addPageIsOpen,child: FloatingActionButton(
                onPressed: showAddContent,
                tooltip: 'Create',
                child: const Icon(Icons.create),
              ),
            ),
          ],
        ),
      ) 
    );
  }

  Padding FormNewPost() {
    return Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Name", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.black87)),

            TextFormField(
              controller: formNameController,
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                hintText: "Enter your name", 
                hintStyle: TextStyle(color: Colors.black26)
              ),
            ),
            const SizedBox(height: 20),

            const Text("Content", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.black87)),

            TextFormField(
              controller: formContentController,
              maxLines: 8, //or null 
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                hintText: "Write content", 
                hintStyle: TextStyle(color: Colors.black26)
              ),
            ),

            const SizedBox(height: 20),

            Row(
              children: [
                TextButton(
                  style: TextButton.styleFrom(backgroundColor: Colors.red),
                  onPressed: showAddContent,
                  child: const Text('Cancel', style: TextStyle(color: Colors.white)),
                ),
                const Spacer(),
                TextButton(
                  style: TextButton.styleFrom(backgroundColor: Colors.blue),
                  onPressed: handleAddPost,
                  child: const Text('Post now', style: TextStyle(color: Colors.white)),
                ),

              ],
            )
          ],
        ),
      );
  }

  ListView PostListPage() {
    return ListView(
        children: [
          for (var selectedPost in allPosts)
            BigCard(post: selectedPost, handleLike: handleLikePost, handleDelete: handleDeletePost)
        ],
      );
  }
}

class BigCard extends StatelessWidget {
  const BigCard({super.key, required this.post, required this.handleLike, required this.handleDelete});

  final Post post;
  final handleLike;
  final handleDelete;

  @override
  Widget build(BuildContext context) {
  var appState = context.watch<MyAppState>();
    const styleName = TextStyle(
        fontWeight: FontWeight.bold, color: Colors.black87, fontSize: 16);
    const styleUserName = TextStyle(
        fontWeight: FontWeight.w300, color: Colors.black45, fontSize: 12);
    const styleContent = TextStyle(
        fontWeight: FontWeight.w300, color: Colors.black87, fontSize: 12);

    IconData likeIcon = post.getLikeStatus ? Icons.favorite : Icons.favorite_border;


    return Card(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(2),
        child: Column(
          children: [
            ListTile(
              leading: const Icon(
                Icons.person,
                color: Colors.black87,
              ),
              title: Row(
                children: [
                  Text(
                    post.getName,
                    style: styleName,
                  ),
                  Spacer(),
                  Text(
                    post.getUsername,
                    style: styleUserName,
                  ),
                ],
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10),
                  
                  Text(post.getTimestamp,
                      style: styleUserName,
                      textAlign: TextAlign.start,
                      textWidthBasis: TextWidthBasis.longestLine),
                  const SizedBox(height: 10),

                  Text(post.getContent, style: styleContent),

                  const SizedBox(height: 10),

                  Text('${post.getLikeCount} people liked this post',
                      style: styleUserName,
                      textAlign: TextAlign.start,
                      textWidthBasis: TextWidthBasis.longestLine),

                  const SizedBox(height: 10),

                  Row(
                    children: [
                      IconButton(
                        icon: Icon(likeIcon, color: Colors.red),
                        onPressed: () {
                          handleLike(post);
                        },
                      ),

                      const Spacer(),

                      Visibility(visible: appState.adminMode ,child: TextButton.icon(
                        icon: const Icon(Icons.delete, color: Colors.white),
                        label: Text("Delete", style: TextStyle(color: Colors.white)),
                        onPressed: () {
                          handleDelete(post);
                        },
                        style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.red)),
                      ),)


                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
