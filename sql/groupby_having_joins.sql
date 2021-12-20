SELECT status, FLOOR(AVG(amount)), duration as average FROM loan
GROUP BY status, duration;

SELECT status, duration, MAX(amount) as max_loan FROM loan
WHERE duration = 36 AND status = 'A'
GROUP BY status, duration;

SELECT k_symbol, ROUND(AVG(amount)) as average FROM bank.order
WHERE k_symbol != ' '
GROUP BY k_symbol
ORDER BY AVG(amount)
LIMIT 1;

SELECT district_id, COUNT(account.account_id) as no_accounts, A2 as districtname, COUNT(loan_id) as no_loans
FROM account
JOIN district ON district_id = A1
JOIN loan ON loan.account_id = account.account_id
GROUP BY district_id, districtname
HAVING no_loans = 10
ORDER BY no_accounts;

# Find the districts with more than 100 clients.

SELECT A2 as district_name, COUNT(client_id) as no_clients 
FROM district
JOIN client ON district_id = A1
GROUP BY district_name, A2
HAVING no_clients > 100;

# Find the transactions (type, operation) with a mean amount greater than 10000.

SELECT type, operation, ROUND(AVG(amount)) as mean_amount FROM trans
GROUP BY type, operation
HAVING mean_amount > 10000;

# Get card_id and year_issued for all gold cards.

SELECT card_id, YEAR(CONVERT(substring_index(issued, ' ', 1), DATE))  as year_issued FROM card
WHERE type = 'gold';

# When was the first gold card issued? (Year)

SELECT YEAR(CONVERT(substring_index(issued, ' ', 1), DATE))  as year_issued FROM card
WHERE type = 'gold'
ORDER BY year_issued
LIMIT 1;

# Get issue date as:
# date_issued: 'November 7th, 1993'
# fecha_emision: '07 of November of 1993'

SELECT DATE_FORMAT(CONVERT(substring_index(issued, ' ', 1), DATE), '%M %D, %Y' ) as year_issued,
DATE_FORMAT(CONVERT(substring_index(issued, ' ', 1), DATE), '%d of %M of %Y' ) as fecha_emision
FROM card;

#Get different card types.

SELECT DISTINCT type FROM card;

#Get transactions in the first 15 days of 1993.

SELECT * FROM trans
WHERE date BETWEEN '930101' AND '930115';

#Get all running loans.

SELECT * FROM loan
WHERE status = 'C' or status = 'D';

#Find the different values from the field A2 that start with the letter 'K'.


#Find the different values from the field A2 that end with the letter 'K'.
#Discuss the possible use cases of using regular expressions in your query.
