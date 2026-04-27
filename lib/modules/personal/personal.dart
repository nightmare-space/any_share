import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:global_repository/global_repository.dart';
import 'package:speed_share/generated/l10n.dart';
import 'package:speed_share/modules/personal/setting/setting_page.dart';
import 'package:speed_share/modules/widget/header.dart';
import 'package:speed_share/speed_share.dart';
import 'package:url_launcher/url_launcher_string.dart';

class PersonalPage extends StatefulWidget {
  const PersonalPage({Key? key}) : super(key: key);

  @override
  State<PersonalPage> createState() => _PersonalPageState();
}

class _PersonalPageState extends State<PersonalPage> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: $(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Header(),
          if (personHeader != null)
            Column(
              children: [
                personHeader!,
                SizedBox(height: $(8)),
              ],
            ),
          SizedBox(height: $(12)),
          // personalItem(
          //   title: S.of(context).aboutSpeedShare,
          //   onTap: () {
          //     Get.to(const SettingPage());
          //   },
          // ),
          // personalItem(
          //   title: S.of(context).theTermsOfService,
          //   onTap: () {
          //     Get.to(const SettingPage());
          //   },
          // ),
          personalItem(
            title: l10n.projectBoard,
            onTap: () {
              Get.to(ViewMetric(
                uiWidth: 600,
                screenWidth: Get.size.width,
                child: const ProjBoardV2(),
              ));
            },
          ),
          personalItem(
            title: l10n.privacyAgreement,
            onTap: () {
              Get.to(const PrivacyPage());
            },
          ),
          personalItem(
            title: l10n.setting,
            onTap: () {
              Get.to(const SettingPage());
            },
          ),
          personalItem(
            title: l10n.joinQQGroup,
            onTap: () async {
              const String url = 'mqqapi://card/show_pslcard?src_type=internal&version=1&uin=673706601&card_type=group&source=qrcode';
              if (await canLaunchUrlString(url)) {
                await launchUrlString(url);
              } else {
                showToast(l10n.openQQFail);
                // throw 'Could not launch $url';
              }
            },
          ),
          personalItem(
            title: l10n.changeLog,
            onTap: () async {
              Get.to(const ChangeLogPage());
            },
          ),
          personalItem(
            title: l10n.aboutSpeedShare,
            onTap: () async {
              String license = await rootBundle.loadString('LICENSE');
              Get.to(AboutPage(
                applicationName: l10n.appName,
                appVersion: Config.versionName,
                versionCode: Config.versionCode,
                logo: Padding(
                  padding: EdgeInsets.only(top: $(32)),
                  child: SizedBox(
                    width: $(100),
                    height: $(100),
                    child: Image.asset('assets/icon/app_icon_1024.png'),
                  ),
                ),
                otherVersionLink: 'http://nightmare.press/YanTool/resources/SpeedShare/?C=N;O=A',
                openSourceLink: 'https://github.com/nightmare-space/speed_share',
                license: license,
                canOpenDrawer: false,
              ));
            },
          ),
        ],
      ),
    );
  }

  Widget personalItem({
    required String title,
    void Function()? onTap,
  }) {
    return Padding(
      padding: EdgeInsets.only(bottom: $(8)),
      child: Material(
        borderRadius: BorderRadius.circular($(12)),
        color: Theme.of(context).colorScheme.surfaceContainer,
        child: InkWell(
          borderRadius: BorderRadius.circular($(10)),
          onTap: () {
            onTap!();
          },
          child: Container(
            height: $(52),
            padding: EdgeInsets.symmetric(horizontal: $(10)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: TextStyle(fontSize: $(16)),
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  size: $(16),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
