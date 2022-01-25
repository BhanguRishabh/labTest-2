

import UIKit
import CoreData

class ViewController: UIViewController {
   // var DataNow:DataforGame? = nil
    
    
    @IBOutlet weak var label: UILabel!
    
    @IBOutlet weak var score1: UILabel!
    
    
    @IBOutlet weak var score2: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        let appDelegate = UIApplication.shared.delegate as! AppDelegate
//        let context:NSManagedObjectContext = appDelegate.persistentContainer.viewContext
//        let entity = NSEntityDescription.entity(forEntityName: "DataforGame", in: context)
//        let data = DataforGame(entity: entity!, insertInto: context)
//
//
//        data.gamer = 1
//        data.gameActive = true
//        data.counting = 0
//        data.scoreCross = 0
//        data.scoreNought = 0
//        data.lastButtonPosition = -1
//        data.recordInput = [0,0,0,0,0,0,0,0,0]
//
//        do{
//            try context.save()
//            print("context saving done")
//
//
//        }
//        catch{   print("context saving error")}
//
        
        
        
        
        
 // Do any additional setup after loading the view.
     
     let pullDown = UISwipeGestureRecognizer(target: self, action: #selector(swiped))  // detection downswipe
    pullDown.direction = UISwipeGestureRecognizer.Direction.down
     view.addGestureRecognizer(pullDown)
     
     
 }
  
    var player = 1// person variable to keep track of players turn , intialized with player one
    var recordOfInput = [0,0,0,0,0,0,0,0,0]   // keeping track of inputs
    var winningInputs = [[0,1,2],[3,4,5],[6,7,8],[0,4,8],[2,4,6],[0,3,6],[1,4,7],[2,5,8]] // all posibble winning combinationns
    var gameIsActive = true // variable to keep track if game is on-going or stopped
    var count = 0  //   variable to keep tracks whether all the nine moves are made, and game is complete with no one winning
    var ScoreOfCross = 0  // keep...
    var ScoreOfNought = 0 // ........ tracks of number of wins
    var recordLastButtonPosition = -1
    
    @IBAction func button(_ sender: AnyObject) {
        
        if(recordOfInput[sender.tag-1] == 0  && gameIsActive == true) {   // Check button is its unSelected and game is on-going
            
            recordLastButtonPosition = sender.tag // keeps track of button cicked
            
            recordOfInput[sender.tag-1] = player
            count = 0;// assign count to zero every time player makes a move
            if(player == 1){
                sender.setImage(UIImage(named:"cross.png"), for: UIControl.State())
                player = 2
                label.backgroundColor = UIColor.systemBlue
                label.text="PLAYER 2 MAKE MOVE "
                
            }
            else{
                sender.setImage(UIImage(named:"nought.png"), for: UIControl.State())
                label.backgroundColor = UIColor.systemBlue
                player = 1
                label.text="PLAYER 1 MAKE MOVE "
            }
            
            for cmb in winningInputs {
                if   recordOfInput[cmb[0]] == recordOfInput[cmb[1]] && recordOfInput[cmb[1]] == recordOfInput[cmb[2]] && recordOfInput[cmb[0]] != 0 { // checking if first of combination is not empty and all three consequtive array have equal value(either 1s 0r 2s)
                    
                    
                    
                    if(recordOfInput[cmb[0]] == 1){
                        label.backgroundColor = UIColor.lightGray
                        label.text="PLAYER 1 ,CROSS HAS  WON "
                        ScoreOfCross+=1
                        score1.text = String(ScoreOfCross)+" wins"
                        
                        
                        }
                    else{
                       
                        label.backgroundColor = UIColor.systemYellow
                        label.text="PLAYER 2 ,NOUGHT HAS WON "
                        ScoreOfNought+=1
                        score2.text = String(ScoreOfNought)+" wins"

                         }
                    
                    gameIsActive = false // in case either player win game is InActive
                    playAgain() // playAgain func is called
                    
                    
                }
                
            }
                   
         //----- if all the moves are made with no player WINNING, then display Try Again button
            
            for i in recordOfInput{
                    if(i != 0){
                    count+=1  }
                 }
            if(count == 9 ){
                label.backgroundColor = UIColor.systemPink
                label.text="Draw"
                playAgain()
            }
        }
          
    }
    
    
    
           func playAgain( ) {  // this function restart new game by removing images of cross and nought
           DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) { // inducing delay so user can see his input briefly before restarting new game (for smooth user experince)
               self.player = 1//
               self.gameIsActive = true
               self.recordOfInput = [0,0,0,0,0,0,0,0,0]  // making input record to initial values
               self.label.backgroundColor = UIColor.systemBlue
               self.label.text="PLAYER 1 MAKE A MOVE"
               
               for i in 1...9 {   // using loop over nine buttons to remove images
                    let btn = self.view.viewWithTag(i) as! UIButton
                    btn.setImage(nil, for: UIControl.State())
              }
        }
    }
    
       
    //--- pull down swipe displays message and reset scores for each player to zero
    @objc func swiped(gesture: UISwipeGestureRecognizer) {
        let alert = UIAlertController(title: "Message ", message: " Game is Reset", preferredStyle: .alert)
        self.present(alert, animated: true, completion: nil)
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: false, block: { _ in alert.dismiss(animated: true, completion: nil)} )
        
        
         playAgain()
         ScoreOfCross = 0
         ScoreOfNought = 0
         score1.text = "0 wins"
         score2.text = "0 wins"
        
        
    }
    
    // shake motion
        override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
            if event?.subtype == UIEvent.EventSubtype.motionShake {
                print("phone is shaking")
                reverseTheState()
            }
        }
    
    
    func reverseTheState(){
        
        if(gameIsActive){
            if(player == 1) {
                player = 2
                count-=1
                let btn = self.view.viewWithTag(recordLastButtonPosition) as! UIButton
                btn.setImage(nil, for: UIControl.State())
                recordOfInput[recordLastButtonPosition-1] = 0
                label.backgroundColor = UIColor.systemBlue
                label.text="PLAYER 2 MAKE MOVE AGAIN "
                
             }
            
            else{
                player = 1
                count-=1
                let btn = self.view.viewWithTag(recordLastButtonPosition) as! UIButton
                btn.setImage(nil, for: UIControl.State())
                recordOfInput[recordLastButtonPosition-1] = 0
                label.backgroundColor = UIColor.systemBlue
                
                label.text="PLAYER 1 MAKE MOVE AGAIN "
                
                
                
            }
            
            
        }
        
        
    } // end of reverse the stste
    
   }

