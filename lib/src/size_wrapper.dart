import 'package:flutter/foundation.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

typedef OnWidgetSizeChange = Function(Size newSize);

class WidgetSizeRenderObject extends RenderProxyBox {
  WidgetSizeRenderObject(this.onSizeChange);

  final OnWidgetSizeChange onSizeChange;
  Size? currentSize;

  @override
  void performLayout() {
    super.performLayout();

    try {
      Size? newSize = child?.size;

      if (newSize != null && currentSize != newSize) {
        currentSize = newSize;
        WidgetsBinding.instance.addPostFrameCallback((_) {
          onSizeChange(newSize);
        });
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }
}

class WidgetSizeWrapper extends SingleChildRenderObjectWidget {
  const WidgetSizeWrapper({
    Key? key,
    required this.onSizeChange,
    required Widget child,
  }) : super(key: key, child: child);

  final OnWidgetSizeChange onSizeChange;

  @override
  RenderObject createRenderObject(BuildContext context) {
    return WidgetSizeRenderObject(onSizeChange);
  }
}
