//
//  MoviesViewController.swift
//  TattooApp_PetProject
//
//  Created by Поляндий on 12.10.2022.
//

import Foundation
import UIKit

class RecommendationViewController: UIViewController {
    
    @IBOutlet var sideMenuBtn: UIBarButtonItem!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.tintColor = .white
        sideMenuBtn.target = self.revealViewController()
        sideMenuBtn.action = #selector(self.revealViewController()?.revealSideMenu)
    }
    
}
