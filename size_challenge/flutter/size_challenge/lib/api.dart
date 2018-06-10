import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Comic{

  final Image comicImage;
  final String comicTitle;

  Comic.fromJson(Map jsonMap) :
      comicImage = new Image.network(jsonMap['img']),
      comicTitle = jsonMap['title'],
      assert (comicImage != null),
      assert (comicTitle != null);
}


class ComicApi{

  /// Rest to get current comic to xkcd
  Future<Comic> getComic() async {

    try{

      var restResponse = await http.get('https://xkcd.com/info.0.json');
      if (restResponse.statusCode != 200)
        return null;

      return Comic.fromJson(json.decode(restResponse.body));
    } on http.ClientException {
      return null;
    }

  }
}