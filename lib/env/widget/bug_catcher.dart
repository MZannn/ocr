// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ocr_visitor/env/class/env.dart';
import 'package:ocr_visitor/env/class/shortcut.dart';
import 'package:ocr_visitor/env/extension/on_context.dart';
import 'package:package_info_plus/package_info_plus.dart';

import 'inkmaterial.dart';

class BugSheet extends StatelessWidget {
  const BugSheet(
      {Key? key,
      required this.title,
      required this.content,
      required this.pagePath,
      required this.statePath})
      : super(key: key);
  final String title, content, pagePath, statePath;

  factory BugSheet.withModel(ReportModel model,
          {required String pagePath, required String statePath}) =>
      BugSheet(
          title: model.title,
          content: model.content,
          pagePath: pagePath,
          statePath: statePath);

  @override
  Widget build(BuildContext context) {
    var my = Shortcut.of(context);

    return Container(
        alignment: Alignment.center,
        constraints: BoxConstraints(maxHeight: my.query.size.height / 2.5),
        child:
            Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          Container(
              constraints: const BoxConstraints(minHeight: kToolbarHeight),
              color: my.color.error,
              padding: const EdgeInsets.all(
                16,
              ),
              child: Row(children: [
                Expanded(
                    child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                      Text(title,
                          style: my.text.labelMedium?.copyWith(
                              fontSize: 14, color: my.color.background),
                          textAlign: TextAlign.start),
                      FutureBuilder(
                          future: PackageInfo.fromPlatform(),
                          builder: (_, AsyncSnapshot<PackageInfo> snap) {
                            if (snap.connectionState == ConnectionState.done &&
                                snap.data != null) {
                              return Text(
                                  "${Asset.app_label} v${snap.data?.version ?? 0.0}",
                                  textAlign: TextAlign.end,
                                  style: my.text.labelSmall?.copyWith(
                                      color:
                                          my.color.background.withOpacity(0.75),
                                      fontSize: 10));
                            } else {
                              return const SizedBox();
                            }
                          })
                    ])),
                InkMaterial(
                    tooltip: "Salin Rincian Masalah",
                    shapeBorder: const CircleBorder(),
                    onTap: () async {
                      PackageInfo package = await PackageInfo.fromPlatform();
                      String message =
                          'TITLE: $title\nDATE: ${DateTime.now()}\nSTATE PATH: $statePath\nPAGE PATH: $pagePath\nCONTENT: $content\nVERSION: ${package.version}';
                      await Clipboard.setData(ClipboardData(text: message));
                      context.close();
                      context.alert(
                          label: "Rincian Masalah Berhasil Disalin",
                          color: my.color.secondary);
                    },
                    child: Padding(
                        padding: const EdgeInsets.all(
                          16,
                        ),
                        child: Icon(Icons.copy,
                            size: 20, color: my.color.background)))
              ])),
          Expanded(
            child: Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(color: my.color.background),
              child: Scrollbar(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(
                    16,
                  ),
                  child: Text(
                    content,
                  ),
                ),
              ),
            ),
          ),
        ]));
  }

  Future<T?> openWith<T extends Object?>(BuildContext context) {
    if (content.contains('Http status error [403]')) {
      return context.to(child: const Text("403 Forbidden"));
    } else {
      return showModalBottomSheet<T>(
          backgroundColor: Colors.white,
          barrierColor:
              Theme.of(context).colorScheme.onBackground.withOpacity(0.55),
          context: context,
          builder: (_) => BugSheet(
              title: title,
              content: content,
              pagePath: pagePath,
              statePath: statePath));
    }
  }
}
