echo "sql_file,real_time" > times.csv

for sql_file in *.sql
do
# Run the SQL file and capture the "real" time
real_time=$( (time -p psql -d "ssb" -U "postgres" -f $sql_file > /dev/null) 2>&1 | awk '/real/ {print $2}')

# Write the buffer size, SQL file name, and "real" time to the CSV file
echo "$sql_file,$real_time" >> times.csv
done