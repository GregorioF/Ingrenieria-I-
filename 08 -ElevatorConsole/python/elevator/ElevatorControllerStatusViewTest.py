#
# Developed by 10Pines SRL
# License: 
# This work is licensed under the 
# Creative Commons Attribution-NonCommercial-ShareAlike 3.0 Unported License. 
# To view a copy of this license, visit http://creativecommons.org/licenses/by-nc-sa/3.0/ 
# or send a letter to Creative Commons, 444 Castro Street, Suite 900, Mountain View, 
# California, 94041, USA.
#  
#
# Developed by 10Pines SRL
# License: 
# This work is licensed under the 
# Creative Commons Attribution-NonCommercial-ShareAlike 3.0 Unported License. 
# To view a copy of this license, visit http://creativecommons.org/licenses/by-nc-sa/3.0/ 
# or send a letter to Creative Commons, 444 Castro Street, Suite 900, Mountain View, 
# California, 94041, USA.
#  
import unittest
from ElevatorController import ElevatorController

class Visitor:
    pass

class DoorVisitor(Visitor):
    pass


class DescriptionDoorVisitor(DoorVisitor):
    def visitCabinDoorClosingState(cabineDoor):
        return "Puerca Cerrandose"

    def visitCabinDoorOpenedState(cabineDoor):
        return "Puerta Abierta"

    def visitCabinDoorClosedState(cabineDoor):
        return "Puerta Cerrada"

    def visitCabinDoorOpeningState(cabineDoor):
        return "Puerta Abriendose"



class ElevatorControllerConsole():
    def __init__(self,elevatorController):
        self._elevatorController = elevatorController
        self.elevatorController.subscribeConsole(self)
        self._lines = []
        
    def lines(self):
        return self._lines

    def goUpPushedFromFloor(self):
        self._lines.append(self._elevatorController.acceptDoorVisitor())




class ElevatorControllerStatusView:
    def __init__(self,elevatorController):
        pass
    
class ElevatorControllerViewTest(unittest.TestCase):
    
    def test01ElevatorControllerConsoleTracksDoorClosingState(self):
        elevatorController = ElevatorController()
        elevatorControllerConsole = ElevatorControllerConsole(elevatorController)
        
        elevatorController.goUpPushedFromFloor(1) 
                
        lines = elevatorControllerConsole.lines()

        self.assertEquals(1,len(lines))
        self.assertEquals("Puerta Cerrandose",lines[0])

    def test02ElevatorControllerConsoleTracksCabinState(self):
        elevatorController = ElevatorController()
        elevatorControllerConsole = ElevatorControllerConsole(elevatorController)
        
        elevatorController.goUpPushedFromFloor(1) 
        elevatorController.cabinDoorClosed()
                
        lines = elevatorControllerConsole.lines()

        self.assertEquals(3,len(lines))
        self.assertEquals("Puerta Cerrandose",lines[0])
        self.assertEquals("Puerta Cerrada",lines[1])
        self.assertEquals("Cabina Moviendose",lines[2])

    def test03ElevatorControllerConsoleTracksCabinAndDoorStateChanges(self):
        elevatorController = ElevatorController()
        elevatorControllerConsole = ElevatorControllerConsole(elevatorController)
        
        elevatorController.goUpPushedFromFloor(1) 
        elevatorController.cabinDoorClosed()
        elevatorController.cabinOnFloor(1)
                
        lines = elevatorControllerConsole.lines()

        self.assertEquals(5,len(lines))
        self.assertEquals("Puerta Cerrandose",lines[0])
        self.assertEquals("Puerta Cerrada",lines[1])
        self.assertEquals("Cabina Moviendose",lines[2])
        self.assertEquals("Cabina Detenida",lines[3])
        self.assertEquals("Puerta Abriendose",lines[4])

    def test04ElevatorControllerCanHaveMoreThanOneView(self):
        elevatorController = ElevatorController()
        elevatorControllerConsole = ElevatorControllerConsole(elevatorController)
        elevatorControllerStatusView = ElevatorControllerStatusView(elevatorController)
        
        elevatorController.goUpPushedFromFloor(1) 
        elevatorController.cabinDoorClosed()
        elevatorController.cabinOnFloor(1)
                
        lines = elevatorControllerConsole.lines()

        self.assertEquals(5,len(lines))
        self.assertEquals("Puerta Cerrandose",lines[0])
        self.assertEquals("Puerta Cerrada",lines[1])
        self.assertEquals("Cabina Moviendose",lines[2])
        self.assertEquals("Cabina Detenida",lines[3])
        self.assertEquals("Puerta Abriendose",lines[4])

        self.assertEquals("Stopped",elevatorControllerStatusView.cabinStateFieldModel())
        self.assertEquals("Opening",elevatorControllerStatusView.cabinDoorStateFieldModel())
    


