
# Developed by 10Pines SRL
# License: 
# This work is licensed under the 
# Creative Commons Attribution-NonCommercial-ShareAlike 3.0 Unported License. 
# To view a copy of this license, visit http://creativecommons.org/licenses/by-nc-sa/3.0/ 
# or send a letter to Creative Commons, 444 Castro Street, Suite 900, Mountain View, 
# California, 94041, USA.
#  
import unittest
from enum import Enum


class Door:

    def isCabinDoorOpened(self):
        pass

    def isCabinDoorOpening(self):
        pass

    def isCabinDoorClosed(self):
        pass

    def isCabinDoorClosing(self):
        pass
    
    def doorStarClosing(self):
    	return DoorClosing()
    	

    def doorStarOpening(self):
        return DoorOpening()

    def doorClose(self):
    	return DoorClose()

    def doorOpen(self):
    	return DoorOpen()





class Cabine(object):

    def __init__(self):
        self._door = DoorOpen()

    def isCabinStopped(self):
        pass

    def isCabinMoving(self):
        pass

    def isCabinWaitingForPeople(self):
        pass

    def isCabinDoorOpened(self):
        return self._door.isCabinDoorOpened()

    def isCabinDoorOpening(self):
        return self._door.isCabinDoorOpening()

    def isCabinDoorClosed(self):
        return self._door.isCabinDoorClosed()

    def isCabinDoorClosing(self):
        return self._door.isCabinDoorClosing()

    def waitForPeopleTimedOut(self):

        self._door = DoorClosing()

    def goingUp(self):
        self._door = self._door.goingUp()
        return self

    def cabinDoorClosed(self):
        res =  CabineInMovement(self._door)
        res._door = DoorClose()
        return res





class DoorOpening(Door):

    def isCabinDoorOpened(self):
        return False

    def isCabinDoorOpening(self):
        return True

    def isCabinDoorClosed(self):
        return False

    def isCabinDoorClosing(self):
        return False

    def goingUp(self):
    	return DoorClosing()


class DoorOpen(Door):

    def isCabinDoorOpened(self):
        return True

    def isCabinDoorOpening(self):
        return False

    def isCabinDoorClosed(self):
        return False

    def isCabinDoorClosing(self):
        return False

    def goingUp(self):
    	return DoorClosing()



class DoorClosing(Door):

    def isCabinDoorOpened(self):
        return False

    def isCabinDoorOpening(self):
        return False

    def isCabinDoorClosed(self):
        return False

    def isCabinDoorClosing(self):
        return True

    def goingUp(self):
    	return self


class DoorClose(Door):

    def isCabinDoorOpened(self):
        return False

    def isCabinDoorOpening(self):
        return False

    def isCabinDoorClosed(self):
        return True

    def isCabinDoorClosing(self):
        return False

    def goingUp(self):
    	return self





class CabineInMovement(Cabine):
    def __init__(self, aDoor):
        super(self.__class__, self).__init__()
        self._door = aDoor

    def isCabinStopped(self):
        return False

    def isCabinMoving(self):
        return True

    def isCabinWaitingForPeople(self):
        return False

    def StopAndOpenDoor(self):
    	self._door = self._door.doorOpen()
        return CabineStoped(self._door)
        

class CabineStoped(Cabine):
    def __init__(self, aDoor):
        super(self.__class__, self).__init__()
        self._door = aDoor

    def isCabinStopped(self):
        return True

    def isCabinMoving(self):
        return False

    def isCabinWaitingForPeople(self):
        return False

    def openCabinDoor(self):
        self._door = self._door.doorStarOpening()
        return self



class CabineWaitingForPeople(Cabine):
    def __init__(self, aDoor):
        super(self.__class__, self).__init__()
        self._door = aDoor

    def isCabinStopped(self):
        return False

    def isCabinMoving(self):
        return False

    def isCabinWaitingForPeople(self):
        return True




