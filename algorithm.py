#  Each employee has a list named 'availability'
#  'Availability' is filled with boolean values for each half-hour segment
#  Starts at Sunday at midnight

def createAvailabilityList(days, hours):
	a = []
	for day in range(days):
		a += [[0] * hours]
	return a

hours = 48
days = 7

a = createAvailabilityList(days, hours)
print("	a=", a)