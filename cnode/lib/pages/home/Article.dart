class Author {
  String loginname;
  String avatar_url;
  Author(this.loginname, this.avatar_url);
}


class Article {
  String id;
  String author_id;
  String tab;
  String content;
  String title;
  String last_reply_at;
  bool top;
  bool good;
  int reply_count;
  int visit_count;
  String create_at;
  Author author;


  Article(this.id, this.author_id, this.tab, this.content, this.title, this.last_reply_at,
        this.top,  this.good, this.reply_count, this.visit_count,
        this.create_at, this.author);

  Article.fromJSON(Map data) {
    this.id = data['id'];
    this.author_id = data['author_id'];
    this.tab = data['tab'];
    this.content = data['content'];
    this.title = data['title'];
    this.last_reply_at = data['last_reply_at'];
    this.top = data['top'];
    this.good = data['good'];
    this.reply_count = data['reply_count'];
    this.visit_count = data['visit_count'];
    this.create_at = data['create_at'];
    this.author = new Author(data['author']['loginname'], data['author']['avatar_url']);
  }
}

List<Article> articleLists = <Article>[];