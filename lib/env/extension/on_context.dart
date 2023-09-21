import 'package:flutter/material.dart';
import 'package:ocr_visitor/env/class/shortcut.dart';
import 'package:ocr_visitor/env/variable/constant.dart';
import 'package:ocr_visitor/env/widget/bug_catcher.dart';

extension OnContext on BuildContext {
  Future<T?> to<T extends Object?>({required Widget child, Object? arguments}) {
    try {
      return Navigator.push<T>(this, MaterialPageRoute(builder: (_) => child));
    } catch (e) {
      throw BugSheet(
              title: "Gagal Membuka Halaman",
              content: "$e",
              pagePath: "env/extension/ici_context.dart",
              statePath: "-")
          .openWith(this);
    }
  }

  Future toNamed<T extends Object?>({
    required String route,
    Object? arguments,
  }) {
    try {
      return Navigator.pushNamed(this, route, arguments: arguments);
    } catch (e) {
      throw BugSheet(
              title: "Gagal Membuka Rute $route",
              content: "$e",
              pagePath: "env/extension/context.dart",
              statePath: "-")
          .openWith(this);
    }
  }

  Future toReplacementNamed<T extends Object?>({
    required String route,
    Object? arguments,
  }) {
    try {
      return Navigator.pushReplacementNamed(
        this,
        route,
        arguments: arguments,
      );
    } catch (e) {
      throw BugSheet(
              title: "Gagal Membuka Rute $route",
              content: "$e",
              pagePath: "env/extension/context.dart",
              statePath: "-")
          .openWith(this);
    }
  }

  Future toRemoveNamed<T extends Object?>({
    required String route,
    Object? arguments,
  }) {
    try {
      return Navigator.pushNamedAndRemoveUntil(
        this,
        route,
        (route) => false,
        arguments: arguments,
      );
    } catch (e) {
      throw BugSheet(
              title: "Gagal Membuka Rute $route",
              content: "$e",
              pagePath: "env/extension/context.dart",
              statePath: "-")
          .openWith(this);
    }
  }

  void close<T extends Object?>([T? result]) => Navigator.pop<T>(this, result);

  ScaffoldFeatureController<SnackBar, SnackBarClosedReason> alert(
      {required String label,
      Color? color,
      Duration? duration,
      EdgeInsetsGeometry? margin,
      void Function(ScaffoldMessengerState snackbar)? onTap}) {
    var my = Shortcut.of(this);
    return ScaffoldMessenger.of(this).showSnackBar(SnackBar(
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        margin: const EdgeInsets.only(left: 20, bottom: 20, right: 20),
        elevation: 2,
        content: Row(children: [
          Icon(Icons.info_outline, color: my.color.background),
          const SizedBox(width: 8),
          Expanded(
              child: Text(label.toUpperCase(),
                  style: const TextStyle(
                      fontWeight: FontWeight.w600, fontSize: 10.0)))
        ]),
        backgroundColor: color ?? my.color.error.withOpacity(0.925),
        duration: duration ?? Constants.alertDuration));
  }

  Future<T?> sheet<T extends Object?>(
          {required Widget child,
          double vertRadius = 8,
          bool isScrollable = false,
          double maxWidth = double.infinity}) =>
      showModalBottomSheet(
        context: this,
        builder: (ctx) => child,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(vertRadius),
          ),
        ),
        constraints: BoxConstraints(
          maxWidth: maxWidth,
        ),
        isScrollControlled: isScrollable,
        backgroundColor: Colors.white,
      );
}
