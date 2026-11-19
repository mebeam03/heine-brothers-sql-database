# Heine Brothers’ Coffee Relational Database Design & SQL Analysis

A  case study inspired by Heine Brothers’ Coffee, a Louisville coffee chain. The project demonstrates relational database design, crow’s foot entity–relationship modeling, keys and constraints, many-to-many relationships, subtype specialization, and SQL reporting using an 18-table SQLite database.

> **Data disclaimer:** This project is not affiliated with Heine Brothers’ Coffee. The database design, operational records, employee information, inventory, suppliers, transactions, and query results are **synthetic**. 

## Entity–relationship diagram

![Heine Brothers’ Coffee ERD](Heine_Brothers_ERD.png)

The model demonstrates primary/foreign keys, one-to-many relationships, optional participation, composite keys, associative entities, and disjoint/overlapping specialization.

## Example SQL analysis

| Analysis | SQL concepts |
| --- | --- |
| Store revenue and completed-order volume | `JOIN`, `SUM`, `COUNT(DISTINCT)`, `GROUP BY`, `ORDER BY` |
| Top five beverages at Fern Creek | Multi-table `JOIN`, subtype filtering, aggregation, `LIMIT` |
| Inventory reorder candidates | `LEFT JOIN`, `COALESCE`, calculations, filtering |

The three executable queries are in [`Three_Sample_SQL_Queries.sql`](Three_Sample_SQL_Queries.sql); their example outputs are in `Query_1_Results.csv`, `Query_2_Results.csv`, and `Query_3_Results.csv`.

## Run the queries

1. Open [`heine_coffee_demo.sqlite`](heine_coffee_demo.sqlite) with **DB Browser for SQLite** or another SQLite-compatible client.
2. Open the **Execute SQL** tab.
3. Open `Three_Sample_SQL_Queries.sql`, or paste an individual `SELECT` statement from that file.
4. Run the statement and compare the results with the matching CSV file.

## Repository files

| File | Purpose |
| --- | --- |
| `Heine_Brothers_ERD.png` | Diagram preview displayed above |
| `heine_coffee_demo.sqlite` | Synthetic SQLite dataset |
| `Three_Sample_SQL_Queries.sql` | Three sample analyses |
| `Query_1_Results.csv` | Store-level query output |
| `Query_2_Results.csv` | Beverage query output |
| `Query_3_Results.csv` | Inventory query output |
