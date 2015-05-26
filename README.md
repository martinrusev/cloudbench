# Cloudbench - A collection of benchmark results for different Cloud providers

## Tools used

	fio 
	sysbench

## Tests 


	# Disk I/O with fio
	fio ssd.fio 

	# Disk I/O with sysbench
	sysbench --test=fileio --file-total-size=6G prepare
	sysbench --test=fileio --file-total-size=6G --file-test-mode=rndrw --max-time=300 --max-requests=0 --file-extra-flags=direct run
	sysbench --test=fileio --file-total-size=6G cleanup

	# CPU
	sysbench --test=cpu --cpu-max-prime=20000 run
	
	
	# MySQL
	mysql -u root -p
	create database benchmark;
	
	sysbench --test=oltp --oltp-table-size=1000000 --mysql-db=benchmark --mysql-user=root --mysql-password=123456 prepare
	sysbench --test=oltp --oltp-table-size=1000000 --mysql-db=benchmark --mysql-user=root --mysql-password=123456 --max-time=60 --oltp-read-only=on --max-requests=0 --num-threads=8 run

	sysbench --test=oltp --mysql-db=benchmark --mysql-user=root --mysql-password=123456 cleanup
	

## Scaleway - Last update 26.05.2015

