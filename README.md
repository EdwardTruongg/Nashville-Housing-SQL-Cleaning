# SQL-Nashville-Housing-Cleaning

This project is a beginner SQL data cleaning project where I cleaned a Nashville Housing dataset using Microsoft SQL Server. I used SQL queries to standardize date formats, split address columns, populate missing values, normalize fields, and remove duplicates. The goal was to practice real-world data cleaning techniques in SQL.

## 🔧 Tools Used

- Microsoft SQL Server Management Studio (SSMS)
- T-SQL
- Nashville Housing dataset (public)

## 📊 Key Cleaning Steps

- Standardized the SaleDate column to a consistent DATE format
- Populated missing PropertyAddress data by matching ParcelID
- Split PropertyAddress into separate Street and City columns using `SUBSTRING` and `CHARINDEX`
- Split OwnerAddress into separate Address, City, and State using `PARSENAME`
- Normalized the SoldAsVacant field by changing 1/0 to 'Yes'/'No'
- Removed duplicate rows using `ROW_NUMBER()` with a CTE
- Dropped unused columns for a cleaner final dataset

## ▶️ How to Run This Project

1. Open `cleaning_script.sql` in SQL Server Management Studio.
2. Make sure the `NashvilleHousing` table is available in your database.
3. Run each section step-by-step to see the cleaning process.
4. Verify the cleaned table by running `SELECT *` queries.

## 📚 Learning Takeaways

Through this project, I learned how to:

- Use `ALTER TABLE` and `UPDATE` for in-place cleaning
- Apply string functions like `SUBSTRING`, `CHARINDEX`, and `PARSENAME` to split columns
- Use a CTE with `ROW_NUMBER()` to safely remove duplicates
- Standardize Yes/No fields for consistency
- Document a clear cleaning workflow for reproducibility

---
