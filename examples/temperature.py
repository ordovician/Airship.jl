R = 8.3144598
def gas_volume(n, T, P):
    return n*R*T.to_kelvin().value/P
    
class Celsius(object):
    """docstring for Celsius"""
    def __init__(self, temp):
        super(Celsius, self).__init__()
        if type(temp) == float or type(temp) == int:
            self.value = temp
        else:
            self.value = temp.to_celsius().value

    def __repr__(self):
        return "Celsius({0})".format(self.value)
        
    def to_celsius(self):
        return self
 
    def to_kelvin(self):
        return Kelvin(self.value + 273.15)
    
    def to_fahrenheit(self):
        return Fahrenheit(self.value*9/5 + 32)
        
    def __add__(self, temp):
        return Celsius(self.value + temp.to_celsius().value)
        
    def __sub__(self, temp):
        return Celsius(self.value - temp.to_celsius().value)
        
class Kelvin(object):
    """docstring for Kelvin"""
    def __init__(self, temp):
        super(Kelvin, self).__init__()
        if type(temp) == float or type(temp) == int:
            self.value = temp
        else:
            self.value = temp.to_kelvin().value

    def __repr__(self):
        return "Kelvin({0})".format(self.value)
        
    def to_kelvin(self):
        return self

    def to_celsius(self):
        return Celsius(self.value - 273.15)
        
    def to_fahrenheit(self):
        return self.to_celsius().to_fahrenheit()
                     
    def __add__(self, temp):
        return Kelvin(self.value + temp.to_kelvin().value)
        
    def __sub__(self, temp):
        return Kelvin(self.value - temp.to_kelvin().value)
        
class Fahrenheit(object):
    """docstring for FahrenheitFahrenheit"""
    def __init__(self, temp):
        super(Fahrenheit, self).__init__()
        if type(temp) == float or type(temp) == int:
            self.value = temp
        else:
            self.value = temp.to_fahrenheit().value

    def __repr__(self):
        return "Fahrenheit({0})".format(self.value)
        
    def to_kelvin(self):
        return self.to_celsius().to_kelvin()

    def to_celsius(self):
        return Celsius((self.value - 32)*5/9)
     
    def to_fahrenheit(self):
        return self
                     
    def __add__(self, temp):
        return Fahrenheit(self.value + temp.to_fahrenheit().value)
        
    def __sub__(self, temp):
        return Fahrenheit(self.value - temp.to_fahrenheit().value)