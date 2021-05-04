//
//  EmojiTableViewController.swift
//  EmojiList
//
//  Created by Жадаев Алексей on 03.05.2021.
//

import UIKit

class EmojiTableViewController: UITableViewController {
    
    var emojiObjects = [
        Emoji(emojiPic: "🧐", name: "Thinker", description: "Think about it", haveLike: false),
        Emoji(emojiPic: "😤", name: "Bull", description: "Steam will go out", haveLike: false),
        Emoji(emojiPic: "🥶", name: "Cold", description: "Too cold outside", haveLike: false)
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        self.title = "Emoji List"
        self.navigationItem.leftBarButtonItem = self.editButtonItem
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return emojiObjects.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "emojiCellIdentifier", for: indexPath) as! EmojiTableViewCell
        let emoji = emojiObjects[indexPath.row]
        cell.configure(object: emoji)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            emojiObjects.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .left)
        }
    }
    
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let movedEmoji = emojiObjects.remove(at: sourceIndexPath.row)
        emojiObjects.insert(movedEmoji, at: destinationIndexPath.row)
        tableView.reloadData()
    }
}
