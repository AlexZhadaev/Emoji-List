//
//  AddEmojiTableViewController.swift
//  EmojiList
//
//  Created by Жадаев Алексей on 05.05.2021.
//

import UIKit

class AddEmojiTableViewController: UITableViewController {

    var emoji = Emoji(emojiPic: "", name: "", description: "", haveLike: false)
    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var emojiTextField: UITextField!
    @IBOutlet weak var emojiNameTextField: UITextField!
    @IBOutlet weak var emojiDescriptionTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        editingScreen()
        saveButtonAccessibility()
    }
    
    private func saveButtonAccessibility() {
        guard let emojiText = emojiTextField.text else {return}
        guard let nameText = emojiNameTextField.text else {return}
        guard let descriptionText = emojiDescriptionTextField.text else {return}
        saveButton.isEnabled = !emojiText.isEmpty && !nameText.isEmpty && !descriptionText.isEmpty
    }
    
    private func editingScreen() {
        emojiTextField.text = emoji.emojiPic
        emojiNameTextField.text = emoji.name
        emojiDescriptionTextField.text = emoji.description
    }
    
    @IBAction func textChanged(_ sender: UITextField) {
        saveButtonAccessibility()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        guard segue.identifier == "saveUnwindSegue" else { return }
        let emoji = emojiTextField.text ?? ""
        let name = emojiNameTextField.text ?? ""
        let description = emojiDescriptionTextField.text ?? ""
        self.emoji = Emoji(emojiPic: emoji, name: name, description: description, haveLike: self.emoji.haveLike)
    }
}
