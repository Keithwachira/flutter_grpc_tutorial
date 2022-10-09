import 'package:grpc/grpc.dart';
import 'package:grpc_flutter/services/proto/hello.pbgrpc.dart';

class HelloService {

  ///here enter your host without the http part (e.g enter google.com now http://google.com)
  String baseUrl = "example.com";

  HelloService._internal();
  static final HelloService _instance = HelloService._internal();

  factory HelloService() => _instance;

  ///static HelloService instance that we will call when we want to make requests
  static HelloService get instance => _instance;
   ///HelloClient is the  class that was generated for us when we ran the generation command
  ///it represent our Hello service in our proto file.
  ///We will be calling any method from that service using this instance.
  ///We will pass a channel to it to initialize it
  late HelloClient _helloClient;

  ///this will be used to create a channel once we create an instance of class.
  ///Call HelloService().init() before making any call.
  Future<void> init() async {
    _createChannel();
  }

  ///provide public access to the HelloClient instance
  HelloClient get helloClient {
    return _helloClient;
  }

  ///here we create a channel and use it to initialize the HelloClient that was generated
  ///
  _createChannel() {
    final channel = ClientChannel(
      baseUrl,

      ///port: 9043,
      port: 443,

      ///use credentials: ChannelCredentials.insecure() if you want to connect without Tls
      ///Sample without TLS
      //options: const ChannelOptions(credentials: ChannelCredentials.insecure()),

      ///use this if you are connecting with Tls
      ///Sample with TLS
      options: const ChannelOptions(),
    );
    _helloClient = HelloClient(channel);
  }
}
