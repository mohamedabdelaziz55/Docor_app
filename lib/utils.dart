
String timeAgo(String dateTime) {
  try {
    DateTime postDate = DateTime.parse(dateTime).toLocal();
    DateTime now = DateTime.now().toLocal();
    final Duration difference = now.difference(postDate);

    if (difference.inSeconds < 60) {
      return "Just now";  // إذا كان الوقت أقل من دقيقة
    } else if (difference.inMinutes < 60) {
      return "${difference.inMinutes} minute";
    } else if (difference.inHours < 24) {
      return "${difference.inHours} hour";
    } else if (difference.inDays < 7) {
      return "${difference.inDays} day";
    } else if (difference.inDays < 30) {
      return "${difference.inDays ~/ 7} week";
    } else if (difference.inDays < 365) {
      return "${difference.inDays ~/ 30} month";
    } else {
      return "${difference.inDays ~/ 365} year(s) ago";
    }
  } catch (_) {
    return "Unknown date";  // في حالة حدوث أي خطأ
  }
}
