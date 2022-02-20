//driver searches for car keys but doesnt find it
//driver sends alert from phone to
//Car Unlocks only if in close proximity or else phone sends car too far alert
//car doors unlock
//driver gets in the car and sits down
//driver turns on engine
//stereo turns on autmatically
//stereo - vol up, down, trackup down, source of input
//driver and passenger seatbelt check - beep longer for driver seatbelt check, shorter for passenger check
//gear shifts and indicators
//accelerate
//decelerate
//break
//emergency breaking with prox sensor
//baby on board indicator.


import Foundation


//Call site
var myAudiCar:audiCar = audiCar()
myAudiCar.userRequestByPhone()
myAudiCar.userAccessByPhone()
myAudiCar.phoneSensedInPromixity()
myAudiCar.userAccessByPhone()
myAudiCar.engineStart()
myAudiCar.speedUp()
myAudiCar.applyBreaks()
myAudiCar.speedUp()
myAudiCar.applyEmergencyBreaks()
myAudiCar.speedUp()
myAudiCar.removeEmergencyBreaks()
myAudiCar.speedUp()
myAudiCar.engineStop()
/*
 Protocol defines the basic
 functionalities of a car engine
 */
protocol CarEngine{
    
    var engineStatus:Bool {set get}
    var currentSpeed:Int {set get}
    var maxSpeed:Int {set get}
    
    //turns on car engine
    func engineOn()
    //turns off car engine
    func engineOff()
    // acclerate the car
    func accelerate()
    // decelrate the car
    func decelerate()
    // speed decrease for breaking
    func breaking()
    // bring car to emergency halt
    func emergencyBreaking()
}

/*
 Protocol defines the breaks and gears functionality
 of a car.
 Should they be deifferent protocols?
 */
protocol Breaks{
    var handBreakStatus:Bool { get set }
    
    func backBreaks()
    // turn handbreaks for emergency breaking
    func handBreakOn()
    // turn off handbreaks
    func handBreakOff()
}

/*
 Protocol that defines the operations off a
 car stereo.
 */
protocol CarStereo{
    
    var carStereoStatus:Bool { get set }
    var songTracks:[String] { get }
    var currentTrack:Int { get set }
    var maxVolume:Int { get }
    var minVolume:Int { get }
    var currentVolume:Int { get set }

    // turn on car stereo
    func carSteroOn()
    //turn off car stereo
    func carStereoOff()
    // get current track
    func getCurrentTrack()
    //switch track
    func nextTrack()
    //turn up the volume ! Whoop ! Whoop!
    func volumeUp()
    //turn down the volumne #dislike
    func volumeDown()
}

/*
 Protocol that checks if the phone is in proximity or not
 */
protocol PhoneSensor{
  var isPhoneNear:Bool {get set}

  func phoneInProximity()

  func phoneNotInProximity()

}
/*
 Protocol that checks if the user requested through phone
 */
protocol Request{
  var requestByUser: Bool {get set}
  func requestMade ()
  func requestNotMade ()
}
/*
 Protocol that defines the operations of a carlock
 */
protocol Carlock{
    var carLockStatus:Bool {get set}
    
    //method to lock a car
    func carLock()
    
    //method to unlock a car
    func carUnlock()
}

//concrete  implementation for car Engine
class CarEngineImpl:CarEngine{

    var engineStatus:Bool = false
    var currentSpeed:Int = 0
    var maxSpeed:Int = 4;
    
    //tuens on engine
    func engineOn() {
        // check if engine is already on
        if(engineStatus==true){
            print("Engine Already On")
        }
        else{
            engineStatus = true
            print("Engine Turned On")
        }
    }
    
    //turn off engine
    func engineOff() {
        // check if engine is already off
        if(engineStatus==false){
            print("Engine Already OFF")
        }
        else{
            engineStatus = false
            print("Engine Turned OFF")
        }
    }
    
    
    func accelerate() {
        //stop accelerating after max speed is reached
        if(!engineStatus){
            print("Engine Off! Please Turn on Engine")
        }
        else if(currentSpeed==maxSpeed || currentSpeed>maxSpeed){
            currentSpeed = maxSpeed
            print("Max Speed is reached")
        }
        else{
            currentSpeed = currentSpeed + 2;
            print("Current Speed of car is ",currentSpeed)
        }
    }
    
    func decelerate() {
        if(!engineStatus){
            print("Engine Off! Please Turn on Engine")
        }
        else if(currentSpeed==0 || currentSpeed<0){
            currentSpeed = 0
            print("Max Speed is stopped! Cant decelerate")
        }
        else{
            currentSpeed = currentSpeed - 1;
            print("Current Speed of car is ",currentSpeed)
        }
    }
    
    func breaking() {
        if(!engineStatus){
            print("Engine Off! Please Turn on Engine")
        }
        else if(currentSpeed==0 || currentSpeed<0){
            currentSpeed = 0
            print("Max Speed is stopped! Cant decelerate")
        }
        else{
            currentSpeed = currentSpeed - 2;
            print("Current Speed of car is ",currentSpeed)
        }
    }
    
