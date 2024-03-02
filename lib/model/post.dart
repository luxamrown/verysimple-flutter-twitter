class Post {
  int id;
  String name;
  String username;
  String timestamp;
  String content;
  int likeCount;
  bool isLiked;
  
  Post({required this.id, required this.name, required this.username, required this.timestamp, required this.content, required this.likeCount, required this.isLiked});

  int get getId {
    return id;
  }

  String get getName {
    return name;
  }

  String get getUsername {
    return username;
  }

  String get getTimestamp {
    return timestamp;
  }

  String get getContent {
    return content;
  }

  int get getLikeCount {
    return likeCount;
  }
  
  bool get getLikeStatus{
    return isLiked;
  }

  void setLike() {
    isLiked = !isLiked;
    likeCount =  isLiked ? likeCount + 1 : likeCount - 1;
  }

  static List<Post> initPost() {
    return [
      Post(id:1, name: "Luxam Rown", username: "@luxamrown", timestamp: "05-12-2003", content: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.", likeCount: 5, isLiked: true),
      Post(id:2, name: "Ethan Hunt", username: "@ethanhunt", timestamp: "12-12-1991", content: "Lorem ipsum dolor sit amet,", likeCount: 20, isLiked: false),
      Post(id:3, name: "Benji", username: "@benjidunn", timestamp: "12-12-1991", content: "Lorem ipsum dolor sit amet,", likeCount: 2, isLiked: false),
    ];
  }
}

