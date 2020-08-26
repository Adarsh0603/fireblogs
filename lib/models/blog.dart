class Blog {
  final String id;
  final String blogTitle;
  final String blogContent;
  final String authorName;

  Blog(this.id, this.blogTitle, this.blogContent, this.authorName);
  Map<String, dynamic> toMap() {
    return {
      'blogTitle': blogTitle,
      'blogContent': blogContent,
    };
  }
}
