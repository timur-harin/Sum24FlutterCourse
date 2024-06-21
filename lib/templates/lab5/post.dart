// TODO add dependencies

class Post {
  late final int userId;
  late final int id;
  late final String title;
  late final String body;

  Post({required this.userId, required this.id, required this.title, required this.body});

  // TODO task 1 to make this class for url http://jsonplaceholder.typicode.com/posts

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      userId: json['userId'],
      id: json['id'],
      title: json['title'],
      body: json['body'],
    );
  }

  factory Post.toJson(Post post) {}
}

Future<List<Post>> fetchPosts() async {
  // TODO task 1.2 to make this function for url http://jsonplaceholder.typicode.com/posts
  // // Using fabric from class
  return [];
}
