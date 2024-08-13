### Project Overview: Advanced Data Cleaning in PostgreSQL


#### **Introduction:**
Welcome to my advanced data cleaning project in PostgreSQL. In this project, I took on the challenge of transforming a raw dataset into a clean, structured format, showcasing my ability to handle essential data cleaning tasks—a critical skill for any data analyst. This project involved standardizing date formats, normalizing address data, unifying categorical data, removing duplicates, and optimizing the dataset by dropping unnecessary columns. Below is a summary of the key steps and techniques I used to accomplish this.

#### **Step 1: Standardizing Date Formats**
The first task in the data cleaning process was to standardize the date format in the `sale_date` column. The original data included both date and time, but for analytical purposes, I only needed the date. I altered the column to convert it to the `date` data type, ensuring consistency and making the data easier to work with.

#### **Step 2: Resolving Missing Property Addresses**
Some records in the dataset had missing `property_address` values. To resolve this, I used a technique where I filled in these missing addresses by referencing other entries with the same `parcel_id`. This ensured that every property had a valid address, improving the overall integrity of the dataset.

#### **Step 3: Splitting Address Data into Components**
The `property_address` and `owner_address` columns contained combined data (e.g., street, city, state) that needed to be split into individual components for better usability. I used substring and splitting functions to break down these addresses into separate fields:
- `proprerty_split_address` and `proprerty_split_city` for the property address.
- `owner_split_addres`, `owner_split_city`, and `owner_split_state` for the owner address.

This step greatly improved the clarity and usability of the address data.

#### **Step 4: Unifying Categorical Data**
The `sold_as_vacant` column had inconsistent values, such as 'Y', 'N', and various other forms. To standardize this data, I implemented a case statement to unify these values into a consistent 'Yes' and 'No' format. This standardization made the data more uniform and easier to analyze.

#### **Step 5: Removing Duplicates**
Duplicates in a dataset can lead to skewed analysis, so I addressed this by identifying and removing duplicate records based on key columns such as `parcel_id`, `sale_date`, `sale_price`, and others. I utilized window functions to assign row numbers and deleted any rows where the row number was greater than one, effectively removing duplicates and ensuring that each entry was unique.

#### **Step 6: Cleaning Up Unused Columns**
After cleaning the data, several columns were no longer necessary. To streamline the dataset, I dropped these unused columns, including the original combined address fields and other less relevant data. This final step ensured that the dataset was lean, focused, and ready for further analysis.

#### **Conclusion:**
This project highlights my ability to perform advanced data cleaning tasks in PostgreSQL. By standardizing formats, resolving missing values, normalizing data, removing duplicates, and optimizing the dataset, I transformed a raw dataset into a clean, structured format. This project demonstrates my proficiency in SQL and my understanding of the data cleaning process, making it a valuable addition to my portfolio.

If you're interested in the detailed SQL code used in this project, you can find it in the associated files in this repository. Thank you for checking out my project!
