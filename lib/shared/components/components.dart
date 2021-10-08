import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop/layout/shop_app/cubit/shop_cubit.dart';
import 'package:shop/shared/styles/colors.dart';

Widget defaultButton({
  double width = double.infinity,
  Color background = Colors.blue,
  double radius = 0.0,
  bool isUpperCase = true,
  @required String text,
  @required Function function,
}) {
  return Container(
    height: 40.0,
    width: width,
    child: MaterialButton(
      onPressed: function,
      child: Text(
        isUpperCase ? text.toUpperCase() : text,
        style: TextStyle(color: Colors.white),
      ),
    ),
    decoration: BoxDecoration(
      color: background,
      borderRadius: BorderRadius.circular(
        radius,
      ),
    ),
  );
}

Widget defaultTextButton({
  @required String text,
  @required Function function,
}) =>TextButton(
    onPressed: function,
    child: Text(
      text.toUpperCase(),
    ),
  );


Widget defaultFormField({
  @required TextEditingController controller,
  @required TextInputType type,
  @required Function validation,
  @required String labelText,
  @required IconData prefix,
  Function onTap,
  Function onSubmit,
  Function onChange,
  IconData suffixIcon,
  bool obscureText = false,
  Function suffixIconPress,
  bool isClickable = true,
}) =>
    TextFormField(
      onFieldSubmitted: onSubmit,
      onChanged: onChange,
      enabled: isClickable,
      validator: validation,
      controller: controller,
      decoration: InputDecoration(
        prefixIcon: Icon(
          prefix,
        ),
        suffixIcon:
            IconButton(icon: Icon(suffixIcon), onPressed: suffixIconPress),
        labelText: labelText,
        border: OutlineInputBorder(),
      ),
      keyboardType: type,
      obscureText: obscureText,
      onTap: onTap,
    );

Widget buildTaskItem(Map model, context) => Dismissible(
      key: Key(model['id'].toString()),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            CircleAvatar(
              radius: 38.0,
              child: Text(
                "${model['time']}",
              ),
            ),
            SizedBox(
              width: 20,
            ),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${model['title']}",
                    style: TextStyle(
                      fontSize: 22.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "${model['date']}",
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: 20,
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.check_box,
                color: Colors.blue,
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.archive_outlined,
                color: Colors.black45,
              ),
            )
          ],
        ),
      ),
      onDismissed: (direction) {},
    );

Widget tasksBuilder({
  @required List<Map> tasks,
}) =>
    ConditionalBuilder(
      condition: tasks.length > 0,
      builder: (context) => ListView.separated(
        itemBuilder: (context, index) => buildTaskItem(tasks[index], context),
        separatorBuilder: (context, index) => Divider(
          height: 1.0,
          color: Colors.amber,
          thickness: 2.0,
        ),
        itemCount: tasks.length,
      ),
      fallback: (context) => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.menu,
              size: 80.0,
              color: Colors.black45,
            ),
            Text(
              "No Tasks Yet, Please Add Some Tasks ",
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );



Widget myDivider() => Divider(
      height: 1.0,
      color: Colors.amber,
      thickness: 2.0,
    );



void navigateTo(context, widget) =>
    Navigator.push(context, MaterialPageRoute(builder: (context) => widget));

void navigateAndFinish(context, widget) => Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
      (route) => false,
    );
void showToast({
  @required String text,
  @required ToastState state,
})=> Fluttertoast.showToast(
  msg: text,
  toastLength: Toast.LENGTH_LONG,
  gravity: ToastGravity.BOTTOM,
  timeInSecForIosWeb: 5,
  backgroundColor:chooseToastColor(state),
  textColor: Colors.white,
  fontSize: 16.0,
);


enum ToastState {SUCCESS,ERROR,WARNING}


Color chooseToastColor(ToastState state)
{
  Color color;
  switch(state)
  {
    case ToastState.SUCCESS:
      color=Colors.green;
    break;
    case ToastState.ERROR:
      color=Colors.red;
      break;
    case ToastState.WARNING:
      color=Colors.amber;
      break;
  }
  return color;
}

Widget buildListProduct(
    model,
    context, {
      bool isOldPrice = true,
    }) =>
    Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        height: 120.0,
        child: Row(
          children: [
            Stack(
              alignment: AlignmentDirectional.bottomStart,
              children: [
                Image(
                  image: NetworkImage(model.image),
                  width: 120.0,
                  height: 120.0,
                ),
                if (model.discount != 0 && isOldPrice)
                  Container(
                    color: Colors.red,
                    padding: EdgeInsets.symmetric(
                      horizontal: 5.0,
                    ),
                    child: Text(
                      'DISCOUNT',
                      style: TextStyle(
                        fontSize: 8.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
              ],
            ),
            SizedBox(
              width: 20.0,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    model.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 14.0,
                      height: 1.3,
                    ),
                  ),
                  Spacer(),
                  Row(
                    children: [
                      Text(
                        model.price.toString(),
                        style: TextStyle(
                          fontSize: 12.0,
                          color: defaultColor,
                        ),
                      ),
                      SizedBox(
                        width: 5.0,
                      ),
                      if (model.discount != 0 && isOldPrice)
                        Text(
                          model.oldPrice.toString(),
                          style: TextStyle(
                            fontSize: 10.0,
                            color: Colors.grey,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                      Spacer(),
                      IconButton(
                        onPressed: () {
                          ShopCubit.get(context).changeFavorites(model.id);
                        },
                        icon: CircleAvatar(
                          radius: 15.0,
                          backgroundColor:
                          ShopCubit.get(context).favourite[model.id]
                              ? defaultColor
                              : Colors.grey,
                          child: Icon(
                            Icons.favorite_border,
                            size: 14.0,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );