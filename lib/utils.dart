String timeAgo(String dateTime) {
  try {
    DateTime postDate = DateTime.parse(dateTime);
    final Duration difference = DateTime.now().difference(postDate);

    if (difference.inSeconds < 60) {
      return "Just now";
    } else if (difference.inMinutes < 60) {
      return "منذ ${difference.inMinutes} دقيقة";
    } else if (difference.inHours < 24) {
      return "منذ ${difference.inHours} ساعة";
    } else if (difference.inDays < 7) {
      return "منذ ${difference.inDays} يوم";
    } else if (difference.inDays < 30) {
      return "منذ ${difference.inDays ~/ 7} أسبوع";
    } else if (difference.inDays < 365) {
      return "منذ ${difference.inDays ~/ 30} شهر";
    } else {
      return "منذ ${difference.inDays ~/ 365} سنة";
    }
  } catch (_) {
    return "تاريخ غير معروف";
  }
}