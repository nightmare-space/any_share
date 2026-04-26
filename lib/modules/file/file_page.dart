import 'dart:io';
import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:global_repository/global_repository.dart';
import 'package:open_file/open_file.dart';
import 'package:path/path.dart' as path;
import 'package:responsive_framework/responsive_framework.dart';
import 'package:speed_share/app/controller/file_controller.dart';
import 'package:file_manager/file_manager.dart' as file_manager;
import 'package:speed_share/generated/l10n.dart';
import 'package:speed_share/themes/theme.dart';
import '../widget/header.dart';
import '../widget/icon.dart';
import 'package:android_api_server_client/android_api_server_client.dart';

class NiIconButton extends StatelessWidget {
  const NiIconButton({Key? key, this.child, this.onTap}) : super(key: key);
  final Widget? child;
  final GestureTapCallback? onTap;
  @override
  Widget build(BuildContext context) {
    final $ = context.$;
    return SizedBox(
      width: $(48),
      height: $(48),
      child: InkWell(
        borderRadius: BorderRadius.circular($(24)),
        onTap: onTap,
        child: Padding(
          padding: EdgeInsets.all($(12)),
          child: child,
        ),
      ),
    );
  }
}

class FilePage extends StatefulWidget {
  const FilePage({Key? key}) : super(key: key);

  @override
  State<FilePage> createState() => _FilePageState();
}

