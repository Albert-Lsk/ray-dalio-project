#!/bin/bash

echo "💬 开始下载雷·达里奥语录和金句资料..."

# 语录资源URLs
quote_urls=(
    "https://thestrive.co/ray-dalio-quotes/"
    "https://www.cantechletter.com/2023/08/ray-dalio-principles-a-summary/"
    "https://fourminutebooks.com/ray-dalio-books/"
)

# 语录文件名
quote_names=(
    "ray_dalio_quotes_35_collection.html"
    "principles_summary_quotes.html"
    "book_summaries_quotes.html"
)

echo "📝 将下载 ${#quote_urls[@]} 个语录资源..."

# 循环下载语录
for i in "${!quote_urls[@]}"; do
    echo "⬇️ 下载语录资源 $((i+1))/${#quote_urls[@]}: ${quote_names[i]}"
    wget "${quote_urls[i]}" -O "Quotes/${quote_names[i]}"
    
    if [ -f "Quotes/${quote_names[i]}" ]; then
        echo "✅ 成功: ${quote_names[i]}"
    else
        echo "❌ 失败: ${quote_names[i]}"
    fi
done

echo "🎉 语录资料下载完成！"
echo "📁 语录文件保存在: Quotes/"
