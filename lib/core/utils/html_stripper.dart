import 'package:html/parser.dart' as htmlParser;


class HtmlStripper {

  static String stripHtml(String htmlString) {
    return htmlParser.parse(htmlString).body?.text ?? '';
  }
}