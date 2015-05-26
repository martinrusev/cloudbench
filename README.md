# Cloudbench - A collection of benchmark results for different Cloud providers

## Tools used

	fio 
	sysbench 

## Tests 

	# Disk I/O
	fio ssd.fio

	# CPU
	sysbench --test=cpu --cpu-max-prime=20000 run
	
	
	# MySQL
	sysbench --test=oltp --oltp-table-size=1000000 --mysql-db=benchmark --mysql-user=root --mysql-password=123456 prepare
	sysbench --test=oltp --oltp-table-size=1000000 --mysql-db=benchmark --mysql-user=root --mysql-password=123456 --max-time=60 --oltp-read-only=on --max-requests=0 --num-threads=8 run
	

## Scaleway - Last update 26.05.2015

