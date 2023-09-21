part of '../class/env.dart';

class ReportModel extends Equatable {
  const ReportModel(
      {required this.api,
      required this.title,
      required this.content,
      required this.message,
      required this.version,
      required this.datetime,
      required this.type});
  final String api, title, content, message, version, datetime;
  final Type type;

  static Future<ReportModel> onDefault(
      {required List<String> api,
      required String title,
      required String content,
      required Type type}) async {
    Future<String> version() async {
      try {
        var info = await PackageInfo.fromPlatform();
        return "${Asset.app_label} v${info.version}";
      } catch (e) {
        return "";
      }
    }

    return ReportModel(
      type: type,
      api: api.map((e) => Constants.apiUrl + e).join(","),
      title: title,
      content: content,
      message: '',
      version: await version(),
      datetime: DateFormat('dd-MM-yyyy HH:mm:ss').format(DateTime.now()),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "api": api,
      "title": title,
      "content": content,
      "message": message,
      "version": version,
      "datetime": datetime,
      "type": type.name.toUpperCase()
    };
  }

  @override
  List<Object?> get props => [
        "api: $api",
        "title: $title",
        "content: $content",
        "message: $message",
        "version: $version",
        "datetime: $datetime",
        "type: $type"
      ];
}
