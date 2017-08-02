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

class DetailGameTableView: UITableViewController {
    
    
    @IBOutlet weak var imageViewcoverGame: UIImageView!
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var labelPopularity: UILabel!
    @IBOutlet weak var labelViewers: UILabel!
    @IBOutlet weak var labelChannels: UILabel!
    
    var indexOfSelectedGame: Int!
    
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadDataGame()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 8
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = UIColor.clear
    }
    
    func loadDataGame() {
        imageViewcoverGame.sd_setImage(with: URL(string: GameSingleton.shared.game.coverURL!))
        tableView.backgroundView = UIImageView(image: imageViewcoverGame.image)
        tableView.backgroundView?.alpha = 0.2
        labelName.text = GameSingleton.shared.game.name!
        labelPopularity.text = "\(GameSingleton.shared.game.popularity!)"
        labelViewers.text = "\(GameSingleton.shared.game.viewers!)"
        labelChannels.text = "\(GameSingleton.shared.game.channels!)"
    }
    
    
    @IBAction func closeView() {
        let vc = self.storyboard!.instantiateViewController(withIdentifier: "topGames")
        // the following two lines configures the animation. default is .auto
        Hero.shared.setDefaultAnimationForNextTransition(HeroDefaultAnimationType.zoomOut)
        Hero.shared.setContainerColorForNextTransition(.lightGray)
        hero_replaceViewController(with: vc)
    }
    @IBAction func addToFavoritesButton(_ sender: Any) {
        
    }

}
