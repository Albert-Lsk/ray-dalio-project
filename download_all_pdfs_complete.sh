#!/bin/bash

echo "🚀 开始下载雷·达里奥完整PDF资料库..."

# 完整PDF下载链接数组
urls=(
    "https://www.bridgewater.com/big-debt-crises/principles-for-navigating-big-debt-crises-by-ray-dalio.pdf"
    "https://www.economicprinciples.org/downloads/ray_dalio__how_the_economic_machine_works__leveragings_and_deleveragings.pdf"
    "https://ia800207.us.archive.org/27/items/BridgewaterRayDalioPrinciples/Bridgewater%20-%20Ray%20Dalio%20-%20Principles.pdf"
    "https://irp.cdn-website.com/6256fbb5/files/uploaded/50713532.pdf"
    "https://www.economicprinciples.org/downloads/how-countries-go-broke-part-1.pdf"
    "http://charitythinking.weebly.com/uploads/4/5/5/4/45542031/ray_dalio_how_the_economic_machine_works.pdf"
    "http://orcamgroup.com/wp-content/uploads/2013/08/How-the-Economic-Machine-Works-A-Template-for-Understanding-What-is-Happening-Now-Ray-Dalio-Bridgewater.pdf"
)

# 对应的规范文件名
names=(
    "principles-for-navigating-big-debt-crises.pdf"
    "how-the-economic-machine-works-official.pdf"
    "principles-life-and-work.pdf"
    "changing-world-order.pdf"
    "how-countries-go-broke.pdf"
    "economic-machine-works-v1.pdf"
    "economic-machine-works-v2.pdf"
)

echo "📚 将下载 ${#urls[@]} 个PDF文件到Books/文件夹..."

# 循环下载所有PDF
for i in "${!urls[@]}"; do
    echo ""
    echo "⬇️ 下载文件 $((i+1))/${#urls[@]}: ${names[i]}"
    
    # 检查文件是否已存在
    if [ -f "Books/${names[i]}" ]; then
        echo "📄 文件已存在，跳过: ${names[i]}"
        continue
    fi
    
    # 下载文件
    wget -P Books/ "${urls[i]}" -O "Books/${names[i]}"
    
    # 检查下载是否成功
    if [ -f "Books/${names[i]}" ]; then
        file_size=$(ls -lh "Books/${names[i]}" | awk '{print $5}')
        echo "✅ 下载成功: ${names[i]} (${file_size})"
    else
        echo "❌ 下载失败: ${names[i]}"
    fi
done

echo ""
echo "🎉 PDF资料库下载完成！"
echo "📁 所有文件保存在: Books/"

# 显示统计信息
total_files=$(ls -1 Books/*.pdf 2>/dev/null | wc -l)
total_size=$(du -sh Books/ 2>/dev/null | cut -f1)
echo "📊 总计: $total_files 个PDF文件，总大小: $total_size"
