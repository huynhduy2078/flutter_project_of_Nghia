import 'package:chat_messanger_ui/core/models/user_model.dart';
import 'package:chat_messanger_ui/core/network_layer/helper/api_helper.dart';
import 'package:flutter/material.dart';

class UserViewModel extends ChangeNotifier {
  final apiHelper = ApiHelper();

  getImgByUser(email) {
    for (var i = 0; i < userMessages.length; i++) {
      if (userMessages[i].email == email) {
        return userMessages[i].profilePicUrl;
      }
    }
  }

  UserModel getUserByUser(id) {
    return userMessages.firstWhere((user) => (user.userId == id),
        orElse: () => null);
  }

  List<UserModel> userMessages = [
    UserModel(
      userId: 1,
      name: "Nguyễn Hữu Nghĩa",
      phone: "123123123",
      email: "huunghia8896@gmail.com",
      profilePicUrl:
          "https://scontent-hkt1-1.xx.fbcdn.net/v/t1.6435-1/p200x200/57122301_1170928453073668_9170941227883823104_n.jpg?_nc_cat=110&ccb=1-3&_nc_sid=7206a8&_nc_ohc=iSMkQPoMemgAX8XW3Bo&_nc_oc=AQn2_Y1NR6gAjMO5JTGUk2e9sapyNh9nKI298fL7GyDt656K5bWHhUX7_fU4GiuLG78&_nc_ht=scontent-hkt1-1.xx&tp=6&oh=25ac65b348b8e9acb2c231d0a2913fe4&oe=609CF7E9",
      isOnline: true,
    ),
    UserModel(
      userId: 2,
      name: "Nguyễn Nhật Thành",
      email: "nguyennhatthanh95@gmail.com",
      profilePicUrl:
          "https://play-lh.googleusercontent.com/-cyXF2_vs8LjdVY74AZTDL7TTkPPZnQFEX98axY2LQtDy-r6_NbW77VAd5WRYJ9_dg",
      isOnline: false,
    ),
    UserModel(
      userId: 3,
      name: "Võ Hữu Hải",
      email: "haivo@gmail.com",
      profilePicUrl:
          "https://scontent.fdad3-2.fna.fbcdn.net/v/t1.6435-9/148862039_2098845666919184_2363807376967657108_n.jpg?_nc_cat=101&ccb=1-3&_nc_sid=09cbfe&_nc_ohc=UAxm_EopvRAAX9ieimr&_nc_ht=scontent.fdad3-2.fna&oh=4203b207a54248935ca767c1bf8befc7&oe=609E499E",
      isOnline: false,
    ),
    UserModel(
      userId: 4,
      name: "Phúc Nguyễn",
      email: "Phucconga@gmail.com",
      profilePicUrl:
          "https://scontent-hkt1-1.xx.fbcdn.net/v/t1.6435-9/145125374_2956790244551580_1196515674077778820_n.jpg?_nc_cat=107&ccb=1-3&_nc_sid=09cbfe&_nc_ohc=WyssJPErMPUAX-botag&_nc_ht=scontent-hkt1-1.xx&oh=6a68c578413d31e6266a3d1fea2e03bb&oe=609E3741",
      isOnline: false,
    ),
    UserModel(
      userId: 5,
      name: "Nguyễn Huỳnh Duy",
      phone: "213414141",
      email: "huynhduy281096@gmail.com",
      profilePicUrl:
          "https://scontent.fdad3-3.fna.fbcdn.net/v/t1.6435-9/147667367_2221894577947263_4563611527763467797_n.jpg?_nc_cat=108&ccb=1-3&_nc_sid=09cbfe&_nc_ohc=-uYfuDE_6OAAX_CaCgi&_nc_ht=scontent.fdad3-3.fna&oh=1d6277049e6c24310bcd32aef84d9ad8&oe=60A72E81",
      isOnline: true,
    ),
  ];
}
