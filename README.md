# MSSQL Data Cleaning Lab

Enterprise-style SQL Server data cleaning, normalization, and integrity enforcement project.

This project demonstrates production-level database design principles including:

* Data normalization
* Duplicate handling
* Persisted computed columns
* Index strategy
* Unique constraint enforcement
* Transaction-safe stored procedures
* Error handling patterns
* Deterministic expression design

---

## 📦 Project Structure

```
mssql-data-cleaning-lab
│
├── 00_create_database.sql
│
├── 01_Tables
│   ├── Customers.sql
│   ├── Customers_Alter_AddComputedColumns.sql
│   ├── Customers_AddIndexes.sql
│   └── Customers_AddUniqueConstraint.sql
│
├── 04_StoredProcedures
│   └── usp_InsertCustomer.sql
│
├── 05_Functions
│   └── fn_NormalizeText.sql
│
├── 07_DataCleaning
│   ├── Remove_Duplicates_Customers.sql
│   └── Normalize_Customers.sql
│
└── README.md
```

---

## 🎯 Project Goals

The main goal of this project is to simulate a real-world production data cleaning and integrity enforcement workflow in Microsoft SQL Server.

Key objectives:

* Clean inconsistent customer data
* Normalize text values (case, whitespace, Turkish characters)
* Prevent duplicate email entries at database level
* Implement transaction-safe insert operations
* Demonstrate enterprise-level SQL design patterns

---

## 🧹 Data Cleaning Strategy

### 1️⃣ Duplicate Detection

Duplicates are identified using:

```sql
ROW_NUMBER() OVER (PARTITION BY NormalizedEmail ORDER BY CreatedAt)
```

Oldest record is preserved, newer duplicates are removed.

---

### 2️⃣ Normalization

Normalization includes:

* `LOWER()`
* `LTRIM()` / `RTRIM()`
* Turkish character mapping:

  * ç → c
  * ğ → g
  * ı → i
  * ö → o
  * ş → s
  * ü → u

Normalization is implemented using **persisted computed columns** for performance and indexing support.

---

## 🏗 Architecture Highlights

### ✅ Persisted Computed Columns

```sql
NormalizedEmail AS LOWER(LTRIM(RTRIM(Email))) PERSISTED
```

Benefits:

* Automatically calculated
* Physically stored
* Indexable
* Deterministic

---

### ✅ Index Strategy

* `IX_Customers_NormalizedEmail`
* `IX_Customers_NormalizedFullName_City`
* `UX_Customers_NormalizedEmail` (UNIQUE)

The unique index enforces database-level duplicate prevention.

---

### ✅ Constraint-Driven Integrity

Duplicate prevention is handled by:

```sql
CREATE UNIQUE INDEX UX_Customers_NormalizedEmail
ON dbo.Customers (NormalizedEmail);
```

This ensures data integrity even under concurrent inserts.

---

### ✅ Enterprise Insert Pattern

`usp_InsertCustomer` stored procedure:

* Uses `SET XACT_ABORT ON`
* Wrapped in transaction
* Relies on UNIQUE index for duplicate enforcement
* Handles errors via `RAISERROR`
* Returns inserted `CustomerID`

This avoids race conditions and ensures atomicity.

---

## 🔍 Determinism & Performance Considerations

During development, scalar UDF usage in persisted computed columns caused non-deterministic errors.

Final production approach:

* Avoid scalar UDF inside persisted computed columns
* Use inline deterministic expressions
* Ensure index compatibility

This aligns with enterprise SQL Server best practices.

---

## 🧪 How to Run

1. Execute:

   * `00_create_database.sql`

2. Create base table:

   * `01_Tables/Customers.sql`

3. Run data cleaning scripts:

   * `07_DataCleaning/*.sql`

4. Apply computed columns and indexes:

   * `01_Tables/*.sql`

5. Create stored procedure:

   * `04_StoredProcedures/usp_InsertCustomer.sql`

---

## 🚀 Skills Demonstrated

* Advanced T-SQL
* Data normalization
* Window functions
* Constraint-based design
* Index optimization
* Error handling patterns
* Transaction management
* Debugging deterministic function issues
* Production-ready database design

---

## 📈 Future Improvements

* Audit logging via triggers
* Soft delete implementation
* Reporting stored procedures
* Execution plan analysis
* Performance benchmarking

---

## 🏁 Conclusion

This project demonstrates a full lifecycle of:

Data → Cleaning → Normalization → Integrity Enforcement → Controlled Access

It reflects real-world production SQL Server development practices and enterprise data integrity design principles.
