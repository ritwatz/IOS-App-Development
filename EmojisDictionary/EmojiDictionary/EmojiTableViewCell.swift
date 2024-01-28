//
//  EmojiTableViewCell.swift
//  EmojiDictionary
//
//  Created by user2 on 23/01/24.
//

import UIKit

class EmojiTableViewCell: UITableViewCell {
    
    
    @IBOutlet var nameLabel: UILabel!
    
    
    
    @IBOutlet var descriptionLabel: UILabel!
    

    @IBOutlet var symbolLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func update(with emoji: Emoji){
        symbolLabel.text = emoji.symbol
        nameLabel.text = emoji.name
        descriptionLabel.text = emoji.description
    }

}
