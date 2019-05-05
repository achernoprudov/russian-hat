import 'package:flutter/material.dart';

class SelectableGridItem extends StatelessWidget {
  final String title;
  final IconData iconData;
  final bool isSelected;
  final VoidCallback onTap;

  const SelectableGridItem(
      {Key key,
      this.title,
      this.iconData,
      this.isSelected,
      @required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return RaisedButton(
      onPressed: onTap,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
      color: isSelected ? Colors.blue : Colors.grey,
      highlightColor: isSelected ? Colors.lightBlue : Colors.grey[300],
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Icon(
            iconData,
            size: 64,
          ),
          Text(
            title,
            style: textTheme.display2,
          )
        ],
      ),
    );
  }
}