class _FilePageState extends State<FilePage> {
  int pageIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: $(10)),
        child: Column(
          children: [
            Stack(
              alignment: Alignment.centerRight,
              children: [
                const Header(
                  showAddress: false,
                ),
                Padding(
                  padding: EdgeInsets.only(right: $(140)),
                  child: NiIconButton(
                    onTap: () {
                      pageIndex == 0 ? pageIndex = 1 : pageIndex = 0;
                      setState(() {});
                    },
                    child: const Icon(Icons.swap_horiz),
                  ),
                ),
              ],
            ),
            SizedBox(height: $(0)),
            Expanded(
              child: PageTransitionSwitcher(
                transitionBuilder: (
                  Widget child,
                  Animation<double> animation,
                  Animation<double> secondaryAnimation,
                ) {
                  return FadeThroughTransition(
                    animation: animation,
                    secondaryAnimation: secondaryAnimation,
                    fillColor: Colors.transparent,
                    child: child,
                  );
                },
                duration: const Duration(milliseconds: 600),
                layoutBuilder: (widgets) {
                  return Material(
                    color: Colors.transparent,
                    child: Stack(
                      children: widgets,
                    ),
                  );
                },
                child: [
                  // TODO(lin):
                  // fm.FileManager(
                  //   drawer: false,
                  //   path: '/sdcard/SpeedShare',
                  //   address: 'http://127.0.0.1:${fm.Config.port}',
                  //   padding: EdgeInsets.only(bottom: $(8)),
                  //   usePackage: true,
                  // ),
                  fileList(context),
                ][pageIndex],
              ),
            ),
          ],
        ),
      ),
    );
  }

  double getWidth(double max) {
    return (max - $(36)) / 4;
  }

  Material fileList(BuildContext context) {
    if (ResponsiveBreakpoints.of(context).isDesktop) {
      return Material(
        color: Theme.of(context).colorScheme.surface,
        child: Column(
          children: [
            LayoutBuilder(
              builder: (context, con) {
                double width = getWidth(con.maxWidth);
                return Wrap(
                  runSpacing: $(12),
                  spacing: $(12),
                  alignment: WrapAlignment.start,
                  runAlignment: WrapAlignment.start,
                  crossAxisAlignment: WrapCrossAlignment.start,
                  children: [
                    SizedBox(
                      width: width,
                      child: dir(context),
                    ),
                    SizedBox(
                      width: width,
                      child: onknownFile(context),
                    ),
                    SizedBox(
                      width: width,
                      child: zipFile(context),
                    ),
                    SizedBox(
                      width: width,
                      child: docFile(context),
                    ),
                    SizedBox(
                      width: width,
                      child: audio(context),
                    ),
                    SizedBox(
                      width: width,
                      child: video(context),
                    ),
                    SizedBox(
                      width: width,
                      child: imgFile(context),
                    ),
                    SizedBox(
                      width: width,
                      child: apkFile(context),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      );
    }
    return Material(
      color: Theme.of(context).colorScheme.surface,
      child: SingleChildScrollView(
        padding: EdgeInsets.zero,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: $(12)),
            dir(context),
            SizedBox(height: $(12)),
            onknownFile(context),
            SizedBox(height: $(12)),
            Row(
              children: [
                Expanded(child: zipFile(context)),
                SizedBox(width: $(12)),
                Expanded(child: docFile(context)),
              ],
            ),
            SizedBox(height: $(10)),
            Row(
              children: [
                Expanded(child: audio(context)),
                SizedBox(width: $(10)),
                Expanded(child: video(context)),
              ],
            ),
            SizedBox(height: $(10)),
            Row(
              children: [
                Expanded(child: imgFile(context)),
                SizedBox(width: $(10)),
                Expanded(child: apkFile(context)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  CardWrapper video(BuildContext context) {
    return CardWrapper(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          title(S.of(context).video),
          SizedBox(
            height: $(4),
          ),
          Container(
            // TODO(Lin): Do not use hard code color
            color: const Color(0xffE0C4C4).withOpacityExact(0.2),
            height: 1,
          ),
          SizedBox(
            height: $(4),
          ),
          Expanded(
            child: GetBuilder<FileController>(
              builder: (ctl) {
                List<Widget> children = [];
                for (FileSystemEntity name in ctl.videoFiles) {
                  children.add(
                    SizedBox(
                      width: $(60),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          getIconByExt(name.path, context),
                          SizedBox(height: $(8)),
                          SizedBox(
                            height: $(20),
                            child: Text(
                              path.basename(name.path),
                              maxLines: 2,
                              style: TextStyle(
                                fontSize: $(8),
                                height: 1.0,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                  children.add(
                    SizedBox(
                      width: $(8),
                    ),
                  );
                }
                if (children.isEmpty) {
                  return Center(
                    child: Text(
                      S.current.empty,
                      style: TextStyle(
                        fontSize: $(16),
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                    ),
                  );
                }
                return SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: children,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  CardWrapper audio(BuildContext context) {
    return CardWrapper(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          title(S.of(context).music),
          SizedBox(height: $(4)),
          Container(
            color: const Color(0xffE0C4C4).withOpacityExact(0.2),
            height: 1,
          ),
          SizedBox(height: $(10)),
          GetBuilder<FileController>(
            builder: (ctl) {
              List<Widget> children = [];
              for (FileSystemEntity file in ctl.audioFiles) {
                children.add(
                  Column(
                    children: [
                      getIconByExt(file.path, context),
                      SizedBox(
                        height: $(4),
                      ),
                      Text(
                        path.basename(file.path),
                        style: TextStyle(
                          fontSize: $(10),
                        ),
                      ),
                    ],
                  ),
                );
                children.add(
                  SizedBox(
                    width: $(20),
                  ),
                );
              }
              if (children.isEmpty) {
                return Center(
                  child: Text(
                    S.current.empty,
                    style: TextStyle(
                      fontSize: $(16),
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                );
              }
              return SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: children,
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  CardWrapper dir(BuildContext context) {
    return CardWrapper(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          title(S.of(context).directory),
          SizedBox(
            height: $(4),
          ),
          Container(
            // TODO: Do not use hard code color
            color: const Color(0xffE0C4C4).withOpacityExact(0.2),
            height: 1,
          ),
          SizedBox(
            height: $(10),
          ),
          Expanded(
            child: GetBuilder<FileController>(
              builder: (ctl) {
                List<Widget> children = [];
                for (FileSystemEntity name in ctl.dirFiles) {
                  children.add(
                    SizedBox(
                      width: $(60),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            '${file_manager.Config.packagePrefix}assets/icon/dir.svg',
                            width: $(32),
                            height: $(32),
                            color: Theme.of(context).primaryColor,
                          ),
                          SizedBox(
                            height: $(8),
                          ),
                          SizedBox(
                            height: $(20),
                            child: Text(
                              path.basename(name.path),
                              style: TextStyle(
                                fontSize: $(8),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                  children.add(
                    SizedBox(
                      width: $(4),
                    ),
                  );
                }
                if (children.isEmpty) {
                  return Center(
                    child: Text(
                      S.current.empty,
                      style: TextStyle(
                        fontSize: $(16),
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                    ),
                  );
                }
                return SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  padding: EdgeInsets.zero,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: children,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  CardWrapper imgFile(BuildContext context) {
    return CardWrapper(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          title(S.of(context).image),
          SizedBox(height: $(4)),
          Container(
            color: const Color(0xffE0C4C4).withOpacityExact(0.2),
            height: 1,
          ),
          SizedBox(height: $(4)),
          Expanded(
            child: GetBuilder<FileController>(
              builder: (ctl) {
                List<Widget> children = [];
                for (FileSystemEntity name in ctl.imgFiles) {
                  children.add(
                    SizedBox(
                      width: $(60),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          getIconByExt(name.path, context),
                          SizedBox(height: $(8)),
                          SizedBox(
                            height: $(20),
                            child: Text(
                              path.basename(name.path),
                              maxLines: 2,
                              style: TextStyle(
                                fontSize: $(8),
                                height: 1.0,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                  children.add(
                    SizedBox(
                      width: $(20),
                    ),
                  );
                }
                if (children.isEmpty) {
                  return Center(
                    child: Text(
                      S.current.empty,
                      style: TextStyle(
                        fontSize: $(16),
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                    ),
                  );
                }
                return SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: children,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  CardWrapper apkFile(BuildContext context) {
    return CardWrapper(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          title(S.of(context).apk),
          SizedBox(
            height: $(4),
          ),
          Container(
            color: const Color(0xffE0C4C4).withOpacityExact(0.2),
            height: 1,
          ),
          SizedBox(
            height: $(4),
          ),
          Expanded(
            child: GetBuilder<FileController>(
              builder: (ctl) {
                if (GetPlatform.isDesktop) {
                  return const SizedBox();
                }
                List<Widget> children = [];
                for (FileSystemEntity name in ctl.apkFiles) {
                  children.add(
                    SizedBox(
                      width: $(40),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {
                              OpenFile.open(name.path);
                            },
                            child: Image.network(
                              DefaultAas.apkIconUrl(path: name.path),
                              gaplessPlayback: true,
                              width: $(40),
                              height: $(40),
                              fit: BoxFit.cover,
                              errorBuilder: (_, __, ___) {
                                return const SizedBox();
                              },
                            ),
                          ),
                          SizedBox(
                            height: $(8),
                          ),
                          SizedBox(
                            height: $(20),
                            child: Text(
                              path.basename(name.path),
                              maxLines: 2,
                              style: TextStyle(
                                fontSize: $(8),
                                height: 1.0,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                  children.add(
                    SizedBox(
                      width: $(20),
                    ),
                  );
                }
                if (children.isEmpty) {
                  return Center(
                    child: Text(
                      S.current.empty,
                      style: TextStyle(
                        fontSize: $(16),
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                    ),
                  );
                }
                return SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: children,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  CardWrapper docFile(BuildContext context) {
    return CardWrapper(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          title(S.of(context).doc),
          SizedBox(height: $(4)),
          Container(
            color: const Color(0xffE0C4C4).withOpacityExact(0.2),
            height: 1,
          ),
          SizedBox(height: $(4)),
          Expanded(
            child: GetBuilder<FileController>(
              builder: (ctl) {
                List<Widget> children = [];
                for (FileSystemEntity file in ctl.docFiles) {
                  children.add(
                    SizedBox(
                      // color: Colors.red,
                      width: $(64),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          getIconByExt(file.path, context),
                          SizedBox(height: $(8)),
                          SizedBox(
                            height: $(20),
                            child: Text(
                              path.basename(file.path),
                              maxLines: 2,
                              style: TextStyle(
                                fontSize: $(8),
                                height: 1.0,
                                textBaseline: TextBaseline.ideographic,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                  children.add(
                    SizedBox(
                      width: $(4),
                    ),
                  );
                }
                if (children.isEmpty) {
                  return Center(
                    child: Text(
                      S.current.empty,
                      style: TextStyle(
                        fontSize: $(16),
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                    ),
                  );
                }
                return SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: children,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  CardWrapper zipFile(BuildContext context) {
    return CardWrapper(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          title(S.of(context).zip),
          SizedBox(height: $(4)),
          Container(
            color: const Color(0xffE0C4C4).withOpacityExact(0.2),
            height: 1,
          ),
          SizedBox(height: $(4)),
          Expanded(
            child: GetBuilder<FileController>(
              builder: (ctl) {
                List<Widget> children = [];
                for (FileSystemEntity file in ctl.zipFiles) {
                  children.add(
                    SizedBox(
                      // color: Colors.red,
                      width: $(64),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          getIconByExt(file.path, context),
                          SizedBox(height: $(8)),
                          SizedBox(
                            height: $(20),
                            child: Text(
                              path.basename(file.path),
                              maxLines: 2,
                              style: TextStyle(
                                fontSize: $(8),
                                height: 1.0,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                  children.add(
                    SizedBox(
                      width: $(4),
                    ),
                  );
                }
                if (children.isEmpty) {
                  return Center(
                    child: Text(
                      S.current.empty,
                      style: TextStyle(
                        fontSize: $(16),
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                    ),
                  );
                }
                return SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: children,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Center title(String data) {
    return Center(
      child: Text(
        data,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Theme.of(context).colorScheme.onSurface,
          fontSize: $(16),
        ),
      ),
    );
  }

  CardWrapper onknownFile(BuildContext context) {
    return CardWrapper(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          title(S.of(context).unknownFile),
          SizedBox(height: $(4)),
          Container(
            color: const Color(0xffE0C4C4).withOpacityExact(0.2),
            height: 1,
          ),
          SizedBox(height: $(4)),
          Expanded(
            child: GetBuilder<FileController>(
              builder: (ctl) {
                List<Widget> children = [];
                for (FileSystemEntity file in ctl.onknown) {
                  children.add(
                    SizedBox(
                      width: $(64),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          getIconByExt(file.path, context),
                          SizedBox(height: $(8)),
                          SizedBox(
                            height: $(20),
                            child: Text(
                              path.basename(file.path),
                              maxLines: 2,
                              style: TextStyle(
                                fontSize: $(8),
                                height: 1,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                  children.add(
                    SizedBox(
                      width: $(4),
                    ),
                  );
                }
                if (children.isEmpty) {
                  return Center(
                    child: Text(
                      S.current.empty,
                      style: TextStyle(
                        fontSize: $(16),
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                    ),
                  );
                }
                return SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: children,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class CardWrapper extends StatelessWidget {
  const CardWrapper({
    Key? key,
    this.child,
    this.padding,
    this.height,
  }) : super(key: key);
  final Widget? child;
  final EdgeInsetsGeometry? padding;
  final double? height;

  @override
  Widget build(BuildContext context) {
    final $ = context.$;
    return Container(
      decoration: BoxDecoration(
        color: context.colorScheme.surfaceContainer,
        borderRadius: BorderRadius.circular($(12)),
      ),
      height: height ?? $(120),
      padding: padding ??
          EdgeInsets.symmetric(
            vertical: $(4),
            horizontal: $(12),
          ),
      child: child,
    );
  }
}
