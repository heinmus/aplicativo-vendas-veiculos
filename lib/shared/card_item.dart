import 'package:flutter/material.dart';

class CardItem extends StatelessWidget {
  final String title;
  final String? subtitle;
  final String? detail;
  final Color backgroundColor;
  final String? imageUrl;
  final IconData icon;
  final VoidCallback? onTap;

  const CardItem({
    super.key,
    required this.title,
    this.subtitle,
    this.detail,
    required this.backgroundColor,
    this.imageUrl,
    required this.icon,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.blue.shade100,
      elevation: 3, 
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Parte de cima: imagem ou ícone
              Expanded(
                child: Center(
                  child: (imageUrl != null && imageUrl!.isNotEmpty)
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.asset(
                            imageUrl!,
                            width: double.infinity,
                            height: double.infinity,
                            fit: BoxFit.cover,
                            errorBuilder: (context, erro, stack) {
                              return Icon(
                                icon,
                                size: 45,
                                color: Colors.red.shade400,
                              );
                            },
                          ),
                        )
                      : Icon(
                          icon,
                          size: 48,
                          color: Colors.blue.shade800,
                        ),
                ),
              ),

              const SizedBox(height: 8),

              // Título 
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),

              if (subtitle != null)
                Text(
                  subtitle!,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[700],
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),

              if (detail != null)
                Text(
                  detail!,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.black54,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
