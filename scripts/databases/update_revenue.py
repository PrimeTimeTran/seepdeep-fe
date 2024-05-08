import pandas as pd

def update_budget_and_gross_in_csv(csv_file_path, gross_and_budget_file_path, output_csv_file_path):
    gross_and_budget_df = pd.read_csv(gross_and_budget_file_path)
    imdb_top_1000_df = pd.read_csv(csv_file_path)
    budget_gross_map = {}
    for index, row in gross_and_budget_df.iterrows():
        primary_title = row['primaryTitle']
        budget = row['budget']
        gross = row['gross']
        if primary_title not in budget_gross_map:
            budget_gross_map[primary_title] = []
        budget_gross_map[primary_title].append((budget, gross))
    for index, row in imdb_top_1000_df.iterrows():
        title = row['title']
        if title in budget_gross_map:
            budget_data = budget_gross_map[title][0]
            budget, gross = budget_data
            budget_millions = round(budget / 1_000_000, 2)
            gross_millions = round(gross / 1_000_000, 2)
            imdb_top_1000_df.at[index, 'budget'] = budget_millions
            imdb_top_1000_df.at[index, 'worldwide_gross'] = gross_millions
    imdb_top_1000_df.to_csv(output_csv_file_path, index=False)
    print(f"Updated 'budget' and 'worldwide_gross' in '{output_csv_file_path}'.")
update_budget_and_gross_in_csv('./imdb_top_1000.csv', './gross_and_budget.csv', './imdb_top_1000.csv')
