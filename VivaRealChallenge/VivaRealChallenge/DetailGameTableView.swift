//
//  DetailGameTableView.swift
//  VivaRealChallenge
//
//  Created by Hoff Henry Pereira da Silva on 02/08/17.
//  Copyright © 2017 Hoff Henry Pereira da Silva. All rights reserved.
//

import UIKit
import Hero
import SDWebImage
import FCAlertView

class DetailGameTableView: UITableViewController {
    
    
    @IBOutlet weak var imageViewcoverGame: UIImageView!
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var labelPopularity: UILabel!
    @IBOutlet weak var labelViewers: UILabel!
    @IBOutlet weak var labelChannels: UILabel!
    @IBOutlet weak var buttonAddRemoveFavorite: UIButton!
    
    var indexOfSelectedGame: Int!
    var controller = GameController()
    
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        controller.favoriteDelegate = self
        loadDataGame()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 8
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = UIColor.clear
    }
    
    func loadDataGame() {
        imageViewcoverGame.sd_setImage(with: URL(string: GameSingleton.shared.game.coverURL))
        tableView.backgroundView = UIImageView(image: imageViewcoverGame.image)
        tableView.backgroundView?.alpha = 0.2
        labelName.text = GameSingleton.shared.game.name
        labelPopularity.text = "\(GameSingleton.shared.game.popularity)"
        labelViewers.text = "\(GameSingleton.shared.game.viewers)"
        labelChannels.text = "\(GameSingleton.shared.game.channels)"
        if GameSingleton.shared.game.isFavorite {
            buttonAddRemoveFavorite.setTitle("Desmarcar dos favoritos", for: .normal)
        } else {
            buttonAddRemoveFavorite.setTitle( "Marcar como favorito", for: .normal)
        }
    }
    
    
    @IBAction func closeView() {
        let vc = self.storyboard!.instantiateViewController(withIdentifier: "topGames")
        Hero.shared.setDefaultAnimationForNextTransition(HeroDefaultAnimationType.zoomOut)
        Hero.shared.setContainerColorForNextTransition(.lightGray)
        hero_replaceViewController(with: vc)
    }
    @IBAction func addToFavoritesButton(_ sender: Any) {
        if GameSingleton.shared.game.isFavorite {
            controller.removeFromFavoriteList(game: GameSingleton.shared.game)
        } else {
            controller.addToFavoriteList(game: GameSingleton.shared.game)
        }
    }

}

extension DetailGameTableView: GameFavoriteDelegate {
    func gameIsFavorite(answer: Bool) {
        let alert = FCAlertView()
        alert.makeAlertTypeSuccess()
        if answer {
            alert.showAlert(withTitle: "🎉🎉🎉🎉", withSubtitle: "\(String(describing: labelName.text!)) agora é um favorito.", withCustomImage: nil, withDoneButtonTitle: "Ok", andButtons: nil)
        } else {
             alert.showAlert(withTitle: "😩😩😩😩", withSubtitle: "\(String(describing: labelName.text!)) não é mais um favorito.", withCustomImage: nil, withDoneButtonTitle: "Ok", andButtons: nil)
        }
        loadDataGame()
    }
}
