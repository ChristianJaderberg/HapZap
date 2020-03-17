//
//  HapZapTableViewCell.swift
//  HapZap
//
//  Created by Christian Jäderberg on 2020-03-16.
//  Copyright © 2020 Christian Jäderberg. All rights reserved.
//

import UIKit

protocol HapZapTableViewCellDelegate {
    func didTapPlayInSpotifyButton(spotifyURI: String)
}

class HapZapTableViewCell: UITableViewCell {

    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var songNameLabel: UILabel!
    @IBOutlet weak var artistNameLabel: UILabel!
    @IBOutlet weak var albumImageView: UIImageView!
    
    var delegate: HapZapTableViewCellDelegate?
    var hapZap: SongHapZap?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func setHapZap(hapzap: SongHapZap) {
        self.hapZap = hapzap
    }
    
    @IBAction func playInSpotifyButtonTapped(_ sender: Any) {
        guard let spotifyURI = self.hapZap?.trackURI else { return }
        self.delegate?.didTapPlayInSpotifyButton(spotifyURI: spotifyURI)
    }
}
