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
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = false
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        controller.delegate = self
        pleaseWait()
        controller.getGames(quantity: 50)
        collectionView?.backgroundView = UIImageView(image: #imageLiteral(resourceName: "ac.jpg"))
        collectionView?.backgroundView?.alpha = 0.4
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

}

extension GameCollectionView: GameDelegate {
    func showError(message: String) {
        let alert = FCAlertView()
        alert.makeAlertTypeWarning()
        clearAllNotice()
        alert.showAlert(withTitle: "😩", withSubtitle: "Houve um erro... \(message)", withCustomImage: nil, withDoneButtonTitle: "Ok", andButtons: nil)
    }

    func loadGameSuccesfuly() {
        collectionView?.reloadData()
        clearAllNotice()
    }

    
}
