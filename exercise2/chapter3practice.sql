-- point to the chinook database

-- write a query that selects all columns and rows from the track table

-- write a query that only retrieves the Name,  GenreId, Composer, and the UnitPrice from the track table

-- repeat the last query but only show rows with a UnitPrice greater than .99 

-- write a query that returns all columns and rows that have a composer of Billy Corgan

-- write a query that sorts the entire list by Name A-Z

-- look at the invoice table, write a query that displays only invoices from Brazil include only the CustomerId, the InvoiceDate, the BillingCountry, the Total, and a calculated value that would show what each invoice would look like if it was discounted by 25 %

-- return all columns and rows of invoices that were generated in 2012

-- in the customers table combine the last and first names of each customer insert a comma between the last and first names name this column "Customer"

-- switch to the ex database

-- write a query that displays the vendor_id, invoice_total, the invoice_total with the credit total subtracted - name this column "net invoice, and the invoice total with the credit total subtracted and then divided by two - name this column "half off"

-- list the customer_id and the area codes of each customer's phone number include the ()

-- select the vendor_id, the invoice_number, and the invoice_due_date from the active_invoices table format the date so that it looks like this: Jan-01-2010 refer to table on page 261

-- write a query that shows the vendor_id, invoice_number, and the invoice total from the active_invoices round the invoice_total to the nearest whole dollar and sort the result set by vendor_id ascending and invoice_total descending

-- switch back to the chinook database

-- write a query that shows each country in the customer table list each country only once and sort A-Z

-- write a query that shows all columns from the track table if the track is longer 250000 milliseconds sort the tracks longest to shortest

-- write a query that shows all columns for each invoice if the invoice is less than or equal to 1.98

-- write a query that lists all invoices with a date on or after August 2, 2013

-- switch back to ex 

-- write a query that only shows the active_invoices that have a credit_total

-- write a query that shows the paid_invoices with an invoice total greater > 2500 and vendor_id of 110

-- write a query that shows the paid_invoices with an invoice total greater > 2500 or a vendor_id of 110

-- use the NOT operator to show all employees that aren't 'IT Staff'

-- switch back to chinook

-- use the IN operator to determine all customers located in North America (note: there are only two countries listed in North America)

-- use the BETWEEN operator to display all tracks longer than 158589 milliseconds and less than 253962 milliseconds

-- use the Like operator to display any customer located in a city that starts with Mad

-- use a REGEXP to list any customer whose city contains the characters 're'

-- use a REGEXP to list any customer whose country ends with 'ia'

-- list any invoice whose billing state is Null

-- list any invoice is Null

-- sort the list of customers by country Z-A,  state A-Z, and city Z-A include all columns

-- switch back to the ex database

-- write a query that displays all paid invoices but only display the 5 biggest as seen in the invoice totals

-- write a query that displays the 10 smallest invoices in the paid_invoices table starting with invoice_totals greater than 50.00