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

    override func viewDidLoad() {
        super.viewDidLoad()
        controller.delegate = self
        controller.getGames(quantity: 50)
        
        collectionView?.backgroundView = UIImageView(image: #imageLiteral(resourceName: "ac.jpg"))
        collectionView?.backgroundView?.alpha = 0.4

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
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
        let vc = self.storyboard!.instantiateViewController(withIdentifier: "detailGame")
        
        // the following two lines configures the animation. default is .auto
        Hero.shared.setDefaultAnimationForNextTransition(HeroDefaultAnimationType.zoom)
        Hero.shared.setContainerColorForNextTransition(.lightGray)
        
        hero_replaceViewController(with: vc)
    }
    
    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}

extension GameCollectionView: GameDelegate {
    func showError(message: String) {
        let alert = FCAlertView()
        alert.makeAlertTypeWarning()
        alert.showAlert(withTitle: "😩", withSubtitle: "Houve um erro... \(message)", withCustomImage: nil, withDoneButtonTitle: "Ok", andButtons: nil)
    }

    func loadGameSuccesfuly() {
        collectionView?.reloadData()
    }

    
}
