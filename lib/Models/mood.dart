class MoodModel {
  String? uid;
  String? title;
  String? mood;

  MoodModel({
    this.uid,
    this.title,
    this.mood,
  });

  // Getting data from server
  factory MoodModel.fromMap(map) {
    return MoodModel(
      uid: map['uid'],
      title: map['title'],
      mood: map['mood'],
    );
  }
  // Sending data to server
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'mood': mood,
      'title': title,
    };
  }
}
