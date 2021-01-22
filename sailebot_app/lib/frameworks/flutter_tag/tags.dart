import 'package:flutter/material.dart';
import 'package:sailebot_app/frameworks/flutter_tag/custom_wrap.dart';
import 'package:sailebot_app/frameworks/flutter_tag/item_tags.dart';

///ItemBuilder
typedef Widget ItemBuilder(int index);

class Tags extends StatefulWidget {
  Tags(
      {this.columns,
      this.itemCount = 0,
      this.symmetry = false,
      this.horizontalScroll = false,
      this.heightHorizontalScroll = 60,
      this.spacing = 6,
      this.runSpacing = 14,
      this.alignment = WrapAlignment.center,
      this.runAlignment = WrapAlignment.center,
      this.direction = Axis.horizontal,
      this.verticalDirection = VerticalDirection.down,
      this.textDirection = TextDirection.ltr,
      this.itemBuilder,
      Key key})
      : assert(itemCount >= 0),
        assert(alignment != null),
        assert(runAlignment != null),
        assert(direction != null),
        assert(verticalDirection != null),
        assert(textDirection != null),
        super(key: key);

  ///specific number of columns
  final int columns;

  ///numer of item List
  final int itemCount;

  /// imposes the same width and the same number of columns for each row
  final bool symmetry;

  /// ability to scroll tags horizontally
  final bool horizontalScroll;

  /// horizontal spacing of  the [ItemTags]
  final double heightHorizontalScroll;

  /// horizontal spacing of  the [ItemTags]
  final double spacing;

  /// vertical spacing of  the [ItemTags]
  final double runSpacing;

  /// horizontal alignment of  the [ItemTags]
  final WrapAlignment alignment;

  /// vertical alignment of  the [ItemTags]
  final WrapAlignment runAlignment;

  /// direction of  the [ItemTags]
  final Axis direction;

  /// Iterate [Item] from the lower to the upper direction or vice versa
  final VerticalDirection verticalDirection;

  /// Text direction of  the [ItemTags]
  final TextDirection textDirection;

  /// Generates a list of [ItemTags].
  ///
  /// Creates a list with [length] positions and fills it with values created by
  /// calling [generator] for each index in the range `0` .. `length - 1`
  /// in increasing order.
  final ItemBuilder itemBuilder;

  /// custom TextField
  // final TagsTextField textField;

  @override
  TagsState createState() => TagsState();
}

class TagsState extends State<Tags> {
  final GlobalKey _containerKey = GlobalKey();
  Orientation _orientation = Orientation.portrait;
  double _width = 0;

  final List<DataList> _list = List();

  List<Item> get getAllItem => _list.toList();

  //get the current width of the screen
  void _getWidthContext() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final keyContext = _containerKey.currentContext;
      if (keyContext != null) {
        final RenderBox box = keyContext.findRenderObject();
        final size = box.size;
        setState(() {
          _width = size.width;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // essential to avoid infinite loop of addPostFrameCallback
    if (widget.symmetry &&
        (MediaQuery.of(context).orientation != _orientation || _width == 0)) {
      _orientation = MediaQuery.of(context).orientation;
      _getWidthContext();
    }

    Widget child;
    if (widget.horizontalScroll && !widget.symmetry)
      child = Container(
        height: widget.heightHorizontalScroll,
        color: Colors.transparent,
        child: ListView(
          padding: EdgeInsets.all(0),
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          physics: ClampingScrollPhysics(),
          children: _buildItems(),
        ),
      );
    else
      child = CustomWrap(
        key: _containerKey,
        alignment: widget.alignment,
        runAlignment: widget.runAlignment,
        spacing: widget.spacing,
        runSpacing: widget.runSpacing,
        column: widget.columns,
        symmetry: widget.symmetry,
        textDirection: widget.textDirection,
        direction: widget.direction,
        verticalDirection: widget.verticalDirection,
        crossAxisAlignment: WrapCrossAlignment.end,
        children: _buildItems(),
      );

    return DataListInherited(
      list: _list,
      symmetry: widget.symmetry,
      itemCount: widget.itemCount,
      child: child,
    );
  }

  List<Widget> _buildItems() {
    List<Widget> finalList = List();

    List<Widget> itemList = List.generate(widget.itemCount, (i) {
      final Widget item = widget.itemBuilder(i);
      if (widget.symmetry)
        return Container(
          width: _widthCalc(),
          child: item,
        );
      else if (widget.horizontalScroll)
        return Container(
          margin: EdgeInsets.symmetric(horizontal: widget.spacing),
          alignment: Alignment.center,
          child: item,
        );
      return item;
    });

    if (widget.horizontalScroll && widget.textDirection == TextDirection.rtl)
      itemList = itemList.reversed.toList();
    finalList.addAll(itemList);
    return finalList;
  }

  //Container width divided by the number of columns when symmetry is active
  double _widthCalc() {
    int columns = widget.columns ?? 0;
    int margin = widget.spacing.round();

    int subtraction = columns * (margin);
    double width = (_width > 1) ? (_width - subtraction) / columns : _width;

    return width;
  }
}

/// Inherited Widget
class DataListInherited extends InheritedWidget {
  DataListInherited(
      {Key key, this.list, this.symmetry, this.itemCount, Widget child})
      : super(key: key, child: child);

  final List<DataList> list;
  final bool symmetry;
  final int itemCount;

  @override
  bool updateShouldNotify(DataListInherited old) {
    //print("inherited");
    return false;
  }

  /*static DataListInherited of(BuildContext context) =>
      context.inheritFromWidgetOfExactType(DataListInherited);*/
  static DataListInherited of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType();
}

/// Data List
class DataList extends ValueNotifier implements Item {
  DataList(
      {@required this.title,
      this.index,
      bool highlights = false,
      bool active = true,
      this.customData})
      : _showDuplicate = highlights,
        _active = active,
        super(active);

  final String title;
  final dynamic customData;
  final int index;

  get showDuplicate {
    final val = _showDuplicate;
    _showDuplicate = false;
    return val;
  }

  bool _showDuplicate;
  set showDuplicate(bool a) {
    _showDuplicate = a;
    // rebuild only the specific Item that changes its value
    notifyListeners();
  }

  get active => _active;
  bool _active;
  set active(bool a) {
    _active = a;
    // rebuild only the specific Item that changes its value
    notifyListeners();
  }
}
