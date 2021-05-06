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
        self.title = "Emoji List"
        self.navigationItem.leftBarButtonItem = self.editButtonItem
    }
    
    @IBAction func unwindSegueFromAddScreen(segue: UIStoryboardSegue) {
        guard segue.identifier == "saveUnwindSegue" else { return }
        let addEmojiTableViewController = segue.source as! AddEmojiTableViewController
        let emoji = addEmojiTableViewController.emoji
        
        if let selectedIndexPath = tableView.indexPathForSelectedRow {
            emojiObjects[selectedIndexPath.row] = emoji
            tableView.reloadRows(at: [selectedIndexPath], with: .fade)
        } else {
            let newEmojiIndexPath = IndexPath(row: emojiObjects.count, section: 0)
            emojiObjects.append(emoji)
            tableView.insertRows(at: [newEmojiIndexPath], with: .fade)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        guard segue.identifier == "editingEmojiSegue" else { return }
        guard let indexPath = tableView.indexPathForSelectedRow else { return }
        let emoji = emojiObjects[indexPath.row]
        let navigationVC = segue.destination as! UINavigationController
        let addEmojiTableViewController = navigationVC.topViewController as! AddEmojiTableViewController
        addEmojiTableViewController.emoji = emoji
        addEmojiTableViewController.title = "Edit"
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
    
    override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let done = doneAction(at: indexPath)
        let like = likeAction(at: indexPath)
        return UISwipeActionsConfiguration(actions: [done, like])
    }
    
    func doneAction(at indexPath: IndexPath) -> UIContextualAction {
        let action = UIContextualAction(style: .destructive, title: "Done") { action, view, completion in
            self.emojiObjects.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .fade)
            completion(true)
        }
        action.backgroundColor = .systemGreen
        action.image = UIImage(systemName: "checkmark.circle")
        return action
    }
    
    func likeAction(at indexPath: IndexPath) -> UIContextualAction {
        var emoji = emojiObjects[indexPath.row]
        
        let action = UIContextualAction(style: .normal, title: "LikeIt") { action, view, completion in
            emoji.haveLike = !emoji.haveLike
            self.emojiObjects[indexPath.row] = emoji
            completion(true)
        }
        action.backgroundColor = emoji.haveLike ? .systemRed : .systemGray
        action.image = UIImage(systemName: "heart")
        return action
    }
}
