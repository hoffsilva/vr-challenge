//
//  FavoritedGameTableView.swift
//  VivaRealChallenge
//
//  Created by Hoff Henry Pereira da Silva on 03/08/17.
//  Copyright © 2017 Hoff Henry Pereira da Silva. All rights reserved.
//

import UIKit
import SDWebImage
import FCAlertView

class FavoritedGameTableView: UITableViewController {
    
    @IBOutlet weak var footerView: UIView!
    
    var controller = GameController()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        controller.favoritedGameDelegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        controller.getFavoritedGames()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return controller.arrayOfFavoritedGames.count
    }
    

    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        if controller.arrayOfFavoritedGames.count == 0 {
            footerView.isHidden = false
            return footerView
        } else {
            footerView.isHidden = true
            return nil
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if controller.arrayOfFavoritedGames.count == 0 {
            tableView.isScrollEnabled = false
            footerView.isHidden = false
            return tableView.bounds.height
        } else {
            tableView.isScrollEnabled = true
            footerView.isHidden = true
            return 0
        }
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath) as! FavoritedGameTableViewCell
        cell.imageViewCoverGame.sd_setImage(with: URL(string: controller.getFavoritedURL(item: indexPath.row)))
        cell.labelNameGame.text = controller.getFavoritedName(item: indexPath.row)
        cell.labelPopularity.text = "\(controller.getFavoritedPopularity(item: indexPath.row))"
        return cell
    }

    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            controller.deleteFavoritedGame(item: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}

extension FavoritedGameTableView: FavoritedGameDelegate {
    func deletedSuccessfuly() {
        let alert = FCAlertView()
        alert.makeAlertTypeSuccess()
        alert.showAlert(withTitle: "😩😩😩😩", withSubtitle: "Game removido dos favoritos.", withCustomImage: nil, withDoneButtonTitle: "Ok", andButtons: nil)
        tableView.reloadData()
    }

    func favoritedGamesLoadedSuccessfuly() {
        tableView.reloadData()
    }
}
