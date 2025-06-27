#!/bin/bash

echo "🔄 开始批量转换所有PDF文件为文本格式..."

# 确保输出目录存在
mkdir -p Output/TXT Output/Markdown

# 计算PDF文件总数
pdf_count=$(find Books -name "*.pdf" | wc -l)
echo "📚 发现 $pdf_count 个PDF文件"

counter=1

# 批量转换PDF为TXT
echo "📝 转换为TXT格式..."
for pdf_file in Books/*.pdf; do
    if [ -f "$pdf_file" ]; then
        # 获取文件名（不含路径和扩展名）
        filename=$(basename "$pdf_file" .pdf)
        
        echo "⬇️ ($counter/$pdf_count) 转换: $filename"
        
        # PDF转TXT
        pdftotext "$pdf_file" "Output/TXT/${filename}.txt"
        
        # 检查转换是否成功
        if [ -f "Output/TXT/${filename}.txt" ]; then
            echo "✅ TXT转换成功: ${filename}.txt"
        else
            echo "❌ TXT转换失败: $filename"
        fi
        
        counter=$((counter + 1))
    fi
done

echo "🎉 所有PDF文件转换完成！"
echo "📁 文本文件保存在: Output/TXT/"

# 显示转换结果统计
txt_count=$(find Output/TXT -name "*.txt" | wc -l)
echo "📊 成功转换: $txt_count 个文件"
