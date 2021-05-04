//
//  EmojiTableViewCell.swift
//  EmojiList
//
//  Created by Жадаев Алексей on 03.05.2021.
//

import UIKit

class EmojiTableViewCell: UITableViewCell {

    @IBOutlet weak var emojiLabel: UILabel!
    @IBOutlet weak var nameEmojiLabel: UILabel!
    @IBOutlet weak var descriptionEmojiLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    func configure(object: Emoji) {
        self.emojiLabel.text = object.emojiPic
        self.nameEmojiLabel.text = object.name
        self.descriptionEmojiLabel.text = object.description
    }
}
