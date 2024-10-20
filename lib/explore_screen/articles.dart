import 'package:speakup/explore_screen/article_widget.dart';

class Articles {
  static List<ArticleWidget> articles = const [
    ArticleWidget(
        name: "Mastering Key Interview Questions",
        content:
            """Preparing for job interviews can be daunting, but with the right approach, you can confidently tackle even the toughest questions. This guide will help you master some of the most common interview questions, providing you with strategies to craft compelling answers.\n\n"Tell me about yourself." This question is often used as an icebreaker, but it's also an opportunity to set the tone for the interview. Prepare a 2-3 minute "elevator pitch" that summarizes your professional background, key achievements, and why you're interested in this position. For example, you might say: "I'm a marketing professional with 5 years of experience in digital advertising. In my current role at XYZ Company, I've led campaigns that increased client engagement by 40%. I'm particularly excited about this position because it aligns with my passion for data-driven marketing strategies."

"What is your greatest weakness?" This question assesses your self-awareness and ability to improve. Choose a genuine weakness, but focus on how you're actively working to overcome it. For instance: "I sometimes struggle with public speaking. To address this, I've joined a local Toastmasters""",
        imgURI:
            "https://static.jobscan.co/blog/uploads/Job-interview-tips-1.jpg")
  ];

  static List<ArticleWidget> getFullArticles() {
    return articles;
  }
}
