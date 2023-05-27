from mysqlx.errors import DatabaseError
import datetime

# Print formatted table from an SQL result. Attribute list gives names for headers and number of attributes
def printResults(attributes, results, largeCells = False):
    if largeCells:
        cellWidth = 34
    else:
        cellWidth = 18

    print("")
    # Print name of each attribute
    print("-"*(len(attributes)*cellWidth+1))
    for a in attributes:
        if largeCells:
            print("| {:<32}".format(a), end="")
        else:
            print("| {:<16}".format(a), end="")
    print("|")
    print("-"*(len(attributes)*cellWidth+1))

    # Print data for each attribute
    for r in results:
        for i in range(len(attributes)):
            if type(r[i]) == float:
                res = round(r[i], 3)
                if largeCells:
                    print("| {:<32}".format(res), end="")
                else:
                    print("| {:<16}".format(res), end="")
            elif type(r[i]) == datetime.datetime:
                date = r[i].strftime("%Y-%m-%d")
                if largeCells:
                    print("| {:<32}".format(date), end="")
                else:
                    print("| {:<16}".format(date), end="")
            else:
                if largeCells:
                    print("| {:<32}".format(r[i]), end="")
                else:
                    print("| {:<16}".format(r[i]), end="")
        print("|")
    print("-"*(len(attributes)*cellWidth+1))

# Print available attributes for a given table
def printAttributes(session, table):
    query = "DESCRIBE " + table + ";"
    try:
        result = session.sql(query).execute()
        print("The attributes in " + table.upper() + " are:")
        for a in result.fetch_all():
            print("  " + a[0])
    except DatabaseError as de:
        print("Error executing SQL command: {}".format(de.msg))
        return

# Call query to show overall results summed from all stages
def showLeaderboard(session):
    query = "SELECT S.user, U.country, SUM(S.points) as points FROM submissions S, users U WHERE s.user = u.userName GROUP BY user ORDER BY points DESC;"
    result = session.sql(query).execute()
    attributes = ["User", "Country", "Points"]
    printResults(attributes, result.fetch_all())
    input("Press enter to continue to main menu")

# Show available stages and then the leaderboard for a selected one
def showStageLeaderboard(session):
    print("\nSelect stage by entering its number")
    
    stageOptions = session.sql("SELECT stageName FROM stages ORDER BY startDate").execute()
    for i, s in enumerate(stageOptions.fetch_all()):
        print("  " + str(i + 1) + "\t" + s[0])
    stage = input("Stage number: ")

    query = "SELECT user, score, points FROM submissions WHERE stage = '" + stageOptions[int(stage) - 1][0] + "' ORDER BY points DESC;"
    attributes = ["User", "Score", "Points"]

    try:
        result = session.sql(query).execute()
        printResults(attributes, result.fetch_all())
        input("Press enter to continue to main menu")
    except DatabaseError as de:
        print("Error executing SQL command: {}".format(de.msg))
        return

