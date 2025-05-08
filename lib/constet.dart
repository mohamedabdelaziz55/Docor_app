const String linkServerName = "http://10.0.2.2:8012/php_doctor";
const String imageRoot = "http://10.0.2.2:8012/php_doctor/upload";
//auth
const String linkSignUp = "$linkServerName/auth/singup.php";
const String docSignUp = "$linkServerName/auth/singupDoc.php";
const String doclogin = "$linkServerName/auth/logindoc.php";
const String linklogin = "$linkServerName/auth/login.php";
const String linkEditProfile = "$linkServerName/auth/updateprofile.php";
//questions
const String linkAdd = "$linkServerName/questions/add.php";
const String linkView = "$linkServerName/questions/select.php";
const String linkDelete = "$linkServerName/questions/delete.php";
const String linkEdit = "$linkServerName/questions/update.php";
//Artices
const String linkViewArtices = "$linkServerName/articles/select.php";
const String linkAddArtices = "$linkServerName/articles/add.php";
const String linkDeleteArtices = "$linkServerName/articles/delete.php";
const String linkUpdateArtices = "$linkServerName/articles/update.php";
//message
const String getMessage = "$linkServerName/message/get_messages.php";
const String sendMessage = "$linkServerName/message/send_messages.php";
//comments
const String addComments ="$linkServerName/comments/add.php";
const String deleteComments ="$linkServerName/comments/delete.php";
const String viewComments ="$linkServerName/comments/select.php";
const String editComments ="$linkServerName/comments/update.php";
const String viewCommentsByAskId = "$linkServerName/comments/selectbyquestion.php";