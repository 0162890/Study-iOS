import UIKit
import SafariServices

class ThirdVideoViewController: UIViewController {
    
    typealias DataSource = UICollectionViewDiffableDataSource<VideoSection, Video>
    typealias Snapshot = NSDiffableDataSourceSnapshot<VideoSection, Video> 

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var collectionView: UICollectionView!
    
    private var videoSections = VideoSection.allSections
    private lazy var dataSource = makeDataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setup()
        self.applySnapshot(animatingDifferences: false)
    }
    
    private func setup() {
        self.searchBar.delegate = self
        self.searchBar.placeholder = "검색어를 입력하세요."
    }
    
    private func makeDataSource() -> DataSource {
        let dataSource = DataSource(collectionView: self.collectionView) { collectionView, indexPath, video -> UICollectionViewCell? in
            let videoCell = collectionView.dequeueReusableCell(withReuseIdentifier: "VideoCollectionViewCell", for: indexPath) as? VideoCollectionViewCell
            videoCell?.video = video
            return videoCell
        }
        
        return dataSource
    }
    
    private func applySnapshot(animatingDifferences: Bool = true) {
        var snapshot = Snapshot()
        snapshot.appendSections(videoSections)
        videoSections.forEach { videoSection in
            snapshot.appendItems(videoSection.videos, toSection: videoSection)
        }
        self.dataSource.apply(snapshot, animatingDifferences: animatingDifferences)
    }

}

extension ThirdVideoViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let video = self.dataSource.itemIdentifier(for: indexPath)
        
        guard let link = video?.link else { return }
        
        let safariViewController = SFSafariViewController(url: link)
        present(safariViewController, animated: true, completion: nil)
    }
}

extension ThirdVideoViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.updateVideoList(with: searchText)
        self.applySnapshot()
    }
    
    func updateVideoList(with text: String) {
        if text == "" {
            self.videoSections = VideoSection.allSections
        } else {
            self.videoSections = VideoSection.allSections.filter({ videoSection in
                var isContainedSection = videoSection.title.lowercased().contains(text.lowercased())
                videoSection.videos.forEach { video in
                    if video.title.lowercased().contains(text.lowercased()) {
                        isContainedSection = true
                    }
                }
                return isContainedSection
            })
        }
    }
}
