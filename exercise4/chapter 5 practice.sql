-- point to the ap database
use ap;

-- create a table of records from invoices that have been been paid in full but only get some of the columns invoice_id, vendor_id, invoice_number name this table archive_candidates
create table archive_candidates as SELECT invoice_id, vendor_id, invoice_number from invoices where invoice_total - payment_total - credit_total = 0;

-- run this script
alter table archive_candidates MODIFY vendor_id INT(11);
alter table archive_candidates modify invoice_number varchar(50);

-- insert a row into this table without specifying  the column names 
-- the restriction is that using this method you must 
-- 1. not include any auto_increment type values
-- 2. the statement must follow the column sequence left to right


-- now lets suppose you have only the invoice_id, the vendor_id, and the invoice_id for a specific invoice you wish to add to this table

-- first insert a row with the column names specified

-- next insert two rows with the column names specified

-- next insert a row with values only for the invoice_id and invoice_number omit vendor_id the columns specified remeber to pass a null placeholder

-- repeat above with the column names specified for invoice_id, and invoice_number it should populate the vendor_id with a null value

-- add to this table using a query this time add invoice_id, vendor_id, invoice_number from the invoices table where the invoice_total is < 60

-- in the archive_candidates table change the invoice_id to your first name for any row that has a vendor_id of 123

-- use a subquery to update all rows that have a vendor_id of 34 change the invoice_id to ILOVEQUERIES

-- delete the row with an invoice_id of 13

-- delete the rows that have a vendor_id of 34

-- delete all of the rows that have a vendor_id of 96 or an invoice_id of 23