part of 'index.dart';

class LogInterceptor extends Interceptor {
  LogInterceptor({
    this.request = true,
    this.requestHeader = true,
    this.requestBody = false,
    this.responseHeader = true,
    this.responseBody = false,
    this.error = true,
    this.logSize = 999,
  });

  bool request;
  bool requestHeader;
  bool requestBody;
  bool responseBody;
  bool responseHeader;
  bool error;
  final logSize;

  @override
  onRequest(RequestOptions options) async {
    print("*** Request ***");
    print(
        "${options.method} ${options.uri} ?${options.queryParameters} B${options.data} H${options.headers}");
    return options;
  }

  @override
  onError(DioError err) async {
    if (error) {
      print('*** DioError ***:');
      print(err);
      if (err.response != null) {
        printAll(err.response.toString());
      }
    }
    return err;
  }

  @override
  onResponse(Response response) async {
    print("*** Response ***");
    printAll(response.toString());
    return response;
  }

  printAll(msg) {
    _printAll(msg.toString().replaceAll("\n", ""));
  }

  _printAll(String msg) {
    int groups = (msg.length / logSize).ceil();
    for (int i = 0; i < groups; ++i) {
      print(msg.substring(
          i * logSize, math.min<int>(i * logSize + logSize, msg.length)));
    }
  }
}
