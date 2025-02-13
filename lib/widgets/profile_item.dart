
import 'package:flutter/material.dart';


class ProfileItem extends StatelessWidget {
  final String icon;
  final String title;
  final String? subtitle;
  final Function()? onTap;

  const ProfileItem (
      {super.key,
        required this.icon,
        required this.title,
        this.subtitle, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: ListTile(
        onTap: onTap,
        leading: Image.asset(icon,width: 40,height: 40,),
        title: Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            color: Colors.black54,
          ),
        ),
        subtitle: subtitle != null
            ? Text(
          subtitle!,
          style: const TextStyle(
            fontSize: 16,
            color: Colors.black87,
            fontWeight: FontWeight.w500,
          ),
        )
            : null,
        trailing: onTap!=null? const Icon(
          Icons.arrow_forward_ios_rounded,
          color: Colors.black54,
          size: 20,
        ) : null,
        contentPadding: EdgeInsets.zero,
      ),
    );
  }
}