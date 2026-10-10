-- Overall Data Balances 
SELECT SUM(Debit) AS TotalDebit, 
       SUM(Credit) AS TotalCredit
FROM dbo.JournalEntries;

-- Weekend Postings 
SELECT *
FROM dbo.JournalEntries
WHERE DATENAME(WEEKDAY, [Date]) IN ('Saturday', 'Sunday')
ORDER BY [Date];

-- Round number entries 
SELECT *
FROM dbo.JournalEntries
WHERE (Debit IS NOT NULL AND Debit % 1000 = 0)
   OR (Credit IS NOT NULL AND Credit % 1000 = 0)
ORDER BY [Date];

-- Duplicate entries 
SELECT Account_Code, [Date], Debit, Credit, COUNT(*) AS Occurrences
FROM dbo.JournalEntries
GROUP BY Account_Code, [Date], Debit, Credit
HAVING COUNT(*) > 1
ORDER BY Occurrences DESC;

-- Activity by Account 
SELECT Account_Code,
       COUNT(*) AS EntryCount,
       SUM(Debit) AS TotalDebit,
       SUM(Credit) AS TotalCredit
FROM dbo.JournalEntries
GROUP BY Account_Code
ORDER BY EntryCount DESC;

-- Largest Single entries 
SELECT TOP 20 *
FROM dbo.JournalEntries
WHERE Debit IS NOT NULL OR Credit IS NOT NULL
ORDER BY COALESCE(Debit, Credit) DESC;

-- Daily Balance check
SELECT [Date],
       SUM(ISNULL(Debit,0)) AS TotalDebit,
       SUM(ISNULL(Credit,0)) AS TotalCredit,
       SUM(ISNULL(Debit,0)) - SUM(ISNULL(Credit,0)) AS Difference
FROM dbo.JournalEntries
GROUP BY [Date]
HAVING SUM(ISNULL(Debit,0)) - SUM(ISNULL(Credit,0)) <> 0
ORDER BY [Date];

-- Manual Journal Entry Check 
SELECT Transaction_ID,
       COUNT(*) AS LineCount,
       SUM(ISNULL(Debit,0)) AS TotalDebit,
       SUM(ISNULL(Credit,0)) AS TotalCredit,
       SUM(ISNULL(Debit,0)) - SUM(ISNULL(Credit,0)) AS Difference
FROM dbo.JournalEntries
WHERE Transaction_ID LIKE 'JR%'
GROUP BY Transaction_ID
ORDER BY ABS(SUM(ISNULL(Debit,0)) - SUM(ISNULL(Credit,0))) DESC;
