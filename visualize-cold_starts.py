import pandas as pd
import matplotlib.pyplot as plt

# Read the CSV data from a file
df = pd.read_csv('times.csv')

# Convert 'real_time' to float
df['real_time'] = df['real_time'].astype(float)

# Create a new column combining 'sql_file' and 'run_number'
df['query_run'] = df['sql_file'] + ' - run ' + df['run_number'].astype(str)

# Plot the data
df.set_index('query_run')['real_time'].plot(kind='bar', figsize=(12, 6))

# Set the title and labels
plt.title('Execution Time for Each Query Run')
plt.xlabel('Query Run')
plt.ylabel('Real Time (seconds)')

# Show the plot
plt.show()
