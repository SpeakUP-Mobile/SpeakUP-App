import 'package:get/get.dart';
import 'package:speakup/explore_screen/article_widget.dart';
import 'articles.dart';
import 'article_page.dart';

class ExploreController extends GetxController {
  RxList<ArticleWidget> fullArticles = <ArticleWidget>[].obs;

  @override
  void onInit() async {
    for (int i = 0; i < Articles.getFullArticles().length; i++) {
      fullArticles.add(Articles.getFullArticles()[i]);
    }
    super.onInit();
  }

  void viewArticle(String name, String content) {
    Get.to(const ArticlePage(), arguments: [name, content]);
  }
}