class ElevatorControllerIdle:

    def __init__(self):
        self._actualFloor = 0
        self._cabine = CabineStoped(DoorOpen())

    def isIdle(self):
        return True

    def isWorking(self):
        return False

    def isCabinDoorOpened(self):
        return self._cabine.isCabinDoorOpened()

    def isCabinDoorOpening(self):
        return self._cabine.isCabinDoorOpening()

    def isCabinDoorClosed(self):
        return self._cabine.isCabinDoorClosed()

    def isCabinDoorClosing(self):
        return self._cabine.isCabinDoorClosing()

    def cabinFloorNumber(self):
        return self._actualFloor

    def isCabinStopped(self):
        return self._cabine.isCabinStopped()

    def isCabinMoving(self):
        return self._cabine.isCabinMoving()

    def isCabinWaitingForPeople(self):
        return self._cabine.isCabinWaitingForPeople()

    def cabinFloorNumber(self):
        return self._actualFloor

    def isCabinStopped(self):
        return self._cabine.isCabinStopped()

    def isCabinMoving(self):
        return self._cabine.isCabinMoving()

    def isCabinWaitingForPeople(self):
        return self._cabine.isCabinWaitingForPeople()

    def goUpPushedFromFloor(self, aFloorNumber):
        self._cabine = self._cabine.goingUp()
        return ElevatorControlleWorking(self, aFloorNumber)

    def cabinDoorClosed(self):
        return self

    def openCabinDoor(self):
        return self






class ElevatorControlleWorking:

    def __init__(self, OtherElevatorControler, aFloorToGo):
        self._actualFloor = OtherElevatorControler._actualFloor
        self._cabine = OtherElevatorControler._cabine
        self._nextFloors = [aFloorToGo]

    def isIdle(self):
        return False

    def isWorking(self):
        return not True

    def isCabinDoorOpened(self):
        return self._cabine.isCabinDoorOpened()

    def isCabinDoorOpening(self):
        return self._cabine.isCabinDoorOpening()

    def isCabinDoorClosed(self):
        return self._cabine.isCabinDoorClosed()

    def isCabinDoorClosing(self):
        return self._cabine.isCabinDoorClosing()

    def cabinFloorNumber(self):
        return self._actualFloor

    def isCabinStopped(self):
        return self._cabine.isCabinStopped()

    def isCabinMoving(self):
        return self._cabine.isCabinMoving()

    def isCabinWaitingForPeople(self):
        return self._cabine.isCabinWaitingForPeople()

    def cabinFloorNumber(self):
        return self._actualFloor

    def isCabinStopped(self):
        return self._cabine.isCabinStopped()

    def isCabinMoving(self):
        return self._cabine.isCabinMoving()

    def isCabinWaitingForPeople(self):
        return self._cabine.isCabinWaitingForPeople()

    def goUpPushedFromFloor(self, aFloorNumber):
        self._cabine = self._cabine.goingUp()
        self._nextFloors.append(aFloorNumber)
        return self

    def cabinOnFloor(self, aFloorNumber):
        self._actualFloor = aFloorNumber
        if aFloorNumber == self._nextFloors[0]:
            self._cabine = self._cabine.StopAndOpenDoor()
            self._nextFloors.remove(aFloorNumber)
        return self

    def cabinDoorClosed(self):
        self._cabine = self._cabine.cabinDoorClosed()
        return self

    def openCabinDoor(self):
        self._cabine.openCabinDoor()
        return self

    def cabinDoorOpened(self):
        if not len(self._nextFloors) == 0 :
            self._cabine = _cabine.cabineStartWaitForPeople





class ElevatorController:
    def __init__(self):
        self._elevatorController = ElevatorControllerIdle()

    def isIdle(self):
        return self._elevatorController.isIdle()
    
    def isWorking(self):
        return not self._elevatorController.isWorking()

    def isCabinDoorOpened(self):

        return self._elevatorController.isCabinDoorOpened()

    def isCabinDoorOpening(self):
        return self._elevatorController.isCabinDoorOpening()

    def isCabinDoorClosed(self):
        return self._elevatorController.isCabinDoorClosed()

    def isCabinDoorClosing(self):
        return self._elevatorController.isCabinDoorClosing()

    def cabinFloorNumber(self):
        return self._elevatorController.cabinFloorNumber()

    def isCabinStopped(self):
        return self._elevatorController.isCabinStopped()

    def isCabinMoving(self):
        return self._elevatorController.isCabinMoving()

    def isCabinWaitingForPeople(self):
        return self._elevatorController.isCabinWaitingForPeople()

    def goUpPushedFromFloor(self, aFloorNumber):

        self._elevatorController = self._elevatorController.goUpPushedFromFloor(aFloorNumber)

    def cabinOnFloor(self, aFloorNumber):
        self._elevatorController = self._elevatorController.cabinOnFloor(aFloorNumber)

    def cabinDoorClosed(self):
        self._elevatorController = self._elevatorController.cabinDoorClosed()

    def openCabinDoor(self):
        self._elevatorController.openCabinDoor()

    def cabinDoorOpened(self):
        self._elevatorController = self._elevatorController.cabinDoorOpened()


    def waitForPeopleTimedOut(self):
        self._cabine.waitForPeopleTimedOut()


    def closeCabinDoor(self):
        if not self._stateOfDoor == DoorStateEnum.close:
            if not self._isIdle and not self._stateOfDoor == DoorStateEnum.opening:
                self._stateOfDoor = DoorStateEnum.closing
            self._stateOfCabine = CabineStateEnum.stopped


