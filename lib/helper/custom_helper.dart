import 'package:html/parser.dart' as htmlParser;


class CustomHelper {

  static String stripHtml(String htmlString) {
    return htmlParser.parse(htmlString).body?.text ?? '';
  }
}