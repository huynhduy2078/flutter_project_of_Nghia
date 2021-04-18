import 'package:chat_messanger_ui/core/viewmodels/nav_vm.dart';
import 'package:chat_messanger_ui/core/viewmodels/chat_vm.dart';
import 'package:chat_messanger_ui/core/viewmodels/login_vm.dart';
import 'package:chat_messanger_ui/core/viewmodels/product_vm.dart';
import 'package:chat_messanger_ui/core/viewmodels/signup_vm.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

final registerProviders = <SingleChildWidget>[
  ChangeNotifierProvider(create: (_) => LoginViewModel()),
  ChangeNotifierProvider(create: (_) => NavItems()),
  ChangeNotifierProvider(create: (_) => SignupViewModel()),
  ChangeNotifierProvider(create: (_) => ChatViewModel()),
  ChangeNotifierProvider(create: (_) => ProductViewModel()),
];
