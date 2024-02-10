import sqlite3

# Connect to the SQLite database
conn = sqlite3.connect('app.db')

# Create a cursor object to execute SQL commands
cursor = conn.cursor()

# Create User table if not exists
cursor.execute('''
    CREATE TABLE IF NOT EXISTS User (
        id INTEGER PRIMARY KEY,
        name TEXT,
        food_type TEXT,
        carbohydrates REAL,
        fats REAL,
        dairy REAL,
        protein REAL,
        count INTEGER DEFAULT 0
    )
''')

# Define valid food types
valid_food_types = ["fruit", "steak", "chicken bowl", "yogurt", "cereal"]

# Function to prompt user for macronutrient input
def get_macro_input():
    carbohydrates = float(input("Enter the amount of carbohydrates you ate (g): "))
    fats = float(input("Enter the amount of fats you ate (g): "))
    dairy = float(input("Enter the amount of dairy you ate (g): "))
    protein = float(input("Enter the amount of protein you ate (g): "))
    return carbohydrates, fats, dairy, protein

# Function to prompt user for valid food type
def get_food_type():
    while True:
        food_type = input("Enter the type of food you ate: ").lower()
        if food_type in valid_food_types:
            return food_type
        else:
            print("Invalid food type. Please choose from:", valid_food_types)

# Check if the user already exists in the database
cursor.execute("SELECT name FROM User")
existing_users = cursor.fetchall()

if existing_users:
    name = existing_users[0][0]  # Assuming there is only one user
else:
    # Prompt user for name if no user exists
    name = input("Enter your name: ")

# Main loop
while True:
    print("\n1. Add food entry")
    print("2. Delete food entry")
    print("3. Exit")
    choice = input("Enter your choice: ")
    
    if choice == '1':
        # Prompt user for macronutrient input
        carbohydrates, fats, dairy, protein = get_macro_input()
        
        # Prompt user for food type
        food_type = get_food_type()
        
        # Insert or update macronutrient data into User table
        cursor.execute("SELECT count FROM User WHERE name = ? AND food_type = ?", (name, food_type))
        existing_count = cursor.fetchone()
        if existing_count:
            # Food type already exists for the user, update the count
            count = existing_count[0] + 1
            cursor.execute("UPDATE User SET count = ? WHERE name = ? AND food_type = ?", (count, name, food_type))
        else:
            # Food type doesn't exist for the user, insert with count 1
            count = 1
            cursor.execute("INSERT INTO User (name, food_type, carbohydrates, fats, dairy, protein, count) VALUES (?, ?, ?, ?, ?, ?, ?)", (name, food_type, carbohydrates, fats, dairy, protein, count))
        
        # Commit changes to the database
        conn.commit()
        print("Data inserted successfully.")
    
    elif choice == '2':
        # Prompt user for food type to delete
        food_type_to_delete = get_food_type()
        
        # Delete the food entry for the specified food type
        cursor.execute("DELETE FROM User WHERE name = ? AND food_type = ?", (name, food_type_to_delete))
        
        # Commit changes to the database
        conn.commit()
        print("Data deleted successfully.")
    
    elif choice == '3':
        break

# Close the connection
conn.close()