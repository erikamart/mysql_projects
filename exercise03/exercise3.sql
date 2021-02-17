/* Use the chinook database.
Unless otherwise noted use explicit syntax. */

-- Exercise 3

/* 1. Write a select statement that joins the album table to the artist table and returns these 
   columns for every Album in the database: AlbumId, Title, ArtistId, and the artist's Name */
SELECT Albumid, Title, album.ArtistId, artist.Name
FROM album
INNER JOIN artist ON album.artistid = artist.artistid;

/* 2. For each Invoice in the database list the InvoiceId, the InvoiceDate, the CustomerId, and Total. 
   Also include the customer's LastName, and Country. Add a clause so that the result is sorted by 
   country A-Z, and within each country by invoice total - largest to smallest.  */
SELECT InvoiceId, InvoiceDate, invoice.CustomerId, Total, customer.LastName, customer.Country
FROM invoice
INNER JOIN customer ON invoice.customerid = customer.customerid
ORDER by country, invoice.Total DESC;

/* 3. Write a select statement that joins the invoice table to the invoice_line table and returns 
   these columns: InvoiceId, InvoiceDate, CustomerId, Quantity, and UnitPrice. The query should  
   only return orders for customers 16, 34, 37. */
SELECT invoice.InvoiceId, InvoiceDate, invoice.CustomerId, Quantity, UnitPrice
FROM invoice
INNER JOIN invoiceline ON invoice.InvoiceId = invoiceline.InvoiceId
WHERE invoice.CustomerId IN ('16','34','37');

/* 4. Return the same result as question 3, but this time use implicit syntax */
SELECT invoice.InvoiceId, InvoiceDate, invoice.CustomerId, Quantity, UnitPrice
FROM invoice, invoiceline
WHERE invoice.InvoiceId = invoiceline.InvoiceId
AND invoice.CustomerId IN ('16','34','37');

/* 5. Return the same result as question 3, but this time use the USING keyword */
SELECT invoice.InvoiceId, InvoiceDate, invoice.CustomerId, Quantity, UnitPrice
FROM invoice
JOIN invoiceline USING (InvoiceId)
WHERE invoice.CustomerId IN ('16','34','37');

/* 6. Return the same result as question 3, but this time use table aliases, you may use implicit syntax, 
   the USING keyword, or any syntax you choose that works, but use table aliases */ 
SELECT nv.InvoiceId, InvoiceDate, nv.CustomerId, Quantity, UnitPrice
FROM invoice AS nv
INNER JOIN invoiceline AS ln ON nv.InvoiceId = ln.InvoiceId
WHERE nv.CustomerId IN ('16','34','37');

/* 7. Write a select statement that joins the album and the track tables. 
   Display these columns: AlbumId, Title, TrackId, Name, Composer, and Miliseconds. 
   Only return rows where the composer contains the text 'Clapton' */
SELECT al.AlbumId, Title, TrackId, tr.Name, Composer, Milliseconds
FROM album AS al
INNER JOIN track AS tr ON al.AlbumId = tr.AlbumId
WHERE Composer like '%Clapton%';

/* 8. For each row in the invoiceline table return the following information: 
   InvoiceId, TrackId, InvoiceDate, CustomerId, customers' LastName, and Phone */
SELECT nl.InvoiceId, TrackId, InvoiceDate, nv.CustomerId, cu.LastName, cu.Phone
FROM invoiceline AS nl
JOIN invoice AS nv ON nl.InvoiceId = nv.InvoiceId
JOIN customer AS cu ON nv.CustomerId = cu.CustomerId;

/* 9. For every employee in the database write a query that shows the EmployeeId, the LastName, and 
   the HireDate. If the employee has customers assigned to them display the CustomerId and the 
   customer's email address. Sort the list so that employees without customers are listed at the top. 
   Note: the tables are joined on a customer column called SupportRepId */
SELECT em.EmployeeId, em.LastName, HireDate, cu.CustomerId, cu.Email
FROM employee AS em 
LEFT JOIN customer AS cu ON em.EmployeeId = cu.SupportRepId
ORDER by cu.customerId;

