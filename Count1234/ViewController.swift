//
//  ViewController.swift
//  Count1234
//
//  Created by DR. EHSAN on 2/10/15.
//  Copyright (c) 2015 Monzurul Ehsan. All rights reserved.
//

//Comment 1

import UIKit
import AVFoundation

class ViewController: UIViewController {

    @IBOutlet weak var imageTick: UIImageView!
    @IBOutlet weak var buttonNext: UIButton!
    @IBOutlet weak var labelCorrectCount: UILabel!
    @IBOutlet weak var labelWrongCount: UILabel!
    @IBOutlet weak var labelQuestion: UILabel!
    @IBOutlet weak var labelFeedback: UILabel!

    @IBOutlet weak var buttonChoiceOne: UIButton!
    @IBOutlet weak var buttonChoiceTwo: UIButton!
    @IBOutlet weak var buttonChoiceThree: UIButton!
    
    
    var firstNumber:UInt32!
    var secondNumber:UInt32!
    var correctChoice:UInt32!
   
    var correctAnswer:UInt32!
    var incorrectAnswer1:UInt32!
    var incorrectAnswer2:UInt32!
    
    var numberOfCorrectResponses:Int = 0
    var numberofWrongResponses:Int = 0
    var ANIMATION_DURATION:Double = 1.0
    
    var audioClipSuccess: AVAudioPlayer!
    var audioClipFailure: AVAudioPlayer!

   
    @IBAction func nextTapped(sender: AnyObject) {
        println("Next Tapped")
        UIView.beginAnimations("", context: nil)
        UIView.setAnimationDuration(ANIMATION_DURATION)
        generateNewProblem()
        UIView.commitAnimations()
    }
    @IBAction func resetTapped(sender: AnyObject) {
        println("resetTapped")
        numberOfCorrectResponses = 0
        numberofWrongResponses = 0
        labelCorrectCount.text = String(numberOfCorrectResponses)
        labelWrongCount.text = String(numberofWrongResponses)

    }
    
    @IBAction func choiceOneTapped(sender: AnyObject) {
        println("choiceOneTapped")
        self.choiceTapped(choiceValue: 1)
        
    }
    
    @IBAction func choiceTwoTapped(sender: AnyObject) {
        println("choiceTwoTapped")
        self.choiceTapped(choiceValue: 2)
    }
    
    
    @IBAction func choiceThreeTapped(sender: AnyObject) {
        println("choiceThreeTapped")
        self.choiceTapped(choiceValue: 3)
        
    }
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        initializeSoundFiles()
        
