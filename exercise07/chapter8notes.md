# Chapter 8: Data Types  
### **Objectives:**
- Describe the categories of data types
- Distinguish between integer and real numbers
- Distinguish between fixed and floating decimal types
- Describe precision and scale
- Use the ENUM and SET keywords
- Convert data to a different data type
- Use Date/Time functions
- Use the extract and format functions to alter the display of dates and times Use Case and IF functions  

### **Read Chapter 8 in the book.**

### **Data types:**
String, character, and text are terms used interchangeably.  

`CHAR` = fixed width a `NAME` field defined as CHAR(25) means that Mary would be stored in this manner:  
‘Mary_____________________‘  
(The underscores would not be seen but it demonstrates that 25 spaces are used)  

`VARCHAR(25)` means the same value would be stored as:  
‘Mary’  

One byte of a var char value stores the length of the string being stored. This enables string pattern searches like `REGEXP` and `LIKE` to work the same with both types of data.  

**Numeric Data**  

`INTEGERS` types = numeric data without decimal points.  

`BIGINT`  

`INT`  

`MEDIUMINT`  

`SMALLINT`  

`TINYINT`  

Unsigned means that the column may only store positive numbers.  

`BOOLEAN` = synonymous with `TINYTYPE`  

Used to store flags. For example a list of customers that are Cash on Delivery. Or a list of students that are eligible for discounts.  

Zerofill is important for certain data that is ported from one application to another. For example importing .csv data from excel into a MySQL installation will often drop the leading zeros.  

This could be a problem in a situation such as what we have at this school. A student id may be `0002133` or it may be `2167445` when importing data, one may find that `0002133` will import as `2133` if this isn’t accounted for.  

But if you think about how an id is used you would probably store this as string data. Why? Because you wouldn’t use it in calculations. In that case try something like this:  
```
update vendors set vendor_zip_code = lpad(vendor_zip_code,9,'0');  
```

**DECIMAL data types**  
Term number of digits to the right is the scale, total number of digits is its precision.  

FIXED – or DECIMAL data types  

FLOAT – used to store floating point numbers at a single set precision 7 significant digits.  

DECIMAL – used to store double precision numbers, used to store up to 15 significant digits.  

Business applications almost always use DECIMAL data types.  

**DATES and TIMES**  
One type for actually storing data in MySQL:  
`2011-08-15`  

Usually its best to store the entire year value for a date object and then for formatting on reports and queries use the date_format function.  

Don’t pass formatting into a date/time field. This will result in an error.  

`ENUM` and `SET` used to define a set of acceptable values in a column of a table.  
If an insert statement passes a value that is not defined in a column with an `ENUM` data type an empty string is inserted.  

A `SET` value allows more than one value to be stored from a list of strings.  

**`IMPLICIT` data conversion**  
There are times when it might be necessary to explicitly convert data types, in this case use `CAST` or `CONVERT` – typically use `CAST`.  

The only real difference in these is syntax and that `CAST` is more universally used. `CAST` requires an `AS CONVERT` does not. 
```
SELECT vendor_id, default_account_number, CAST(default_account_number AS dec(5,2)) as altered FROM vendors;  
```

`FORMAT` and `CHAR` explanations are on page 237. Read about them.  
`FORMAT` converts numeric data to strings and inserts commas to delimit thousands.  
`CHAR` returns a binary string to assist in formatting output for keys on a keyboard. Such as `TABS`, `LINE FEEDS`, and `CARRIAGE` returns.