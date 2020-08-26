class Blog {
  final String id;
  final String blogTitle;
  final String blogContent;

  Blog(this.id, this.blogTitle, this.blogContent);
  Map<String, dynamic> toMap() {
    return {
      'blogTitle': blogTitle,
      'blogContent': blogContent,
    };
  }
}
