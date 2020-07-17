import UIKit
import SafariServices

class FirstVideoViewController: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var collectionView: UICollectionView!

    private var videos = Video.allVideos
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setup()
    }
    
    private func setup() {
        self.searchBar.delegate = self
        self.searchBar.placeholder = "검색어를 입력하세요."
    }

}

extension FirstVideoViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.videos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let videoCell = collectionView.dequeueReusableCell(withReuseIdentifier: "VideoCollectionViewCell", for: indexPath) as? VideoCollectionViewCell else {
                return UICollectionViewCell()
        }
        
        let video = videos[indexPath.item]
        videoCell.video = video
        
        return videoCell
    }
}

extension FirstVideoViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let video = self.videos[indexPath.item]
        
        guard let link = video.link else { return }
        
        let safariViewController = SFSafariViewController(url: link)
        present(safariViewController, animated: true, completion: nil)
    }
}

extension FirstVideoViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.updateVideoList(with: searchText)
        self.collectionView.reloadData()
    }
    
    func updateVideoList(with text: String) {
        if text == "" {
            self.videos = Video.allVideos
        } else {
            self.videos = Video.allVideos.filter { video in
                return video.title.lowercased().contains(text.lowercased())
            }
        }
    }
}