    func emergencyBreaking() {
        currentSpeed = 0;
    }
    
    
}
//concrete implementation on phonse sensor
class PhonseSensorImpl: PhoneSensor{
  var isPhoneNear: Bool = false
  func phoneInProximity() {
    isPhoneNear = true
    print("phone is in proximity")
  
  }
  func phoneNotInProximity() {
    isPhoneNear =  false
    print("phone not in promixity")
  
  }
}

class Requestbyuserimpl: Request{
  var requestByUser = false
  func requestMade() {
    requestByUser = true
    print("user has sent a request to access the car")
  }
  func requestNotMade(){
    requestByUser = false
    print("user has not made any access request yet")
  }
}
//Car Stereo Concerete implementation
class CarStereoImpl:CarStereo{
    var carStereoStatus: Bool = false
    
    var songTracks: [String] = ["Easy on Me", "UpTown Funk","Levitating", "Highway to hell"]
    
    var currentTrack: Int = 1
    
    var maxVolume: Int = 100
    
    var minVolume: Int = 0
    
    var currentVolume: Int = 25
    
    
    func carSteroOn() {
        if(carStereoStatus == true){
            print("Stero Already On")
        }
        else{
            carStereoStatus = true
            print("Stereo Turned On")
        }
    }
    
    func carStereoOff() {
        if(carStereoStatus == false){
            print("Stero Already Off")
        }
        else{
            carStereoStatus = false
            print("Stereo Turned Off")
        }
    }
    
    func getCurrentTrack() {
        print("Current Track is ",songTracks[currentTrack])
    }
    
    func nextTrack() {
        currentTrack = (currentTrack+1)%(songTracks.count)
    }
    
    func volumeUp() {
        if(currentVolume == maxVolume){
            print("Max Volume Reached")
        }
        else{
            currentVolume = currentVolume + 1
            print("Current Volume is ",currentVolume)
        }
    }
    
    func volumeDown() {
        if(currentVolume == minVolume){
            print("Min Volume Reached")
        }
        else{
            currentVolume = currentVolume-1
            print("Current Volume is ",currentVolume)
        }
    }
    
    
}

//concerete implementtion for breaks
class BrakesImpl:Breaks{
    
    var handBreakStatus:Bool = true
    
    func backBreaks() {
        print("Back breaks applied! Car Decelerating")
    }
    
    func handBreakOn() {
        handBreakStatus = true
        print("Hand break applied")
    }
    
    func handBreakOff() {
        handBreakStatus = false
        print("hand break not applied")
    }
}

/*
 lock class concrete implementation
 */

class CarLockImpl:Carlock{
    var carLockStatus: Bool = true
    
    func carLock() {
        carLockStatus = true
        print("Car is Locked")
    }
    
    func carUnlock() {
        carLockStatus = false
        print("Car is unlocked")
    }
}
/*
 Car abstarct class
 */
public class Car{
    
    let myEngine:CarEngine = CarEngineImpl()
    let myStereo:CarStereo = CarStereoImpl()
    let myBreak:Breaks = BrakesImpl()
    let myLock:Carlock = CarLockImpl()
    let myPhoneSensor:PhoneSensor = PhonseSensorImpl()
    let myRequest:Request = Requestbyuserimpl()
    //todo lock and unlock
    
    func engineStart(){
    }
    
    func engineStop(){
    }
    
    func speedUp(){
    }
    
    func speedDown(){
    }
    
    func applyBreaks(){
    }

    func userRequestByPhone(){
      myRequest.requestMade()
    }

    func phoneSensedInPromixity(){
      myPhoneSensor.phoneInProximity()
    }
    
    func applyEmergencyBreaks(){
    }
    
    func removeEmergencyBreaks(){
    }

    func userAccessByPhone(){
      if (myPhoneSensor.isPhoneNear && myRequest.requestByUser)
      {
        myLock.carUnlock()

      }
      else {
        myPhoneSensor.phoneNotInProximity()
        myLock.carLock()
      }
    }
}

// audi car implementation with car injection
class audiCar:Car{
    
    override func engineStart(){
        myEngine.engineOn()
        myStereo.carSteroOn()
        myStereo.getCurrentTrack()
        myLock.carLock()
    }
    
   override func engineStop(){
        myEngine.engineOff()
        myLock.carUnlock()
        myStereo.carStereoOff()
    }
    
    override func speedUp(){
        if(myBreak.handBreakStatus){
            print("Warning! Handbreaks On!")
        }
        myEngine.accelerate()
    }
    
    override func speedDown(){
        myEngine.decelerate()
    }

    override func applyBreaks(){
        myBreak.backBreaks()
        myEngine.breaking()
    }
    
    override func applyEmergencyBreaks(){
        myBreak.handBreakOn()
        myEngine.emergencyBreaking()
    }
    
    override func removeEmergencyBreaks(){
        myBreak.handBreakOff()
    }
}
