#!/bin/bash

echo "🎤 开始批量下载演讲和文章资料..."

# 演讲文字稿URLs
speech_urls=(
    "https://singjupost.com/transcript-of-ray-dalios-interview-on-moonshots-with-peter-diamandis/"
    "https://singjupost.com/economy-really-work-ray-dalio-transcript/"
)

# 演讲文件名
speech_names=(
    "2025_Moonshots_transcript.html"
    "2013_Economic_Machine_transcript.html"
)

# 文章URLs  
article_urls=(
    "https://www.chandlernguyen.com/blog/tag/ray-dalio/"
    "https://thestrive.co/ray-dalio-quotes/"
)

# 文章文件名
article_names=(
    "ray_dalio_blog_collection.html"
    "ray_dalio_quotes.html"
)

echo "📢 下载演讲文字稿..."
for i in "${!speech_urls[@]}"; do
    echo "⬇️ 下载演讲 $((i+1)): ${speech_names[i]}"
    wget "${speech_urls[i]}" -O "Speeches/${speech_names[i]}"
done

echo "📰 下载文章资料..."
for i in "${!article_urls[@]}"; do
    echo "⬇️ 下载文章 $((i+1)): ${article_names[i]}"
    wget "${article_urls[i]}" -O "Articles/${article_names[i]}"
done

echo "🎉 演讲和文章下载完成！"
