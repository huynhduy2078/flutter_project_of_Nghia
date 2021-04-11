// list of Icon
List listEventIcon = [
  {
    "id": 1,
    "iconGif": "images/like.gif",
    "iconPng": "images/ic_like_fill.png",
    "name": "like",
  },
  {
    "id": 2,
    "iconGif": "images/love.gif",
    "iconPng": "images/love2.png",
    "name": "love",
  },
  {
    "id": 3,
    "iconGif": "images/haha.gif",
    "iconPng": "images/haha2.png",
    "name": "haha",
  },
  {
    "id": 4,
    "iconGif": "images/wow.gif",
    "iconPng": "images/wow2.png",
    "name": "wow",
  },
  {
    "id": 5,
    "iconGif": "images/sad.gif",
    "iconPng": "images/sad2.png",
    "name": "like",
  },
  {
    "id": 6,
    "iconGif": "images/angry.gif",
    "iconPng": "images/angry2.png",
    "name": "angry",
  },
];

List listEventAction = [ {
    "id": 0,
    "name": "delete",
    "title": "Xóa"
  },
  {
    "id": 1,
    "name": "copy",
    "title": "Sao Chép"
  },
  {
    "id": 2,
    "name": "Tính Năng 1",
    "title": "Action3"
  },
  {
    "id": 3,
    "name": "Tính Năng 2",
    "title": "Action4"
  },
];


getIcon(int id) {
  for (var i = 0; i < listEventIcon.length; i++) {
    if (listEventIcon[i]['id'] == id) {
      return listEventIcon[i];
    }
  }
  return null;
}
