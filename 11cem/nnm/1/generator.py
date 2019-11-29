from __future__ import division
import random
import math

x1 = []
x2 = []
y = []
for i in range(100):
	x1.append(round(random.uniform(-1, 1), 2))
	x2.append(round(random.uniform(-1, 1), 2))
	y.append(round(math.sqrt(x2[i] ** 2 + x1[i] ** 2), 2))

x1_str = ''
x2_str = ''
y_str = ''
for i in range(100):
	x1_str += ' ' + str(x1[i])
	x2_str += ' ' + str(x2[i])
	y_str += ' ' + str(y[i])
x12_input = '[' + x1_str + ';' + x2_str + ']'
y_input = '[' + y_str + ']'

input = open('input.txt', 'w')
input.write(x12_input)
input.write('\n')
input.write(y_input)
input.close()

print(math.sqrt(0.7 ** 2 + 0.3 ** 2))
print(math.sqrt(0.3 ** 2 + 0.2 ** 2))
print(math.sqrt(0.9 ** 2 + 0.9 ** 2))