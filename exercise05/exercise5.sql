/* Use  the Chinook  database. 
Read Chapter 6 of the book.
*/
-- Exercise 5

/*  1. Write a SELECT statement that returns the count of the number of artists in the artist table.*/
SELECT COUNT(*) AS Artist_Count
FROM artist;

/*  2. Write a SELECT statements that displays the highest inoive, lowest invoice, and average invoice of all of the inoices in the invoice table. 
Use the Total to determine each of these. Use column aliases of your choosing for each of these, and round the average summary to two decimal places. */
SELECT  MAX(Total) AS Highest_Invoice,
		MIN(Total) AS Lowest_Invoice,
		ROUND(AVG(Total), 2) AS Average_Invoice
FROM invoice;

/*  3. Count each TrackId that exists in the invoiceline table, but only count each TrackId one time */ 
SELECT COUNT(DISTINCT TrackId) AS TrackId_Amt
FROM invoiceline;

/*  4. Total all of the invoices in the invoice table for all invoices with a BillingCountry  of 'Brazil', 'Chile', or 'Argentina' */
SELECT SUM(Total) AS Invoice_Totals
FROM invoice
WHERE BillingCountry IN ('Brazil','Chile', 'Argentina'); 

/* 5. Count the number of invoices by each BillingCountry. To count each instance of an invoice in the data you must use a GROUP BY function - display the country name and the counts. */
SELECT BillingCountry, COUNT(BillingCountry) AS Invoice_Counts
FROM invoice
GROUP BY BillingCountry;

/*  6. Count the number of tracks for each genre. Display the GenreId and the Name of the genre. */
SELECT COUNT(tr.GenreId) AS GenreId_Count, ge.name AS Genre_Name
FROM track AS tr
JOIN genre AS ge ON tr.GenreId = ge.GenreId
GROUP BY tr.GenreId;

/*  7. Write a SELECT statement that returns the average length of each track by album as shown in the Miliseconds column of the track table, return the AlbumId, the album Title, the ArtistId, and the Name of the artist */
SELECT AVG(Milliseconds) AS Avg_Milliseconds, tr.AlbumId, al.Title AS Album_Title, al.ArtistId, ar.Name AS Artist_Name
FROM track AS tr
LEFT JOIN album AS al ON tr.AlbumId = al.AlbumId
LEFT JOIN artist AS ar ON al.ArtistId = ar.ArtistId
GROUP BY tr.AlbumId;

/* 8. For each state in the United States that exists in the customer table, determine the number of CustomerId, List the State and the number of customers. Don't list customers in countries other than the USA.  */
SELECT State, COUNT(CustomerId) AS Customer_Amt
FROM customer
WHERE Country = 'USA'
GROUP BY State;

/* 9. Total the invoicrd for each customer in the Invoice table that has more than one invoice, return the CustomerId and this totalled amount */ 
SELECT CustomerId, SUM(total) AS Inv_Total
FROM invoice
GROUP BY customerId
HAVING COUNT(*) >=1;

/* 10. Write a SELECT statement that totals all the invoice amounts by SupportRepId. Return the supportrepid and the total. Sort the results so that the support rep id with the largest total of invoices is at the top. */
SELECT SupportRepId, SUM(Total) AS Total_Amts
FROM invoice AS nv
LEFT JOIN customer AS cu ON nv.CustomerId = cu.CustomerId
GROUP BY SupportRepId
ORDER BY Total_Amts DESC;

/* 11. For each album in the database, display the AlbumId, the album's Name, the shortest track, the longest track and the average track length (as shown in the miliseconds column of the track table). */
SELECT tr.AlbumId, Title AS Album_Name, MIN(milliseconds) AS Shortest_Track, MAX(milliseconds) AS Longest_Track, AVG(milliseconds) AS Avg_Tack_Length
FROM track AS tr
JOIN album AS al ON tr.AlbumId = al.AlbumId
GROUP BY Album_Name;

/* 12. Write a SELECT statement that returns one row for each employee in the employee table. Additionally return the count of customers for each employee. If the employee has no associated customers  list the employee anyway. Display the  employee first name and last name and the  count of customers. */
SELECT em.FirstName, em.LastName, COUNT(customerId) AS Customer_Count
FROM employee AS em
LEFT JOIN customer AS cu ON em.EmployeeId = cu.SupportRepId
GROUP BY EmployeeId;

/* 13. Use the ROLLUP function and a group by function to total all invoiceline Quantities by invoice in the invoiceline table as well as a grand total of all the quantities. Display the InvoiceId and the total 
Quantity for each invoice as well as the grand total. */
SELECT InvoiceId, SUM(Quantity) AS Quantity_Total
FROM invoiceline
GROUP BY InvoiceId, Quantity WITH ROLLUP;

/*  14. Use two grouping levels and the ROLLUP function to count the number of customers by  country, and within each country by state*/
SELECT Country, State, COUNT(*) AS Amt_customers
FROM customer
GROUP BY Country, State WITH ROLLUP;

/* 15. List the top 5 artists in terms of total sales. List the artist Name, and the sum of all invoices by the artist, biggest (in terms of total sales, to smallest). Hint : to do this you will need to join artist to album to track to invoiceline to invoice, sum the Total of each invoice, group by the artist name or artistid and sort the list in descending order with a limit clause. */
SELECT 	ar.Name AS Artist_Name,
		COUNT(nv.invoiceId) AS Qty_of_Sales,
		SUM(nv.Total) AS Total_Sales
FROM artist AS ar
LEFT JOIN album AS al ON ar.ArtistId = al.ArtistId
LEFT JOIN track AS tr ON al.AlbumId = tr.AlbumId
LEFT JOIN invoiceline AS nl ON tr.TrackId = nl.TrackId
LEFT JOIN invoice AS nv ON nl.InvoiceId = nv.InvoiceId
GROUP BY ar.Name
ORDER by Total_Sales DESC 
LIMIT 5;