/* 10. Write a query that displays the AlbumId, the album Title, the TrackId, the Composer of the track,  the MediaTypeId, 
   and the media Name for any track whose composer contains 'Jimmy Page' and whose AlbumId is 44 */
SELECT al.AlbumId, Title, TrackId, Composer, mt.MediaTypeId, mt.Name
FROM album AS al
INNER JOIN track AS tr ON al.AlbumId = tr.AlbumId
INNER JOIN mediatype AS mt ON tr.MediaTypeId = mt.MediaTypeId
WHERE Composer LIKE '%Jimmy Page%'
AND tr.AlbumId = 44;

/* 11. Join the customer table to itself so that only customers located in the same city and country as 
   other customers are displayed. Display the CustomerId, the City, and Country for each customer. */ 
SELECT c1.CustomerId, c1.City, c1.Country 
FROM customer AS c1 
JOIN customer AS c2 ON c1.City = c2.City
AND c1.Country = c2.Country
AND c1.CustomerId <> c2.CustomerId
ORDER BY c1.City, c1.Country;

/* 12. Use the UNION operator to generate a result set consisting of four columns from the invoice table:  
   InvoiceId, InvoiceDate, Total, And a calculated column called Destination: if the Invoice has a Country 
   of USA display the words'Domestic' otherwise display the words 'International'*/
SELECT nv.InvoiceId, InvoiceDate, Total, 'Domestic' as Destination
FROM invoice AS nv
WHERE BillingCountry like '%USA%'
UNION
SELECT nv.InvoiceId, InvoiceDate, Total, 'Inernational' as Destination
FROM invoice AS nv
WHERE BillingCountry != '%USA%';

/* 13. Produce a query that displays the employee FirstName, LastName, Customer FirstName, LastName, InvoiceId,
   InvoiceDate, Total, TrackId, track Name for every row in the invoiceline table. Use column aliases to 
   distinguish the customer first and last name and the employee first and last name. */

SELECT 	em.FirstName AS EmployeeFirstName, 
		em.LastName AS EmployeeLastName, 
		cu.FirstName AS CustomerFirstName, 
		cu.LastName AS CustomerLastName, 
		nv.InvoiceId, 
		InvoiceDate, 
		Total, 
		nl.TrackId, 
		tk.Name AS TrackName
FROM track AS tk
INNER JOIN invoiceline AS nl ON tk.TrackId = nl.TrackId
INNER JOIN invoice AS nv ON nl.InvoiceId = nv.InvoiceId
INNER JOIN customer AS cu ON nv.CustomerId = cu.CustomerId
INNER JOIN employee AS em ON cu.SupportRepId = em.EmployeeId;

/* 14. Write a query that displays the CustomerId, the InvoiceDate, and the Total for any invoice that includes
   a track whose genre is 'Jazz' */
SELECT nv.CustomerId, nv.InvoiceDate, nv.Total
FROM genre AS ge
INNER JOIN track AS tk ON ge.GenreId = tk.GenreId
INNER JOIN invoiceline as nl ON tk.TrackId = nl.TrackId
INNER JOIN invoice AS nv ON nl.InvoiceId = nv.InvoiceId
WHERE ge.Name = 'Jazz';

/* 15. For every artist whose Name starts with 'A' or 'B' display the artist Name, any AlbumId and album Name 
   associated with the artists, any TrackId and track Names associated with the artists, and the associated 
   GenreId and genre Names associated with the track. Use column aliases to distinguish the four Name columns*/
SELECT  ar.Name AS ArtistName, 
		al.AlbumId, 
		al.Title AS AlbumName, 
		tk.TrackId, 
		tk.Name AS TrackName, 
		ge.GenreId, 
		ge.Name AS GenreName
FROM artist AS ar
LEFT JOIN album AS al ON ar.ArtistId = al.ArtistId
LEFT JOIN track AS tk ON al.AlbumId = tk.AlbumId
LEFT JOIN genre AS ge ON tk.GenreId = ge.GenreId
WHERE ar.Name like 'A%'
OR ar.Name like 'B%';