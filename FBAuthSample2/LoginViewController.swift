
import UIKit
import Firebase

class LoginViewController: UIViewController {
    
    @IBOutlet weak var Logemail: UITextField!
    @IBOutlet weak var Logpass: UITextField!
    @IBOutlet weak var Logbtnshape: UIButton!
    
    var databaseRefer : DatabaseReference!
    var databaseHandle : DatabaseHandle!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Logbtnshape.layer.cornerRadius = 0.07 * Logbtnshape.bounds.size.width
        
        let strboard = UIStoryboard(name: "Main", bundle: nil)
        let ctrler = strboard.instantiateViewController(withIdentifier: "SignoutView")
        self.present(ctrler,animated: true,completion: nil)
        
    }
    
    
    
    @IBAction func LogAction(_ sender: Any) {
        
        Auth.auth().signIn(withEmail: Logemail.text!, password: Logpass.text!) { (user, error) in
            if(user != nil){
                
                self.databaseRefer = Database.database().reference()
                
                let uid = Auth.auth().currentUser?.uid
                
                print("LOGIN SUCCESS !")
                print(uid!)
                
                self.databaseRefer.child("users").child(uid!).observeSingleEvent(of: .value, with: { (data) in
                    let value = data.value as? NSDictionary
                    let Fname = value?["First Name"] as? String ?? "" // ??= else  ->  else Fname = ""
                    let Lname = value?["Last Name"] as? String ?? ""
                    let Age = value?["Age"] as? String ?? ""
                    print(Fname)
                    print(Lname)
                    print(Age)
                })
                
            }
            else{
                if let myError = error?.localizedDescription{
                    print(myError)
                }else{
                    print("Error Can't LOGIN")
                }
            }
        }

    }
    
    

}
