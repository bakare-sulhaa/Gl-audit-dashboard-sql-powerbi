# General Ledger Audit Analytics - SQL & Power BI

An audit analytics project applying SQL-based anomaly detection to a general ledger 
dataset, visualized in Power BI as an interactive audit dashboard.

## What this covers
- Cleaned and imported 21,551 journal entries into SQL Server, resolving mixed date 
  formats and inconsistent number formatting in the raw data
- Wrote SQL queries to test for common audit red flags: weekend postings, round-number 
  entries, duplicate entries, and debit/credit imbalances
- Built a Power BI dashboard with KPIs, exception flagging, and an Audit Risk Summary

## Key findings
- Identified a ₦85 debit/credit variance (0.0000006% of total volume) traced to a 
  consistent daily rounding pattern
- Flagged one orphan manual journal entry with no offsetting debit, requiring follow-up
- ~60% of postings occurred on weekends — an unusual pattern worth further review
- ~8% of entries were round numbers, a recognized testing red flag

## Tools
SQL Server (SSMS), Power BI

## Dataset
Synthetic/anonymized general ledger dataset sourced from Kaggle, used for educational 
and portfolio purposes.

<img width="1489" height="635" alt="Screenshot 2026-10-10 113052" src="https://github.com/user-attachments/assets/752c7a28-a279-4a65-b4da-46969b9df573" />
