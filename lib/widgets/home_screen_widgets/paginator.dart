import 'package:fireblogs/constants.dart';
import 'package:fireblogs/data/blogs.dart';
import 'package:fireblogs/widgets/add_blog_screen_widgets/normal_loader.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:fireblogs/date_enum.dart';

class Paginator extends StatefulWidget {
  @override
  _PaginatorState createState() => _PaginatorState();
}

class _PaginatorState extends State<Paginator> {
  bool isLoading = false;

  void onClick(DateType dateType) async {
    Provider.of<Blogs>(context, listen: false).resetFetchingBooleans(true);
    setState(() {
      isLoading = true;
    });
    await Provider.of<Blogs>(context, listen: false)
        .fetchBlogsFromFirebase(dateType);
    Provider.of<Blogs>(context, listen: false).resetFetchingBooleans(false);
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<Blogs>(
      builder: (ctx, blogs, _) => Padding(
        padding: EdgeInsets.only(left: 20, bottom: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            isLoading
                ? NormalLoader(
                    size: 14,
                    color: Colors.orange,
                  )
                : Text(
                    '${DateFormat('dd MMM').format(blogs.getWeekData['startDate'])}' +
                        ' - ${DateFormat('dd MMM').format(blogs.getWeekData['endDate'])}',
                    style: kPaginatorTextStyle,
                  ),
            Spacer(),
            IconButton(
              constraints: BoxConstraints(
                maxHeight: 30,
              ),
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              icon: Icon(Icons.chevron_left),
              onPressed: !blogs.selectedDate.isAfter(DateTime.utc(2020, 08, 26))
                  ? null
                  : () => onClick(DateType.older),
            ),
            IconButton(
                constraints: BoxConstraints(maxHeight: 30),
                icon: Icon(Icons.chevron_right),
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onPressed: !blogs.selectedDate
                        .isBefore(DateTime.now().subtract(Duration(days: 8)))
                    ? null
                    : () => onClick(DateType.newer)),
          ],
        ),
      ),
    );
  }
}
