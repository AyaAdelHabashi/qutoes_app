import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:qutoes_app/core/di.dart';
import 'package:qutoes_app/core/theme/colors.dart';
import 'package:qutoes_app/core/widgets/appbar.dart';
import 'package:qutoes_app/feature/profile/controller/profile_controller.dart';
import 'package:qutoes_app/feature/profile/ui/widgets/lang_dialog.dart';
import 'package:qutoes_app/feature/profile/ui/widgets/logout.dart';
import 'package:qutoes_app/feature/profile/ui/widgets/profile_action.dart';
import 'package:qutoes_app/feature/profile/ui/widgets/profile_header.dart';
import 'package:qutoes_app/feature/profile/ui/widgets/profile_tile.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  bool getProfileInfoLoading = false;
  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileController>(
      builder: (context, provider, child) {
        return SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              provider.isLoading
                  ? Center(child: CircularProgressIndicator())
                  : Column(
                      children: [
                        ProfileHeader(
                          name: provider.user["name"] ?? "",
                          email: provider.user["email"] ?? "",
                          imageUrl: "https://i.pravatar.cc/300",
                        ),
                        SizedBox(height: 16),
                        //  ProfileActions(),
                        ProfileOptionTile(
                          icon: 'assets/images/edit_profile.svg',
                          title: tr("edit_profile"),
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return ChangeNotifierProvider.value(
                                  value: ServiceLocator.getIt<ProfileController>(),
                                  child: Consumer<ProfileController>(
                                    builder: (context, provider2, child) {
                                      return AlertDialog(
                                        title: Text(tr("edit_profile")),
                                        content: Form(
                                          key: provider2.formKey,
                                          child: TextFormField(
                                            autovalidateMode: AutovalidateMode.onUserInteraction,
                                            controller: provider2.nameController,
                                            validator: (value) {
                                              if (value == null || value.isEmpty) {
                                                return tr("name_required");
                                              }
                                              return null;
                                            },
                                            decoration: InputDecoration(
                                              hintText: tr("name"),
                                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                                            ),
                                          ),
                                        ),
                                        actions: [
                                          TextButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: Text(tr("Cancel")),
                                          ),
                                          provider2.updateProfileLoading
                                              ? Center(child: CircularProgressIndicator())
                                              : TextButton(
                                                  onPressed: () {
                                                    if (provider2.formKey.currentState!.validate()) {
                                                      provider2.updateProfile(context: context);
                                                    }
                                                  },
                                                  child: Text(tr("Confirm")),
                                                ),
                                        ],
                                      );
                                    },
                                  ),
                                );
                              },
                            );
                          },
                        ),
                        SizedBox(height: 8),

                        ProfileOptionTile(
                          icon: 'assets/images/change_password.svg',
                          title: tr('change+password'),
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (context) => ChangeNotifierProvider.value(
                                value: ServiceLocator.getIt<ProfileController>(),
                                child: Consumer<ProfileController>(
                                  builder: (context, provider, child) {
                                    return AlertDialog(
                                      title: Text(tr("change_password")),
                                      content: Form(
                                        key: provider.changePasswordFormKey,
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            TextFormField(
                                              controller: provider.oldPasswordController,
                                              validator: (value) {
                                                if (value == null || value.isEmpty) {
                                                  return "Old password is required";
                                                }
                                                return null;
                                              },

                                              decoration: InputDecoration(
                                                hintText: tr("old_password"),
                                                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                                              ),
                                            ),
                                            SizedBox(height: 12),
                                            TextFormField(
                                              validator: (value) {
                                                if (value == null || value.isEmpty) {
                                                  return tr("new_password_required");
                                                }
                                                return null;
                                              },
                                              controller: provider.newPasswordController,
                                              decoration: InputDecoration(
                                                hintText: tr("new_password"),
                                                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: Text(tr("cancel")),
                                        ),
                                        provider.changePasswordLoading
                                            ? Center(child: CircularProgressIndicator())
                                            : TextButton(
                                                onPressed: () {
                                                  if (provider.changePasswordFormKey.currentState!.validate()) {
                                                    provider.changePassword(context: context);
                                                  }
                                                },
                                                child: Text(tr("confirm")),
                                              ),
                                      ],
                                    );
                                  },
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
              SizedBox(height: 8),
              ProfileOptionTile(
                icon: 'assets/images/translate.svg',
                title: tr('language'),
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return LanguageDialog();
                    },
                  );
                },
              ),
              SizedBox(height: 8),
              ProfileOptionTile(
                icon: 'assets/images/logout.svg',
                title: tr('logout'),
                iconColor: Colors.red,
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return LogoutDialog();
                    },
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
