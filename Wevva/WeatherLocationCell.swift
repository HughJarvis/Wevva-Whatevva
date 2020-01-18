import UIKit

class WeatherLocationCell: UITableViewCell {

    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var weatherDescriptionLabel: UILabel!
    @IBOutlet weak var placeLabel: UILabel!
    
    func setLocation(location: Location) {
        placeLabel.text = location.name
        let roundedTempInC = (location.main.temperature - 273).rounded(.down)
        temperatureLabel.text = String(roundedTempInC)+"C"
        weatherDescriptionLabel.text = location.weather[0].description
    //    iconImageView.image = UIImage(imageLiteralResourceName: location.weather[0].icon)
    }
}
