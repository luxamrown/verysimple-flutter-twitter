import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.blue,
          ),
        textTheme: GoogleFonts.montserratTextTheme(textTheme)
      ),

      home: const MyHomePage(title: 'Simple Twt Flutter'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool popupIsOpen = false;

  void setPopupNewPost() {
    setState(() {
      popupIsOpen = !popupIsOpen;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        // backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title, style: const TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: ListView(
          children: [BigCard(name: "keset",), BigCard(name: "keset",)],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: setPopupNewPost,
        tooltip: 'Create',
        child: const Icon(Icons.create),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class BigCard extends StatelessWidget {
  const BigCard({
    super.key,
    required this.name
  });

  final String name;

  @override
  Widget build(BuildContext context) {

    const styleName = TextStyle(fontWeight: FontWeight.bold, color: Colors.black87, fontSize: 16);
    const styleUserName = TextStyle(fontWeight: FontWeight.w300, color: Colors.black45, fontSize: 12);
    const styleContent = TextStyle(fontWeight: FontWeight.w300, color: Colors.black87, fontSize: 12);

    return const Card(
      color: Colors.white,
      child: Padding(
        padding: EdgeInsets.all(2),
        child: Column(
          children: [
          ListTile(
            leading: Icon(
              Icons.person,
              color: Colors.black87,
            ),
            title: Row(
              children: [
                Text(
                  "Luxam Rown",
                  style: styleName,
                ),
                Spacer(),
                Text(
                  '@luxamrown',
                  style: styleUserName,
                ),
              ],
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 10),
                Text('25-12-2003', style: styleUserName, textAlign: TextAlign.start, textWidthBasis: TextWidthBasis.longestLine),
                SizedBox(height: 10),
                Text('Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.', style: styleContent),
                SizedBox(height: 10),
                Text('25 people liked this post', style: styleUserName, textAlign: TextAlign.start, textWidthBasis: TextWidthBasis.longestLine),
              ],
            ),
          ),
          ],
        ),
      ),
    );
  }
}