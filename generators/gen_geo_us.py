import random
import string

print 'number,lon,lat'

n = 1000000

for i in range(0,1000 * 1000 * 100):
    lon = random.randrange(-126 * n, -76 * n) / (1.0 * n)
    lat = random.randrange(28 * n, 48 * n) / (1.0 * n)

    print str(i) + "," + str(lon) + "," + str(lat)
