class Blog {
  final String id;
  final String authorId;
  final String blogTitle;
  final String blogContent;
  final String authorName;
  final String blogTopic;
  final String blogDate;
  final String blogDateFMT;
  final String imageUrl;
  final bool fitImage;

  Blog(
      this.id,
      this.authorId,
      this.blogTitle,
      this.blogContent,
      this.authorName,
      this.blogTopic,
      this.blogDate,
      this.blogDateFMT,
      this.imageUrl,
      this.fitImage);
}
