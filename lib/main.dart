import 'package:flutter/material.dart';
import 'package:grpc/grpc.dart';
import 'package:grpc_flutter/hello_service.dart';
import 'package:grpc_flutter/services/proto/hello.pbgrpc.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  ///add this line to initialize the HelloService and create a channel
  HelloService().init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Grpc Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Grpc Home'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  ///call sayHello from helloClient service
  var hello = "default";

  Future<void> sayHello() async {
    try {
      HelloRequest helloRequest = HelloRequest();
      helloRequest.name = "Itachi";


      var helloResponse = await HelloService.instance.helloClient.sayHello(helloRequest);
      ///do something with your response here
      setState(() {
        hello = helloResponse.message;
      });
    } on GrpcError catch (e) {
      ///handle all grpc errors here
      ///errors such us UNIMPLEMENTED,UNIMPLEMENTED etc...
      print(e);
    } catch (e) {
      ///handle all generic errors here
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              hello,
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: sayHello,
        tooltip: 'Said Hello',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
