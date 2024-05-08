import pandas as pd

def update_gross_percentages(csv_file_path, output_file_path):
    # Read the CSV file into a pandas DataFrame
    df = pd.read_csv(csv_file_path)
    
    # Convert columns to numeric, handling non-numeric values
    df['Domestic Gross'] = pd.to_numeric(df['Domestic Gross'], errors='coerce')
    df['Worldwide Gross'] = pd.to_numeric(df['Worldwide Gross'], errors='coerce')
    df['International Gross'] = pd.to_numeric(df['International Gross'], errors='coerce')
    
    # Fill missing values in 'Domestic Gross' and 'International Gross' with 0
    df['Domestic Gross'].fillna(0, inplace=True)
    df['International Gross'].fillna(0, inplace=True)
    
    # Calculate Domestic % and International % for each row and round to 2 decimal places
    df['Domestic %'] = round((df['Domestic Gross'] / df['Worldwide Gross']) * 100, 2)
    df['International %'] = round((df['International Gross'] / df['Worldwide Gross']) * 100, 2)
    
    # Convert 'Oscars Nominated' and 'Oscars Won' columns to integers
    # Fill missing values in 'Oscars Nominated' and 'Oscars Won' with 0
    df['Oscars Nominated'].fillna(0, inplace=True)
    df['Oscars Won'].fillna(0, inplace=True)
    
    # Convert 'Oscars Nominated' and 'Oscars Won' columns to integer data type
    df['Oscars Nominated'] = df['Oscars Nominated'].astype(int)
    df['Oscars Won'] = df['Oscars Won'].astype(int)
    
    # Save the updated DataFrame to a new CSV file
    df.to_csv(output_file_path, index=False)
    
    print(f"Updated data has been saved to '{output_file_path}'.")

# Specify the input and output CSV file paths
input_csv_file_path = './PixarMovies.csv'
output_csv_file_path = './PixarMovies2.csv'

# Call the function to update the CSV file with the correct percentages and data types
update_gross_percentages(input_csv_file_path, output_csv_file_path)
