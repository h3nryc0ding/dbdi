import pandas as pd
import matplotlib.pyplot as plt

# Read the CSV data from a file
df = pd.read_csv('times.csv')

# Convert the 'real_time' column to seconds
df['real_time'] = df['real_time'].str.split().str.get(1).str.split('m').str.get(0).astype(float) * 60 + df['real_time'].str.split().str.get(1).str.split('m').str.get(1).str[:-1].astype(float)

# Pivot the DataFrame to get 'buffer_size' as columns and 'real_time' as values
pivot_df = df.pivot(index='sql_file', columns='buffer_size', values='real_time')

# Plot the data
pivot_df.plot(kind='bar', figsize=(12, 6))

# Set the title and labels
plt.title('Execution Time for Different Buffer Sizes')
plt.xlabel('SQL File')
plt.ylabel('Real Time (seconds)')

# Show the plot
plt.show()
