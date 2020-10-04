//
//  TweetViewController.swift
//  Twitter
//
//  Created by Edgar Reyes on 10/3/20.
//  Copyright © 2020 Dan. All rights reserved.
//

import UIKit

class TweetViewController: UIViewController, UITextViewDelegate {

    @IBOutlet weak var tweetTextView: UITextView!
    @IBOutlet weak var characterCount: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tweetTextView.delegate = self
        tweetTextView.becomeFirstResponder()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func Cancel(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func Tweet(_ sender: UIBarButtonItem) {
        if (!tweetTextView.text.isEmpty) {
            TwitterAPICaller.client?.postTweet(tweetString: tweetTextView.text, success: {self.dismiss(animated: true, completion: nil)}, failure: { (error) in
                print("Error posting tweet \(error)")
                self.dismiss(animated: true, completion: nil)
            })
        } else {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        
        // Set the max character limit
        let characterLimit = 280

        // Construct what the new text would be if we allowed the user's latest edit
        let newText = NSString(string: textView.text!).replacingCharacters(in: range, with: text)

        // TODO: Update Character Count Label
        characterCount.text = "\(newText.count)/280"
        // The new text should be allowed? True/False
        return newText.count < characterLimit
       // TODO: Check the proposed new text character count
       // Allow or disallow the new text
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
