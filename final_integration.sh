#!/bin/bash

echo "🎯 开始生成雷·达里奥完整思想资料合集..."

# 确保输出目录存在
mkdir -p Output/{Final,PDF,Markdown,TXT}

# 创建最终合集文件
final_file="Output/Final/RayDalio_Complete_Collection.md"

# 开始创建合集文档
cat > "$final_file" << 'EOF'
# 雷·达里奥完整思想资料合集
## Ray Dalio Complete Works Collection

---
**生成时间**: $(date)
**资料来源**: 官方PDF、演讲文字稿、文章合集、语录整理
**处理方式**: 自动化脚本整合

---

EOF

echo "📚 整合书籍内容..."
echo -e "\n## 📖 书籍全集\n" >> "$final_file"

# 合并所有书籍文本
book_count=0
for txt_file in Output/TXT/*.txt; do
    if [ -f "$txt_file" ]; then
        filename=$(basename "$txt_file" .txt)
        echo "📖 整合书籍: $filename"
        
        echo -e "\n### 《$filename》\n" >> "$final_file"
        echo -e "---\n" >> "$final_file"
        cat "$txt_file" >> "$final_file"
        echo -e "\n\n---\n" >> "$final_file"
        
        book_count=$((book_count + 1))
    fi
done

echo "🎤 整合演讲内容..."
echo -e "\n## 🎙️ 演讲文字稿\n" >> "$final_file"

# 处理演讲HTML文件（提取纯文本）
speech_count=0
for html_file in Speeches/*.html; do
    if [ -f "$html_file" ]; then
        filename=$(basename "$html_file" .html)
        echo "🎤 整合演讲: $filename"
        
        echo -e "\n### $filename\n" >> "$final_file"
        echo -e "---\n" >> "$final_file"
        
        # 使用简单方法提取HTML中的文本
        if command -v html2text &> /dev/null; then
            html2text "$html_file" >> "$final_file"
        else
            # 简单的HTML标签清理
            sed 's/<[^>]*>//g' "$html_file" | sed '/^\s*$/d' >> "$final_file"
        fi
        
        echo -e "\n\n---\n" >> "$final_file"
        speech_count=$((speech_count + 1))
    fi
done

echo "📰 整合文章内容..."
echo -e "\n## 📰 文章与博客\n" >> "$final_file"

# 处理文章HTML文件
article_count=0
for html_file in Articles/*.html; do
    if [ -f "$html_file" ]; then
        filename=$(basename "$html_file" .html)
        echo "📰 整合文章: $filename"
        
        echo -e "\n### $filename\n" >> "$final_file"
        echo -e "---\n" >> "$final_file"
        
        # 提取HTML文本
        if command -v html2text &> /dev/null; then
            html2text "$html_file" >> "$final_file"
        else
            sed 's/<[^>]*>//g' "$html_file" | sed '/^\s*$/d' >> "$final_file"
        fi
        
        echo -e "\n\n---\n" >> "$final_file"
        article_count=$((article_count + 1))
    fi
done

echo "💬 整合语录内容..."
echo -e "\n## 💭 经典语录与金句\n" >> "$final_file"

# 处理语录文件
quote_count=0
for html_file in Quotes/*.html; do
    if [ -f "$html_file" ]; then
        filename=$(basename "$html_file" .html)
        echo "💬 整合语录: $filename"
        
        echo -e "\n### $filename\n" >> "$final_file"
        echo -e "---\n" >> "$final_file"
        
        # 提取HTML文本
        if command -v html2text &> /dev/null; then
            html2text "$html_file" >> "$final_file"
        else
            sed 's/<[^>]*>//g' "$html_file" | sed '/^\s*$/d' >> "$final_file"
        fi
        
        echo -e "\n\n---\n" >> "$final_file"
        quote_count=$((quote_count + 1))
    fi
done

# 添加文档结尾信息
cat >> "$final_file" << EOF

---

## 📊 资料统计

- **书籍数量**: $book_count 本
- **演讲数量**: $speech_count 篇  
- **文章数量**: $article_count 篇
- **语录合集**: $quote_count 个

---
**整合完成时间**: $(date)
**文件大小**: $(wc -c < "$final_file" | numfmt --to=iec)
**总行数**: $(wc -l < "$final_file")

EOF

echo "📄 生成最终PDF..."
# 生成PDF
if command -v pandoc &> /dev/null; then
    pandoc "$final_file" -o "Output/PDF/RayDalio_Complete_Collection.pdf" \
           --metadata title="雷·达里奥完整思想资料合集" \
           --metadata author="Ray Dalio" \
           --metadata date="$(date)" \
           --toc \
           --toc-depth=2
    
    if [ -f "Output/PDF/RayDalio_Complete_Collection.pdf" ]; then
        pdf_size=$(ls -lh "Output/PDF/RayDalio_Complete_Collection.pdf" | awk '{print $5}')
        echo "✅ PDF生成成功: RayDalio_Complete_Collection.pdf ($pdf_size)"
    else
        echo "❌ PDF生成失败"
    fi
else
    echo "⚠️ pandoc未安装，跳过PDF生成"
fi

# 复制Markdown文件到输出目录
cp "$final_file" "Output/Markdown/"

echo ""
echo "🎉 最终整合完成！"
echo "📁 输出文件："
echo "   - Markdown: $final_file"
echo "   - PDF: Output/PDF/RayDalio_Complete_Collection.pdf"
echo ""

# 显示文件大小统计
final_size=$(ls -lh "$final_file" | awk '{print $5}')
echo "📊 最终统计："
echo "   - 合集大小: $final_size"
echo "   - 包含内容: $book_count 本书籍, $speech_count 个演讲, $article_count 篇文章, $quote_count 个语录合集"
