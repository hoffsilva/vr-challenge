//
//  GameCollectionView.swift
//  VivaRealChallenge
//
//  Created by Hoff Henry Pereira da Silva on 01/08/17.
//  Copyright © 2017 Hoff Henry Pereira da Silva. All rights reserved.
//

import UIKit
import SDWebImage
import FCAlertView
import Hero

private let reuseIdentifier = "Cell"

class GameCollectionView: UICollectionViewController {
    
    var controller = GameController()
    let refreshControll = UIRefreshControl()
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = false
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        controller.delegate = self
        collectionView?.alwaysBounceVertical = true
        callRefreshControll()
        let index = arc4random_uniform(UInt32(controller.arrayOfBackgrounds.count))
        collectionView?.backgroundView = UIImageView(image: controller.getBackground(item: Int(index)))
        collectionView?.backgroundView?.alpha = 0.4
    }

    override func viewDidAppear(_ animated: Bool) {
        loadGames()
    }
    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return controller.arrayOfGames.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! GameCollectionViewCell
        cell.imageViewGameThumb?.sd_setImage(with: URL(string: controller.getURL(item: indexPath.row)))
        if controller.isFavorite(item: indexPath.row) {
            cell.imageViewIsFavorite?.isHidden = false
        } else {
           cell.imageViewIsFavorite?.isHidden = true
        }
        return cell
    }

    // MARK: UICollectionViewDelegate
    
    override func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        cell.backgroundColor = UIColor.clear
    }

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        controller.detailGame(rowOfGame: indexPath.row)
        let vc = self.storyboard!.instantiateViewController(withIdentifier: "detailGame")
        Hero.shared.setDefaultAnimationForNextTransition(HeroDefaultAnimationType.zoom)
        Hero.shared.setContainerColorForNextTransition(.lightGray)
        hero_replaceViewController(with: vc)
    }
    
    func callRefreshControll() {
        refreshControll.tintColor = #colorLiteral(red: 0.1215686277, green: 0.01176470611, blue: 0.4235294163, alpha: 1)
        refreshControll.addTarget(self, action: #selector(loadGames), for: .valueChanged)
        collectionView?.addSubview(refreshControll)
        collectionView?.alwaysBounceVertical = true
    }
    
    func loadGames() {
        pleaseWait()
        controller.getGames(quantity: 50)
    }

}

extension GameCollectionView: GameDelegate {
    func showError(message: String) {
        let alert = FCAlertView()
        alert.makeAlertTypeWarning()
        clearAllNotice()
        refreshControll.endRefreshing()
        alert.showAlert(inView: self, withTitle: "😩", withSubtitle: "Houve um erro... \(message)", withCustomImage: nil, withDoneButtonTitle: "Ok", andButtons: nil)
    }

    func loadGameSuccesfuly() {
        collectionView?.reloadData()
        refreshControll.endRefreshing()
        clearAllNotice()
    }
}
