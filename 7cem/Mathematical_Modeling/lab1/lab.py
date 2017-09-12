#python27
from matplotlib import pyplot
from MidSquareMethod import MidSquareMethod
from MultiplicativeCongruentialMethod import MultiplicativeCongruentialMethod

def GetCorrelation(z, s=3):
    r = 12 * (1.0 / (len(z) - s)) * sum([z[i] * z[i + s] for i in xrange(len(z) - s)]) - 3.0
    return r

def ShowMathCoeffs(z):
    mathematicalExpectation = sum(z) / len(z)
    dispersion = sum([z[i] ** 2 - mathematicalExpectation ** 2 for i in xrange(len(z))]) / len(z)
    print 'len {0}. Mat. ojidanie = {1}. dispersion = {2}'.format(len(z), mathematicalExpectation, dispersion)


def ShowPlot(z):
    pyplot.style.use('seaborn')
    pyplot.subplot(1, 1, 1)
    pyplot.hist(z, color='C2')
    pyplot.show()



# phase 1
while True:
    try:
        sourceNumber = int(raw_input('Input source (1994 for check) or type "Q" to exit:'))
        count = int(raw_input('Input count (20 forfor check) or type "Q" to exit:'))
    except Exception:
        break
    z = MidSquareMethod(sourceNumber, count)
    print z
    ShowPlot(z)

print 'phase 2'
#phase 2
pyplot.figure(figsize=(6, 6))
while True:
    try:
        countOfNumbers = int(raw_input('Input count or type "Q" to exit:'))
    except Exception:
        break
    z = MultiplicativeCongruentialMethod(countOfNumbers)
    ShowPlot(z)
    ShowMathCoeffs(z)
    print GetCorrelation(z)