# Show custom leaderboard 
def showCustomLeaderboard(session):
    userInput = ""
    attributes = []
    filters = []
    orders = []
    tables = ["Submissions", "Users", "Stages"]

    while userInput != "0":
        print("\nSelect option or proceed to show leaderboard:")
        print("  1\tSelect Submissions table")
        print("  2\tSelect Users table")
        print("  3\tSelect Stages table")
        print("  4\tAdd sort condition")
        print("")
        print("  0\tProceed to show leaderboard")
        userInput = input("Enter option: ")

        if (userInput.isdigit()):
            userInputInt = int(userInput)

            # Table selected, proceed to choosing attributes
            if (userInputInt > 0 and userInputInt <= 3):
                userInputInt -= 1
                attributeInput = ""
                while attributeInput != "0":
                    print("\n" + tables[userInputInt] + " table selected. Enter name of attribute to include it or choose another option")
                    print("  [x]\tAdd attribute in selected table")
                    print("  1\tShow available attributes")
                    print("  0\tSelect another table or proceed to leaderboard")
                    attributeInput = input("Enter option: ")

                    if (attributeInput == "1"):
                        printAttributes(session, tables[userInputInt])
                    elif (attributeInput != "0"):
                        # Add filter (where clause)
                        filterInput = input("Filter based on this attribute? [y/n]: ")
                        if (filterInput == "y"):
                            filterInput = input("Equal '=', Smaller '<' or Greater '>'? ")
                            filterValue = input("Enter value to compare against: ")
                            filters.append(tables[userInputInt] + "." + attributeInput + filterInput + "'" + filterValue + "'")

                            filterInput = input("Remove attribute from results table? [y/n]: ")
                            if (filterInput == "n"):
                                attributes.append(tables[userInputInt] + "." + attributeInput)
                        else:
                            attributes.append(tables[userInputInt] + "." + attributeInput)

            # Select attribute to sort from
            elif (userInputInt == 4):
                print("Select attribute to sort by")
                for i, a in enumerate(attributes):
                    print("  " + str(i + 1) + "\t" + a.split('.')[1])
                print("\n  0\tCancel and go back to previous menu")
                sortInput = input("Select option: ")
                if (sortInput.isdigit()):
                    sortInputInt = int(sortInput)
                    if (sortInputInt > 0 and sortInputInt - 1 < len(attributes)):
                        sortInput = input("Order ascending ('a') or descending ('d')? ")
                        if (sortInput == "a"):
                            orders.append(attributes[sortInputInt-1] + " ASC")
                        elif (sortInput == "d"):
                            orders.append(attributes[sortInputInt-1] + " DESC")

            elif (userInputInt != 0):
                print("Invalid number")
        else:
            print("Invalid input. Choose a valid number")

    # Construct 'WHERE' clause to use in query
    filterQuery = ""
    for i, f in enumerate(filters):
        if (i == 0):
            filterQuery += "WHERE " + f
        else:
            filterQuery += "AND " + f

    # Consruct 'ORDER BY' clause to use in query
    orderQuery = ""
    if (orders):
        orderQuery = "ORDER BY "
        for o in orders:
            orderQuery += o + ","
    orderQuery = orderQuery[:-1]
    print(orderQuery)

    # Construct query from previous input
    query = "SELECT " + ",".join(attributes) \
            + " FROM submissions \
                JOIN users ON submissions.user=users.username \
                JOIN stages ON submissions.stage=stages.stagename " \
            + filterQuery + orderQuery + ";"

    # Exclude table from visible header
    attributeNames = []
    for a in attributes:
        attributeNames.append(a.split('.')[1].capitalize())
    
    # Execute query and print results
    try:
        result = session.sql(query).execute()
        printResults(attributeNames, result.fetch_all())
        input("Press enter to continue to main menu")
    except DatabaseError as de:
        print("Error executing SQL command: {}".format(de.msg))
        return

# Print some stats from the competition database
def showStats(session):
    print("\nSelect a stat to show")
    print("  1\tAverage point per country")
    print("  2\tMost popular motherboards")
    print("  3\tAverage memory frequency per stage")
    print("  4\tPercentage of submissions on last day")
    userInput = input("Select Option: ")

    # Set query and headers based on input
    query = ""
    attributes = []
    largeCells = False
    if (userInput == "1"):
        query = "SELECT country, AVG(points) as avgPoints FROM submissions JOIN users ON submissions.user = users.username GROUP BY country ORDER BY avgPoints DESC;"
        attributes = ["Country", "Avg. points"]

    elif (userInput == "2"):
        query = "SELECT CONCAT(m.manufacturer, ' ', m.chipset, ' ', m.model) as motherboardName, COUNT(motherboard) as numSubmissions \
                FROM submissions s JOIN motherboards m on s.motherboard=m.shortName \
                GROUP BY motherboard \
                ORDER BY numSubmissions DESC;"
        attributes = ["Motherboard", "Times used"]
        largeCells = True

    elif (userInput == "3"):
        query = "SELECT stage, AVG(memoryFrequency) as avgMem FROM submissions GROUP BY stage ORDER BY avgMem DESC;"
        attributes = ["Stage", "Avg. frequency"]

    elif (userInput == "4"):
        query = "SELECT (SELECT COUNT(score) FROM submissions su join stages st ON su.stage = st.stageName WHERE su.submissionDate = st.enddate) \
                / (SELECT COUNT(score) FROM submissions) * 100 as PercentageOfLastDaySubs;"
        attributes = ["Percentage"]

    # Execute query and print results
    try:
        result = session.sql(query).execute()
        printResults(attributes, result.fetch_all(), largeCells)
        input("Press enter to continue to main menu")
    except DatabaseError as de:
        print("Error executing SQL command: {}".format(de.msg))
        return
    
    
# Update the score for a given user and stage. Calls procedure that also updates points if necessary
def updateResult(session):
    print("\nEnter username, stage and new score for submission to update")
    userName = input("Username: ")
    stage = input("Stage: ")
    score = input("New score: ")

    print("Set score to " + score + " for " + userName + " in stage " + stage)
    if input("Do you want to proceed? [y/n]: ") == "y":
        query = "CALL UpdateScore(" + score + ", '" + userName + "', '" + stage + "');"
        try:
            result = session.sql(query).execute()
        except DatabaseError as de:
            print("Error executing SQL command: {}".format(de.msg))
            return

        if (result.fetch_all()[0][0] == "Points updated"):
            print("Result updated, points recalculated")
        else:
            print("Result updated, points did not need recalculation")

        input("Press enter to continue to main menu")


