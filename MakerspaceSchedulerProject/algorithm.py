#  Each employee has a list named 'availability'
#  'Availability' is filled with boolean values for each half-hour segment
#  Starts at Sunday at midnight

def createAvailabilityList(hours, days):
	a = []
	for hour in range(hours):
		a += [[0] * days]
	return a

hours = 48
days = 7

a = createAvailabilityList(hours, days)
print("	a=", a)