import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/core/constants/app_colors.dart';
import 'package:movies_app/core/constants/app_images.dart';

class ButtomSheet extends StatefulWidget {
  const ButtomSheet({super.key, this.onAvatarSelected});

  final ValueChanged<String>? onAvatarSelected;

  @override
  State<ButtomSheet> createState() => _ButtomSheetState();
}

class _ButtomSheetState extends State<ButtomSheet> {
  String? selectedAvatar;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 500.h,
      color: AppColors.backgroundColor,

      child: GridView.builder(
        physics: const NeverScrollableScrollPhysics(),

        padding: EdgeInsets.all(20.w),

        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,

          crossAxisSpacing: 15.w,
          mainAxisSpacing: 15.h,

          childAspectRatio: 1,
        ),

        itemCount: 9,

        itemBuilder: (context, index) {
          final avatar = 'avatar${index + 1}';

          final bool isSelected = selectedAvatar == avatar;

          return GestureDetector(
            onTap: () {
              setState(() {
                selectedAvatar = avatar;
              });

              widget.onAvatarSelected?.call(avatar);
            },

            child: Container(
              padding: EdgeInsets.all(8.w),

              decoration: BoxDecoration(
                color: isSelected
                    ? AppColors.mainColor.withOpacity(0.3)
                    : Colors.transparent,

                border: Border.all(color: AppColors.mainColor, width: 2.w),

                borderRadius: BorderRadius.circular(15.r),
              ),

              child: Image.asset(_getAvatarPath(avatar)),
            ),
          );
        },
      ),
    );
  }

  String _getAvatarPath(String avatar) {
    switch (avatar) {
      case 'avatar1':
        return AppImages.avatar1;
      case 'avatar2':
        return AppImages.avatar2;
      case 'avatar3':
        return AppImages.avatar3;
      case 'avatar4':
        return AppImages.avatar4;
      case 'avatar5':
        return AppImages.avatar5;
      case 'avatar6':
        return AppImages.avatar6;
      case 'avatar7':
        return AppImages.avatar7;
      case 'avatar8':
        return AppImages.avatar8;
      case 'avatar9':
        return AppImages.avatar9;
      default:
        return AppImages.avatar1;
    }
  }
}
