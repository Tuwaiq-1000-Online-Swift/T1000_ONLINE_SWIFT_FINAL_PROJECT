//
//  MyProfileVC.swift
//  T1000_ONLINE_FINAL_PROJECT
//
//  Created by يعرُب on 19/05/1443 AH.
//

import UIKit
import NVActivityIndicatorView

class MyProfileVC: UIViewController {
    
    // MARK: OUTLETS
    @IBOutlet weak var loaderView: NVActivityIndicatorView!
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var imageUrlTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupUI()
    }
    
    
    func setupUI(){
        userImageView.makeCircularImage()
        
        if let user = UserManager.loggedInUser {
            if let image = user.picture {
                userImageView.setImageFromStringUrl(stringUrl: image)
            }
            
            nameLabel.text = user.firstName + " " + user.lastName
            
            firstNameTextField.text = user.firstName
            phoneTextField.text = user.phone
            imageUrlTextField.text = user.picture
            
        }
    }
    

    // MARK: ACTIONS
    
    @IBAction func submitButtonClicked(_ sender: Any) {
        guard let loggedInUser = UserManager.loggedInUser else {return}
        
        loaderView.startAnimating()
        UserAPI.updateUserInfo(userId: loggedInUser.id, firstName: firstNameTextField.text!, phone: phoneTextField.text!, imageUrl: imageUrlTextField.text!) { user, message in
            
            self.loaderView.stopAnimating()
            if let responseUser = user {
                
                if let image = user?.picture {
                    self.userImageView.setImageFromStringUrl(stringUrl: image)
                }
                
                self.nameLabel.text = responseUser.firstName + " " + responseUser.lastName
                
            }
        }
    }
    
}
