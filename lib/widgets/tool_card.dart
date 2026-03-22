import 'package:flutter/material.dart';
import 'package:my_first_app/models/tool_item.dart';
import 'package:my_first_app/theme/design_tokens.dart';

class ToolCard extends StatefulWidget {
  const ToolCard({
    super.key,
    required this.tool,
    required this.isFavorite,
    required this.onTap,
    required this.onLongPress,
    required this.onFavoriteToggle,
  });

  final ToolItem tool;
  final bool isFavorite;
  final VoidCallback onTap;
  final VoidCallback onLongPress;
  final VoidCallback onFavoriteToggle;

  @override
  State<ToolCard> createState() => _ToolCardState();
}

class _ToolCardState extends State<ToolCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _heartAnimController;
  late Animation<double> _heartScaleAnimation;

  @override
  void initState() {
    super.initState();
    _heartAnimController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
    _heartScaleAnimation = TweenSequence<double>([
      TweenSequenceItem(
        tween: Tween(begin: 1.0, end: 1.2)
            .chain(CurveTween(curve: Curves.easeOut)),
        weight: 50,
      ),
      TweenSequenceItem(
        tween: Tween(begin: 1.2, end: 1.0)
            .chain(CurveTween(curve: Curves.elasticOut)),
        weight: 50,
      ),
    ]).animate(_heartAnimController);
  }

  @override
  void dispose() {
    _heartAnimController.dispose();
    super.dispose();
  }

  void _onHeartTap() {
    _heartAnimController.forward(from: 0.0);
    widget.onFavoriteToggle();
  }

  @override
  Widget build(BuildContext context) {
    final b = Theme.of(context).brightness;
    final cardColor = DT.cardBg(b);
    final borderColor = DT.cardBorder(b);
    final gradient = toolGradients[widget.tool.id];

    return Hero(
      tag: 'tool_hero_${widget.tool.id}',
      child: Material(
        color: cardColor,
        borderRadius: BorderRadius.circular(DT.radiusLg),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: widget.onTap,
          onLongPress: widget.onLongPress,
          borderRadius: BorderRadius.circular(DT.radiusLg),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(DT.radiusLg),
              border: Border.all(color: borderColor, width: 0.5),
            ),
            padding: const EdgeInsets.only(
              top: DT.spaceLg,
              bottom: DT.radiusMd,
              left: DT.spaceMd,
              right: DT.spaceMd,
            ),
            child: Stack(
              children: [
                // 主要內容
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // 漸層圓角方塊 icon
                    Container(
                      width: 56,
                      height: 56,
                      decoration: BoxDecoration(
                        gradient: gradient != null
                            ? LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: gradient,
                              )
                            : null,
                        color: gradient == null ? widget.tool.color : null,
                        borderRadius: BorderRadius.circular(DT.radiusMd),
                      ),
                      child: Icon(
                        widget.tool.icon,
                        color: Colors.white,
                        size: 28,
                      ),
                    ),
                    const SizedBox(height: 10),
                    // 工具名稱
                    Text(
                      widget.tool.fallbackName,
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w500,
                        color: DT.toolName(b),
                        height: 1.2,
                      ),
                      textAlign: TextAlign.center,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
                // 右上角愛心按鈕（含 AnimatedScale）
                Positioned(
                  top: -8,
                  right: -8,
                  child: ScaleTransition(
                    scale: _heartScaleAnimation,
                    child: IconButton(
                      icon: Icon(
                        widget.isFavorite
                            ? Icons.favorite
                            : Icons.favorite_border,
                        color: widget.isFavorite
                            ? DT.brandPrimary
                            : DT.subtitle(b),
                        size: 20,
                      ),
                      onPressed: _onHeartTap,
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(
                        minWidth: 32,
                        minHeight: 32,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
