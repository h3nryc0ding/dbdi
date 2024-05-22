# Define an array of shared buffer sizes
buffer_sizes=("64MB" "256MB" "2056MB" "6144MB" "12288MB" "19456MB")

# Create a CSV file and write the header
echo "buffer_size,sql_file,real_time" > times.csv

# Loop over each buffer size
for buffer_size in ${buffer_sizes[@]}
do
  # Set the shared buffer size
  psql ssb --command "ALTER SYSTEM SET shared_buffers TO '$buffer_size';"
  
  # Restart the PostgreSQL service
  service postgresql restart
  
  # Loop over each SQL file
  for sql_file in *.sql
  do
    # Run the SQL file and capture the "real" time
    real_time=$( (time psql -d "ssb" -U "root" -f $sql_file > /dev/null) 2>&1 | grep real)
    
    # Write the buffer size, SQL file name, and "real" time to the CSV file
    echo "$buffer_size,$sql_file,$real_time" >> times.csv
  done
done
