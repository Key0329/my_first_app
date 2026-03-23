import 'package:flutter/material.dart';
import '../theme/design_tokens.dart';

/// 工具頁面中的區段卡片，使用品牌色淡底、無邊框、圓角容器。
/// 可選的 [label] 會以品牌色文字顯示於內容上方。
class ToolSectionCard extends StatelessWidget {
  const ToolSectionCard({super.key, required this.child, this.label});

  final Widget child;
  final String? label;

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    final bgColor = brightness == Brightness.dark
        ? DT.brandPrimaryBgDark
        : DT.brandPrimaryBgLight;
    final labelColor = brightness == Brightness.dark
        ? DT.brandPrimarySoft
        : DT.brandPrimary;

    return Container(
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(DT.toolSectionRadius),
      ),
      child: Padding(
        padding: const EdgeInsets.all(DT.toolSectionPadding),
        child: label != null
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    label!,
                    style: TextStyle(
                      fontSize: DT.fontToolLabel,
                      color: labelColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: DT.spaceSm),
                  child,
                ],
              )
            : child,
      ),
    );
  }
}
