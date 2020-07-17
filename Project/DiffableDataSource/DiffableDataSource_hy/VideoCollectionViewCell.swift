//
//  VideoCollectionViewCell.swift
//  DiffableDataSource_hy
//
//  Created by 김하연 on 2020/07/17.
//  Copyright © 2020 hayeonKim. All rights reserved.
//

import UIKit

class VideoCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    
    var video: Video? {
        didSet {
            self.imageView.image = self.video?.thumbnail
            self.titleLabel.text = self.video?.title
            self.subtitleLabel.text = "\(self.video?.lessonCount ?? 0) lessons"
        }
    }
}
