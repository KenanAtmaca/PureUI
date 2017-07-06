import UIKit

class testVC: UIViewController {
    
    @IBOutlet weak var tButton: PUIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
      // tButton.setGradient("#B65757", "#eeeeee", .bottom)
       // tButton.setButtonStyle(type: .D)
    //    tButton.setIndicator(style: .gray, position: .left, scale: nil)
        
    }

    @IBAction func tappedButton(_ sender:Any) {
     
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    //   tButton.removeIndicator()
        
    }
    
   
}
