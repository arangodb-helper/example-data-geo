import random
import string

print 'number,lon,lat'

n = 1000000

for i in range(0,1000 * 1000 * 100):
    lon = random.randrange(-180 * n, 180 * n) / (1.0 * n)
    lat = random.randrange(-90 * n, 90 * n) / (1.0 * n)

    print str(i) + "," + str(lon) + "," + str(lat)
