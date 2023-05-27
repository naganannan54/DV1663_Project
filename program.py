import mysqlx
from mysqlx.errors import DatabaseError
import functions as f

# Connect to server on localhost
session = mysqlx.get_session({
    "host": "localhost",
    "port": 33060,
    "user": "root",
    "password": "DV1663"
})
DB_NAME = 'project'

try:
    session.sql("USE {}".format(DB_NAME)).execute()
except DatabaseError as de:
    if de.errno == 1049:
        print("Error: Database '{}' does not exist.".format(DB_NAME))
    else:
        print("Error executing SQL command: {}".format(de))
        raise

userInput = ""
while userInput != "0":
    print("\nSelect an option by entering the number:")
    print("  1\tFull leaderboard")    
    print("  2\tStage leaderboard")    
    print("  3\tCustom leaderboard")     
    print("  4\tStats")                  
    print("  5\tUpdate result")         
    print("")
    print("  0\tExit application")

    userInput = input("\nEnter option: ")

    if userInput == "1":
        f.showLeaderboard(session)
    elif userInput == "2":
        f.showStageLeaderboard(session)
    elif userInput == "3":
        f.showCustomLeaderboard(session)
    elif userInput == "4":
        f.showStats(session)
    elif userInput == "5":
        f.updateResult(session)
    elif userInput == "0":
        print("Goodbye")
    else:
        print("Unknown input. Type just the number (1, 2, etc.)")

