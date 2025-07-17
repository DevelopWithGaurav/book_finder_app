import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../common/extensions.dart';
import '../generated/assets.dart';

export '../../generated/assets.dart';

class CustomImage extends StatelessWidget {
  final String path;
  final double? height;
  final double? width;
  final BoxFit? fit;
  final String? placeholder;
  final String? onError;
  final Color? color;
  final Alignment? alignment;
  final Function()? onTap;
  final bool viewFullScreen;
  final double radius;
  final bool isFile;
  final File? imageFile;
  const CustomImage({
    super.key,
    required this.path,
    this.height,
    this.width,
    this.fit,
    this.placeholder,
    this.color,
    this.onError,
    this.alignment,
    this.onTap,
    this.radius = 0,
    this.viewFullScreen = false,
    this.isFile = false,
    this.imageFile,
  });

  @override
  Widget build(BuildContext context) {
    // log('${image.replaceAll('\\', '/')}',name: "IMAGE");
    // if(p)
    return InkWell(
      borderRadius: BorderRadius.circular(radius),
      onTap: (onTap != null || viewFullScreen)
          ? () {
              if (onTap != null) {
                onTap!();
              }
              if (viewFullScreen) {
                // Navigator.push(context, getCustomRoute(child: ImageGallery(images: [path])));
              }
            }
          : null,
      child: Ink(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(radius),
          child: Builder(builder: (context) {
            if (isFile && imageFile != null) {
              return Image.file(
                imageFile!,
                fit: fit,
                height: height,
                width: width,
              );
            }

            if (path.startsWith('assets/')) {
              return _CustomAssetImage(
                path: path,
                fit: fit,
                height: height,
                width: width,
                color: color,
                alignment: alignment ?? Alignment.center,
              );
            }
            String url = path.replaceAll('\\', '/');

            return CachedNetworkImage(
              imageUrl: url.url,
              height: height,
              width: width,
              fit: fit,
              placeholderFadeInDuration: const Duration(seconds: 1),
              alignment: alignment ?? Alignment.center,
              placeholder: (context, imageUrl) {
                return Transform(
                  transform: placeholder != null ? Matrix4.diagonal3Values(0.75, 0.75, 1) : Matrix4.diagonal3Values(1, 1, 1),
                  alignment: Alignment.center,
                  child: Image.asset(
                    placeholder != null ? placeholder! : Assets.assetsImagesShimmer,
                    height: height,
                    width: width,
                    fit: BoxFit.cover,
                  ),
                );
              },
              errorWidget: (context, imageUrl, stackTrace) {
                return Image.asset(
                  onError != null ? onError! : Assets.assetsImagesPlaceholder,
                  height: height,
                  width: width,
                  fit: fit,
                  color: color,
                );
              },
            );
          }),
        ),
      ),
    );
  }
}

class _CustomAssetImage extends StatelessWidget {
  const _CustomAssetImage({
    // ignore: unused_element_parameter
    super.key,
    required this.path,
    this.height,
    this.width,
    this.color,
    this.fit,
    this.alignment,
  });

  final String path;
  final Color? color;
  final double? height;
  final double? width;
  final BoxFit? fit;
  final Alignment? alignment;

  @override
  Widget build(BuildContext context) {
    return Image(
      image: AssetImage(path),
      fit: fit,
      height: height,
      width: width,
      color: color,
      alignment: alignment ?? Alignment.center,
    );
  }
}
