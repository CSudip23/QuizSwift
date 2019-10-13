//
//  ViewController.swift
//  FinalProject
//
//  Created by Sudip Chitroda on 2019-07-18.
//  Copyright © 2019 Sudip Chitroda. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let listOfQuestions  = QuestionList()
    let totalQuestions = 20
    var pressed : Bool = true
    var questionNum : Int = 0
    var score: Int = 0
    var progress: Int = 1
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        nextQuestion()
        updateProgress(quesNum: progress)
        Progress.transform = Progress.transform.scaledBy(x: 1, y: 3)
        Progress.layer.cornerRadius = 15
        Progress.clipsToBounds = true
        
    }
    
    @IBOutlet weak var questions: UILabel!
    
    @IBAction func answerButton(_ sender: UIButton) {
        
        if(sender.tag==1){
            pressed = true;
            
        }
        else{
            pressed = false;
            
        }
        checkAnswer();
        progress = progress + 1
        updateProgress(quesNum: progress)
        questionNum = questionNum + 1
        nextQuestion();
        
    }
    @IBOutlet weak var Progress: UIProgressView!
    
    @IBOutlet weak var questionTotal: UILabel!
    
    @IBOutlet weak var Score: UILabel!
    
    
    func updateInterface(){
        
        Score.text = "Score: \(score)"
        questionTotal.text = "\(questionNum+1)/\(totalQuestions)"
    }
    
    func nextQuestion() {
        if(questionNum <= 19){
            
            updateInterface()
            
            questions.text = listOfQuestions.list[questionNum].question
        }
        else{
            
            let blurEffect = UIBlurEffect(style: .dark)

            let blurEffectView = UIVisualEffectView(effect: blurEffect)

            blurEffectView.frame = self.view.frame

            self.view.insertSubview(blurEffectView, at: 5)
            
            let alert = UIAlertController(title: "Quiz Complete. \n Your score is: \(score)", message: "Restart the Quiz", preferredStyle: .alert)
          
            alert.addAction(UIAlertAction(title: "Play Again", style: .default, handler: {(alert: UIAlertAction!) in self.startOver()
                blurEffectView.removeFromSuperview()
            }))
            
            let action = UIAlertAction(title: "Exit", style: .cancel, handler: { action in
                
                let secondView = self.storyboard!.instantiateViewController(withIdentifier: "SecondView") as! SecondViewController
                
                self.present(secondView, animated: true, completion: nil)
            })
            
            alert.addAction(action)
           
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func checkAnswer() {
        
        let correctAns = listOfQuestions.list[questionNum].answer
        if(correctAns == pressed){

            score += 1;
            if (questionNum < 19){
            let alert = UIAlertController(title: "Correct", message: "", preferredStyle: .alert)
                let height:NSLayoutConstraint = NSLayoutConstraint(item: alert.view!, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: 100)
                alert.view.addConstraint(height)

                let width:NSLayoutConstraint = NSLayoutConstraint(item: alert.view!, attribute: NSLayoutConstraint.Attribute.width, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: 100)
                alert.view.addConstraint(width)
//
                
                let imageView = UIImageView(frame: CGRect(x: 40, y: 50, width: 20, height: 20))
                imageView.image = UIImage(named: "check")

                alert.view.addSubview(imageView)
            present(alert, animated: true) {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.06) { [weak self] in
                    guard self?.presentedViewController == alert else { return }
                    
                    self?.dismiss(animated: true, completion: nil)
                    }
                }
            }
        }
        else{
            
            if (questionNum < 19){
                let alert = UIAlertController(title: "Wrong", message: "", preferredStyle: .alert)
                let height:NSLayoutConstraint = NSLayoutConstraint(item: alert.view!, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: 100)
                alert.view.addConstraint(height)
                
                let width:NSLayoutConstraint = NSLayoutConstraint(item: alert.view!, attribute: NSLayoutConstraint.Attribute.width, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: 100)
                alert.view.addConstraint(width)
                
                let imageView = UIImageView(frame: CGRect(x: 40, y: 50, width: 20, height: 20))
                imageView.image = UIImage(named: "cross")
                
                alert.view.addSubview(imageView)
                
                present(alert, animated: true) {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.06) { [weak self] in
                        guard self?.presentedViewController == alert else { return }
                        
                        self?.dismiss(animated: true, completion: nil)
                    }
                }
            }
        }
    }
    
    
    func startOver() {
        
        progress = 1
        updateProgress(quesNum: progress)
        questionNum = 0
        score = 0
        nextQuestion()
    }
    
    func updateProgress(quesNum: Int){
        
        let totalProgress: Float = Float(quesNum)/Float(totalQuestions)
        self.Progress.setProgress(totalProgress, animated: true)
       
    }
}

