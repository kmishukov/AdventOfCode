import os

path = os.getcwd()
filePath = path + "/input"
f = open(filePath, "r")

currentCalories = 0
totalCaloriesArr = []

def countLine(line):
    global maxCalories
    global currentCalories
    try:
        number = int(line)
        currentCalories += number
    except:
        totalCaloriesArr.append(currentCalories)
        currentCalories = 0

with open(filePath, 'rb') as f:
    while True:
        line = f.readline()
        if not line:
            break
        countLine(line)

totalCaloriesArr.sort()
print(sum(totalCaloriesArr[-3:]))
