import 'package:speakup/explore_screen/article_widget.dart';

class Articles {
  static List<ArticleWidget> articles = const [
    ArticleWidget(
        name: "Mastering Key Interview Questions",
        content:
            """Preparing for job interviews can be daunting, but with the right approach, you can confidently tackle even the toughest questions. This guide will help you master some of the most common interview questions, providing you with strategies to craft compelling answers.

"Tell me about yourself." This question is often used as an icebreaker, but it's also an opportunity to set the tone for the interview. Prepare a 2-3 minute "elevator pitch" that summarizes your professional background, key achievements, and why you're interested in this position. For example, you might say: "I'm a marketing professional with 5 years of experience in digital advertising. In my current role at XYZ Company, I've led campaigns that increased client engagement by 40%. I'm particularly excited about this position because it aligns with my passion for data-driven marketing strategies."

"What is your greatest weakness?" This question assesses your self-awareness and ability to improve. Choose a genuine weakness, but focus on how you're actively working to overcome it. For instance: "I sometimes struggle with public speaking. To address this, I've joined a local Toastmasters group and have been volunteering to lead more presentations at work. I've already seen significant improvement in my confidence and delivery."

"Why do you want to work here?" This question gauges your knowledge of the company and your enthusiasm for the role. Research the company thoroughly and align your goals with their mission and values. You could respond: "I've long admired your company's commitment to sustainability. Your recent initiative to reduce carbon emissions by 50% by 2030 particularly resonates with me. I believe my background in environmental engineering would allow me to contribute meaningfully to this goal."

"Where do you see yourself in five years?" This question assesses your long-term goals and how they align with the company's needs. Be honest about your career aspirations while demonstrating commitment to the role and company. An example answer could be: "In five years, I hope to have grown into a leadership position where I can mentor junior developers and contribute to strategic decisions. I'm excited about the potential for growth within your organization, particularly given your track record of promoting from within."

"Can you describe a challenging work situation and how you overcame it?" This question evaluates your problem-solving skills and resilience. Use the STAR method (Situation, Task, Action, Result) to structure your response. For example: "In my previous role, we faced a critical software bug just before a major release. I was tasked with identifying and fixing the issue within 24 hours. I organized a team of developers, delegated tasks, and worked through the night to isolate and fix the bug. We successfully released the update on time, and it was our most stable release to date."

"Do you have any questions for us?" This is your chance to demonstrate your interest and gain valuable insights. Prepare thoughtful questions about the role, team, and company culture. You might ask: "Can you tell me more about the team I'd be working with? I'm particularly interested in understanding the collaborative dynamics and how different departments interact on projects."

Remember, the key to mastering interview questions is preparation, practice, and authenticity. Tailor your responses to highlight your unique experiences and skills, and always relate them back to the requirements of the position you're applying for. Practice your answers out loud, either alone or with a friend, to become more comfortable with your responses. Be prepared to elaborate on any point you make, as interviewers may ask follow-up questions. It's also important to be concise in your answers - aim for responses that are detailed enough to be substantive, but brief enough to maintain the interviewer's interest. Lastly, remember that an interview is a two-way street. While you're answering questions, you should also be evaluating whether the company and role are a good fit for you. Good luck with your interview preparation!""",
        imgURI:
            "https://static.jobscan.co/blog/uploads/Job-interview-tips-1.jpg")
  ];

  static List<ArticleWidget> getFullArticles() {
    return articles;
  }
}
