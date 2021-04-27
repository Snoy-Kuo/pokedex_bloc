import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../utils/string_util.dart';

Widget customText(String? msg,
    {TextStyle? style,
    TextAlign textAlign = TextAlign.justify,
    overflow = TextOverflow.clip,
    BuildContext? context}) {
  if (msg == null) {
    return SizedBox(
      height: 0,
      width: 0,
    );
  } else {
    if (context != null && style != null) {
      var fontSize =
          style.fontSize ?? Theme.of(context).textTheme.bodyText2!.fontSize;
      style = style.copyWith(
          fontSize: fontSize! - (fullWidth(context) <= 375 ? 2 : 0));
    }
    return Text(
      msg,
      style: style,
      textAlign: textAlign,
      overflow: overflow,
    );
  }
}

double fullWidth(BuildContext context) {
  return MediaQuery.of(context).size.width;
}

double fullHeight(BuildContext context) {
  return MediaQuery.of(context).size.height;
}

double getDimension(context, double unit) {
  if (fullWidth(context) <= 360.0) {
    return unit / 1.3;
  } else {
    return unit;
  }
}

dynamic customAdvanceNetworkImage(String path) {
  return CachedNetworkImageProvider(path);
}

double getFontSize(BuildContext context, double size) {
  if (MediaQuery.of(context).textScaleFactor < 1) {
    return getDimension(context, size);
  } else {
    return getDimension(context, size / MediaQuery.of(context).textScaleFactor);
  }
}

String getTypeImage(String type) {
  switch (type) {
    case 'Fighting':
      return 'assets/images/types/Fight.png';
    default:
      return 'assets/images/types/${type.capitalize()}.png';
  }
}
