import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'viewmodels/chat_vm.dart';

final chatVM = ChangeNotifierProvider.autoDispose((ref) => ChatViewModel());
