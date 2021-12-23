import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flibrary/models/device.dart';

final deviceProvider = ChangeNotifierProvider((ref) => DeviceModel());
