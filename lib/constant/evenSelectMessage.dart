// list of Icon
List listEventIcon = [
  {
    "id": 1,
    "iconGif": "assets/images/like.gif",
    "iconPng": "assets/images/ic_like_fill.png",
    "name": "like",
  },
  {
    "id": 2,
    "iconGif": "assets/images/love.gif",
    "iconPng": "assets/images/love2.png",
    "name": "love",
  },
  {
    "id": 3,
    "iconGif": "assets/images/haha.gif",
    "iconPng": "assets/images/haha2.png",
    "name": "haha",
  },
  {
    "id": 4,
    "iconGif": "assets/images/wow.gif",
    "iconPng": "assets/images/wow2.png",
    "name": "wow",
  },
  {
    "id": 5,
    "iconGif": "assets/images/sad.gif",
    "iconPng": "assets/images/sad2.png",
    "name": "like",
  },
  {
    "id": 6,
    "iconGif": "assets/images/angry.gif",
    "iconPng": "assets/images/angry2.png",
    "name": "angry",
  },
];

List listEventAction = [
  {"id": 0, "name": "delete", "title": "Xóa"},
  {"id": 1, "name": "copy", "title": "Sao Chép"},
  {"id": 2, "name": "Tính Năng 1", "title": "Action3"},
  {"id": 3, "name": "Tính Năng 2", "title": "Action4"},
];

getIcon(int id) {
  for (var i = 0; i < listEventIcon.length; i++) {
    if (listEventIcon[i]['id'] == id) {
      return listEventIcon[i];
    }
  }
  return null;
}