        view.backgroundColor = UIColor(patternImage: UIImage(named: "background.jpg")!)
        generateNewProblem()
    }
    
    func initializeSoundFiles(){
        var path: String = NSBundle.mainBundle().pathForResource("success", ofType: "wav")!
        var myAudioUrl: NSURL = NSURL(fileURLWithPath: path)!
        audioClipSuccess = AVAudioPlayer(contentsOfURL: myAudioUrl, error: nil)
        
        var path2: String = NSBundle.mainBundle().pathForResource("failure", ofType: "wav")!
        var myAudioUrl2: NSURL = NSURL(fileURLWithPath: path2)!
        audioClipFailure = AVAudioPlayer(contentsOfURL: myAudioUrl2, error: nil)
    }
    
    func hideButtons(){
        self.imageTick.hidden = true
        self.buttonNext.hidden = true
        self.buttonChoiceOne.enabled = true
        self.buttonChoiceTwo.enabled = true
        self.buttonChoiceThree.enabled = true
        self.buttonChoiceOne.backgroundColor = UIColor.blueColor()
        self.buttonChoiceTwo.backgroundColor = UIColor.blueColor()
        self.buttonChoiceThree.backgroundColor = UIColor.blueColor()
        self.labelQuestion.backgroundColor = UIColor.greenColor()
        
    }
    
    func showButtons(){
        self.imageTick.hidden = false
        self.buttonNext.hidden = false
        self.buttonChoiceOne.enabled = false
        self.buttonChoiceTwo.enabled = false
        self.buttonChoiceThree.enabled = false
        self.buttonChoiceOne.backgroundColor = UIColor.lightGrayColor()
        self.buttonChoiceTwo.backgroundColor = UIColor.lightGrayColor()
        self.buttonChoiceThree.backgroundColor = UIColor.lightGrayColor()
        self.labelQuestion.backgroundColor = UIColor.lightGrayColor()

    }
    

    
    func choiceTapped(choiceValue choice:UInt32){
        
        UIView.beginAnimations("", context: nil)
        UIView.setAnimationDuration(ANIMATION_DURATION)
        
        self.showButtons()
        
        if(choice == correctChoice){
            imageTick.image = UIImage(named: "correct2.png")
            numberOfCorrectResponses++
            audioClipSuccess.play()
        }
        else{
            imageTick.image = UIImage(named: "wrong2.png")
            populateFeedback(choiceChosen: choice)
            self.labelFeedback.hidden = false
            numberofWrongResponses++
            audioClipFailure.play()
        }
        
        labelCorrectCount.text = String(numberOfCorrectResponses)
        labelWrongCount.text = String(numberofWrongResponses)
        
        UIView.commitAnimations()

    }
    
    func populateFeedback(choiceChosen choice:UInt32){
        
        var selectedChoice:String = ""
        
        if(choice == 1){
            selectedChoice = buttonChoiceOne.titleForState(UIControlState.Normal)!
        }
        else if(choice == 2){
            selectedChoice = buttonChoiceTwo.titleForState(UIControlState.Normal)!
        }
        else{
            selectedChoice = buttonChoiceThree.titleForState(UIControlState.Normal)!
        }
        
        self.labelFeedback.text = "ANSWER: " + String(correctAnswer) + " SELECTED: " + selectedChoice
        
    }
    
    func generateNewProblem(){
        
        firstNumber = arc4random() % 50
        secondNumber = arc4random() % 50
        correctAnswer = firstNumber + secondNumber
        
        labelQuestion.text = String(firstNumber) + " + " + String(secondNumber)
        generateAnswerChoices()
        
        self.hideButtons()
        
        self.labelFeedback.hidden = true
        
        
    }
    
    
    func generateAnswerChoices(){
        
        generateIncorrectChoices()
        
        correctChoice = (arc4random() % 3) + 1
        if(correctChoice == 1){
            buttonChoiceOne.setTitle(String(correctAnswer), forState: UIControlState.Normal)
            buttonChoiceTwo.setTitle(String(incorrectAnswer1), forState: UIControlState.Normal)
            buttonChoiceThree.setTitle(String(incorrectAnswer2), forState: UIControlState.Normal)
       }
        else if(correctChoice == 2){
            buttonChoiceOne.setTitle(String(incorrectAnswer1), forState: UIControlState.Normal)
            buttonChoiceTwo.setTitle(String(correctAnswer), forState: UIControlState.Normal)
            buttonChoiceThree.setTitle(String(incorrectAnswer2), forState: UIControlState.Normal)
        }
        else{
            buttonChoiceOne.setTitle(String(incorrectAnswer1), forState: UIControlState.Normal)
            buttonChoiceTwo.setTitle(String(incorrectAnswer2), forState: UIControlState.Normal)
            buttonChoiceThree.setTitle(String(correctAnswer), forState: UIControlState.Normal)
        }
        
        
    }
    
    
    func generateIncorrectChoices(){
        
        if(correctAnswer > 10){
          incorrectAnswer1 = correctAnswer - 10
        }
        else{
            incorrectAnswer1 = correctAnswer + 10
        }
        
        if(correctAnswer > 1){
            incorrectAnswer2 = correctAnswer - 1
        }
        else{
            incorrectAnswer2 = correctAnswer + 1
        }
    }
    
    
    func performHardwareSpecificAction(){
        
        //If device is 3.5 inch - reduce width of the question label
        var deviceWidth:CGFloat = self.view.frame.width
        var deviceHeight:CGFloat = self.view.frame.height
        
        if ( (deviceHeight == 480.0) && (deviceWidth == 320.0) ){
            println("Detected iPhone 4S")
        }

    }
    



}

