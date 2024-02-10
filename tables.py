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

# Function to display past entries and prompt user to select one for deletion
def select_entry_to_delete():
    # Retrieve past entries for the user
    cursor.execute("SELECT id, food_type, count FROM User WHERE name = ?", (name,))
    past_entries = cursor.fetchall()
    
    # Display past entries
    print("Past entries:")
    for entry in past_entries:
        print(f"ID: {entry[0]}, Food Type: {entry[1]}, Count: {entry[2]}")
    
    # Prompt user to select entry to delete
    while True:
        try:
            entry_id = int(input("Enter the ID of the entry to delete: "))
            if entry_id in [entry[0] for entry in past_entries]:
                return entry_id
            else:
                print("Invalid entry ID. Please choose a valid ID.")
        except ValueError:
            print("Invalid input. Please enter a number.")

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
        # Add food entry
        carbohydrates, fats, dairy, protein = get_macro_input()
        food_type = get_food_type()
        cursor.execute("SELECT count FROM User WHERE name = ? AND food_type = ?", (name, food_type))
        existing_count = cursor.fetchone()
        if existing_count:
            count = existing_count[0] + 1
            cursor.execute("UPDATE User SET count = ? WHERE name = ? AND food_type = ?", (count, name, food_type))
        else:
            count = 1
            cursor.execute("INSERT INTO User (name, food_type, carbohydrates, fats, dairy, protein, count) VALUES (?, ?, ?, ?, ?, ?, ?)", (name, food_type, carbohydrates, fats, dairy, protein, count))
        conn.commit()
        print("Data inserted successfully.")
    
    elif choice == '2':
        # Delete food entry
        entry_id_to_delete = select_entry_to_delete()
        cursor.execute("SELECT count FROM User WHERE id = ?", (entry_id_to_delete,))
        existing_count = cursor.fetchone()[0]
        if existing_count > 1:
            cursor.execute("UPDATE User SET count = ? WHERE id = ?", (existing_count - 1, entry_id_to_delete))
        else:
            cursor.execute("DELETE FROM User WHERE id = ?", (entry_id_to_delete,))
        conn.commit()
        print("Entry deleted successfully.")
        
    elif choice == '3':
        break

# Close the connection
conn.close()