class ElevatorEmergency(Exception):
    pass

class ElevatorTest(unittest.TestCase):

    def test01ElevatorStartsIdleWithDoorOpenOnFloorZero(self):
        elevatorController = ElevatorController()
        
        self.assertTrue(elevatorController.isIdle())
        self.assertTrue(elevatorController.isCabinStopped())
        self.assertTrue(elevatorController.isCabinDoorOpened())
        self.assertEqual(0,elevatorController.cabinFloorNumber())
    
    def test02CabinDoorStartsClosingWhenElevatorGetsCalled(self):
        elevatorController = ElevatorController()
    
        elevatorController.goUpPushedFromFloor(1)
        
        self.assertFalse(elevatorController.isIdle())
        self.assertTrue(elevatorController.isWorking())
        
        self.assertTrue(elevatorController.isCabinStopped())
        self.assertFalse(elevatorController.isCabinMoving())
        
        self.assertFalse(elevatorController.isCabinDoorOpened())
        self.assertFalse(elevatorController.isCabinDoorOpening())
        self.assertTrue(elevatorController.isCabinDoorClosing())
        self.assertFalse(elevatorController.isCabinDoorClosed())
    
    def test03CabinStartsMovingWhenDoorGetsClosed(self):
        elevatorController = ElevatorController()
    
        elevatorController.goUpPushedFromFloor(1)
        elevatorController.cabinDoorClosed()
        
        self.assertFalse(elevatorController.isIdle())
        self.assertTrue(elevatorController.isWorking())
    
        self.assertFalse(elevatorController.isCabinStopped())
        self.assertTrue(elevatorController.isCabinMoving())
        
        self.assertFalse(elevatorController.isCabinDoorOpened())
        self.assertFalse(elevatorController.isCabinDoorOpening())
        self.assertFalse(elevatorController.isCabinDoorClosing())
        self.assertTrue(elevatorController.isCabinDoorClosed())

    def test04CabinStopsAndStartsOpeningDoorWhenGetsToDestination(self):
        elevatorController = ElevatorController()
    
        elevatorController.goUpPushedFromFloor(1)
        elevatorController.cabinDoorClosed()
        elevatorController.cabinOnFloor(1)

        self.assertFalse(elevatorController.isIdle())
        self.assertTrue(elevatorController.isWorking())
        
        self.assertTrue(elevatorController.isCabinStopped())
        self.assertFalse(elevatorController.isCabinMoving())
                
        self.assertFalse(elevatorController.isCabinDoorOpened())
        self.assertTrue(elevatorController.isCabinDoorOpening())
        self.assertFalse(elevatorController.isCabinDoorClosing())
        self.assertFalse(elevatorController.isCabinDoorClosed())

        self.assertEquals(1,elevatorController.cabinFloorNumber())

    def test05ElevatorGetsIdleWhenDoorGetOpened(self):
        elevatorController = ElevatorController()
    
        elevatorController.goUpPushedFromFloor(1)
        elevatorController.cabinDoorClosed()
        elevatorController.cabinOnFloor(1)
        elevatorController.cabinDoorOpened()
        
        self.assertTrue(elevatorController.isIdle())
        self.assertFalse(elevatorController.isWorking())
        
        self.assertTrue(elevatorController.isCabinStopped())
        self.assertFalse(elevatorController.isCabinMoving())

        self.assertTrue(elevatorController.isCabinDoorOpened())
        self.assertFalse(elevatorController.isCabinDoorOpening())
        self.assertFalse(elevatorController.isCabinDoorClosing())
        self.assertFalse(elevatorController.isCabinDoorClosed())
        
        self.assertEquals(1,elevatorController.cabinFloorNumber())
    