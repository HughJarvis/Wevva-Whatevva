//
//  MatchedWeatherViewController.swift
//  Wevva
//
//  Created by Hugh Jarvis on 18/01/2020.
//  Copyright © 2020 Hugh. All rights reserved.
//

import UIKit

class MatchedWeatherViewController: UIViewController {

    
    @IBOutlet weak var weatherView: UITableView!
    
    let viewController = ViewController()
    var fetchedLocations: [Location] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        weatherView.dataSource = self
        weatherView.delegate = self
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension MatchedWeatherViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.fetchedLocations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let location = self.fetchedLocations[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "WeatherLocationCell") as! WeatherLocationCell
        
        cell.setLocation(location: location)
        
        return cell
    }
}
