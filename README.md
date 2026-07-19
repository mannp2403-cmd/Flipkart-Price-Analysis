# 🛒 Flipkart E-Commerce Product Analysis Dashboard

## 📌 Project Overview
This project presents an interactive, enterprise-grade business intelligence dashboard developed in **Power BI** to evaluate and analyze product distribution, pricing architectures, market segmentation, and markdown strategies across **Flipkart's e-commerce platform**.

The dashboard translates massive tabular web-scraped data into clean, executive-level visual insights. By organizing raw pricing metrics into dynamic distribution groups (price points, discount depths, and customer sentiment), this analytical dashboard helps brand managers and category analysts instantly track listing volume health, spot heavily discounted segments, and audit competitive brand positioning.

---

## 🛠️ Data Architecture & Tech Stack
*   **Data Source:** Raw e-commerce product listings containing features such as brand names, pricing, categories, and ratings.
*   **Data Transformation Layer:** Power Query (M Language) for structural database schema cleanups.
*   **Data Modelling Engine:** Power BI DAX (Data Analysis Expressions) for calculated columns and custom metrics.
*   **Front-End Presentation:** Power BI Desktop with a tailored, modern application-style dark UI theme.

---

## 📊 Business Key Performance Indicators (KPIs)
To provide an analytical baseline at the absolute top layer of the canvas, the following core DAX measures were constructed to populate the KPI banner:

1. **Total Unique Listings Volume:**
   ```dax
   Total Products = COUNTROWS('flipkart_clean_final')
   ```
2. **Brand Variety Index:**
   ```dax
   Total Brands = DISTINCTCOUNT('flipkart_clean_final'[brand])
   ```
3. **Macro Category Spread:**
   ```dax
   Total Categories = DISTINCTCOUNT('flipkart_clean_final'[primary_category])
   ```
4. **Platform-wide Quality Baseline:**
   ```dax
   Avg Rating = AVERAGE('flipkart_clean_final'[product_rating])
   ```

---

## 📈 Dashboard Layout & Visual Anchors

The canvas relies on a professional, 16:9 widescreen layout divided into strategic structural zones:

### 1️⃣ Core Engine Layer (Middle Row)
*   **Visual 1: Top 10 Categories by Listing Volume (Clustered Column Chart)**
    *   *X-Axis:* `primary_category` | *Y-Axis:* `Total Products` measure.
    *   *Filters Applied:* Top N constraint limiting the chart to the top 10 categories ranked by volume to prevent visualization bloat.
*   **Visual 2: Top 10 High-Volume Brands (Clustered Bar Chart)**
    *   *Y-Axis:* `brand` | *X-Axis:* `Total Products` measure.
    *   *Context:* Configured horizontally to provide immediate comparison with the category volume graph.

### 2️⃣ Macro Market Share & Sentiments (Bottom Row)
*   **Visual 3: Product Sentiment Archetypes (Donut Chart)**
    *   *Legend:* `rating_tier` | *Values:* `Total Products`.
    *   *Objective:* Captures a distribution breakdown showing customer rating buckets.
*   **Visual 4: Price Point Concentration (Pie Chart)**
    *   *Legend:* `price_dist_tier` | *Values:* `Total Products`.
    *   *Objective:* Displays inventory distribution ratios across low, medium, premium, and luxury cost segments.
*   **Visual 5: Markdown Depth Analysis (Large Bottom Column Chart)**
    *   *X-Axis:* `discount_tier` | *Y-Axis:* `Total Products`.
    *   *Styling:* Custom color-coded sequence mapping discount bands from conservative (0-20%) to aggressive clearances (80-100%).

---

## ⚙️ Data Engineering & Calculated Columns (Binning Logic)
Continuous numerical attributes were grouped into operational bins to make the visualization clean and prevent "rainbow-wheel" visual overloads. These groups were mapped dynamically using calculated columns:

### ⚡ 1. Price Range Segments
```dax
price_dist_tier = 
SWITCH(
    TRUE(),
    'flipkart_clean_final'[retail_price] < 500, "<500",
    'flipkart_clean_final'[retail_price] <= 1000, "500-1000",
    'flipkart_clean_final'[retail_price] <= 2000, "1000-2000",
    'flipkart_clean_final'[retail_price] <= 5000, "2000-5000",
    ">5000"
)
```

### ⚡ 2. Customer Sentiment Ranges
```dax
rating_tier = 
SWITCH(
    TRUE(),
    'flipkart_clean_final'[product_rating] <= 2, "1-2",
    'flipkart_clean_final'[product_rating] <= 3, "2-3",
    'flipkart_clean_final'[product_rating] <= 4, "3-4",
    "4-5"
)
```

### ⚡ 3. Markdown Target Bands
```dax
discount_tier = 
SWITCH(
    TRUE(),
    'flipkart_clean_final'[discount_percentage] <= 20, "0-20%",
    'flipkart_clean_final'[discount_percentage] <= 40, "20-40%",
    'flipkart_clean_final'[discount_percentage] <= 60, "40-60%",
    'flipkart_clean_final'[discount_percentage] <= 80, "60-80%",
    "80-100%"
)
```

---

## 🛑 Key Technical Challenges & Resolutions

### 🧩 Challenge 1: The 27,000 Ghost-Rows Data Pollution
*   **Symptom:** Donut charts displayed a massive unnamed blue slice capturing **27K records (approx 70% of the entire dataset)**. Similarly, bar charts showed an enormous blank category row, which artificially inflated the summary KPI metrics.
*   **Root Cause:** During raw CSV compilation/export steps, thousands of terminal blank entries were processed by Power BI as active records containing `NULL` text attributes.
*   **Resolution:** Patched at the database core by accessing **Power Query Editor**, filtering the `primary_category` column headers, and unchecking the `(Blank)` / `Null` entries. This executed a clean row-by-row structural purging, reducing the overall record volume to true active items and automatically fixing the KPI totals.


---

## 🎨 Professional Presentation & UI Polish
To move away from standard default layouts, this dashboard was designed like a premium SaaS application interface:
*   **Background Canvas:** Set to a deep, high-contrast violet/slate color palette by turning the canvas background transparency down to `0%`.
*   **Visual Framing:** Every component utilizes a clean, high-contrast white container block styled with an active **Visual Border**, curved margins rounded to **12px**, and muted **Bottom-Right Drop Shadows** to construct a sleek, floating glassmorphism design language.
*   **Clean Geometry:** Monotonous X and Y axes numbers were disabled across the bar visuals, replacing them with precise, clean **Data Labels** located directly at the terminal tips of the charts.

---

## 🖼️ Dashboard Showcase
*(Placeholder for the terminal polished interface rendering)*

![image

---
### 💡 How to Run the Project
1. Clone this repository to your local architecture.
2. Ensure you have the latest edition of **Power BI Desktop** installed.
3. Open the `.pbix` dashboard model workspace.
4. If required, re-link the underlying data path to the `flipkart_clean_final.csv` source via the Transform Data environment.
