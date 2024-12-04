/*select the schema*/
USE famous_paintings;

/*find the average price of an artwork by artist*/
CREATE TEMPORARY TABLE temp_table AS
	SELECT product_size.sale_price, product_size.work_id, work.artist_id, artist.full_name
    	FROM product_size
    	LEFT JOIN work 
		ON work.work_id = product_size.work_id
	LEFT JOIN artist
		ON artist.artist_id = work.artist_id;

SELECT full_name, AVG(sale_price)
	FROM temp_table
	WHERE full_name IS NOT NULL
	GROUP BY full_name;
    
/*list and count all the museums which are open on both sunday and monday*/
CREATE TEMPORARY TABLE monday_museum AS 
	SELECT name, day
	FROM museum_hours
	INNER JOIN museum
		ON museum.museum_id = museum_hours.museum_id
	WHERE day = "Monday";
        
CREATE TEMPORARY TABLE sunday_museum AS 
	SELECT name, day
	FROM museum_hours
	INNER JOIN museum
		ON museum.museum_id = museum_hours.museum_id
	WHERE day = "Sunday";
        
SELECT monday_museum.name
	FROM monday_museum
	INNER JOIN sunday_museum
		ON sunday_museum.name = monday_museum.name;

SELECT COUNT(monday_museum.name)
	FROM monday_museum
	INNER JOIN sunday_museum
		ON sunday_museum.name = monday_museum.name;
