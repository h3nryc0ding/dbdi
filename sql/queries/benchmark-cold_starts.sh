# Define the shared buffer size
buffer_size="256MB"

# Create a CSV file and write the header
echo "sql_file,real_time,run_number" > times.csv

# Set the shared buffer size
psql ssb --command "ALTER SYSTEM SET shared_buffers TO '$buffer_size';"

# Restart the PostgreSQL service
service postgresql restart

# Loop over each SQL file
for sql_file in *.sql
do
  # Clear the buffer cache before the loop
  service postgresql stop
  sync
  echo 3 > /proc/sys/vm/drop_caches
  service postgresql start
  
  # Execute each query 4 times
  for run_number in {1..5}
  do
    # Run the SQL file and capture the "real" time
    real_time=$( (time -p psql -d "ssb" -U "root" -f $sql_file > /dev/null) 2>&1 | awk '/real/ {print $2}')
    
    # Write the buffer size, SQL file name, "real" time, and run number to the CSV file
    echo "$sql_file,$real_time,$run_number" >> times.csv
  done
done
